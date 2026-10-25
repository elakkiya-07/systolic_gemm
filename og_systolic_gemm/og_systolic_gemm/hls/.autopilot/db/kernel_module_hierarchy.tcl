set ModuleHierarchy {[{
"Name" : "og_systolic_gemm", "RefName" : "og_systolic_gemm","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_og_systolic_gemm_Pipeline_RD_VITIS_LOOP_133_1_fu_174", "RefName" : "og_systolic_gemm_Pipeline_RD_VITIS_LOOP_133_1","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "RD_VITIS_LOOP_133_1","RefName" : "RD_VITIS_LOOP_133_1","ID" : "2","Type" : "pipeline"},]},
	{"Name" : "grp_systolic_core_fu_212", "RefName" : "systolic_core","ID" : "3","Type" : "dataflow",
		"SubInsts" : [
		{"Name" : "feed_A_U0", "RefName" : "feed_A","ID" : "4","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "FA_VITIS_LOOP_51_1","RefName" : "FA_VITIS_LOOP_51_1","ID" : "5","Type" : "pipeline"},]},
		{"Name" : "feed_B_U0", "RefName" : "feed_B","ID" : "6","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "FB_VITIS_LOOP_58_1","RefName" : "FB_VITIS_LOOP_58_1","ID" : "7","Type" : "pipeline"},]},
		{"Name" : "pe_1_U0", "RefName" : "pe_1","ID" : "8","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_pe_1_Pipeline_PE_LOOP_fu_39", "RefName" : "pe_1_Pipeline_PE_LOOP","ID" : "9","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "PE_LOOP","RefName" : "PE_LOOP","ID" : "10","Type" : "pipeline"},]},]},
		{"Name" : "pe_2_U0", "RefName" : "pe_2","ID" : "11","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_pe_2_Pipeline_PE_LOOP_fu_39", "RefName" : "pe_2_Pipeline_PE_LOOP","ID" : "12","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "PE_LOOP","RefName" : "PE_LOOP","ID" : "13","Type" : "pipeline"},]},]},
		{"Name" : "pe_4_U0", "RefName" : "pe_4","ID" : "14","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_pe_4_Pipeline_PE_LOOP_fu_39", "RefName" : "pe_4_Pipeline_PE_LOOP","ID" : "15","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "PE_LOOP","RefName" : "PE_LOOP","ID" : "16","Type" : "pipeline"},]},]},
		{"Name" : "pe_3_U0", "RefName" : "pe_3","ID" : "17","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_pe_3_Pipeline_PE_LOOP_fu_39", "RefName" : "pe_3_Pipeline_PE_LOOP","ID" : "18","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "PE_LOOP","RefName" : "PE_LOOP","ID" : "19","Type" : "pipeline"},]},]},
		{"Name" : "pe_5_U0", "RefName" : "pe_5","ID" : "20","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_pe_5_Pipeline_PE_LOOP_fu_39", "RefName" : "pe_5_Pipeline_PE_LOOP","ID" : "21","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "PE_LOOP","RefName" : "PE_LOOP","ID" : "22","Type" : "pipeline"},]},]},
		{"Name" : "pe_7_U0", "RefName" : "pe_7","ID" : "23","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_pe_7_Pipeline_PE_LOOP_fu_39", "RefName" : "pe_7_Pipeline_PE_LOOP","ID" : "24","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "PE_LOOP","RefName" : "PE_LOOP","ID" : "25","Type" : "pipeline"},]},]},
		{"Name" : "pe_6_U0", "RefName" : "pe_6","ID" : "26","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_pe_6_Pipeline_PE_LOOP_fu_39", "RefName" : "pe_6_Pipeline_PE_LOOP","ID" : "27","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "PE_LOOP","RefName" : "PE_LOOP","ID" : "28","Type" : "pipeline"},]},]},
		{"Name" : "pe_8_U0", "RefName" : "pe_8","ID" : "29","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_pe_8_Pipeline_PE_LOOP_fu_39", "RefName" : "pe_8_Pipeline_PE_LOOP","ID" : "30","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "PE_LOOP","RefName" : "PE_LOOP","ID" : "31","Type" : "pipeline"},]},]},
		{"Name" : "pe_U0", "RefName" : "pe","ID" : "32","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_pe_Pipeline_PE_LOOP_fu_39", "RefName" : "pe_Pipeline_PE_LOOP","ID" : "33","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "PE_LOOP","RefName" : "PE_LOOP","ID" : "34","Type" : "pipeline"},]},]},
		{"Name" : "sink_A_U0", "RefName" : "sink_A","ID" : "35","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "SA_VITIS_LOOP_65_1","RefName" : "SA_VITIS_LOOP_65_1","ID" : "36","Type" : "pipeline"},]},
		{"Name" : "sink_B_U0", "RefName" : "sink_B","ID" : "37","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "SB_VITIS_LOOP_72_1","RefName" : "SB_VITIS_LOOP_72_1","ID" : "38","Type" : "pipeline"},]},
		{"Name" : "collect_U0", "RefName" : "collect","ID" : "39","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "CO_VITIS_LOOP_79_1","RefName" : "CO_VITIS_LOOP_79_1","ID" : "40","Type" : "pipeline"},]},]},
	{"Name" : "grp_og_systolic_gemm_Pipeline_WR_VITIS_LOOP_145_2_fu_243", "RefName" : "og_systolic_gemm_Pipeline_WR_VITIS_LOOP_145_2","ID" : "41","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "WR_VITIS_LOOP_145_2","RefName" : "WR_VITIS_LOOP_145_2","ID" : "42","Type" : "pipeline"},]},]
}]}