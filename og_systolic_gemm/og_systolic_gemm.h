#ifndef GEMM_H
#define GEMM_H

#include <ap_fixed.h>
#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>     // ap_axis -> AXI4-Stream side channels (TLAST, TKEEP...)

#define N 3                   // 3x3 systolic array

// Mixed precision, fixed-point
typedef ap_fixed<16, 8>  data_t;   // operands: 8 integer + 8 fractional bits
typedef ap_fixed<32, 16> acc_t;    // accumulator: 32-bit (16 integer + 16 fractional)

// 32-bit AXI4-Stream word (data + TLAST/TKEEP/TSTRB; no user/id/dest)
typedef ap_axis<32, 0, 0, 0> axis_t;

// Top-level accelerator: A and B stream in, C streams out
void og_systolic_gemm(hls::stream<axis_t> &in_A,
                   hls::stream<axis_t> &in_B,
                   hls::stream<axis_t> &out_C);

#endif // GEMM_H