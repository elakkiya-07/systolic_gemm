set moduleName og_systolic_gemm
set isTopModule 1
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
set C_modelName {og_systolic_gemm}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ in_A_V_data_V int 32 regular {axi_s 0 volatile  { in_A Data } }  }
	{ in_A_V_keep_V int 4 regular {axi_s 0 volatile  { in_A Keep } }  }
	{ in_A_V_strb_V int 4 regular {axi_s 0 volatile  { in_A Strb } }  }
	{ in_A_V_last_V int 1 regular {axi_s 0 volatile  { in_A Last } }  }
	{ in_B_V_data_V int 32 regular {axi_s 0 volatile  { in_B Data } }  }
	{ in_B_V_keep_V int 4 regular {axi_s 0 volatile  { in_B Keep } }  }
	{ in_B_V_strb_V int 4 regular {axi_s 0 volatile  { in_B Strb } }  }
	{ in_B_V_last_V int 1 regular {axi_s 0 volatile  { in_B Last } }  }
	{ out_C_V_data_V int 32 regular {axi_s 1 volatile  { out_C Data } }  }
	{ out_C_V_keep_V int 4 regular {axi_s 1 volatile  { out_C Keep } }  }
	{ out_C_V_strb_V int 4 regular {axi_s 1 volatile  { out_C Strb } }  }
	{ out_C_V_last_V int 1 regular {axi_s 1 volatile  { out_C Last } }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "in_A_V_data_V", "interface" : "axis", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "in_A_V_keep_V", "interface" : "axis", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "in_A_V_strb_V", "interface" : "axis", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "in_A_V_last_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "in_B_V_data_V", "interface" : "axis", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "in_B_V_keep_V", "interface" : "axis", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "in_B_V_strb_V", "interface" : "axis", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "in_B_V_last_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "out_C_V_data_V", "interface" : "axis", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "out_C_V_keep_V", "interface" : "axis", "bitwidth" : 4, "direction" : "WRITEONLY"} , 
 	{ "Name" : "out_C_V_strb_V", "interface" : "axis", "bitwidth" : 4, "direction" : "WRITEONLY"} , 
 	{ "Name" : "out_C_V_last_V", "interface" : "axis", "bitwidth" : 1, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 38
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ in_A_TDATA sc_in sc_lv 32 signal 0 } 
	{ in_A_TVALID sc_in sc_logic 1 invld 3 } 
	{ in_A_TREADY sc_out sc_logic 1 inacc 3 } 
	{ in_A_TKEEP sc_in sc_lv 4 signal 1 } 
	{ in_A_TSTRB sc_in sc_lv 4 signal 2 } 
	{ in_A_TLAST sc_in sc_lv 1 signal 3 } 
	{ in_B_TDATA sc_in sc_lv 32 signal 4 } 
	{ in_B_TVALID sc_in sc_logic 1 invld 7 } 
	{ in_B_TREADY sc_out sc_logic 1 inacc 7 } 
	{ in_B_TKEEP sc_in sc_lv 4 signal 5 } 
	{ in_B_TSTRB sc_in sc_lv 4 signal 6 } 
	{ in_B_TLAST sc_in sc_lv 1 signal 7 } 
	{ out_C_TDATA sc_out sc_lv 32 signal 8 } 
	{ out_C_TVALID sc_out sc_logic 1 outvld 11 } 
	{ out_C_TREADY sc_in sc_logic 1 outacc 11 } 
	{ out_C_TKEEP sc_out sc_lv 4 signal 9 } 
	{ out_C_TSTRB sc_out sc_lv 4 signal 10 } 
	{ out_C_TLAST sc_out sc_lv 1 signal 11 } 
	{ s_axi_CTRL_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_CTRL_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_CTRL_AWADDR sc_in sc_lv 4 signal -1 } 
	{ s_axi_CTRL_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_CTRL_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_CTRL_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_CTRL_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_CTRL_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_CTRL_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_CTRL_ARADDR sc_in sc_lv 4 signal -1 } 
	{ s_axi_CTRL_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_CTRL_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_CTRL_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_CTRL_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_CTRL_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_CTRL_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_CTRL_BRESP sc_out sc_lv 2 signal -1 } 
	{ interrupt sc_out sc_logic 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_CTRL_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "CTRL", "role": "AWADDR" },"address":[{"name":"og_systolic_gemm","role":"start","value":"0","valid_bit":"0"},{"name":"og_systolic_gemm","role":"continue","value":"0","valid_bit":"4"},{"name":"og_systolic_gemm","role":"auto_start","value":"0","valid_bit":"7"}] },
	{ "name": "s_axi_CTRL_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "CTRL", "role": "AWVALID" } },
	{ "name": "s_axi_CTRL_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "CTRL", "role": "AWREADY" } },
	{ "name": "s_axi_CTRL_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "CTRL", "role": "WVALID" } },
	{ "name": "s_axi_CTRL_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "CTRL", "role": "WREADY" } },
	{ "name": "s_axi_CTRL_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "CTRL", "role": "WDATA" } },
	{ "name": "s_axi_CTRL_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "CTRL", "role": "WSTRB" } },
	{ "name": "s_axi_CTRL_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "CTRL", "role": "ARADDR" },"address":[{"name":"og_systolic_gemm","role":"start","value":"0","valid_bit":"0"},{"name":"og_systolic_gemm","role":"done","value":"0","valid_bit":"1"},{"name":"og_systolic_gemm","role":"idle","value":"0","valid_bit":"2"},{"name":"og_systolic_gemm","role":"ready","value":"0","valid_bit":"3"},{"name":"og_systolic_gemm","role":"auto_start","value":"0","valid_bit":"7"}] },
	{ "name": "s_axi_CTRL_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "CTRL", "role": "ARVALID" } },
	{ "name": "s_axi_CTRL_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "CTRL", "role": "ARREADY" } },
	{ "name": "s_axi_CTRL_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "CTRL", "role": "RVALID" } },
	{ "name": "s_axi_CTRL_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "CTRL", "role": "RREADY" } },
	{ "name": "s_axi_CTRL_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "CTRL", "role": "RDATA" } },
	{ "name": "s_axi_CTRL_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "CTRL", "role": "RRESP" } },
	{ "name": "s_axi_CTRL_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "CTRL", "role": "BVALID" } },
	{ "name": "s_axi_CTRL_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "CTRL", "role": "BREADY" } },
	{ "name": "s_axi_CTRL_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "CTRL", "role": "BRESP" } },
	{ "name": "interrupt", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "CTRL", "role": "interrupt" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "in_A_TDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "in_A_V_data_V", "role": "default" }} , 
 	{ "name": "in_A_TVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "in_A_V_last_V", "role": "default" }} , 
 	{ "name": "in_A_TREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "inacc", "bundle":{"name": "in_A_V_last_V", "role": "default" }} , 
 	{ "name": "in_A_TKEEP", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "in_A_V_keep_V", "role": "default" }} , 
 	{ "name": "in_A_TSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "in_A_V_strb_V", "role": "default" }} , 
 	{ "name": "in_A_TLAST", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "in_A_V_last_V", "role": "default" }} , 
 	{ "name": "in_B_TDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "in_B_V_data_V", "role": "default" }} , 
 	{ "name": "in_B_TVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "in_B_V_last_V", "role": "default" }} , 
 	{ "name": "in_B_TREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "inacc", "bundle":{"name": "in_B_V_last_V", "role": "default" }} , 
 	{ "name": "in_B_TKEEP", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "in_B_V_keep_V", "role": "default" }} , 
 	{ "name": "in_B_TSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "in_B_V_strb_V", "role": "default" }} , 
 	{ "name": "in_B_TLAST", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "in_B_V_last_V", "role": "default" }} , 
 	{ "name": "out_C_TDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "out_C_V_data_V", "role": "default" }} , 
 	{ "name": "out_C_TVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "out_C_V_last_V", "role": "default" }} , 
 	{ "name": "out_C_TREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "outacc", "bundle":{"name": "out_C_V_last_V", "role": "default" }} , 
 	{ "name": "out_C_TKEEP", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "out_C_V_keep_V", "role": "default" }} , 
 	{ "name": "out_C_TSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "out_C_V_strb_V", "role": "default" }} , 
 	{ "name": "out_C_TLAST", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "out_C_V_last_V", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	og_systolic_gemm {
		in_A_V_data_V {Type I LastRead 1 FirstWrite -1}
		in_A_V_keep_V {Type I LastRead 1 FirstWrite -1}
		in_A_V_strb_V {Type I LastRead 1 FirstWrite -1}
		in_A_V_last_V {Type I LastRead 1 FirstWrite -1}
		in_B_V_data_V {Type I LastRead 1 FirstWrite -1}
		in_B_V_keep_V {Type I LastRead 1 FirstWrite -1}
		in_B_V_strb_V {Type I LastRead 1 FirstWrite -1}
		in_B_V_last_V {Type I LastRead 1 FirstWrite -1}
		out_C_V_data_V {Type O LastRead -1 FirstWrite 1}
		out_C_V_keep_V {Type O LastRead -1 FirstWrite 1}
		out_C_V_strb_V {Type O LastRead -1 FirstWrite 1}
		out_C_V_last_V {Type O LastRead -1 FirstWrite 1}}
	og_systolic_gemm_Pipeline_RD_VITIS_LOOP_133_1 {
		in_A_V_data_V {Type I LastRead 1 FirstWrite -1}
		in_A_V_keep_V {Type I LastRead 1 FirstWrite -1}
		in_A_V_strb_V {Type I LastRead 1 FirstWrite -1}
		in_A_V_last_V {Type I LastRead 1 FirstWrite -1}
		in_B_V_data_V {Type I LastRead 1 FirstWrite -1}
		in_B_V_keep_V {Type I LastRead 1 FirstWrite -1}
		in_B_V_strb_V {Type I LastRead 1 FirstWrite -1}
		in_B_V_last_V {Type I LastRead 1 FirstWrite -1}
		p_out {Type O LastRead -1 FirstWrite 0}
		p_out1 {Type O LastRead -1 FirstWrite 0}
		p_out2 {Type O LastRead -1 FirstWrite 0}
		p_out3 {Type O LastRead -1 FirstWrite 0}
		p_out4 {Type O LastRead -1 FirstWrite 0}
		p_out5 {Type O LastRead -1 FirstWrite 0}
		p_out6 {Type O LastRead -1 FirstWrite 0}
		p_out7 {Type O LastRead -1 FirstWrite 0}
		p_out8 {Type O LastRead -1 FirstWrite 0}
		p_out9 {Type O LastRead -1 FirstWrite 0}
		p_out10 {Type O LastRead -1 FirstWrite 0}
		p_out11 {Type O LastRead -1 FirstWrite 0}
		p_out12 {Type O LastRead -1 FirstWrite 0}
		p_out13 {Type O LastRead -1 FirstWrite 0}
		p_out14 {Type O LastRead -1 FirstWrite 0}
		p_out15 {Type O LastRead -1 FirstWrite 0}
		p_out16 {Type O LastRead -1 FirstWrite 0}
		p_out17 {Type O LastRead -1 FirstWrite 0}}
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
		C_2_2 {Type O LastRead -1 FirstWrite 1}}
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
	{"Name" : "Latency", "Min" : "46", "Max" : "46"}
	, {"Name" : "Interval", "Min" : "47", "Max" : "47"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	in_A_V_data_V { axis {  { in_A_TDATA in_data 0 32 } } }
	in_A_V_keep_V { axis {  { in_A_TKEEP in_data 0 4 } } }
	in_A_V_strb_V { axis {  { in_A_TSTRB in_data 0 4 } } }
	in_A_V_last_V { axis {  { in_A_TVALID in_vld 0 1 }  { in_A_TREADY in_acc 1 1 }  { in_A_TLAST in_data 0 1 } } }
	in_B_V_data_V { axis {  { in_B_TDATA in_data 0 32 } } }
	in_B_V_keep_V { axis {  { in_B_TKEEP in_data 0 4 } } }
	in_B_V_strb_V { axis {  { in_B_TSTRB in_data 0 4 } } }
	in_B_V_last_V { axis {  { in_B_TVALID in_vld 0 1 }  { in_B_TREADY in_acc 1 1 }  { in_B_TLAST in_data 0 1 } } }
	out_C_V_data_V { axis {  { out_C_TDATA out_data 1 32 } } }
	out_C_V_keep_V { axis {  { out_C_TKEEP out_data 1 4 } } }
	out_C_V_strb_V { axis {  { out_C_TSTRB out_data 1 4 } } }
	out_C_V_last_V { axis {  { out_C_TVALID out_vld 1 1 }  { out_C_TREADY out_acc 0 1 }  { out_C_TLAST out_data 1 1 } } }
}

set maxi_interface_dict [dict create]

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
