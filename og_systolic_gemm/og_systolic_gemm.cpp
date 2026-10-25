#include "og_systolic_gemm.h"

// ===========================================================================
//  AXI4-Stream, output-stationary 3x3 systolic array GEMM.
//  A and B arrive on AXI4-Stream ports, C leaves on an AXI4-Stream port.
//  Inside, 9 PEs run as concurrent DATAFLOW processes connected only by
//  FIFOs (hls::stream): a flows left->right, b flows top->bottom, each PE
//  accumulates its own C(i,j). TLAST is asserted on the final C beat so the
//  PS-side DMA knows when the transfer ends.
// ===========================================================================

// ---- AXIS <-> fixed-point conversion --------------------------------------
static data_t axis_to_data(const axis_t &t) {
    ap_uint<16> bits = t.data.range(15, 0);   // 16-bit operand in low bits
    data_t v;
    v.range(15, 0) = bits;
    return v;
}

static axis_t acc_to_axis(const acc_t &v, bool last) {
    axis_t t;
    ap_uint<32> bits = v.range(31, 0);        // full 32-bit accumulator
    t.data = bits;
    t.keep = -1;                              // all 4 bytes valid
    t.strb = -1;
    t.last = last ? 1 : 0;                    // TLAST on final element
    return t;
}

// ---- One Processing Element (true structural PE) --------------------------
static void pe(hls::stream<data_t> &a_in, hls::stream<data_t> &a_out,
               hls::stream<data_t> &b_in, hls::stream<data_t> &b_out,
               hls::stream<acc_t>  &c_out) {
    acc_t acc = 0;
    PE_LOOP: for (int k = 0; k < N; k++) {
#pragma HLS PIPELINE II=1
        data_t a = a_in.read();
        data_t b = b_in.read();
        acc_t prod = (acc_t)(a * b);
#pragma HLS BIND_OP variable=prod op=mul impl=dsp
        acc += prod;
        a_out.write(a);        // forward right
        b_out.write(b);        // forward down
    }
    c_out.write(acc);
}

// ---- Edge feeders / drains / collector ------------------------------------
static void feed_A(data_t A[N][N], hls::stream<data_t> aS[N][N + 1]) {
    FA: for (int k = 0; k < N; k++)
        for (int i = 0; i < N; i++) {
#pragma HLS PIPELINE II=1
            aS[i][0].write(A[i][k]);
        }
}
static void feed_B(data_t B[N][N], hls::stream<data_t> bS[N + 1][N]) {
    FB: for (int k = 0; k < N; k++)
        for (int j = 0; j < N; j++) {
#pragma HLS PIPELINE II=1
            bS[0][j].write(B[k][j]);
        }
}
static void sink_A(hls::stream<data_t> aS[N][N + 1]) {
    SA: for (int k = 0; k < N; k++)
        for (int i = 0; i < N; i++) {
#pragma HLS PIPELINE II=1
            aS[i][N].read();
        }
}
static void sink_B(hls::stream<data_t> bS[N + 1][N]) {
    SB: for (int k = 0; k < N; k++)
        for (int j = 0; j < N; j++) {
#pragma HLS PIPELINE II=1
            bS[N][j].read();
        }
}
static void collect(hls::stream<acc_t> cS[N][N], acc_t C[N][N]) {
    CO: for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
#pragma HLS PIPELINE II=1
            C[i][j] = cS[i][j].read();
        }
}

// ---- The systolic core: internally DATAFLOW -------------------------------
static void systolic_core(data_t A[N][N], data_t B[N][N], acc_t C[N][N]) {
#pragma HLS DATAFLOW
    hls::stream<data_t> aS[N][N + 1];
    hls::stream<data_t> bS[N + 1][N];
    hls::stream<acc_t>  cS[N][N];
#pragma HLS ARRAY_PARTITION variable=aS complete dim=0
#pragma HLS ARRAY_PARTITION variable=bS complete dim=0
#pragma HLS ARRAY_PARTITION variable=cS complete dim=0
#pragma HLS STREAM variable=aS depth=4
#pragma HLS STREAM variable=bS depth=4
#pragma HLS STREAM variable=cS depth=2

    feed_A(A, aS);
    feed_B(B, bS);

    ROW: for (int i = 0; i < N; i++) {
#pragma HLS UNROLL
        COL: for (int j = 0; j < N; j++) {
#pragma HLS UNROLL
            pe(aS[i][j], aS[i][j + 1],
               bS[i][j], bS[i + 1][j],
               cS[i][j]);
        }
    }

    sink_A(aS);
    sink_B(bS);
    collect(cS, C);
}

// ---- Top level: AXI4-Stream interfaces ------------------------------------
void og_systolic_gemm(hls::stream<axis_t> &in_A,
                   hls::stream<axis_t> &in_B,
                   hls::stream<axis_t> &out_C) {
#pragma HLS INTERFACE axis      port=in_A
#pragma HLS INTERFACE axis      port=in_B
#pragma HLS INTERFACE axis      port=out_C
#pragma HLS INTERFACE s_axilite port=return bundle=CTRL

    data_t A[N][N], B[N][N];
    acc_t  C[N][N];
#pragma HLS ARRAY_PARTITION variable=A complete dim=0
#pragma HLS ARRAY_PARTITION variable=B complete dim=0
#pragma HLS ARRAY_PARTITION variable=C complete dim=0

    // Read A and B off the input streams (row-major, N*N beats each)
    RD: for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
#pragma HLS PIPELINE II=1
            A[i][j] = axis_to_data(in_A.read());
            B[i][j] = axis_to_data(in_B.read());
        }
    }

    // Compute on the systolic array
    systolic_core(A, B, C);

    // Stream C out, TLAST on the final element
    WR: for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
#pragma HLS PIPELINE II=1
            bool last = (i == N - 1) && (j == N - 1);
            out_C.write(acc_to_axis(C[i][j], last));
        }
    }
}