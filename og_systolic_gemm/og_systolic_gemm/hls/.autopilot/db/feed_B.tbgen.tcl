set moduleName feed_B
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
set C_modelName {feed_B}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ B_0_0_val int 16 regular {ap_stable 0} }
	{ B_0_1_val int 16 regular {ap_stable 0} }
	{ B_0_2_val int 16 regular {ap_stable 0} }
	{ B_1_0_val int 16 regular {ap_stable 0} }
	{ B_1_1_val int 16 regular {ap_stable 0} }
	{ B_1_2_val int 16 regular {ap_stable 0} }
	{ B_2_0_val int 16 regular {ap_stable 0} }
	{ B_2_1_val int 16 regular {ap_stable 0} }
	{ B_2_2_val int 16 regular {ap_stable 0} }
	{ bS_0_0 int 16 regular {fifo 1 volatile }  }
	{ bS_0_1 int 16 regular {fifo 1 volatile }  }
	{ bS_0_2 int 16 regular {fifo 1 volatile }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "B_0_0_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_0_1_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_0_2_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_1_0_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_1_1_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_1_2_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_2_0_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_2_1_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_2_2_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "bS_0_0", "interface" : "fifo", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "bS_0_1", "interface" : "fifo", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "bS_0_2", "interface" : "fifo", "bitwidth" : 16, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 34
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ start_full_n sc_in sc_logic 1 signal -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ bS_0_1_din sc_out sc_lv 16 signal 10 } 
	{ bS_0_1_full_n sc_in sc_logic 1 signal 10 } 
	{ bS_0_1_write sc_out sc_logic 1 signal 10 } 
	{ bS_0_1_num_data_valid sc_in sc_lv 32 signal 10 } 
	{ bS_0_1_fifo_cap sc_in sc_lv 32 signal 10 } 
	{ bS_0_0_din sc_out sc_lv 16 signal 9 } 
	{ bS_0_0_full_n sc_in sc_logic 1 signal 9 } 
	{ bS_0_0_write sc_out sc_logic 1 signal 9 } 
	{ bS_0_0_num_data_valid sc_in sc_lv 32 signal 9 } 
	{ bS_0_0_fifo_cap sc_in sc_lv 32 signal 9 } 
	{ bS_0_2_din sc_out sc_lv 16 signal 11 } 
	{ bS_0_2_full_n sc_in sc_logic 1 signal 11 } 
	{ bS_0_2_write sc_out sc_logic 1 signal 11 } 
	{ bS_0_2_num_data_valid sc_in sc_lv 32 signal 11 } 
	{ bS_0_2_fifo_cap sc_in sc_lv 32 signal 11 } 
	{ start_out sc_out sc_logic 1 signal -1 } 
	{ start_write sc_out sc_logic 1 signal -1 } 
	{ B_0_0_val sc_in sc_lv 16 signal 0 } 
	{ B_0_1_val sc_in sc_lv 16 signal 1 } 
	{ B_0_2_val sc_in sc_lv 16 signal 2 } 
	{ B_1_0_val sc_in sc_lv 16 signal 3 } 
	{ B_1_1_val sc_in sc_lv 16 signal 4 } 
	{ B_1_2_val sc_in sc_lv 16 signal 5 } 
	{ B_2_0_val sc_in sc_lv 16 signal 6 } 
	{ B_2_1_val sc_in sc_lv 16 signal 7 } 
	{ B_2_2_val sc_in sc_lv 16 signal 8 } 
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
 	{ "name": "bS_0_1_din", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "bS_0_1", "role": "din" }} , 
 	{ "name": "bS_0_1_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bS_0_1", "role": "full_n" }} , 
 	{ "name": "bS_0_1_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bS_0_1", "role": "write" }} , 
 	{ "name": "bS_0_1_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bS_0_1", "role": "num_data_valid" }} , 
 	{ "name": "bS_0_1_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bS_0_1", "role": "fifo_cap" }} , 
 	{ "name": "bS_0_0_din", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "bS_0_0", "role": "din" }} , 
 	{ "name": "bS_0_0_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bS_0_0", "role": "full_n" }} , 
 	{ "name": "bS_0_0_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bS_0_0", "role": "write" }} , 
 	{ "name": "bS_0_0_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bS_0_0", "role": "num_data_valid" }} , 
 	{ "name": "bS_0_0_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bS_0_0", "role": "fifo_cap" }} , 
 	{ "name": "bS_0_2_din", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "bS_0_2", "role": "din" }} , 
 	{ "name": "bS_0_2_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bS_0_2", "role": "full_n" }} , 
 	{ "name": "bS_0_2_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bS_0_2", "role": "write" }} , 
 	{ "name": "bS_0_2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bS_0_2", "role": "num_data_valid" }} , 
 	{ "name": "bS_0_2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bS_0_2", "role": "fifo_cap" }} , 
 	{ "name": "start_out", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "start_out", "role": "default" }} , 
 	{ "name": "start_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "start_write", "role": "default" }} , 
 	{ "name": "B_0_0_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_0_0_val", "role": "default" }} , 
 	{ "name": "B_0_1_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_0_1_val", "role": "default" }} , 
 	{ "name": "B_0_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_0_2_val", "role": "default" }} , 
 	{ "name": "B_1_0_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_1_0_val", "role": "default" }} , 
 	{ "name": "B_1_1_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_1_1_val", "role": "default" }} , 
 	{ "name": "B_1_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_1_2_val", "role": "default" }} , 
 	{ "name": "B_2_0_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_2_0_val", "role": "default" }} , 
 	{ "name": "B_2_1_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_2_1_val", "role": "default" }} , 
 	{ "name": "B_2_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_2_2_val", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	feed_B {
		B_0_0_val {Type I LastRead 0 FirstWrite -1}
		B_0_1_val {Type I LastRead 0 FirstWrite -1}
		B_0_2_val {Type I LastRead 0 FirstWrite -1}
		B_1_0_val {Type I LastRead 0 FirstWrite -1}
		B_1_1_val {Type I LastRead 0 FirstWrite -1}
		B_1_2_val {Type I LastRead 0 FirstWrite -1}
		B_2_0_val {Type I LastRead 0 FirstWrite -1}
		B_2_1_val {Type I LastRead 0 FirstWrite -1}
		B_2_2_val {Type I LastRead 0 FirstWrite -1}
		bS_0_0 {Type O LastRead -1 FirstWrite 1}
		bS_0_1 {Type O LastRead -1 FirstWrite 1}
		bS_0_2 {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "11", "Max" : "11"}
	, {"Name" : "Interval", "Min" : "10", "Max" : "10"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	B_0_0_val { ap_stable {  { B_0_0_val in_data 0 16 } } }
	B_0_1_val { ap_stable {  { B_0_1_val in_data 0 16 } } }
	B_0_2_val { ap_stable {  { B_0_2_val in_data 0 16 } } }
	B_1_0_val { ap_stable {  { B_1_0_val in_data 0 16 } } }
	B_1_1_val { ap_stable {  { B_1_1_val in_data 0 16 } } }
	B_1_2_val { ap_stable {  { B_1_2_val in_data 0 16 } } }
	B_2_0_val { ap_stable {  { B_2_0_val in_data 0 16 } } }
	B_2_1_val { ap_stable {  { B_2_1_val in_data 0 16 } } }
	B_2_2_val { ap_stable {  { B_2_2_val in_data 0 16 } } }
	bS_0_0 { ap_fifo {  { bS_0_0_din fifo_data_out 1 16 }  { bS_0_0_full_n fifo_status_empty 0 1 }  { bS_0_0_write fifo_data_in 1 1 }  { bS_0_0_num_data_valid fifo_update 0 32 }  { bS_0_0_fifo_cap fifo_data 0 32 } } }
	bS_0_1 { ap_fifo {  { bS_0_1_din fifo_data_out 1 16 }  { bS_0_1_full_n fifo_status_empty 0 1 }  { bS_0_1_write fifo_data_in 1 1 }  { bS_0_1_num_data_valid fifo_update 0 32 }  { bS_0_1_fifo_cap fifo_data 0 32 } } }
	bS_0_2 { ap_fifo {  { bS_0_2_din fifo_data_out 1 16 }  { bS_0_2_full_n fifo_status_empty 0 1 }  { bS_0_2_write fifo_data_in 1 1 }  { bS_0_2_num_data_valid fifo_update 0 32 }  { bS_0_2_fifo_cap fifo_data 0 32 } } }
}
