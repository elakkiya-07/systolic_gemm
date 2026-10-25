set moduleName og_systolic_gemm_Pipeline_WR_VITIS_LOOP_145_2
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set isPipelined_legacy 1
set pipeline_type loop_auto_rewind
set FunctionProtocol ap_ctrl_hs
set restart_counter_num 0
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 29
set C_modelName {og_systolic_gemm_Pipeline_WR_VITIS_LOOP_145_2}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ C_load int 32 regular  }
	{ C_1_load int 32 regular  }
	{ C_2_load int 32 regular  }
	{ C_3_load int 32 regular  }
	{ C_4_load int 32 regular  }
	{ C_5_load int 32 regular  }
	{ C_6_load int 32 regular  }
	{ C_7_load int 32 regular  }
	{ C_8_load int 32 regular  }
	{ out_C_V_data_V int 32 regular {axi_s 1 volatile  { out_C Data } }  }
	{ out_C_V_keep_V int 4 regular {axi_s 1 volatile  { out_C Keep } }  }
	{ out_C_V_strb_V int 4 regular {axi_s 1 volatile  { out_C Strb } }  }
	{ out_C_V_last_V int 1 regular {axi_s 1 volatile  { out_C Last } }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "C_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "C_1_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "C_2_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "C_3_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "C_4_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "C_5_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "C_6_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "C_7_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "C_8_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "out_C_V_data_V", "interface" : "axis", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "out_C_V_keep_V", "interface" : "axis", "bitwidth" : 4, "direction" : "WRITEONLY"} , 
 	{ "Name" : "out_C_V_strb_V", "interface" : "axis", "bitwidth" : 4, "direction" : "WRITEONLY"} , 
 	{ "Name" : "out_C_V_last_V", "interface" : "axis", "bitwidth" : 1, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 21
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ out_C_TREADY sc_in sc_logic 1 outacc 9 } 
	{ C_load sc_in sc_lv 32 signal 0 } 
	{ C_1_load sc_in sc_lv 32 signal 1 } 
	{ C_2_load sc_in sc_lv 32 signal 2 } 
	{ C_3_load sc_in sc_lv 32 signal 3 } 
	{ C_4_load sc_in sc_lv 32 signal 4 } 
	{ C_5_load sc_in sc_lv 32 signal 5 } 
	{ C_6_load sc_in sc_lv 32 signal 6 } 
	{ C_7_load sc_in sc_lv 32 signal 7 } 
	{ C_8_load sc_in sc_lv 32 signal 8 } 
	{ out_C_TDATA sc_out sc_lv 32 signal 9 } 
	{ out_C_TVALID sc_out sc_logic 1 outvld 12 } 
	{ out_C_TKEEP sc_out sc_lv 4 signal 10 } 
	{ out_C_TSTRB sc_out sc_lv 4 signal 11 } 
	{ out_C_TLAST sc_out sc_lv 1 signal 12 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "out_C_TREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "outacc", "bundle":{"name": "out_C_V_data_V", "role": "default" }} , 
 	{ "name": "C_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_load", "role": "default" }} , 
 	{ "name": "C_1_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_1_load", "role": "default" }} , 
 	{ "name": "C_2_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_2_load", "role": "default" }} , 
 	{ "name": "C_3_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_3_load", "role": "default" }} , 
 	{ "name": "C_4_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_4_load", "role": "default" }} , 
 	{ "name": "C_5_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_5_load", "role": "default" }} , 
 	{ "name": "C_6_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_6_load", "role": "default" }} , 
 	{ "name": "C_7_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_7_load", "role": "default" }} , 
 	{ "name": "C_8_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_8_load", "role": "default" }} , 
 	{ "name": "out_C_TDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "out_C_V_data_V", "role": "default" }} , 
 	{ "name": "out_C_TVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "out_C_V_last_V", "role": "default" }} , 
 	{ "name": "out_C_TKEEP", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "out_C_V_keep_V", "role": "default" }} , 
 	{ "name": "out_C_TSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "out_C_V_strb_V", "role": "default" }} , 
 	{ "name": "out_C_TLAST", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "out_C_V_last_V", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	og_systolic_gemm_Pipeline_WR_VITIS_LOOP_145_2 {
		C_load {Type I LastRead 0 FirstWrite -1}
		C_1_load {Type I LastRead 0 FirstWrite -1}
		C_2_load {Type I LastRead 0 FirstWrite -1}
		C_3_load {Type I LastRead 0 FirstWrite -1}
		C_4_load {Type I LastRead 0 FirstWrite -1}
		C_5_load {Type I LastRead 0 FirstWrite -1}
		C_6_load {Type I LastRead 0 FirstWrite -1}
		C_7_load {Type I LastRead 0 FirstWrite -1}
		C_8_load {Type I LastRead 0 FirstWrite -1}
		out_C_V_data_V {Type O LastRead -1 FirstWrite 1}
		out_C_V_keep_V {Type O LastRead -1 FirstWrite 1}
		out_C_V_strb_V {Type O LastRead -1 FirstWrite 1}
		out_C_V_last_V {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "11", "Max" : "11"}
	, {"Name" : "Interval", "Min" : "10", "Max" : "10"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	C_load { ap_none {  { C_load in_data 0 32 } } }
	C_1_load { ap_none {  { C_1_load in_data 0 32 } } }
	C_2_load { ap_none {  { C_2_load in_data 0 32 } } }
	C_3_load { ap_none {  { C_3_load in_data 0 32 } } }
	C_4_load { ap_none {  { C_4_load in_data 0 32 } } }
	C_5_load { ap_none {  { C_5_load in_data 0 32 } } }
	C_6_load { ap_none {  { C_6_load in_data 0 32 } } }
	C_7_load { ap_none {  { C_7_load in_data 0 32 } } }
	C_8_load { ap_none {  { C_8_load in_data 0 32 } } }
	out_C_V_data_V { axis {  { out_C_TREADY out_acc 0 1 }  { out_C_TDATA out_data 1 32 } } }
	out_C_V_keep_V { axis {  { out_C_TKEEP out_data 1 4 } } }
	out_C_V_strb_V { axis {  { out_C_TSTRB out_data 1 4 } } }
	out_C_V_last_V { axis {  { out_C_TVALID out_vld 1 1 }  { out_C_TLAST out_data 1 1 } } }
}
