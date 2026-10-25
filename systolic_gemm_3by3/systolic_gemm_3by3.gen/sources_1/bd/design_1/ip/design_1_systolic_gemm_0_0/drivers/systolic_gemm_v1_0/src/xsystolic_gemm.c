// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xsystolic_gemm.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XSystolic_gemm_CfgInitialize(XSystolic_gemm *InstancePtr, XSystolic_gemm_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Ctrl_BaseAddress = ConfigPtr->Ctrl_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XSystolic_gemm_Start(XSystolic_gemm *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSystolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL) & 0x80;
    XSystolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XSystolic_gemm_IsDone(XSystolic_gemm *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSystolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XSystolic_gemm_IsIdle(XSystolic_gemm *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSystolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XSystolic_gemm_IsReady(XSystolic_gemm *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSystolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XSystolic_gemm_EnableAutoRestart(XSystolic_gemm *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSystolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL, 0x80);
}

void XSystolic_gemm_DisableAutoRestart(XSystolic_gemm *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSystolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_AP_CTRL, 0);
}

u32 XSystolic_gemm_Get_A_BaseAddress(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_A_BASE);
}

u32 XSystolic_gemm_Get_A_HighAddress(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_A_HIGH);
}

u32 XSystolic_gemm_Get_A_TotalBytes(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XSYSTOLIC_GEMM_CTRL_ADDR_A_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_A_BASE + 1);
}

u32 XSystolic_gemm_Get_A_BitWidth(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XSYSTOLIC_GEMM_CTRL_WIDTH_A;
}

u32 XSystolic_gemm_Get_A_Depth(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XSYSTOLIC_GEMM_CTRL_DEPTH_A;
}

u32 XSystolic_gemm_Write_A_Words(XSystolic_gemm *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XSYSTOLIC_GEMM_CTRL_ADDR_A_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_A_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_A_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XSystolic_gemm_Read_A_Words(XSystolic_gemm *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XSYSTOLIC_GEMM_CTRL_ADDR_A_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_A_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_A_BASE + (offset + i)*4);
    }
    return length;
}

u32 XSystolic_gemm_Write_A_Bytes(XSystolic_gemm *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XSYSTOLIC_GEMM_CTRL_ADDR_A_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_A_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_A_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XSystolic_gemm_Read_A_Bytes(XSystolic_gemm *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XSYSTOLIC_GEMM_CTRL_ADDR_A_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_A_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_A_BASE + offset + i);
    }
    return length;
}

u32 XSystolic_gemm_Get_B_BaseAddress(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_B_BASE);
}

u32 XSystolic_gemm_Get_B_HighAddress(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_B_HIGH);
}

u32 XSystolic_gemm_Get_B_TotalBytes(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XSYSTOLIC_GEMM_CTRL_ADDR_B_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_B_BASE + 1);
}

u32 XSystolic_gemm_Get_B_BitWidth(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XSYSTOLIC_GEMM_CTRL_WIDTH_B;
}

u32 XSystolic_gemm_Get_B_Depth(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XSYSTOLIC_GEMM_CTRL_DEPTH_B;
}

u32 XSystolic_gemm_Write_B_Words(XSystolic_gemm *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XSYSTOLIC_GEMM_CTRL_ADDR_B_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_B_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_B_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XSystolic_gemm_Read_B_Words(XSystolic_gemm *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XSYSTOLIC_GEMM_CTRL_ADDR_B_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_B_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_B_BASE + (offset + i)*4);
    }
    return length;
}

u32 XSystolic_gemm_Write_B_Bytes(XSystolic_gemm *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XSYSTOLIC_GEMM_CTRL_ADDR_B_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_B_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_B_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XSystolic_gemm_Read_B_Bytes(XSystolic_gemm *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XSYSTOLIC_GEMM_CTRL_ADDR_B_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_B_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_B_BASE + offset + i);
    }
    return length;
}

u32 XSystolic_gemm_Get_C_BaseAddress(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_C_BASE);
}

u32 XSystolic_gemm_Get_C_HighAddress(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_C_HIGH);
}

u32 XSystolic_gemm_Get_C_TotalBytes(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XSYSTOLIC_GEMM_CTRL_ADDR_C_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_C_BASE + 1);
}

u32 XSystolic_gemm_Get_C_BitWidth(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XSYSTOLIC_GEMM_CTRL_WIDTH_C;
}

u32 XSystolic_gemm_Get_C_Depth(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XSYSTOLIC_GEMM_CTRL_DEPTH_C;
}

u32 XSystolic_gemm_Write_C_Words(XSystolic_gemm *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XSYSTOLIC_GEMM_CTRL_ADDR_C_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_C_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_C_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XSystolic_gemm_Read_C_Words(XSystolic_gemm *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XSYSTOLIC_GEMM_CTRL_ADDR_C_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_C_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_C_BASE + (offset + i)*4);
    }
    return length;
}

u32 XSystolic_gemm_Write_C_Bytes(XSystolic_gemm *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XSYSTOLIC_GEMM_CTRL_ADDR_C_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_C_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_C_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XSystolic_gemm_Read_C_Bytes(XSystolic_gemm *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XSYSTOLIC_GEMM_CTRL_ADDR_C_HIGH - XSYSTOLIC_GEMM_CTRL_ADDR_C_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Ctrl_BaseAddress + XSYSTOLIC_GEMM_CTRL_ADDR_C_BASE + offset + i);
    }
    return length;
}

void XSystolic_gemm_InterruptGlobalEnable(XSystolic_gemm *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSystolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_GIE, 1);
}

void XSystolic_gemm_InterruptGlobalDisable(XSystolic_gemm *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSystolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_GIE, 0);
}

void XSystolic_gemm_InterruptEnable(XSystolic_gemm *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XSystolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_IER);
    XSystolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_IER, Register | Mask);
}

void XSystolic_gemm_InterruptDisable(XSystolic_gemm *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XSystolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_IER);
    XSystolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_IER, Register & (~Mask));
}

void XSystolic_gemm_InterruptClear(XSystolic_gemm *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSystolic_gemm_WriteReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_ISR, Mask);
}

u32 XSystolic_gemm_InterruptGetEnabled(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XSystolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_IER);
}

u32 XSystolic_gemm_InterruptGetStatus(XSystolic_gemm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XSystolic_gemm_ReadReg(InstancePtr->Ctrl_BaseAddress, XSYSTOLIC_GEMM_CTRL_ADDR_ISR);
}

