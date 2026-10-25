set SynModuleInfo {
  {SRCNAME og_systolic_gemm_Pipeline_RD_VITIS_LOOP_133_1 MODELNAME og_systolic_gemm_Pipeline_RD_VITIS_LOOP_133_1 RTLNAME og_systolic_gemm_og_systolic_gemm_Pipeline_RD_VITIS_LOOP_133_1
    SUBMODULES {
      {MODELNAME og_systolic_gemm_flow_control_loop_pipe_sequential_init RTLNAME og_systolic_gemm_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME og_systolic_gemm_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME feed_A MODELNAME feed_A RTLNAME og_systolic_gemm_feed_A
    SUBMODULES {
      {MODELNAME og_systolic_gemm_sparsemux_7_2_16_1_1 RTLNAME og_systolic_gemm_sparsemux_7_2_16_1_1 BINDTYPE op TYPE sparsemux IMPL onehotencoding_realdef}
      {MODELNAME og_systolic_gemm_flow_control_loop_pipe RTLNAME og_systolic_gemm_flow_control_loop_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME og_systolic_gemm_flow_control_loop_pipe_U}
    }
  }
  {SRCNAME feed_B MODELNAME feed_B RTLNAME og_systolic_gemm_feed_B}
  {SRCNAME pe.1_Pipeline_PE_LOOP MODELNAME pe_1_Pipeline_PE_LOOP RTLNAME og_systolic_gemm_pe_1_Pipeline_PE_LOOP
    SUBMODULES {
      {MODELNAME og_systolic_gemm_mac_muladd_16s_16s_32s_32_4_1 RTLNAME og_systolic_gemm_mac_muladd_16s_16s_32s_32_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
    }
  }
  {SRCNAME pe.1 MODELNAME pe_1 RTLNAME og_systolic_gemm_pe_1}
  {SRCNAME pe.2_Pipeline_PE_LOOP MODELNAME pe_2_Pipeline_PE_LOOP RTLNAME og_systolic_gemm_pe_2_Pipeline_PE_LOOP}
  {SRCNAME pe.2 MODELNAME pe_2 RTLNAME og_systolic_gemm_pe_2}
  {SRCNAME pe.3_Pipeline_PE_LOOP MODELNAME pe_3_Pipeline_PE_LOOP RTLNAME og_systolic_gemm_pe_3_Pipeline_PE_LOOP}
  {SRCNAME pe.3 MODELNAME pe_3 RTLNAME og_systolic_gemm_pe_3}
  {SRCNAME pe.4_Pipeline_PE_LOOP MODELNAME pe_4_Pipeline_PE_LOOP RTLNAME og_systolic_gemm_pe_4_Pipeline_PE_LOOP}
  {SRCNAME pe.4 MODELNAME pe_4 RTLNAME og_systolic_gemm_pe_4}
  {SRCNAME pe.5_Pipeline_PE_LOOP MODELNAME pe_5_Pipeline_PE_LOOP RTLNAME og_systolic_gemm_pe_5_Pipeline_PE_LOOP}
  {SRCNAME pe.5 MODELNAME pe_5 RTLNAME og_systolic_gemm_pe_5}
  {SRCNAME pe.6_Pipeline_PE_LOOP MODELNAME pe_6_Pipeline_PE_LOOP RTLNAME og_systolic_gemm_pe_6_Pipeline_PE_LOOP}
  {SRCNAME pe.6 MODELNAME pe_6 RTLNAME og_systolic_gemm_pe_6}
  {SRCNAME pe.7_Pipeline_PE_LOOP MODELNAME pe_7_Pipeline_PE_LOOP RTLNAME og_systolic_gemm_pe_7_Pipeline_PE_LOOP}
  {SRCNAME pe.7 MODELNAME pe_7 RTLNAME og_systolic_gemm_pe_7}
  {SRCNAME pe.8_Pipeline_PE_LOOP MODELNAME pe_8_Pipeline_PE_LOOP RTLNAME og_systolic_gemm_pe_8_Pipeline_PE_LOOP}
  {SRCNAME pe.8 MODELNAME pe_8 RTLNAME og_systolic_gemm_pe_8}
  {SRCNAME pe_Pipeline_PE_LOOP MODELNAME pe_Pipeline_PE_LOOP RTLNAME og_systolic_gemm_pe_Pipeline_PE_LOOP}
  {SRCNAME pe MODELNAME pe RTLNAME og_systolic_gemm_pe}
  {SRCNAME sink_A MODELNAME sink_A RTLNAME og_systolic_gemm_sink_A}
  {SRCNAME sink_B MODELNAME sink_B RTLNAME og_systolic_gemm_sink_B}
  {SRCNAME collect MODELNAME collect RTLNAME og_systolic_gemm_collect}
  {SRCNAME systolic_core MODELNAME systolic_core RTLNAME og_systolic_gemm_systolic_core
    SUBMODULES {
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME aS_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME aS_4_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME aS_8_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME bS_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME bS_1_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME bS_2_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME aS_1_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME bS_3_U}
      {MODELNAME og_systolic_gemm_fifo_w32_d2_S RTLNAME og_systolic_gemm_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME cS_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME aS_2_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME bS_4_U}
      {MODELNAME og_systolic_gemm_fifo_w32_d2_S RTLNAME og_systolic_gemm_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME cS_1_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME aS_3_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME bS_5_U}
      {MODELNAME og_systolic_gemm_fifo_w32_d2_S RTLNAME og_systolic_gemm_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME cS_2_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME aS_5_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME bS_6_U}
      {MODELNAME og_systolic_gemm_fifo_w32_d2_S RTLNAME og_systolic_gemm_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME cS_3_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME aS_6_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME bS_7_U}
      {MODELNAME og_systolic_gemm_fifo_w32_d2_S RTLNAME og_systolic_gemm_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME cS_4_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME aS_7_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME bS_8_U}
      {MODELNAME og_systolic_gemm_fifo_w32_d2_S RTLNAME og_systolic_gemm_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME cS_5_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME aS_9_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME bS_9_U}
      {MODELNAME og_systolic_gemm_fifo_w32_d2_S RTLNAME og_systolic_gemm_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME cS_6_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME aS_10_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME bS_10_U}
      {MODELNAME og_systolic_gemm_fifo_w32_d2_S RTLNAME og_systolic_gemm_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME cS_7_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME aS_11_U}
      {MODELNAME og_systolic_gemm_fifo_w16_d4_S RTLNAME og_systolic_gemm_fifo_w16_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME bS_11_U}
      {MODELNAME og_systolic_gemm_fifo_w32_d2_S RTLNAME og_systolic_gemm_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME cS_8_U}
      {MODELNAME og_systolic_gemm_start_for_pe_1_U0 RTLNAME og_systolic_gemm_start_for_pe_1_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_pe_1_U0_U}
      {MODELNAME og_systolic_gemm_start_for_pe_4_U0 RTLNAME og_systolic_gemm_start_for_pe_4_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_pe_4_U0_U}
      {MODELNAME og_systolic_gemm_start_for_pe_7_U0 RTLNAME og_systolic_gemm_start_for_pe_7_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_pe_7_U0_U}
      {MODELNAME og_systolic_gemm_start_for_pe_2_U0 RTLNAME og_systolic_gemm_start_for_pe_2_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_pe_2_U0_U}
      {MODELNAME og_systolic_gemm_start_for_pe_3_U0 RTLNAME og_systolic_gemm_start_for_pe_3_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_pe_3_U0_U}
      {MODELNAME og_systolic_gemm_start_for_collect_U0 RTLNAME og_systolic_gemm_start_for_collect_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_collect_U0_U}
      {MODELNAME og_systolic_gemm_start_for_pe_5_U0 RTLNAME og_systolic_gemm_start_for_pe_5_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_pe_5_U0_U}
      {MODELNAME og_systolic_gemm_start_for_pe_6_U0 RTLNAME og_systolic_gemm_start_for_pe_6_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_pe_6_U0_U}
      {MODELNAME og_systolic_gemm_start_for_sink_A_U0 RTLNAME og_systolic_gemm_start_for_sink_A_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_sink_A_U0_U}
      {MODELNAME og_systolic_gemm_start_for_pe_U0 RTLNAME og_systolic_gemm_start_for_pe_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_pe_U0_U}
      {MODELNAME og_systolic_gemm_start_for_pe_8_U0 RTLNAME og_systolic_gemm_start_for_pe_8_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_pe_8_U0_U}
      {MODELNAME og_systolic_gemm_start_for_sink_B_U0 RTLNAME og_systolic_gemm_start_for_sink_B_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_sink_B_U0_U}
    }
  }
  {SRCNAME og_systolic_gemm_Pipeline_WR_VITIS_LOOP_145_2 MODELNAME og_systolic_gemm_Pipeline_WR_VITIS_LOOP_145_2 RTLNAME og_systolic_gemm_og_systolic_gemm_Pipeline_WR_VITIS_LOOP_145_2
    SUBMODULES {
      {MODELNAME og_systolic_gemm_sparsemux_7_2_32_1_1 RTLNAME og_systolic_gemm_sparsemux_7_2_32_1_1 BINDTYPE op TYPE sparsemux IMPL onehotencoding_realdef}
    }
  }
  {SRCNAME og_systolic_gemm MODELNAME og_systolic_gemm RTLNAME og_systolic_gemm IS_TOP 1
    SUBMODULES {
      {MODELNAME og_systolic_gemm_CTRL_s_axi RTLNAME og_systolic_gemm_CTRL_s_axi BINDTYPE interface TYPE interface_s_axilite}
      {MODELNAME og_systolic_gemm_regslice_both RTLNAME og_systolic_gemm_regslice_both BINDTYPE interface TYPE adapter IMPL reg_slice}
    }
  }
}
