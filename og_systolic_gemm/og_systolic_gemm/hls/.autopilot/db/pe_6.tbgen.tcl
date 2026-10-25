set moduleName pe_6
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set isPipelined_legacy 0
set pipeline_type none
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
set C_modelName {pe.6}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ aS_1_2 int 16 regular {fifo 0 volatile }  }
	{ aS_1_3 int 16 regular {fifo 1 volatile }  }
	{ bS_1_2 int 16 regular {fifo 0 volatile }  }
	{ bS_2_2 int 16 regular {fifo 1 volatile }  }
	{ cS_1_2 int 32 regular {fifo 1 volatile }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "aS_1_2", "interface" : "fifo", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "aS_1_3", "interface" : "fifo", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "bS_1_2", "interface" : "fifo", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "bS_2_2", "interface" : "fifo", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "cS_1_2", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 35
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ start_full_n sc_in sc_logic 1 signal -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ start_out sc_out sc_logic 1 signal -1 } 
	{ start_write sc_out sc_logic 1 signal -1 } 
	{ aS_1_2_dout sc_in sc_lv 16 signal 0 } 
	{ aS_1_2_empty_n sc_in sc_logic 1 signal 0 } 
	{ aS_1_2_read sc_out sc_logic 1 signal 0 } 
	{ aS_1_2_num_data_valid sc_in sc_lv 3 signal 0 } 
	{ aS_1_2_fifo_cap sc_in sc_lv 3 signal 0 } 
	{ aS_1_3_din sc_out sc_lv 16 signal 1 } 
	{ aS_1_3_full_n sc_in sc_logic 1 signal 1 } 
	{ aS_1_3_write sc_out sc_logic 1 signal 1 } 
	{ aS_1_3_num_data_valid sc_in sc_lv 32 signal 1 } 
	{ aS_1_3_fifo_cap sc_in sc_lv 32 signal 1 } 
	{ bS_1_2_dout sc_in sc_lv 16 signal 2 } 
	{ bS_1_2_empty_n sc_in sc_logic 1 signal 2 } 
	{ bS_1_2_read sc_out sc_logic 1 signal 2 } 
	{ bS_1_2_num_data_valid sc_in sc_lv 3 signal 2 } 
	{ bS_1_2_fifo_cap sc_in sc_lv 3 signal 2 } 
	{ bS_2_2_din sc_out sc_lv 16 signal 3 } 
	{ bS_2_2_full_n sc_in sc_logic 1 signal 3 } 
	{ bS_2_2_write sc_out sc_logic 1 signal 3 } 
	{ bS_2_2_num_data_valid sc_in sc_lv 32 signal 3 } 
	{ bS_2_2_fifo_cap sc_in sc_lv 32 signal 3 } 
	{ cS_1_2_din sc_out sc_lv 32 signal 4 } 
	{ cS_1_2_full_n sc_in sc_logic 1 signal 4 } 
	{ cS_1_2_write sc_out sc_logic 1 signal 4 } 
	{ cS_1_2_num_data_valid sc_in sc_lv 3 signal 4 } 
	{ cS_1_2_fifo_cap sc_in sc_lv 3 signal 4 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "start_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "start_full_n", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "start_out", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "start_out", "role": "default" }} , 
 	{ "name": "start_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "start_write", "role": "default" }} , 
 	{ "name": "aS_1_2_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "aS_1_2", "role": "dout" }} , 
 	{ "name": "aS_1_2_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "aS_1_2", "role": "empty_n" }} , 
 	{ "name": "aS_1_2_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "aS_1_2", "role": "read" }} , 
 	{ "name": "aS_1_2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "aS_1_2", "role": "num_data_valid" }} , 
 	{ "name": "aS_1_2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "aS_1_2", "role": "fifo_cap" }} , 
 	{ "name": "aS_1_3_din", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "aS_1_3", "role": "din" }} , 
 	{ "name": "aS_1_3_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "aS_1_3", "role": "full_n" }} , 
 	{ "name": "aS_1_3_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "aS_1_3", "role": "write" }} , 
 	{ "name": "aS_1_3_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aS_1_3", "role": "num_data_valid" }} , 
 	{ "name": "aS_1_3_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aS_1_3", "role": "fifo_cap" }} , 
 	{ "name": "bS_1_2_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "bS_1_2", "role": "dout" }} , 
 	{ "name": "bS_1_2_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bS_1_2", "role": "empty_n" }} , 
 	{ "name": "bS_1_2_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bS_1_2", "role": "read" }} , 
 	{ "name": "bS_1_2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "bS_1_2", "role": "num_data_valid" }} , 
 	{ "name": "bS_1_2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "bS_1_2", "role": "fifo_cap" }} , 
 	{ "name": "bS_2_2_din", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "bS_2_2", "role": "din" }} , 
 	{ "name": "bS_2_2_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bS_2_2", "role": "full_n" }} , 
 	{ "name": "bS_2_2_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bS_2_2", "role": "write" }} , 
 	{ "name": "bS_2_2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bS_2_2", "role": "num_data_valid" }} , 
 	{ "name": "bS_2_2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bS_2_2", "role": "fifo_cap" }} , 
 	{ "name": "cS_1_2_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cS_1_2", "role": "din" }} , 
 	{ "name": "cS_1_2_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_1_2", "role": "full_n" }} , 
 	{ "name": "cS_1_2_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_1_2", "role": "write" }} , 
 	{ "name": "cS_1_2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_1_2", "role": "num_data_valid" }} , 
 	{ "name": "cS_1_2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_1_2", "role": "fifo_cap" }}  ]}

