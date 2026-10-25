set moduleName collect
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
set C_modelName {collect}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ cS_0_0 int 32 regular {fifo 0 volatile }  }
	{ cS_0_1 int 32 regular {fifo 0 volatile }  }
	{ cS_0_2 int 32 regular {fifo 0 volatile }  }
	{ cS_1_0 int 32 regular {fifo 0 volatile }  }
	{ cS_1_1 int 32 regular {fifo 0 volatile }  }
	{ cS_1_2 int 32 regular {fifo 0 volatile }  }
	{ cS_2_0 int 32 regular {fifo 0 volatile }  }
	{ cS_2_1 int 32 regular {fifo 0 volatile }  }
	{ cS_2_2 int 32 regular {fifo 0 volatile }  }
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
	{ "Name" : "cS_0_0", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "cS_0_1", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "cS_0_2", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "cS_1_0", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "cS_1_1", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "cS_1_2", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "cS_2_0", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "cS_2_1", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "cS_2_2", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
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
set portNum 70
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ cS_1_1_dout sc_in sc_lv 32 signal 4 } 
	{ cS_1_1_empty_n sc_in sc_logic 1 signal 4 } 
	{ cS_1_1_read sc_out sc_logic 1 signal 4 } 
	{ cS_1_1_num_data_valid sc_in sc_lv 3 signal 4 } 
	{ cS_1_1_fifo_cap sc_in sc_lv 3 signal 4 } 
	{ cS_1_0_dout sc_in sc_lv 32 signal 3 } 
	{ cS_1_0_empty_n sc_in sc_logic 1 signal 3 } 
	{ cS_1_0_read sc_out sc_logic 1 signal 3 } 
	{ cS_1_0_num_data_valid sc_in sc_lv 3 signal 3 } 
	{ cS_1_0_fifo_cap sc_in sc_lv 3 signal 3 } 
	{ cS_1_2_dout sc_in sc_lv 32 signal 5 } 
	{ cS_1_2_empty_n sc_in sc_logic 1 signal 5 } 
	{ cS_1_2_read sc_out sc_logic 1 signal 5 } 
	{ cS_1_2_num_data_valid sc_in sc_lv 3 signal 5 } 
	{ cS_1_2_fifo_cap sc_in sc_lv 3 signal 5 } 
	{ cS_0_1_dout sc_in sc_lv 32 signal 1 } 
	{ cS_0_1_empty_n sc_in sc_logic 1 signal 1 } 
	{ cS_0_1_read sc_out sc_logic 1 signal 1 } 
	{ cS_0_1_num_data_valid sc_in sc_lv 3 signal 1 } 
	{ cS_0_1_fifo_cap sc_in sc_lv 3 signal 1 } 
	{ cS_0_0_dout sc_in sc_lv 32 signal 0 } 
	{ cS_0_0_empty_n sc_in sc_logic 1 signal 0 } 
	{ cS_0_0_read sc_out sc_logic 1 signal 0 } 
	{ cS_0_0_num_data_valid sc_in sc_lv 3 signal 0 } 
	{ cS_0_0_fifo_cap sc_in sc_lv 3 signal 0 } 
	{ cS_0_2_dout sc_in sc_lv 32 signal 2 } 
	{ cS_0_2_empty_n sc_in sc_logic 1 signal 2 } 
	{ cS_0_2_read sc_out sc_logic 1 signal 2 } 
	{ cS_0_2_num_data_valid sc_in sc_lv 3 signal 2 } 
	{ cS_0_2_fifo_cap sc_in sc_lv 3 signal 2 } 
	{ cS_2_1_dout sc_in sc_lv 32 signal 7 } 
	{ cS_2_1_empty_n sc_in sc_logic 1 signal 7 } 
	{ cS_2_1_read sc_out sc_logic 1 signal 7 } 
	{ cS_2_1_num_data_valid sc_in sc_lv 3 signal 7 } 
	{ cS_2_1_fifo_cap sc_in sc_lv 3 signal 7 } 
	{ cS_2_0_dout sc_in sc_lv 32 signal 6 } 
	{ cS_2_0_empty_n sc_in sc_logic 1 signal 6 } 
	{ cS_2_0_read sc_out sc_logic 1 signal 6 } 
	{ cS_2_0_num_data_valid sc_in sc_lv 3 signal 6 } 
	{ cS_2_0_fifo_cap sc_in sc_lv 3 signal 6 } 
	{ cS_2_2_dout sc_in sc_lv 32 signal 8 } 
	{ cS_2_2_empty_n sc_in sc_logic 1 signal 8 } 
	{ cS_2_2_read sc_out sc_logic 1 signal 8 } 
	{ cS_2_2_num_data_valid sc_in sc_lv 3 signal 8 } 
	{ cS_2_2_fifo_cap sc_in sc_lv 3 signal 8 } 
	{ C_0_0 sc_out sc_lv 32 signal 9 } 
	{ C_0_0_ap_vld sc_out sc_logic 1 outvld 9 } 
	{ C_0_1 sc_out sc_lv 32 signal 10 } 
	{ C_0_1_ap_vld sc_out sc_logic 1 outvld 10 } 
	{ C_0_2 sc_out sc_lv 32 signal 11 } 
	{ C_0_2_ap_vld sc_out sc_logic 1 outvld 11 } 
	{ C_1_0 sc_out sc_lv 32 signal 12 } 
	{ C_1_0_ap_vld sc_out sc_logic 1 outvld 12 } 
	{ C_1_1 sc_out sc_lv 32 signal 13 } 
	{ C_1_1_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ C_1_2 sc_out sc_lv 32 signal 14 } 
	{ C_1_2_ap_vld sc_out sc_logic 1 outvld 14 } 
	{ C_2_0 sc_out sc_lv 32 signal 15 } 
	{ C_2_0_ap_vld sc_out sc_logic 1 outvld 15 } 
	{ C_2_1 sc_out sc_lv 32 signal 16 } 
	{ C_2_1_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ C_2_2 sc_out sc_lv 32 signal 17 } 
	{ C_2_2_ap_vld sc_out sc_logic 1 outvld 17 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "cS_1_1_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cS_1_1", "role": "dout" }} , 
 	{ "name": "cS_1_1_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_1_1", "role": "empty_n" }} , 
 	{ "name": "cS_1_1_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_1_1", "role": "read" }} , 
 	{ "name": "cS_1_1_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_1_1", "role": "num_data_valid" }} , 
 	{ "name": "cS_1_1_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_1_1", "role": "fifo_cap" }} , 
 	{ "name": "cS_1_0_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cS_1_0", "role": "dout" }} , 
 	{ "name": "cS_1_0_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_1_0", "role": "empty_n" }} , 
 	{ "name": "cS_1_0_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_1_0", "role": "read" }} , 
 	{ "name": "cS_1_0_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_1_0", "role": "num_data_valid" }} , 
 	{ "name": "cS_1_0_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_1_0", "role": "fifo_cap" }} , 
 	{ "name": "cS_1_2_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cS_1_2", "role": "dout" }} , 
 	{ "name": "cS_1_2_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_1_2", "role": "empty_n" }} , 
 	{ "name": "cS_1_2_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_1_2", "role": "read" }} , 
 	{ "name": "cS_1_2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_1_2", "role": "num_data_valid" }} , 
 	{ "name": "cS_1_2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_1_2", "role": "fifo_cap" }} , 
 	{ "name": "cS_0_1_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cS_0_1", "role": "dout" }} , 
 	{ "name": "cS_0_1_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_0_1", "role": "empty_n" }} , 
 	{ "name": "cS_0_1_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_0_1", "role": "read" }} , 
 	{ "name": "cS_0_1_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_0_1", "role": "num_data_valid" }} , 
 	{ "name": "cS_0_1_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_0_1", "role": "fifo_cap" }} , 
 	{ "name": "cS_0_0_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cS_0_0", "role": "dout" }} , 
 	{ "name": "cS_0_0_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_0_0", "role": "empty_n" }} , 
 	{ "name": "cS_0_0_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_0_0", "role": "read" }} , 
 	{ "name": "cS_0_0_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_0_0", "role": "num_data_valid" }} , 
 	{ "name": "cS_0_0_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_0_0", "role": "fifo_cap" }} , 
 	{ "name": "cS_0_2_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cS_0_2", "role": "dout" }} , 
 	{ "name": "cS_0_2_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_0_2", "role": "empty_n" }} , 
 	{ "name": "cS_0_2_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_0_2", "role": "read" }} , 
 	{ "name": "cS_0_2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_0_2", "role": "num_data_valid" }} , 
 	{ "name": "cS_0_2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_0_2", "role": "fifo_cap" }} , 
 	{ "name": "cS_2_1_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cS_2_1", "role": "dout" }} , 
 	{ "name": "cS_2_1_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_2_1", "role": "empty_n" }} , 
 	{ "name": "cS_2_1_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_2_1", "role": "read" }} , 
 	{ "name": "cS_2_1_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_2_1", "role": "num_data_valid" }} , 
 	{ "name": "cS_2_1_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_2_1", "role": "fifo_cap" }} , 
 	{ "name": "cS_2_0_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cS_2_0", "role": "dout" }} , 
 	{ "name": "cS_2_0_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_2_0", "role": "empty_n" }} , 
 	{ "name": "cS_2_0_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_2_0", "role": "read" }} , 
 	{ "name": "cS_2_0_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_2_0", "role": "num_data_valid" }} , 
 	{ "name": "cS_2_0_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_2_0", "role": "fifo_cap" }} , 
 	{ "name": "cS_2_2_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cS_2_2", "role": "dout" }} , 
 	{ "name": "cS_2_2_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_2_2", "role": "empty_n" }} , 
 	{ "name": "cS_2_2_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cS_2_2", "role": "read" }} , 
 	{ "name": "cS_2_2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_2_2", "role": "num_data_valid" }} , 
 	{ "name": "cS_2_2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cS_2_2", "role": "fifo_cap" }} , 
 	{ "name": "C_0_0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_0_0", "role": "default" }} , 
 	{ "name": "C_0_0_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_0_0", "role": "ap_vld" }} , 
 	{ "name": "C_0_1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_0_1", "role": "default" }} , 
 	{ "name": "C_0_1_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_0_1", "role": "ap_vld" }} , 
 	{ "name": "C_0_2", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_0_2", "role": "default" }} , 
 	{ "name": "C_0_2_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_0_2", "role": "ap_vld" }} , 
 	{ "name": "C_1_0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_1_0", "role": "default" }} , 
 	{ "name": "C_1_0_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_1_0", "role": "ap_vld" }} , 
 	{ "name": "C_1_1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_1_1", "role": "default" }} , 
 	{ "name": "C_1_1_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_1_1", "role": "ap_vld" }} , 
 	{ "name": "C_1_2", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_1_2", "role": "default" }} , 
 	{ "name": "C_1_2_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_1_2", "role": "ap_vld" }} , 
 	{ "name": "C_2_0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_2_0", "role": "default" }} , 
 	{ "name": "C_2_0_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_2_0", "role": "ap_vld" }} , 
 	{ "name": "C_2_1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_2_1", "role": "default" }} , 
 	{ "name": "C_2_1_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_2_1", "role": "ap_vld" }} , 
 	{ "name": "C_2_2", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_2_2", "role": "default" }} , 
 	{ "name": "C_2_2_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "C_2_2", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
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
	{"Name" : "Latency", "Min" : "11", "Max" : "11"}
	, {"Name" : "Interval", "Min" : "10", "Max" : "10"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	cS_0_0 { ap_fifo {  { cS_0_0_dout fifo_data_out 0 32 }  { cS_0_0_empty_n fifo_status_empty 0 1 }  { cS_0_0_read fifo_data_in 1 1 }  { cS_0_0_num_data_valid fifo_update 0 3 }  { cS_0_0_fifo_cap fifo_data 0 3 } } }
	cS_0_1 { ap_fifo {  { cS_0_1_dout fifo_data_out 0 32 }  { cS_0_1_empty_n fifo_status_empty 0 1 }  { cS_0_1_read fifo_data_in 1 1 }  { cS_0_1_num_data_valid fifo_update 0 3 }  { cS_0_1_fifo_cap fifo_data 0 3 } } }
	cS_0_2 { ap_fifo {  { cS_0_2_dout fifo_data_out 0 32 }  { cS_0_2_empty_n fifo_status_empty 0 1 }  { cS_0_2_read fifo_data_in 1 1 }  { cS_0_2_num_data_valid fifo_update 0 3 }  { cS_0_2_fifo_cap fifo_data 0 3 } } }
	cS_1_0 { ap_fifo {  { cS_1_0_dout fifo_data_out 0 32 }  { cS_1_0_empty_n fifo_status_empty 0 1 }  { cS_1_0_read fifo_data_in 1 1 }  { cS_1_0_num_data_valid fifo_update 0 3 }  { cS_1_0_fifo_cap fifo_data 0 3 } } }
	cS_1_1 { ap_fifo {  { cS_1_1_dout fifo_data_out 0 32 }  { cS_1_1_empty_n fifo_status_empty 0 1 }  { cS_1_1_read fifo_data_in 1 1 }  { cS_1_1_num_data_valid fifo_update 0 3 }  { cS_1_1_fifo_cap fifo_data 0 3 } } }
	cS_1_2 { ap_fifo {  { cS_1_2_dout fifo_data_out 0 32 }  { cS_1_2_empty_n fifo_status_empty 0 1 }  { cS_1_2_read fifo_data_in 1 1 }  { cS_1_2_num_data_valid fifo_update 0 3 }  { cS_1_2_fifo_cap fifo_data 0 3 } } }
	cS_2_0 { ap_fifo {  { cS_2_0_dout fifo_data_out 0 32 }  { cS_2_0_empty_n fifo_status_empty 0 1 }  { cS_2_0_read fifo_data_in 1 1 }  { cS_2_0_num_data_valid fifo_update 0 3 }  { cS_2_0_fifo_cap fifo_data 0 3 } } }
	cS_2_1 { ap_fifo {  { cS_2_1_dout fifo_data_out 0 32 }  { cS_2_1_empty_n fifo_status_empty 0 1 }  { cS_2_1_read fifo_data_in 1 1 }  { cS_2_1_num_data_valid fifo_update 0 3 }  { cS_2_1_fifo_cap fifo_data 0 3 } } }
	cS_2_2 { ap_fifo {  { cS_2_2_dout fifo_data_out 0 32 }  { cS_2_2_empty_n fifo_status_empty 0 1 }  { cS_2_2_read fifo_data_in 1 1 }  { cS_2_2_num_data_valid fifo_update 0 3 }  { cS_2_2_fifo_cap fifo_data 0 3 } } }
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
