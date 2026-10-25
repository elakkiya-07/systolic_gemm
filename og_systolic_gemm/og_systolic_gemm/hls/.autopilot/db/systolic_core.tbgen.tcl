set moduleName systolic_core
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set isPipelined_legacy 1
set pipeline_type dataflow
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
set C_modelName {systolic_core}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ A_0_0_val1 int 16 regular {ap_stable 0} }
	{ A_0_1_val2 int 16 regular {ap_stable 0} }
	{ A_0_2_val3 int 16 regular {ap_stable 0} }
	{ A_1_0_val4 int 16 regular {ap_stable 0} }
	{ A_1_1_val5 int 16 regular {ap_stable 0} }
	{ A_1_2_val6 int 16 regular {ap_stable 0} }
	{ A_2_0_val7 int 16 regular {ap_stable 0} }
	{ A_2_1_val8 int 16 regular {ap_stable 0} }
	{ A_2_2_val9 int 16 regular {ap_stable 0} }
	{ B_0_0_val10 int 16 regular {ap_stable 0} }
	{ B_0_1_val11 int 16 regular {ap_stable 0} }
	{ B_0_2_val12 int 16 regular {ap_stable 0} }
	{ B_1_0_val13 int 16 regular {ap_stable 0} }
	{ B_1_1_val14 int 16 regular {ap_stable 0} }
	{ B_1_2_val15 int 16 regular {ap_stable 0} }
	{ B_2_0_val16 int 16 regular {ap_stable 0} }
	{ B_2_1_val17 int 16 regular {ap_stable 0} }
	{ B_2_2_val18 int 16 regular {ap_stable 0} }
	{ C_0_0 int 32 regular {pointer 1}  }
	{ C_0_1 int 32 regular {pointer 1}  }
	{ C_0_2 int 32 regular {pointer 1}  }
	{ C_1_0 int 32 regular {pointer 1}  }
	{ C_1_1 int 32 regular {pointer 1}  }
	{ C_1_2 int 32 regular {pointer 1}  }
	{ C_2_0 int 32 regular {pointer 1}  }
	{ C_2_1 int 32 regular {pointer 1}  }
	{ C_2_2 int 32 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "A_0_0_val1", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "A_0_1_val2", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "A_0_2_val3", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "A_1_0_val4", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "A_1_1_val5", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "A_1_2_val6", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "A_2_0_val7", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "A_2_1_val8", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "A_2_2_val9", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_0_0_val10", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_0_1_val11", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_0_2_val12", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_1_0_val13", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_1_1_val14", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_1_2_val15", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_2_0_val16", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_2_1_val17", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "B_2_2_val18", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "C_0_0", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "C_0_1", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "C_0_2", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "C_1_0", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "C_1_1", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "C_1_2", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "C_2_0", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "C_2_1", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "C_2_2", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 61
set portList { 
	{ A_0_0_val1 sc_in sc_lv 16 signal 0 } 
	{ A_0_1_val2 sc_in sc_lv 16 signal 1 } 
	{ A_0_2_val3 sc_in sc_lv 16 signal 2 } 
	{ A_1_0_val4 sc_in sc_lv 16 signal 3 } 
	{ A_1_1_val5 sc_in sc_lv 16 signal 4 } 
	{ A_1_2_val6 sc_in sc_lv 16 signal 5 } 
	{ A_2_0_val7 sc_in sc_lv 16 signal 6 } 
	{ A_2_1_val8 sc_in sc_lv 16 signal 7 } 
	{ A_2_2_val9 sc_in sc_lv 16 signal 8 } 
	{ B_0_0_val10 sc_in sc_lv 16 signal 9 } 
	{ B_0_1_val11 sc_in sc_lv 16 signal 10 } 
	{ B_0_2_val12 sc_in sc_lv 16 signal 11 } 
	{ B_1_0_val13 sc_in sc_lv 16 signal 12 } 
	{ B_1_1_val14 sc_in sc_lv 16 signal 13 } 
	{ B_1_2_val15 sc_in sc_lv 16 signal 14 } 
	{ B_2_0_val16 sc_in sc_lv 16 signal 15 } 
	{ B_2_1_val17 sc_in sc_lv 16 signal 16 } 
	{ B_2_2_val18 sc_in sc_lv 16 signal 17 } 
	{ C_0_0 sc_out sc_lv 32 signal 18 } 
	{ C_0_1 sc_out sc_lv 32 signal 19 } 
	{ C_0_2 sc_out sc_lv 32 signal 20 } 
	{ C_1_0 sc_out sc_lv 32 signal 21 } 
	{ C_1_1 sc_out sc_lv 32 signal 22 } 
	{ C_1_2 sc_out sc_lv 32 signal 23 } 
	{ C_2_0 sc_out sc_lv 32 signal 24 } 
	{ C_2_1 sc_out sc_lv 32 signal 25 } 
	{ C_2_2 sc_out sc_lv 32 signal 26 } 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ A_0_0_val1_ap_vld sc_in sc_logic 1 invld 0 } 
	{ A_0_1_val2_ap_vld sc_in sc_logic 1 invld 1 } 
	{ A_0_2_val3_ap_vld sc_in sc_logic 1 invld 2 } 
	{ A_1_0_val4_ap_vld sc_in sc_logic 1 invld 3 } 
	{ A_1_1_val5_ap_vld sc_in sc_logic 1 invld 4 } 
	{ A_1_2_val6_ap_vld sc_in sc_logic 1 invld 5 } 
	{ A_2_0_val7_ap_vld sc_in sc_logic 1 invld 6 } 
	{ A_2_1_val8_ap_vld sc_in sc_logic 1 invld 7 } 
	{ A_2_2_val9_ap_vld sc_in sc_logic 1 invld 8 } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ B_0_0_val10_ap_vld sc_in sc_logic 1 invld 9 } 
	{ B_0_1_val11_ap_vld sc_in sc_logic 1 invld 10 } 
	{ B_0_2_val12_ap_vld sc_in sc_logic 1 invld 11 } 
	{ B_1_0_val13_ap_vld sc_in sc_logic 1 invld 12 } 
	{ B_1_1_val14_ap_vld sc_in sc_logic 1 invld 13 } 
	{ B_1_2_val15_ap_vld sc_in sc_logic 1 invld 14 } 
	{ B_2_0_val16_ap_vld sc_in sc_logic 1 invld 15 } 
	{ B_2_1_val17_ap_vld sc_in sc_logic 1 invld 16 } 
	{ B_2_2_val18_ap_vld sc_in sc_logic 1 invld 17 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ C_0_0_ap_vld sc_out sc_logic 1 outvld 18 } 
	{ C_0_1_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ C_0_2_ap_vld sc_out sc_logic 1 outvld 20 } 
	{ C_1_0_ap_vld sc_out sc_logic 1 outvld 21 } 
	{ C_1_1_ap_vld sc_out sc_logic 1 outvld 22 } 
	{ C_1_2_ap_vld sc_out sc_logic 1 outvld 23 } 
	{ C_2_0_ap_vld sc_out sc_logic 1 outvld 24 } 
	{ C_2_1_ap_vld sc_out sc_logic 1 outvld 25 } 
	{ C_2_2_ap_vld sc_out sc_logic 1 outvld 26 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
}
set NewPortList {[ 
	{ "name": "A_0_0_val1", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "A_0_0_val1", "role": "default" }} , 
 	{ "name": "A_0_1_val2", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "A_0_1_val2", "role": "default" }} , 
 	{ "name": "A_0_2_val3", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "A_0_2_val3", "role": "default" }} , 
 	{ "name": "A_1_0_val4", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "A_1_0_val4", "role": "default" }} , 
 	{ "name": "A_1_1_val5", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "A_1_1_val5", "role": "default" }} , 
 	{ "name": "A_1_2_val6", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "A_1_2_val6", "role": "default" }} , 
 	{ "name": "A_2_0_val7", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "A_2_0_val7", "role": "default" }} , 
 	{ "name": "A_2_1_val8", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "A_2_1_val8", "role": "default" }} , 
 	{ "name": "A_2_2_val9", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "A_2_2_val9", "role": "default" }} , 
 	{ "name": "B_0_0_val10", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_0_0_val10", "role": "default" }} , 
 	{ "name": "B_0_1_val11", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_0_1_val11", "role": "default" }} , 
 	{ "name": "B_0_2_val12", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_0_2_val12", "role": "default" }} , 
 	{ "name": "B_1_0_val13", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_1_0_val13", "role": "default" }} , 
 	{ "name": "B_1_1_val14", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_1_1_val14", "role": "default" }} , 
 	{ "name": "B_1_2_val15", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_1_2_val15", "role": "default" }} , 
 	{ "name": "B_2_0_val16", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_2_0_val16", "role": "default" }} , 
 	{ "name": "B_2_1_val17", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_2_1_val17", "role": "default" }} , 
 	{ "name": "B_2_2_val18", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "B_2_2_val18", "role": "default" }} , 
 	{ "name": "C_0_0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_0_0", "role": "default" }} , 
 	{ "name": "C_0_1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_0_1", "role": "default" }} , 
 	{ "name": "C_0_2", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_0_2", "role": "default" }} , 
 	{ "name": "C_1_0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_1_0", "role": "default" }} , 
 	{ "name": "C_1_1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_1_1", "role": "default" }} , 
 	{ "name": "C_1_2", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_1_2", "role": "default" }} , 
 	{ "name": "C_2_0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_2_0", "role": "default" }} , 
 	{ "name": "C_2_1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_2_1", "role": "default" }} , 
 	{ "name": "C_2_2", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_2_2", "role": "default" }} , 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "A_0_0_val1_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "A_0_0_val1", "role": "ap_vld" }} , 
 	{ "name": "A_0_1_val2_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "A_0_1_val2", "role": "ap_vld" }} , 
 	{ "name": "A_0_2_val3_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "A_0_2_val3", "role": "ap_vld" }} , 
 	{ "name": "A_1_0_val4_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "A_1_0_val4", "role": "ap_vld" }} , 
 	{ "name": "A_1_1_val5_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "A_1_1_val5", "role": "ap_vld" }} , 
 	{ "name": "A_1_2_val6_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "A_1_2_val6", "role": "ap_vld" }} , 
 	{ "name": "A_2_0_val7_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "A_2_0_val7", "role": "ap_vld" }} , 
 	{ "name": "A_2_1_val8_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "A_2_1_val8", "role": "ap_vld" }} , 
 	{ "name": "A_2_2_val9_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "A_2_2_val9", "role": "ap_vld" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "B_0_0_val10_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "B_0_0_val10", "role": "ap_vld" }} , 
 	{ "name": "B_0_1_val11_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "B_0_1_val11", "role": "ap_vld" }} , 
 	{ "name": "B_0_2_val12_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "B_0_2_val12", "role": "ap_vld" }} , 
 	{ "name": "B_1_0_val13_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "B_1_0_val13", "role": "ap_vld" }} , 
 	{ "name": "B_1_1_val14_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "B_1_1_val14", "role": "ap_vld" }} , 
 	{ "name": "B_1_2_val15_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "B_1_2_val15", "role": "ap_vld" }} , 
 	{ "name": "B_2_0_val16_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "B_2_0_val16", "role": "ap_vld" }} , 
 	{ "name": "B_2_1_val17_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "B_2_1_val17", "role": "ap_vld" }} , 
 	{ "name": "B_2_2_val18_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "B_2_2_val18", "role": "ap_vld" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "C_0_0_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_0_0", "role": "ap_vld" }} , 
 	{ "name": "C_0_1_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_0_1", "role": "ap_vld" }} , 
 	{ "name": "C_0_2_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_0_2", "role": "ap_vld" }} , 
 	{ "name": "C_1_0_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_1_0", "role": "ap_vld" }} , 
 	{ "name": "C_1_1_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_1_1", "role": "ap_vld" }} , 
 	{ "name": "C_1_2_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_1_2", "role": "ap_vld" }} , 
 	{ "name": "C_2_0_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_2_0", "role": "ap_vld" }} , 
 	{ "name": "C_2_1_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_2_1", "role": "ap_vld" }} , 
 	{ "name": "C_2_2_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_2_2", "role": "ap_vld" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	systolic_core {
		A_0_0_val1 {Type I LastRead 0 FirstWrite -1}
		A_0_1_val2 {Type I LastRead 0 FirstWrite -1}
		A_0_2_val3 {Type I LastRead 0 FirstWrite -1}
		A_1_0_val4 {Type I LastRead 0 FirstWrite -1}
		A_1_1_val5 {Type I LastRead 0 FirstWrite -1}
		A_1_2_val6 {Type I LastRead 0 FirstWrite -1}
		A_2_0_val7 {Type I LastRead 0 FirstWrite -1}
		A_2_1_val8 {Type I LastRead 0 FirstWrite -1}
		A_2_2_val9 {Type I LastRead 0 FirstWrite -1}
		B_0_0_val10 {Type I LastRead 0 FirstWrite -1}
		B_0_1_val11 {Type I LastRead 0 FirstWrite -1}
		B_0_2_val12 {Type I LastRead 0 FirstWrite -1}
		B_1_0_val13 {Type I LastRead 0 FirstWrite -1}
		B_1_1_val14 {Type I LastRead 0 FirstWrite -1}
		B_1_2_val15 {Type I LastRead 0 FirstWrite -1}
		B_2_0_val16 {Type I LastRead 0 FirstWrite -1}
		B_2_1_val17 {Type I LastRead 0 FirstWrite -1}
		B_2_2_val18 {Type I LastRead 0 FirstWrite -1}
		C_0_0 {Type O LastRead -1 FirstWrite 1}
		C_0_1 {Type O LastRead -1 FirstWrite 1}
		C_0_2 {Type O LastRead -1 FirstWrite 1}
		C_1_0 {Type O LastRead -1 FirstWrite 1}
		C_1_1 {Type O LastRead -1 FirstWrite 1}
		C_1_2 {Type O LastRead -1 FirstWrite 1}
		C_2_0 {Type O LastRead -1 FirstWrite 1}
		C_2_1 {Type O LastRead -1 FirstWrite 1}
		C_2_2 {Type O LastRead -1 FirstWrite 1}}
	feed_A {
		A_0_0_val {Type I LastRead 0 FirstWrite -1}
		A_0_1_val {Type I LastRead 0 FirstWrite -1}
		A_0_2_val {Type I LastRead 0 FirstWrite -1}
		A_1_0_val {Type I LastRead 0 FirstWrite -1}
		A_1_1_val {Type I LastRead 0 FirstWrite -1}
		A_1_2_val {Type I LastRead 0 FirstWrite -1}
		A_2_0_val {Type I LastRead 0 FirstWrite -1}
		A_2_1_val {Type I LastRead 0 FirstWrite -1}
		A_2_2_val {Type I LastRead 0 FirstWrite -1}
		aS_0_0 {Type O LastRead -1 FirstWrite 1}
		aS_1_0 {Type O LastRead -1 FirstWrite 1}
		aS_2_0 {Type O LastRead -1 FirstWrite 1}}
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
		bS_0_2 {Type O LastRead -1 FirstWrite 1}}
	pe_1 {
		aS_0_0 {Type I LastRead 1 FirstWrite -1}
		aS_0_1 {Type O LastRead -1 FirstWrite 1}
		bS_0_0 {Type I LastRead 1 FirstWrite -1}
		bS_1_0 {Type O LastRead -1 FirstWrite 1}
		cS_0_0 {Type O LastRead -1 FirstWrite 2}}
	pe_1_Pipeline_PE_LOOP {
		aS_0_0 {Type I LastRead 1 FirstWrite -1}
		bS_0_0 {Type I LastRead 1 FirstWrite -1}
		aS_0_1 {Type O LastRead -1 FirstWrite 1}
		bS_1_0 {Type O LastRead -1 FirstWrite 1}
		acc_04_out {Type O LastRead -1 FirstWrite 3}}
	pe_2 {
		aS_0_1 {Type I LastRead 1 FirstWrite -1}
		aS_0_2 {Type O LastRead -1 FirstWrite 1}
		bS_0_1 {Type I LastRead 1 FirstWrite -1}
		bS_1_1 {Type O LastRead -1 FirstWrite 1}
		cS_0_1 {Type O LastRead -1 FirstWrite 2}}
	pe_2_Pipeline_PE_LOOP {
		aS_0_1 {Type I LastRead 1 FirstWrite -1}
		bS_0_1 {Type I LastRead 1 FirstWrite -1}
		aS_0_2 {Type O LastRead -1 FirstWrite 1}
		bS_1_1 {Type O LastRead -1 FirstWrite 1}
		acc_04_out {Type O LastRead -1 FirstWrite 3}}
	pe_3 {
		aS_0_2 {Type I LastRead 1 FirstWrite -1}
		aS_0_3 {Type O LastRead -1 FirstWrite 1}
		bS_0_2 {Type I LastRead 1 FirstWrite -1}
		bS_1_2 {Type O LastRead -1 FirstWrite 1}
		cS_0_2 {Type O LastRead -1 FirstWrite 2}}
	pe_3_Pipeline_PE_LOOP {
		aS_0_2 {Type I LastRead 1 FirstWrite -1}
		bS_0_2 {Type I LastRead 1 FirstWrite -1}
		aS_0_3 {Type O LastRead -1 FirstWrite 1}
		bS_1_2 {Type O LastRead -1 FirstWrite 1}
		acc_04_out {Type O LastRead -1 FirstWrite 3}}
	pe_4 {
		aS_1_0 {Type I LastRead 1 FirstWrite -1}
		aS_1_1 {Type O LastRead -1 FirstWrite 1}
		bS_1_0 {Type I LastRead 1 FirstWrite -1}
		bS_2_0 {Type O LastRead -1 FirstWrite 1}
		cS_1_0 {Type O LastRead -1 FirstWrite 2}}
	pe_4_Pipeline_PE_LOOP {
		aS_1_0 {Type I LastRead 1 FirstWrite -1}
		bS_1_0 {Type I LastRead 1 FirstWrite -1}
		aS_1_1 {Type O LastRead -1 FirstWrite 1}
		bS_2_0 {Type O LastRead -1 FirstWrite 1}
		acc_04_out {Type O LastRead -1 FirstWrite 3}}
	pe_5 {
		aS_1_1 {Type I LastRead 1 FirstWrite -1}
		aS_1_2 {Type O LastRead -1 FirstWrite 1}
		bS_1_1 {Type I LastRead 1 FirstWrite -1}
		bS_2_1 {Type O LastRead -1 FirstWrite 1}
		cS_1_1 {Type O LastRead -1 FirstWrite 2}}
	pe_5_Pipeline_PE_LOOP {
		aS_1_1 {Type I LastRead 1 FirstWrite -1}
		bS_1_1 {Type I LastRead 1 FirstWrite -1}
		aS_1_2 {Type O LastRead -1 FirstWrite 1}
		bS_2_1 {Type O LastRead -1 FirstWrite 1}
		acc_out {Type O LastRead -1 FirstWrite 3}}
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
		acc_out {Type O LastRead -1 FirstWrite 3}}
	pe_7 {
		aS_2_0 {Type I LastRead 1 FirstWrite -1}
		aS_2_1 {Type O LastRead -1 FirstWrite 1}
		bS_2_0 {Type I LastRead 1 FirstWrite -1}
		bS_3_0 {Type O LastRead -1 FirstWrite 1}
		cS_2_0 {Type O LastRead -1 FirstWrite 2}}
	pe_7_Pipeline_PE_LOOP {
		aS_2_0 {Type I LastRead 1 FirstWrite -1}
		bS_2_0 {Type I LastRead 1 FirstWrite -1}
		aS_2_1 {Type O LastRead -1 FirstWrite 1}
		bS_3_0 {Type O LastRead -1 FirstWrite 1}
		acc_out {Type O LastRead -1 FirstWrite 3}}
	pe_8 {
		aS_2_1 {Type I LastRead 1 FirstWrite -1}
		aS_2_2 {Type O LastRead -1 FirstWrite 1}
		bS_2_1 {Type I LastRead 1 FirstWrite -1}
		bS_3_1 {Type O LastRead -1 FirstWrite 1}
		cS_2_1 {Type O LastRead -1 FirstWrite 2}}
	pe_8_Pipeline_PE_LOOP {
		aS_2_1 {Type I LastRead 1 FirstWrite -1}
		bS_2_1 {Type I LastRead 1 FirstWrite -1}
		aS_2_2 {Type O LastRead -1 FirstWrite 1}
		bS_3_1 {Type O LastRead -1 FirstWrite 1}
		acc_out {Type O LastRead -1 FirstWrite 3}}
	pe {
		aS_2_2 {Type I LastRead 1 FirstWrite -1}
		aS_2_3 {Type O LastRead -1 FirstWrite 1}
		bS_2_2 {Type I LastRead 1 FirstWrite -1}
		bS_3_2 {Type O LastRead -1 FirstWrite 1}
		cS_2_2 {Type O LastRead -1 FirstWrite 2}}
	pe_Pipeline_PE_LOOP {
		aS_2_2 {Type I LastRead 1 FirstWrite -1}
		bS_2_2 {Type I LastRead 1 FirstWrite -1}
		aS_2_3 {Type O LastRead -1 FirstWrite 1}
		bS_3_2 {Type O LastRead -1 FirstWrite 1}
		acc_04_out {Type O LastRead -1 FirstWrite 3}}
	sink_A {
		aS_0_3 {Type I LastRead 1 FirstWrite -1}
		aS_1_3 {Type I LastRead 1 FirstWrite -1}
		aS_2_3 {Type I LastRead 1 FirstWrite -1}}
	sink_B {
		bS_3_0 {Type I LastRead 1 FirstWrite -1}
		bS_3_1 {Type I LastRead 1 FirstWrite -1}
		bS_3_2 {Type I LastRead 1 FirstWrite -1}}
	collect {
		cS_0_0 {Type I LastRead 1 FirstWrite -1}
		cS_0_1 {Type I LastRead 1 FirstWrite -1}
		cS_0_2 {Type I LastRead 1 FirstWrite -1}
		cS_1_0 {Type I LastRead 1 FirstWrite -1}
		cS_1_1 {Type I LastRead 1 FirstWrite -1}
		cS_1_2 {Type I LastRead 1 FirstWrite -1}
		cS_2_0 {Type I LastRead 1 FirstWrite -1}
		cS_2_1 {Type I LastRead 1 FirstWrite -1}
		cS_2_2 {Type I LastRead 1 FirstWrite -1}
		C_0_0 {Type O LastRead -1 FirstWrite 1}
		C_0_1 {Type O LastRead -1 FirstWrite 1}
		C_0_2 {Type O LastRead -1 FirstWrite 1}
		C_1_0 {Type O LastRead -1 FirstWrite 1}
		C_1_1 {Type O LastRead -1 FirstWrite 1}
		C_1_2 {Type O LastRead -1 FirstWrite 1}
		C_2_0 {Type O LastRead -1 FirstWrite 1}
		C_2_1 {Type O LastRead -1 FirstWrite 1}
		C_2_2 {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "17", "Max" : "17"}
	, {"Name" : "Interval", "Min" : "11", "Max" : "11"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	A_0_0_val1 { ap_none {  { A_0_0_val1 in_data 0 16 }  { A_0_0_val1_ap_vld in_vld 0 1 } } }
	A_0_1_val2 { ap_none {  { A_0_1_val2 in_data 0 16 }  { A_0_1_val2_ap_vld in_vld 0 1 } } }
	A_0_2_val3 { ap_none {  { A_0_2_val3 in_data 0 16 }  { A_0_2_val3_ap_vld in_vld 0 1 } } }
	A_1_0_val4 { ap_none {  { A_1_0_val4 in_data 0 16 }  { A_1_0_val4_ap_vld in_vld 0 1 } } }
	A_1_1_val5 { ap_none {  { A_1_1_val5 in_data 0 16 }  { A_1_1_val5_ap_vld in_vld 0 1 } } }
	A_1_2_val6 { ap_none {  { A_1_2_val6 in_data 0 16 }  { A_1_2_val6_ap_vld in_vld 0 1 } } }
	A_2_0_val7 { ap_none {  { A_2_0_val7 in_data 0 16 }  { A_2_0_val7_ap_vld in_vld 0 1 } } }
	A_2_1_val8 { ap_none {  { A_2_1_val8 in_data 0 16 }  { A_2_1_val8_ap_vld in_vld 0 1 } } }
	A_2_2_val9 { ap_none {  { A_2_2_val9 in_data 0 16 }  { A_2_2_val9_ap_vld in_vld 0 1 } } }
	B_0_0_val10 { ap_none {  { B_0_0_val10 in_data 0 16 }  { B_0_0_val10_ap_vld in_vld 0 1 } } }
	B_0_1_val11 { ap_none {  { B_0_1_val11 in_data 0 16 }  { B_0_1_val11_ap_vld in_vld 0 1 } } }
	B_0_2_val12 { ap_none {  { B_0_2_val12 in_data 0 16 }  { B_0_2_val12_ap_vld in_vld 0 1 } } }
	B_1_0_val13 { ap_none {  { B_1_0_val13 in_data 0 16 }  { B_1_0_val13_ap_vld in_vld 0 1 } } }
	B_1_1_val14 { ap_none {  { B_1_1_val14 in_data 0 16 }  { B_1_1_val14_ap_vld in_vld 0 1 } } }
	B_1_2_val15 { ap_none {  { B_1_2_val15 in_data 0 16 }  { B_1_2_val15_ap_vld in_vld 0 1 } } }
	B_2_0_val16 { ap_none {  { B_2_0_val16 in_data 0 16 }  { B_2_0_val16_ap_vld in_vld 0 1 } } }
	B_2_1_val17 { ap_none {  { B_2_1_val17 in_data 0 16 }  { B_2_1_val17_ap_vld in_vld 0 1 } } }
	B_2_2_val18 { ap_none {  { B_2_2_val18 in_data 0 16 }  { B_2_2_val18_ap_vld in_vld 0 1 } } }
	C_0_0 { ap_vld {  { C_0_0 out_data 1 32 }  { C_0_0_ap_vld out_vld 1 1 } } }
	C_0_1 { ap_vld {  { C_0_1 out_data 1 32 }  { C_0_1_ap_vld out_vld 1 1 } } }
	C_0_2 { ap_vld {  { C_0_2 out_data 1 32 }  { C_0_2_ap_vld out_vld 1 1 } } }
	C_1_0 { ap_vld {  { C_1_0 out_data 1 32 }  { C_1_0_ap_vld out_vld 1 1 } } }
	C_1_1 { ap_vld {  { C_1_1 out_data 1 32 }  { C_1_1_ap_vld out_vld 1 1 } } }
	C_1_2 { ap_vld {  { C_1_2 out_data 1 32 }  { C_1_2_ap_vld out_vld 1 1 } } }
	C_2_0 { ap_vld {  { C_2_0 out_data 1 32 }  { C_2_0_ap_vld out_vld 1 1 } } }
	C_2_1 { ap_vld {  { C_2_1 out_data 1 32 }  { C_2_1_ap_vld out_vld 1 1 } } }
	C_2_2 { ap_vld {  { C_2_2 out_data 1 32 }  { C_2_2_ap_vld out_vld 1 1 } } }
}