set ArgLastReadFirstWriteLatency {
	pe_6 {
		aS_1_2 {Type I LastRead 1 FirstWrite -1}
		aS_1_3 {Type O LastRead -1 FirstWrite 1}
		bS_1_2 {Type I LastRead 1 FirstWrite -1}
		bS_2_2 {Type O LastRead -1 FirstWrite 1}
		cS_1_2 {Type O LastRead -1 FirstWrite 2}}
	pe_6_Pipeline_PE_LOOP {
		aS_1_2 {Type I LastRead 1 FirstWrite -1}
		bS_1_2 {Type I LastRead 1 FirstWrite -1}
		aS_1_3 {Type O LastRead -1 FirstWrite 1}
		bS_2_2 {Type O LastRead -1 FirstWrite 1}
		acc_out {Type O LastRead -1 FirstWrite 3}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "10", "Max" : "10"}
	, {"Name" : "Interval", "Min" : "10", "Max" : "10"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	aS_1_2 { ap_fifo {  { aS_1_2_dout fifo_data_out 0 16 }  { aS_1_2_empty_n fifo_status_empty 0 1 }  { aS_1_2_read fifo_data_in 1 1 }  { aS_1_2_num_data_valid fifo_update 0 3 }  { aS_1_2_fifo_cap fifo_data 0 3 } } }
	aS_1_3 { ap_fifo {  { aS_1_3_din fifo_data_out 1 16 }  { aS_1_3_full_n fifo_status_empty 0 1 }  { aS_1_3_write fifo_data_in 1 1 }  { aS_1_3_num_data_valid fifo_update 0 32 }  { aS_1_3_fifo_cap fifo_data 0 32 } } }
	bS_1_2 { ap_fifo {  { bS_1_2_dout fifo_data_out 0 16 }  { bS_1_2_empty_n fifo_status_empty 0 1 }  { bS_1_2_read fifo_data_in 1 1 }  { bS_1_2_num_data_valid fifo_update 0 3 }  { bS_1_2_fifo_cap fifo_data 0 3 } } }
	bS_2_2 { ap_fifo {  { bS_2_2_din fifo_data_out 1 16 }  { bS_2_2_full_n fifo_status_empty 0 1 }  { bS_2_2_write fifo_data_in 1 1 }  { bS_2_2_num_data_valid fifo_update 0 32 }  { bS_2_2_fifo_cap fifo_data 0 32 } } }
	cS_1_2 { ap_fifo {  { cS_1_2_din fifo_data_out 1 32 }  { cS_1_2_full_n fifo_status_empty 0 1 }  { cS_1_2_write fifo_data_in 1 1 }  { cS_1_2_num_data_valid fifo_update 0 3 }  { cS_1_2_fifo_cap fifo_data 0 3 } } }
}
