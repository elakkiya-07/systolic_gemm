#include "gemm.h"

// ---------------------------------------------------------------------------
// One Processing Element.
// Reads 'a' from its left neighbor and 'b' from its top neighbor, does N MACs
// in a local accumulator, and forwards a->right, b->down each step.
// After N steps it emits its final C(i,j) on its own result stream.
// This is a true structural PE: local registers + local forwarding only.
// ---------------------------------------------------------------------------
static void pe(hls::stream<data_t> &a_in,  hls::stream<data_t> &a_out,
               hls::stream<data_t> &b_in,  hls::stream<data_t> &b_out,
               hls::stream<acc_t>  &c_out) {
    acc_t acc = 0;
    PE_LOOP: for (int k = 0; k < N; k++) {
#pragma HLS PIPELINE II=1
        data_t a = a_in.read();
        data_t b = b_in.read();

        data_t bv = b;
        acc_t  prod = (acc_t)(a * bv);
#pragma HLS BIND_OP variable=prod op=mul impl=dsp   // keep the multiply on a DSP
        acc += prod;

        a_out.write(a);      // forward right
        b_out.write(b);      // forward down
    }
    c_out.write(acc);
}

// Feed A into the left edge. PE(i,0) must read A[i][0],A[i][1],...,A[i][N-1]
// in order, so we push column k for every row i on step k.
static void feed_A(data_t A[N][N], hls::stream<data_t> aS[N][N + 1]) {
    FA: for (int k = 0; k < N; k++)
        for (int i = 0; i < N; i++) {
#pragma HLS PIPELINE II=1
            aS[i][0].write(A[i][k]);
        }
}

// Feed B into the top edge. PE(0,j) reads B[0][j],B[1][j],...,B[N-1][j].
static void feed_B(data_t B[N][N], hls::stream<data_t> bS[N + 1][N]) {
    FB: for (int k = 0; k < N; k++)
        for (int j = 0; j < N; j++) {
#pragma HLS PIPELINE II=1
            bS[0][j].write(B[k][j]);
        }
}

// Consume the values that fall off the right edge and the bottom edge,
// otherwise those terminal FIFOs never drain.
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

// Collect each PE's result stream into the output port.
static void collect(hls::stream<acc_t> cS[N][N], acc_t C[N][N]) {
    CO: for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
#pragma HLS PIPELINE II=1
            C[i][j] = cS[i][j].read();
        }
}

// ---------------------------------------------------------------------------
// Top level: instantiate the array of PEs + feeders + drains as concurrent
// DATAFLOW processes, connected only by streams.
// ---------------------------------------------------------------------------
void systolic_gemm(data_t A[N][N], data_t B[N][N], acc_t C[N][N]) {
#pragma HLS INTERFACE s_axilite port=A      bundle=CTRL
#pragma HLS INTERFACE s_axilite port=B      bundle=CTRL
#pragma HLS INTERFACE s_axilite port=C      bundle=CTRL
#pragma HLS INTERFACE s_axilite port=return bundle=CTRL
#pragma HLS DATAFLOW

    // Inter-PE channels. aS[i][j] feeds PE(i,j) from the left; aS[i][N] is the
    // right-edge drain. bS[i][j] feeds PE(i,j) from the top; bS[N][j] is the
    // bottom-edge drain. Each PE also owns a one-shot result stream cS[i][j].
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

    // The spatial array: 9 independent PE processes wired to their neighbors.
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