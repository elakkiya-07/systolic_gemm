// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XOG_SYSTOLIC_GEMM_H
#define XOG_SYSTOLIC_GEMM_H

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
#include "xog_systolic_gemm_hw.h"

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
} XOg_systolic_gemm_Config;
#endif

typedef struct {
    u64 Ctrl_BaseAddress;
    u32 IsReady;
} XOg_systolic_gemm;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XOg_systolic_gemm_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XOg_systolic_gemm_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XOg_systolic_gemm_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XOg_systolic_gemm_ReadReg(BaseAddress, RegOffset) \
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
int XOg_systolic_gemm_Initialize(XOg_systolic_gemm *InstancePtr, UINTPTR BaseAddress);
XOg_systolic_gemm_Config* XOg_systolic_gemm_LookupConfig(UINTPTR BaseAddress);
#else
int XOg_systolic_gemm_Initialize(XOg_systolic_gemm *InstancePtr, u16 DeviceId);
XOg_systolic_gemm_Config* XOg_systolic_gemm_LookupConfig(u16 DeviceId);
#endif
int XOg_systolic_gemm_CfgInitialize(XOg_systolic_gemm *InstancePtr, XOg_systolic_gemm_Config *ConfigPtr);
#else
int XOg_systolic_gemm_Initialize(XOg_systolic_gemm *InstancePtr, const char* InstanceName);
int XOg_systolic_gemm_Release(XOg_systolic_gemm *InstancePtr);
#endif

void XOg_systolic_gemm_Start(XOg_systolic_gemm *InstancePtr);
u32 XOg_systolic_gemm_IsDone(XOg_systolic_gemm *InstancePtr);
u32 XOg_systolic_gemm_IsIdle(XOg_systolic_gemm *InstancePtr);
u32 XOg_systolic_gemm_IsReady(XOg_systolic_gemm *InstancePtr);
void XOg_systolic_gemm_EnableAutoRestart(XOg_systolic_gemm *InstancePtr);
void XOg_systolic_gemm_DisableAutoRestart(XOg_systolic_gemm *InstancePtr);


void XOg_systolic_gemm_InterruptGlobalEnable(XOg_systolic_gemm *InstancePtr);
void XOg_systolic_gemm_InterruptGlobalDisable(XOg_systolic_gemm *InstancePtr);
void XOg_systolic_gemm_InterruptEnable(XOg_systolic_gemm *InstancePtr, u32 Mask);
void XOg_systolic_gemm_InterruptDisable(XOg_systolic_gemm *InstancePtr, u32 Mask);
void XOg_systolic_gemm_InterruptClear(XOg_systolic_gemm *InstancePtr, u32 Mask);
u32 XOg_systolic_gemm_InterruptGetEnabled(XOg_systolic_gemm *InstancePtr);
u32 XOg_systolic_gemm_InterruptGetStatus(XOg_systolic_gemm *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
