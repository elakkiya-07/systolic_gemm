// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xog_systolic_gemm.h"

extern XOg_systolic_gemm_Config XOg_systolic_gemm_ConfigTable[];

#ifdef SDT
XOg_systolic_gemm_Config *XOg_systolic_gemm_LookupConfig(UINTPTR BaseAddress) {
	XOg_systolic_gemm_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XOg_systolic_gemm_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XOg_systolic_gemm_ConfigTable[Index].Ctrl_BaseAddress == BaseAddress) {
			ConfigPtr = &XOg_systolic_gemm_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XOg_systolic_gemm_Initialize(XOg_systolic_gemm *InstancePtr, UINTPTR BaseAddress) {
	XOg_systolic_gemm_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XOg_systolic_gemm_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XOg_systolic_gemm_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XOg_systolic_gemm_Config *XOg_systolic_gemm_LookupConfig(u16 DeviceId) {
	XOg_systolic_gemm_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XOG_SYSTOLIC_GEMM_NUM_INSTANCES; Index++) {
		if (XOg_systolic_gemm_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XOg_systolic_gemm_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XOg_systolic_gemm_Initialize(XOg_systolic_gemm *InstancePtr, u16 DeviceId) {
	XOg_systolic_gemm_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XOg_systolic_gemm_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XOg_systolic_gemm_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

