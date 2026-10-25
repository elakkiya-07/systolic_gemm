#include "og_systolic_gemm.h"
#include <cstdio>
#include <cmath>

// Pack a fixed-point operand into a 32-bit AXIS beat (16-bit value in low bits)
static axis_t make_beat(double v, bool last) {
    data_t fx = (data_t)v;                 // quantize to ap_fixed<16,8>
    axis_t t;
    ap_uint<16> bits = fx.range(15, 0);
    t.data = (ap_uint<32>)bits;            // low 16 bits carry the operand
    t.keep = -1; t.strb = -1;
    t.last = last ? 1 : 0;
    return t;
}

int main() {
    double A[N][N] = { {1,2,3}, {4,5,6}, {7,8,9} };
    double B[N][N] = { {1,2,3}, {4,5,6}, {7,8,9} };

    // Golden reference
    double Cref[N][N] = {0};
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            for (int k = 0; k < N; k++)
                Cref[i][j] += A[i][k] * B[k][j];

    hls::stream<axis_t> in_A, in_B, out_C;

    // Stream A and B in, row-major (TLAST on last beat of each)
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            bool last = (i == N-1) && (j == N-1);
            in_A.write(make_beat(A[i][j], last));
            in_B.write(make_beat(B[i][j], last));
        }

    og_systolic_gemm(in_A, in_B, out_C);

    // Read C back
    double err = 0, ref = 0;
    printf("Systolic GEMM (AXI-Stream) result:\n");
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            axis_t t = out_C.read();
            acc_t cfx;
            cfx.range(31, 0) = t.data.range(31, 0);
            double cv = (double)cfx;
            printf("%9.3f ", cv);
            double d = cv - Cref[i][j];
            err += d*d; ref += Cref[i][j]*Cref[i][j];
        }
        printf("\n");
    }

    double rms = 100.0 * std::sqrt(err / ref);
    printf("\nExpected: 30 36 42 / 66 81 96 / 102 126 150\n");
    printf("RMS %% error = %.6f%%\n", rms);
    printf(rms < 1.0 ? "TEST PASSED\n" : "TEST FAILED\n");
    return (rms < 1.0) ? 0 : 1;
}