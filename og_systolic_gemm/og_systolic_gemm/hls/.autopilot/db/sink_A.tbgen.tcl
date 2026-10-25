set moduleName sink_A
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
set C_modelName {sink_A}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ aS_0_3 int 16 regular {fifo 0 volatile }  }
	{ aS_1_3 int 16 regular {fifo 0 volatile }  }
	{ aS_2_3 int 16 regular {fifo 0 volatile }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "aS_0_3", "interface" : "fifo", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "aS_1_3", "interface" : "fifo", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "aS_2_3", "interface" : "fifo", "bitwidth" : 16, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 22
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ aS_1_3_dout sc_in sc_lv 16 signal 1 } 
	{ aS_1_3_empty_n sc_in sc_logic 1 signal 1 } 
	{ aS_1_3_read sc_out sc_logic 1 signal 1 } 
	{ aS_1_3_num_data_valid sc_in sc_lv 3 signal 1 } 
	{ aS_1_3_fifo_cap sc_in sc_lv 3 signal 1 } 
	{ aS_0_3_dout sc_in sc_lv 16 signal 0 } 
	{ aS_0_3_empty_n sc_in sc_logic 1 signal 0 } 
	{ aS_0_3_read sc_out sc_logic 1 signal 0 } 
	{ aS_0_3_num_data_valid sc_in sc_lv 3 signal 0 } 
	{ aS_0_3_fifo_cap sc_in sc_lv 3 signal 0 } 
	{ aS_2_3_dout sc_in sc_lv 16 signal 2 } 
	{ aS_2_3_empty_n sc_in sc_logic 1 signal 2 } 
	{ aS_2_3_read sc_out sc_logic 1 signal 2 } 
	{ aS_2_3_num_data_valid sc_in sc_lv 3 signal 2 } 
	{ aS_2_3_fifo_cap sc_in sc_lv 3 signal 2 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "aS_1_3_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "aS_1_3", "role": "dout" }} , 
 	{ "name": "aS_1_3_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "aS_1_3", "role": "empty_n" }} , 
 	{ "name": "aS_1_3_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "aS_1_3", "role": "read" }} , 
 	{ "name": "aS_1_3_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "aS_1_3", "role": "num_data_valid" }} , 
 	{ "name": "aS_1_3_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "aS_1_3", "role": "fifo_cap" }} , 
 	{ "name": "aS_0_3_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "aS_0_3", "role": "dout" }} , 
 	{ "name": "aS_0_3_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "aS_0_3", "role": "empty_n" }} , 
 	{ "name": "aS_0_3_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "aS_0_3", "role": "read" }} , 
 	{ "name": "aS_0_3_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "aS_0_3", "role": "num_data_valid" }} , 
 	{ "name": "aS_0_3_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "aS_0_3", "role": "fifo_cap" }} , 
 	{ "name": "aS_2_3_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "aS_2_3", "role": "dout" }} , 
 	{ "name": "aS_2_3_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "aS_2_3", "role": "empty_n" }} , 
 	{ "name": "aS_2_3_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "aS_2_3", "role": "read" }} , 
 	{ "name": "aS_2_3_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "aS_2_3", "role": "num_data_valid" }} , 
 	{ "name": "aS_2_3_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "aS_2_3", "role": "fifo_cap" }}  ]}

set ArgLastReadFirstWriteLatency {
	sink_A {
		aS_0_3 {Type I LastRead 1 FirstWrite -1}
		aS_1_3 {Type I LastRead 1 FirstWrite -1}
		aS_2_3 {Type I LastRead 1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "11", "Max" : "11"}
	, {"Name" : "Interval", "Min" : "10", "Max" : "10"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	aS_0_3 { ap_fifo {  { aS_0_3_dout fifo_data_out 0 16 }  { aS_0_3_empty_n fifo_status_empty 0 1 }  { aS_0_3_read fifo_data_in 1 1 }  { aS_0_3_num_data_valid fifo_update 0 3 }  { aS_0_3_fifo_cap fifo_data 0 3 } } }
	aS_1_3 { ap_fifo {  { aS_1_3_dout fifo_data_out 0 16 }  { aS_1_3_empty_n fifo_status_empty 0 1 }  { aS_1_3_read fifo_data_in 1 1 }  { aS_1_3_num_data_valid fifo_update 0 3 }  { aS_1_3_fifo_cap fifo_data 0 3 } } }
	aS_2_3 { ap_fifo {  { aS_2_3_dout fifo_data_out 0 16 }  { aS_2_3_empty_n fifo_status_empty 0 1 }  { aS_2_3_read fifo_data_in 1 1 }  { aS_2_3_num_data_valid fifo_update 0 3 }  { aS_2_3_fifo_cap fifo_data 0 3 } } }
}
