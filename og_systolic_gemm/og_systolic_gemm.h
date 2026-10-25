#ifndef GEMM_H
#define GEMM_H

#include <ap_fixed.h>
#include <hls_stream.h>

#define N 3                                   // 3x3 systolic array

typedef ap_fixed<16, 6>  data_t;              // operands (low precision)
typedef ap_fixed<32, 14> acc_t;               // right-sized accumulator (was 40,12)

void systolic_gemm(data_t A[N][N], data_t B[N][N], acc_t C[N][N]);

#endif