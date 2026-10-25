// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XSYSTOLIC_GEMM_H
#define XSYSTOLIC_GEMM_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xsystolic_gemm_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Ctrl_BaseAddress;
} XSystolic_gemm_Config;
#endif

typedef struct {
    u64 Ctrl_BaseAddress;
    u32 IsReady;
} XSystolic_gemm;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XSystolic_gemm_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XSystolic_gemm_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XSystolic_gemm_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XSystolic_gemm_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
#ifdef SDT
int XSystolic_gemm_Initialize(XSystolic_gemm *InstancePtr, UINTPTR BaseAddress);
XSystolic_gemm_Config* XSystolic_gemm_LookupConfig(UINTPTR BaseAddress);
#else
int XSystolic_gemm_Initialize(XSystolic_gemm *InstancePtr, u16 DeviceId);
XSystolic_gemm_Config* XSystolic_gemm_LookupConfig(u16 DeviceId);
#endif
int XSystolic_gemm_CfgInitialize(XSystolic_gemm *InstancePtr, XSystolic_gemm_Config *ConfigPtr);
#else
int XSystolic_gemm_Initialize(XSystolic_gemm *InstancePtr, const char* InstanceName);
int XSystolic_gemm_Release(XSystolic_gemm *InstancePtr);
#endif

void XSystolic_gemm_Start(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_IsDone(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_IsIdle(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_IsReady(XSystolic_gemm *InstancePtr);
void XSystolic_gemm_EnableAutoRestart(XSystolic_gemm *InstancePtr);
void XSystolic_gemm_DisableAutoRestart(XSystolic_gemm *InstancePtr);

u32 XSystolic_gemm_Get_A_BaseAddress(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Get_A_HighAddress(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Get_A_TotalBytes(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Get_A_BitWidth(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Get_A_Depth(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Write_A_Words(XSystolic_gemm *InstancePtr, int offset, word_type *data, int length);
u32 XSystolic_gemm_Read_A_Words(XSystolic_gemm *InstancePtr, int offset, word_type *data, int length);
u32 XSystolic_gemm_Write_A_Bytes(XSystolic_gemm *InstancePtr, int offset, char *data, int length);
u32 XSystolic_gemm_Read_A_Bytes(XSystolic_gemm *InstancePtr, int offset, char *data, int length);
u32 XSystolic_gemm_Get_B_BaseAddress(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Get_B_HighAddress(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Get_B_TotalBytes(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Get_B_BitWidth(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Get_B_Depth(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Write_B_Words(XSystolic_gemm *InstancePtr, int offset, word_type *data, int length);
u32 XSystolic_gemm_Read_B_Words(XSystolic_gemm *InstancePtr, int offset, word_type *data, int length);
u32 XSystolic_gemm_Write_B_Bytes(XSystolic_gemm *InstancePtr, int offset, char *data, int length);
u32 XSystolic_gemm_Read_B_Bytes(XSystolic_gemm *InstancePtr, int offset, char *data, int length);
u32 XSystolic_gemm_Get_C_BaseAddress(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Get_C_HighAddress(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Get_C_TotalBytes(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Get_C_BitWidth(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Get_C_Depth(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_Write_C_Words(XSystolic_gemm *InstancePtr, int offset, word_type *data, int length);
u32 XSystolic_gemm_Read_C_Words(XSystolic_gemm *InstancePtr, int offset, word_type *data, int length);
u32 XSystolic_gemm_Write_C_Bytes(XSystolic_gemm *InstancePtr, int offset, char *data, int length);
u32 XSystolic_gemm_Read_C_Bytes(XSystolic_gemm *InstancePtr, int offset, char *data, int length);

void XSystolic_gemm_InterruptGlobalEnable(XSystolic_gemm *InstancePtr);
void XSystolic_gemm_InterruptGlobalDisable(XSystolic_gemm *InstancePtr);
void XSystolic_gemm_InterruptEnable(XSystolic_gemm *InstancePtr, u32 Mask);
void XSystolic_gemm_InterruptDisable(XSystolic_gemm *InstancePtr, u32 Mask);
void XSystolic_gemm_InterruptClear(XSystolic_gemm *InstancePtr, u32 Mask);
u32 XSystolic_gemm_InterruptGetEnabled(XSystolic_gemm *InstancePtr);
u32 XSystolic_gemm_InterruptGetStatus(XSystolic_gemm *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
