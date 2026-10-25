set moduleName pe_3_Pipeline_PE_LOOP
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
set C_modelName {pe.3_Pipeline_PE_LOOP}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ aS_0_2 int 16 regular {fifo 0 volatile }  }
	{ bS_0_2 int 16 regular {fifo 0 volatile }  }
	{ aS_0_3 int 16 regular {fifo 1 volatile }  }
	{ bS_1_2 int 16 regular {fifo 1 volatile }  }
	{ acc_04_out int 32 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "aS_0_2", "interface" : "fifo", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "bS_0_2", "interface" : "fifo", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "aS_0_3", "interface" : "fifo", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "bS_1_2", "interface" : "fifo", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "acc_04_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 28
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ aS_0_2_dout sc_in sc_lv 16 signal 0 } 
	{ aS_0_2_empty_n sc_in sc_logic 1 signal 0 } 
	{ aS_0_2_read sc_out sc_logic 1 signal 0 } 
	{ aS_0_2_num_data_valid sc_in sc_lv 3 signal 0 } 
	{ aS_0_2_fifo_cap sc_in sc_lv 3 signal 0 } 
	{ bS_0_2_dout sc_in sc_lv 16 signal 1 } 
	{ bS_0_2_empty_n sc_in sc_logic 1 signal 1 } 
	{ bS_0_2_read sc_out sc_logic 1 signal 1 } 
	{ bS_0_2_num_data_valid sc_in sc_lv 3 signal 1 } 
	{ bS_0_2_fifo_cap sc_in sc_lv 3 signal 1 } 
	{ aS_0_3_din sc_out sc_lv 16 signal 2 } 
	{ aS_0_3_full_n sc_in sc_logic 1 signal 2 } 
	{ aS_0_3_write sc_out sc_logic 1 signal 2 } 
	{ aS_0_3_num_data_valid sc_in sc_lv 32 signal 2 } 
	{ aS_0_3_fifo_cap sc_in sc_lv 32 signal 2 } 
	{ bS_1_2_din sc_out sc_lv 16 signal 3 } 
	{ bS_1_2_full_n sc_in sc_logic 1 signal 3 } 
	{ bS_1_2_write sc_out sc_logic 1 signal 3 } 
	{ bS_1_2_num_data_valid sc_in sc_lv 32 signal 3 } 
	{ bS_1_2_fifo_cap sc_in sc_lv 32 signal 3 } 
	{ acc_04_out sc_out sc_lv 32 signal 4 } 
	{ acc_04_out_ap_vld sc_out sc_logic 1 outvld 4 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "aS_0_2_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "aS_0_2", "role": "dout" }} , 
 	{ "name": "aS_0_2_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "aS_0_2", "role": "empty_n" }} , 
 	{ "name": "aS_0_2_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "aS_0_2", "role": "read" }} , 
 	{ "name": "aS_0_2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "aS_0_2", "role": "num_data_valid" }} , 
 	{ "name": "aS_0_2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "aS_0_2", "role": "fifo_cap" }} , 
 	{ "name": "bS_0_2_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "bS_0_2", "role": "dout" }} , 
 	{ "name": "bS_0_2_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bS_0_2", "role": "empty_n" }} , 
 	{ "name": "bS_0_2_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bS_0_2", "role": "read" }} , 
 	{ "name": "bS_0_2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "bS_0_2", "role": "num_data_valid" }} , 
 	{ "name": "bS_0_2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "bS_0_2", "role": "fifo_cap" }} , 
 	{ "name": "aS_0_3_din", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "aS_0_3", "role": "din" }} , 
 	{ "name": "aS_0_3_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "aS_0_3", "role": "full_n" }} , 
 	{ "name": "aS_0_3_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "aS_0_3", "role": "write" }} , 
 	{ "name": "aS_0_3_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aS_0_3", "role": "num_data_valid" }} , 
 	{ "name": "aS_0_3_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aS_0_3", "role": "fifo_cap" }} , 
 	{ "name": "bS_1_2_din", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "bS_1_2", "role": "din" }} , 
 	{ "name": "bS_1_2_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bS_1_2", "role": "full_n" }} , 
 	{ "name": "bS_1_2_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bS_1_2", "role": "write" }} , 
 	{ "name": "bS_1_2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bS_1_2", "role": "num_data_valid" }} , 
 	{ "name": "bS_1_2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bS_1_2", "role": "fifo_cap" }} , 
 	{ "name": "acc_04_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "acc_04_out", "role": "default" }} , 
 	{ "name": "acc_04_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "acc_04_out", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	pe_3_Pipeline_PE_LOOP {
		aS_0_2 {Type I LastRead 1 FirstWrite -1}
		bS_0_2 {Type I LastRead 1 FirstWrite -1}
		aS_0_3 {Type O LastRead -1 FirstWrite 1}
		bS_1_2 {Type O LastRead -1 FirstWrite 1}
		acc_04_out {Type O LastRead -1 FirstWrite 3}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "8", "Max" : "8"}
	, {"Name" : "Interval", "Min" : "4", "Max" : "4"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	aS_0_2 { ap_fifo {  { aS_0_2_dout fifo_data_out 0 16 }  { aS_0_2_empty_n fifo_status_empty 0 1 }  { aS_0_2_read fifo_data_in 1 1 }  { aS_0_2_num_data_valid fifo_update 0 3 }  { aS_0_2_fifo_cap fifo_data 0 3 } } }
	bS_0_2 { ap_fifo {  { bS_0_2_dout fifo_data_out 0 16 }  { bS_0_2_empty_n fifo_status_empty 0 1 }  { bS_0_2_read fifo_data_in 1 1 }  { bS_0_2_num_data_valid fifo_update 0 3 }  { bS_0_2_fifo_cap fifo_data 0 3 } } }
	aS_0_3 { ap_fifo {  { aS_0_3_din fifo_data_out 1 16 }  { aS_0_3_full_n fifo_status_empty 0 1 }  { aS_0_3_write fifo_data_in 1 1 }  { aS_0_3_num_data_valid fifo_update 0 32 }  { aS_0_3_fifo_cap fifo_data 0 32 } } }
	bS_1_2 { ap_fifo {  { bS_1_2_din fifo_data_out 1 16 }  { bS_1_2_full_n fifo_status_empty 0 1 }  { bS_1_2_write fifo_data_in 1 1 }  { bS_1_2_num_data_valid fifo_update 0 32 }  { bS_1_2_fifo_cap fifo_data 0 32 } } }
	acc_04_out { ap_vld {  { acc_04_out out_data 1 32 }  { acc_04_out_ap_vld out_vld 1 1 } } }
}
