// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
// CTRL
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read/COR)
//        bit 7  - auto_restart (Read/Write)
//        bit 9  - interrupt (Read)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0 - enable ap_done interrupt (Read/Write)
//        bit 1 - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0 - ap_done (Read/TOW)
//        bit 1 - ap_ready (Read/TOW)
//        others - reserved
// 0x20 ~
// 0x3f : Memory 'A' (9 * 16b)
//        Word n : bit [15: 0] - A[2n]
//                 bit [31:16] - A[2n+1]
// 0x40 ~
// 0x5f : Memory 'B' (9 * 16b)
//        Word n : bit [15: 0] - B[2n]
//                 bit [31:16] - B[2n+1]
// 0x80 ~
// 0xbf : Memory 'C' (9 * 32b)
//        Word n : bit [31:0] - C[n]
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XSYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL 0x00
#define XSYSTOLIC_GEMM_CTRL_ADDR_GIE     0x04
#define XSYSTOLIC_GEMM_CTRL_ADDR_IER     0x08
#define XSYSTOLIC_GEMM_CTRL_ADDR_ISR     0x0c
#define XSYSTOLIC_GEMM_CTRL_ADDR_A_BASE  0x20
#define XSYSTOLIC_GEMM_CTRL_ADDR_A_HIGH  0x3f
#define XSYSTOLIC_GEMM_CTRL_WIDTH_A      16
#define XSYSTOLIC_GEMM_CTRL_DEPTH_A      9
#define XSYSTOLIC_GEMM_CTRL_ADDR_B_BASE  0x40
#define XSYSTOLIC_GEMM_CTRL_ADDR_B_HIGH  0x5f
#define XSYSTOLIC_GEMM_CTRL_WIDTH_B      16
#define XSYSTOLIC_GEMM_CTRL_DEPTH_B      9
#define XSYSTOLIC_GEMM_CTRL_ADDR_C_BASE  0x80
#define XSYSTOLIC_GEMM_CTRL_ADDR_C_HIGH  0xbf
#define XSYSTOLIC_GEMM_CTRL_WIDTH_C      32
#define XSYSTOLIC_GEMM_CTRL_DEPTH_C      9

