// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xog_systolic_gemm.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XOg_systolic_gemm_CfgInitialize(XOg_systolic_gemm *InstancePtr, XOg_systolic_gemm_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Ctrl_BaseAddress = ConfigPtr->Ctrl_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XOg_systolic_gemm_Start(XOg_systolic_gemm *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XOg_systolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL) & 0x80;
    XOg_systolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XOg_systolic_gemm_IsDone(XOg_systolic_gemm *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XOg_systolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XOg_systolic_gemm_IsIdle(XOg_systolic_gemm *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XOg_systolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XOg_systolic_gemm_IsReady(XOg_systolic_gemm *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XOg_systolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XOg_systolic_gemm_EnableAutoRestart(XOg_systolic_gemm *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XOg_systolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL, 0x80);
}

void XOg_systolic_gemm_DisableAutoRestart(XOg_systolic_gemm *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XOg_systolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL, 0);
}

void XOg_systolic_gemm_InterruptGlobalEnable(XOg_systolic_gemm *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XOg_systolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_GIE, 1);
}

void XOg_systolic_gemm_InterruptGlobalDisable(XOg_systolic_gemm *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XOg_systolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_GIE, 0);
}

void XOg_systolic_gemm_InterruptEnable(XOg_systolic_gemm *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XOg_systolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_IER);
    XOg_systolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_IER, Register | Mask);
}

void XOg_systolic_gemm_InterruptDisable(XOg_systolic_gemm *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XOg_systolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_IER);
    XOg_systolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_IER, Register & (~Mask));
}

void XOg_systolic_gemm_InterruptClear(XOg_systolic_gemm *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XOg_systolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_ISR, Mask);
}

u32 XOg_systolic_gemm_InterruptGetEnabled(XOg_systolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XOg_systolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_IER);
}

u32 XOg_systolic_gemm_InterruptGetStatus(XOg_systolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XOg_systolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XOG_SYSTOLIC_GEMM_CTRL_ADDR_ISR);
}

