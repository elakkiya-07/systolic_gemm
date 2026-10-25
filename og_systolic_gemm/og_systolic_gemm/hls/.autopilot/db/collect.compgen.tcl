# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 166 \
    name cS_0_0 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_cS_0_0 \
    op interface \
    ports { cS_0_0_dout { I 32 vector } cS_0_0_empty_n { I 1 bit } cS_0_0_read { O 1 bit } cS_0_0_num_data_valid { I 3 vector } cS_0_0_fifo_cap { I 3 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 167 \
    name cS_0_1 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_cS_0_1 \
    op interface \
    ports { cS_0_1_dout { I 32 vector } cS_0_1_empty_n { I 1 bit } cS_0_1_read { O 1 bit } cS_0_1_num_data_valid { I 3 vector } cS_0_1_fifo_cap { I 3 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 168 \
    name cS_0_2 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_cS_0_2 \
    op interface \
    ports { cS_0_2_dout { I 32 vector } cS_0_2_empty_n { I 1 bit } cS_0_2_read { O 1 bit } cS_0_2_num_data_valid { I 3 vector } cS_0_2_fifo_cap { I 3 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 169 \
    name cS_1_0 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_cS_1_0 \
    op interface \
    ports { cS_1_0_dout { I 32 vector } cS_1_0_empty_n { I 1 bit } cS_1_0_read { O 1 bit } cS_1_0_num_data_valid { I 3 vector } cS_1_0_fifo_cap { I 3 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 170 \
    name cS_1_1 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_cS_1_1 \
    op interface \
    ports { cS_1_1_dout { I 32 vector } cS_1_1_empty_n { I 1 bit } cS_1_1_read { O 1 bit } cS_1_1_num_data_valid { I 3 vector } cS_1_1_fifo_cap { I 3 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 171 \
    name cS_1_2 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_cS_1_2 \
    op interface \
    ports { cS_1_2_dout { I 32 vector } cS_1_2_empty_n { I 1 bit } cS_1_2_read { O 1 bit } cS_1_2_num_data_valid { I 3 vector } cS_1_2_fifo_cap { I 3 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 172 \
    name cS_2_0 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_cS_2_0 \
    op interface \
    ports { cS_2_0_dout { I 32 vector } cS_2_0_empty_n { I 1 bit } cS_2_0_read { O 1 bit } cS_2_0_num_data_valid { I 3 vector } cS_2_0_fifo_cap { I 3 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 173 \
    name cS_2_1 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_cS_2_1 \
    op interface \
    ports { cS_2_1_dout { I 32 vector } cS_2_1_empty_n { I 1 bit } cS_2_1_read { O 1 bit } cS_2_1_num_data_valid { I 3 vector } cS_2_1_fifo_cap { I 3 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 174 \
    name cS_2_2 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_cS_2_2 \
    op interface \
    ports { cS_2_2_dout { I 32 vector } cS_2_2_empty_n { I 1 bit } cS_2_2_read { O 1 bit } cS_2_2_num_data_valid { I 3 vector } cS_2_2_fifo_cap { I 3 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 175 \
    name C_0_0 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_C_0_0 \
    op interface \
    ports { C_0_0 { O 32 vector } C_0_0_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 176 \
    name C_0_1 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_C_0_1 \
    op interface \
    ports { C_0_1 { O 32 vector } C_0_1_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 177 \
    name C_0_2 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_C_0_2 \
    op interface \
    ports { C_0_2 { O 32 vector } C_0_2_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 178 \
    name C_1_0 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_C_1_0 \
    op interface \
    ports { C_1_0 { O 32 vector } C_1_0_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 179 \
    name C_1_1 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_C_1_1 \
    op interface \
    ports { C_1_1 { O 32 vector } C_1_1_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 180 \
    name C_1_2 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_C_1_2 \
    op interface \
    ports { C_1_2 { O 32 vector } C_1_2_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 181 \
    name C_2_0 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_C_2_0 \
    op interface \
    ports { C_2_0 { O 32 vector } C_2_0_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 182 \
    name C_2_1 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_C_2_1 \
    op interface \
    ports { C_2_1 { O 32 vector } C_2_1_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 183 \
    name C_2_2 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_C_2_2 \
    op interface \
    ports { C_2_2 { O 32 vector } C_2_2_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } ap_continue { I 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


# flow_control definition:
set InstName og_systolic_gemm_flow_control_loop_pipe_U
set CompName og_systolic_gemm_flow_control_loop_pipe
set name flow_control_loop_pipe
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control] == "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control"} {
eval "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control { \
    name ${name} \
    prefix og_systolic_gemm_ \
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $CompName BINDTYPE interface TYPE internal_upc_flow_control INSTNAME $InstName
}


