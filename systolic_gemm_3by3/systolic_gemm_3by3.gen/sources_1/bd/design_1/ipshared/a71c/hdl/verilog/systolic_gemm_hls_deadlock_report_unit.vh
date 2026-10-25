   
    parameter PROC_NUM = 14;
    parameter ST_IDLE = 3'b000;
    parameter ST_FILTER_FAKE = 3'b001;
    parameter ST_DL_DETECTED = 3'b010;
    parameter ST_DL_REPORT = 3'b100;
   

    reg [2:0] CS_fsm;
    reg [2:0] NS_fsm;
    reg [PROC_NUM - 1:0] dl_detect_reg;
    reg [PROC_NUM - 1:0] dl_done_reg;
    reg [PROC_NUM - 1:0] origin_reg;
    reg [PROC_NUM - 1:0] dl_in_vec_reg;
    reg [31:0] dl_keep_cnt;
    reg stop_report_path;
    reg [PROC_NUM - 1:0] reported_proc;
    integer i;
    integer fp;

    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            reported_proc <= 'b0;
        end
        else if (CS_fsm == ST_DL_REPORT) begin
            reported_proc <= reported_proc | dl_in_vec;
        end
        else if (CS_fsm == ST_DL_DETECTED) begin
            reported_proc <= 'b0;
        end
    end

    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            stop_report_path <= 1'b0;
        end
        else if (CS_fsm == ST_DL_REPORT && (|(dl_in_vec & reported_proc))) begin
            stop_report_path <= 1'b1;
        end
        else if (CS_fsm == ST_IDLE) begin
            stop_report_path <= 1'b0;
        end
    end

    // FSM State machine
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            CS_fsm <= ST_IDLE;
        end
        else begin
            CS_fsm <= NS_fsm;
        end
    end

    always @ (CS_fsm or dl_in_vec or dl_detect_reg or dl_done_reg or dl_in_vec or origin_reg or dl_keep_cnt) begin
        case (CS_fsm)
            ST_IDLE : begin
                if (|dl_in_vec) begin
                    NS_fsm = ST_FILTER_FAKE;
                end
                else begin
                    NS_fsm = ST_IDLE;
                end
            end
            ST_FILTER_FAKE: begin
                if (dl_keep_cnt >= 32'd1000) begin
                    NS_fsm = ST_DL_DETECTED;
                end
                else if (dl_detect_reg != (dl_detect_reg & dl_in_vec)) begin
                    NS_fsm = ST_IDLE;
                end
                else begin
                    NS_fsm = ST_FILTER_FAKE;
                end
            end
            ST_DL_DETECTED: begin
                // has unreported deadlock cycle
                if ((dl_detect_reg != dl_done_reg) && stop_report_path == 1'b0) begin
                    NS_fsm = ST_DL_REPORT;
                end
                else begin
                    NS_fsm = ST_DL_DETECTED;
                end
            end
            ST_DL_REPORT: begin
                if (|(dl_in_vec & origin_reg)) begin
                    NS_fsm = ST_DL_DETECTED;
                end
                // avoid report deadlock ring.
                else if (|(dl_in_vec & reported_proc)) begin
                    NS_fsm = ST_DL_DETECTED;
                end
                else begin
                    NS_fsm = ST_DL_REPORT;
                end
            end
            default: NS_fsm = ST_IDLE;
        endcase
    end

    // dl_detect_reg record the procs that first detect deadlock
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_detect_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_IDLE) begin
                dl_detect_reg <= dl_in_vec;
            end
        end
    end

    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_keep_cnt <= 32'h0;
        end
        else begin
            if (CS_fsm == ST_FILTER_FAKE && (dl_detect_reg == (dl_detect_reg & dl_in_vec))) begin
                dl_keep_cnt <= dl_keep_cnt + 32'h1;
            end
            else if (CS_fsm == ST_FILTER_FAKE && (dl_detect_reg != (dl_detect_reg & dl_in_vec))) begin
                dl_keep_cnt <= 32'h0;
            end
        end
    end

    // dl_detect_out keeps in high after deadlock detected
    assign dl_detect_out = (|dl_detect_reg) && (CS_fsm == ST_DL_DETECTED || CS_fsm == ST_DL_REPORT);

    // dl_done_reg record the cycles has been reported
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_done_reg <= 'b0;
        end
        else begin
            if ((CS_fsm == ST_DL_REPORT) && (|(dl_in_vec & dl_detect_reg) == 'b1)) begin
                dl_done_reg <= dl_done_reg | dl_in_vec;
            end
        end
    end

    // clear token once a cycle is done
    assign token_clear = (CS_fsm == ST_DL_REPORT) ? ((|(dl_in_vec & origin_reg)) ? 'b1 : 'b0) : 'b0;

    // origin_reg record the current cycle start id
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            origin_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED) begin
                origin_reg <= origin;
            end
        end
    end
   
    // origin will be valid for only one cycle
    wire [PROC_NUM*PROC_NUM - 1:0] origin_tmp;
    assign origin_tmp[PROC_NUM - 1:0] = (dl_detect_reg[0] & ~dl_done_reg[0]) ? 'b1 : 'b0;
    genvar j;
    generate
    for(j = 1;j < PROC_NUM;j = j + 1) begin: F1
        assign origin_tmp[j*PROC_NUM +: PROC_NUM] = (dl_detect_reg[j] & ~dl_done_reg[j]) ? ('b1 << j) : origin_tmp[(j - 1)*PROC_NUM +: PROC_NUM];
    end
    endgenerate
    always @ (CS_fsm or origin_tmp) begin
        if (CS_fsm == ST_DL_DETECTED) begin
            origin = origin_tmp[(PROC_NUM - 1)*PROC_NUM +: PROC_NUM];
        end
        else begin
            origin = 'b0;
        end
    end

    
    // dl_in_vec_reg record the current cycle dl_in_vec
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_in_vec_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED) begin
                dl_in_vec_reg <= origin;
            end
            else if (CS_fsm == ST_DL_REPORT) begin
                dl_in_vec_reg <= dl_in_vec;
            end
        end
    end
    
    // find_df_deadlock to report the deadlock
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            find_df_deadlock <= 1'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED && ((dl_detect_reg == dl_done_reg) || (stop_report_path == 1'b1))) begin
                find_df_deadlock <= 1'b1;
            end
            else if (CS_fsm == ST_IDLE) begin
                find_df_deadlock <= 1'b0;
            end
        end
    end
    
    // get the first valid proc index in dl vector
    function integer proc_index(input [PROC_NUM - 1:0] dl_vec);
        begin
            proc_index = 0;
            for (i = 0; i < PROC_NUM; i = i + 1) begin
                if (dl_vec[i]) begin
                    proc_index = i;
                end
            end
        end
    endfunction

    // get the proc path based on dl vector
    function [344:0] proc_path(input [PROC_NUM - 1:0] dl_vec);
        integer index;
        begin
            index = proc_index(dl_vec);
            case (index)
                0 : begin
                    proc_path = "systolic_gemm_systolic_gemm.feed_A_U0";
                end
                1 : begin
                    proc_path = "systolic_gemm_systolic_gemm.feed_B_U0";
                end
                2 : begin
                    proc_path = "systolic_gemm_systolic_gemm.pe_1_U0";
                end
                3 : begin
                    proc_path = "systolic_gemm_systolic_gemm.pe_2_U0";
                end
                4 : begin
                    proc_path = "systolic_gemm_systolic_gemm.pe_3_U0";
                end
                5 : begin
                    proc_path = "systolic_gemm_systolic_gemm.pe_4_U0";
                end
                6 : begin
                    proc_path = "systolic_gemm_systolic_gemm.pe_5_U0";
                end
                7 : begin
                    proc_path = "systolic_gemm_systolic_gemm.pe_6_U0";
                end
                8 : begin
                    proc_path = "systolic_gemm_systolic_gemm.pe_7_U0";
                end
                9 : begin
                    proc_path = "systolic_gemm_systolic_gemm.pe_8_U0";
                end
                10 : begin
                    proc_path = "systolic_gemm_systolic_gemm.pe_U0";
                end
                11 : begin
                    proc_path = "systolic_gemm_systolic_gemm.sink_A_U0";
                end
                12 : begin
                    proc_path = "systolic_gemm_systolic_gemm.sink_B_U0";
                end
                13 : begin
                    proc_path = "systolic_gemm_systolic_gemm.collect_U0";
                end
                default : begin
                    proc_path = "unknown";
                end
            endcase
        end
    endfunction

    // print the headlines of deadlock detection
    task print_dl_head;
        begin
            $display("\n//////////////////////////////////////////////////////////////////////////////");
            $display("// ERROR!!! DEADLOCK DETECTED at %0t ns! SIMULATION WILL BE STOPPED! //", $time);
            $display("//////////////////////////////////////////////////////////////////////////////");
            fp = $fopen("deadlock_db.dat", "w");
        end
    endtask

    // print the start of a cycle
    task print_cycle_start(input reg [344:0] proc_path, input integer cycle_id);
        begin
            $display("/////////////////////////");
            $display("// Dependence cycle %0d:", cycle_id);
            $display("// (1): Process: %0s", proc_path);
            $fdisplay(fp, "Dependence_Cycle_ID %0d", cycle_id);
            $fdisplay(fp, "Dependence_Process_ID 1");
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print the end of deadlock detection
    task print_dl_end(input integer num, input integer record_time);
        begin
            $display("////////////////////////////////////////////////////////////////////////");
            $display("// Totally %0d cycles detected!", num);
            $display("////////////////////////////////////////////////////////////////////////");
            $display("// ERROR!!! DEADLOCK DETECTED at %0t ns! SIMULATION WILL BE STOPPED! //", record_time);
            $display("//////////////////////////////////////////////////////////////////////////////");
            $fdisplay(fp, "Dependence_Cycle_Number %0d", num);
            $fclose(fp);
        end
    endtask

    // print one proc component in the cycle
    task print_cycle_proc_comp(input reg [344:0] proc_path, input integer cycle_comp_id);
        begin
            $display("// (%0d): Process: %0s", cycle_comp_id, proc_path);
            $fdisplay(fp, "Dependence_Process_ID %0d", cycle_comp_id);
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print one channel component in the cycle
    task print_cycle_chan_comp(input [PROC_NUM - 1:0] dl_vec1, input [PROC_NUM - 1:0] dl_vec2);
        reg [440:0] chan_path;
        integer index1;
        integer index2;
        begin
            index1 = proc_index(dl_vec1);
            index2 = proc_index(dl_vec2);
            case (index1)
                0 : begin // for proc 'systolic_gemm_systolic_gemm.feed_A_U0'
                    case(index2)
                    2: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_1_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.feed_A_U0.aS_0_0_blk_n data_FIFO}
                        if ((~feed_A_U0.aS_0_0_blk_n)) begin
                            if (~aS_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_U' written by process 'systolic_gemm_systolic_gemm.pe_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_U' read by process 'systolic_gemm_systolic_gemm.pe_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_1_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_1_U0_U.if_full_n & systolic_gemm_systolic_gemm_inst.feed_A_U0.ap_start & ~systolic_gemm_systolic_gemm_inst.feed_A_U0.real_start & (trans_in_cnt_0 == trans_out_cnt_0) & ~systolic_gemm_systolic_gemm_inst.start_for_pe_1_U0_U.if_read} start_FIFO}
                        if ((~start_for_pe_1_U0_U.if_full_n & feed_A_U0.ap_start & ~feed_A_U0.real_start & (trans_in_cnt_0 == trans_out_cnt_0) & ~start_for_pe_1_U0_U.if_read)) begin
                            $display("//      Blocked by full output start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_1_U0_U' read by process 'systolic_gemm_systolic_gemm.pe_1_U0',");
                        end
                    end
                    5: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_4_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_4_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.feed_A_U0.aS_1_0_blk_n data_FIFO}
                        if ((~feed_A_U0.aS_1_0_blk_n)) begin
                            if (~aS_4_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_4_U' written by process 'systolic_gemm_systolic_gemm.pe_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_4_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_4_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_4_U' read by process 'systolic_gemm_systolic_gemm.pe_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_4_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_4_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_4_U0_U.if_full_n & systolic_gemm_systolic_gemm_inst.feed_A_U0.ap_start & ~systolic_gemm_systolic_gemm_inst.feed_A_U0.real_start & (trans_in_cnt_0 == trans_out_cnt_0) & ~systolic_gemm_systolic_gemm_inst.start_for_pe_4_U0_U.if_read} start_FIFO}
                        if ((~start_for_pe_4_U0_U.if_full_n & feed_A_U0.ap_start & ~feed_A_U0.real_start & (trans_in_cnt_0 == trans_out_cnt_0) & ~start_for_pe_4_U0_U.if_read)) begin
                            $display("//      Blocked by full output start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_4_U0_U' read by process 'systolic_gemm_systolic_gemm.pe_4_U0',");
                        end
                    end
                    8: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_7_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_8_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.feed_A_U0.aS_2_0_blk_n data_FIFO}
                        if ((~feed_A_U0.aS_2_0_blk_n)) begin
                            if (~aS_8_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_8_U' written by process 'systolic_gemm_systolic_gemm.pe_7_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_8_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_8_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_8_U' read by process 'systolic_gemm_systolic_gemm.pe_7_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_8_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_7_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_7_U0_U.if_full_n & systolic_gemm_systolic_gemm_inst.feed_A_U0.ap_start & ~systolic_gemm_systolic_gemm_inst.feed_A_U0.real_start & (trans_in_cnt_0 == trans_out_cnt_0) & ~systolic_gemm_systolic_gemm_inst.start_for_pe_7_U0_U.if_read} start_FIFO}
                        if ((~start_for_pe_7_U0_U.if_full_n & feed_A_U0.ap_start & ~feed_A_U0.real_start & (trans_in_cnt_0 == trans_out_cnt_0) & ~start_for_pe_7_U0_U.if_read)) begin
                            $display("//      Blocked by full output start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_7_U0_U' read by process 'systolic_gemm_systolic_gemm.pe_7_U0',");
                        end
                    end
                    1: begin //  for dep proc 'systolic_gemm_systolic_gemm.feed_B_U0'
// for dep channel '' info is :
// blk sig is {{systolic_gemm_systolic_gemm_inst.ap_sync_feed_A_U0_ap_ready & systolic_gemm_systolic_gemm_inst.feed_A_U0.ap_idle & ~systolic_gemm_systolic_gemm_inst.ap_sync_feed_B_U0_ap_ready} input_sync}
                        if ((ap_sync_feed_A_U0_ap_ready & feed_A_U0.ap_idle & ~ap_sync_feed_B_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'systolic_gemm_systolic_gemm.feed_B_U0'");
                        end
                    end
                    endcase
                end
                1 : begin // for proc 'systolic_gemm_systolic_gemm.feed_B_U0'
                    case(index2)
                    2: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_1_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.feed_B_U0.bS_0_0_blk_n data_FIFO}
                        if ((~feed_B_U0.bS_0_0_blk_n)) begin
                            if (~bS_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_U' written by process 'systolic_gemm_systolic_gemm.pe_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_U' read by process 'systolic_gemm_systolic_gemm.pe_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    3: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_2_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_1_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.feed_B_U0.bS_0_1_blk_n data_FIFO}
                        if ((~feed_B_U0.bS_0_1_blk_n)) begin
                            if (~bS_1_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_1_U' written by process 'systolic_gemm_systolic_gemm.pe_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_1_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_1_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_1_U' read by process 'systolic_gemm_systolic_gemm.pe_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_1_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_2_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_2_U0_U.if_full_n & systolic_gemm_systolic_gemm_inst.feed_B_U0.ap_start & ~systolic_gemm_systolic_gemm_inst.feed_B_U0.real_start & (trans_in_cnt_1 == trans_out_cnt_1) & ~systolic_gemm_systolic_gemm_inst.start_for_pe_2_U0_U.if_read} start_FIFO}
                        if ((~start_for_pe_2_U0_U.if_full_n & feed_B_U0.ap_start & ~feed_B_U0.real_start & (trans_in_cnt_1 == trans_out_cnt_1) & ~start_for_pe_2_U0_U.if_read)) begin
                            $display("//      Blocked by full output start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_2_U0_U' read by process 'systolic_gemm_systolic_gemm.pe_2_U0',");
                        end
                    end
                    4: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_3_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_2_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.feed_B_U0.bS_0_2_blk_n data_FIFO}
                        if ((~feed_B_U0.bS_0_2_blk_n)) begin
                            if (~bS_2_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_2_U' written by process 'systolic_gemm_systolic_gemm.pe_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_2_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_2_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_2_U' read by process 'systolic_gemm_systolic_gemm.pe_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_2_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_3_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_3_U0_U.if_full_n & systolic_gemm_systolic_gemm_inst.feed_B_U0.ap_start & ~systolic_gemm_systolic_gemm_inst.feed_B_U0.real_start & (trans_in_cnt_1 == trans_out_cnt_1) & ~systolic_gemm_systolic_gemm_inst.start_for_pe_3_U0_U.if_read} start_FIFO}
                        if ((~start_for_pe_3_U0_U.if_full_n & feed_B_U0.ap_start & ~feed_B_U0.real_start & (trans_in_cnt_1 == trans_out_cnt_1) & ~start_for_pe_3_U0_U.if_read)) begin
                            $display("//      Blocked by full output start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_3_U0_U' read by process 'systolic_gemm_systolic_gemm.pe_3_U0',");
                        end
                    end
                    0: begin //  for dep proc 'systolic_gemm_systolic_gemm.feed_A_U0'
// for dep channel '' info is :
// blk sig is {{systolic_gemm_systolic_gemm_inst.ap_sync_feed_B_U0_ap_ready & systolic_gemm_systolic_gemm_inst.feed_B_U0.ap_idle & ~systolic_gemm_systolic_gemm_inst.ap_sync_feed_A_U0_ap_ready} input_sync}
                        if ((ap_sync_feed_B_U0_ap_ready & feed_B_U0.ap_idle & ~ap_sync_feed_A_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'systolic_gemm_systolic_gemm.feed_A_U0'");
                        end
                    end
                    endcase
                end
                2 : begin // for proc 'systolic_gemm_systolic_gemm.pe_1_U0'
                    case(index2)
                    0: begin //  for dep proc 'systolic_gemm_systolic_gemm.feed_A_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_1_U0.grp_pe_1_Pipeline_PE_LOOP_fu_39.aS_0_0_blk_n data_FIFO}
                        if ((~pe_1_U0.grp_pe_1_Pipeline_PE_LOOP_fu_39.aS_0_0_blk_n)) begin
                            if (~aS_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_U' written by process 'systolic_gemm_systolic_gemm.feed_A_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_U' read by process 'systolic_gemm_systolic_gemm.feed_A_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_1_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_1_U0_U.if_empty_n & systolic_gemm_systolic_gemm_inst.pe_1_U0.ap_idle & ~systolic_gemm_systolic_gemm_inst.start_for_pe_1_U0_U.if_write} start_FIFO}
                        if ((~start_for_pe_1_U0_U.if_empty_n & pe_1_U0.ap_idle & ~start_for_pe_1_U0_U.if_write)) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_1_U0_U' written by process 'systolic_gemm_systolic_gemm.feed_A_U0',");
                        end
                    end
                    3: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_2_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_1_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_1_U0.grp_pe_1_Pipeline_PE_LOOP_fu_39.aS_0_1_blk_n data_FIFO}
                        if ((~pe_1_U0.grp_pe_1_Pipeline_PE_LOOP_fu_39.aS_0_1_blk_n)) begin
                            if (~aS_1_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_1_U' written by process 'systolic_gemm_systolic_gemm.pe_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_1_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_1_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_1_U' read by process 'systolic_gemm_systolic_gemm.pe_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_1_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'systolic_gemm_systolic_gemm.feed_B_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_1_U0.grp_pe_1_Pipeline_PE_LOOP_fu_39.bS_0_0_blk_n data_FIFO}
                        if ((~pe_1_U0.grp_pe_1_Pipeline_PE_LOOP_fu_39.bS_0_0_blk_n)) begin
                            if (~bS_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_U' written by process 'systolic_gemm_systolic_gemm.feed_B_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_U' read by process 'systolic_gemm_systolic_gemm.feed_B_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    5: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_4_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_3_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_1_U0.grp_pe_1_Pipeline_PE_LOOP_fu_39.bS_1_0_blk_n data_FIFO}
                        if ((~pe_1_U0.grp_pe_1_Pipeline_PE_LOOP_fu_39.bS_1_0_blk_n)) begin
                            if (~bS_3_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_3_U' written by process 'systolic_gemm_systolic_gemm.pe_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_3_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_3_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_3_U' read by process 'systolic_gemm_systolic_gemm.pe_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_3_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    13: begin //  for dep proc 'systolic_gemm_systolic_gemm.collect_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_1_U0.cS_0_0_blk_n data_FIFO}
                        if ((~pe_1_U0.cS_0_0_blk_n)) begin
                            if (~cS_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_U' written by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_U' read by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_collect_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_collect_U0_U.if_full_n & systolic_gemm_systolic_gemm_inst.pe_1_U0.ap_start & ~systolic_gemm_systolic_gemm_inst.pe_1_U0.real_start & (trans_in_cnt_6 == trans_out_cnt_6) & ~systolic_gemm_systolic_gemm_inst.start_for_collect_U0_U.if_read} start_FIFO}
                        if ((~start_for_collect_U0_U.if_full_n & pe_1_U0.ap_start & ~pe_1_U0.real_start & (trans_in_cnt_6 == trans_out_cnt_6) & ~start_for_collect_U0_U.if_read)) begin
                            $display("//      Blocked by full output start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_collect_U0_U' read by process 'systolic_gemm_systolic_gemm.collect_U0',");
                        end
                    end
                    endcase
                end
                3 : begin // for proc 'systolic_gemm_systolic_gemm.pe_2_U0'
                    case(index2)
                    2: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_1_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_1_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_2_U0.grp_pe_2_Pipeline_PE_LOOP_fu_39.aS_0_1_blk_n data_FIFO}
                        if ((~pe_2_U0.grp_pe_2_Pipeline_PE_LOOP_fu_39.aS_0_1_blk_n)) begin
                            if (~aS_1_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_1_U' written by process 'systolic_gemm_systolic_gemm.pe_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_1_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_1_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_1_U' read by process 'systolic_gemm_systolic_gemm.pe_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_1_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    4: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_3_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_2_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_2_U0.grp_pe_2_Pipeline_PE_LOOP_fu_39.aS_0_2_blk_n data_FIFO}
                        if ((~pe_2_U0.grp_pe_2_Pipeline_PE_LOOP_fu_39.aS_0_2_blk_n)) begin
                            if (~aS_2_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_2_U' written by process 'systolic_gemm_systolic_gemm.pe_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_2_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_2_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_2_U' read by process 'systolic_gemm_systolic_gemm.pe_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_2_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'systolic_gemm_systolic_gemm.feed_B_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_1_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_2_U0.grp_pe_2_Pipeline_PE_LOOP_fu_39.bS_0_1_blk_n data_FIFO}
                        if ((~pe_2_U0.grp_pe_2_Pipeline_PE_LOOP_fu_39.bS_0_1_blk_n)) begin
                            if (~bS_1_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_1_U' written by process 'systolic_gemm_systolic_gemm.feed_B_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_1_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_1_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_1_U' read by process 'systolic_gemm_systolic_gemm.feed_B_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_1_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_2_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_2_U0_U.if_empty_n & systolic_gemm_systolic_gemm_inst.pe_2_U0.ap_idle & ~systolic_gemm_systolic_gemm_inst.start_for_pe_2_U0_U.if_write} start_FIFO}
                        if ((~start_for_pe_2_U0_U.if_empty_n & pe_2_U0.ap_idle & ~start_for_pe_2_U0_U.if_write)) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_2_U0_U' written by process 'systolic_gemm_systolic_gemm.feed_B_U0',");
                        end
                    end
                    6: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_5_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_4_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_2_U0.grp_pe_2_Pipeline_PE_LOOP_fu_39.bS_1_1_blk_n data_FIFO}
                        if ((~pe_2_U0.grp_pe_2_Pipeline_PE_LOOP_fu_39.bS_1_1_blk_n)) begin
                            if (~bS_4_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_4_U' written by process 'systolic_gemm_systolic_gemm.pe_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_4_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_4_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_4_U' read by process 'systolic_gemm_systolic_gemm.pe_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_4_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_5_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_5_U0_U.if_full_n & systolic_gemm_systolic_gemm_inst.pe_2_U0.ap_start & ~systolic_gemm_systolic_gemm_inst.pe_2_U0.real_start & (trans_in_cnt_2 == trans_out_cnt_2) & ~systolic_gemm_systolic_gemm_inst.start_for_pe_5_U0_U.if_read} start_FIFO}
                        if ((~start_for_pe_5_U0_U.if_full_n & pe_2_U0.ap_start & ~pe_2_U0.real_start & (trans_in_cnt_2 == trans_out_cnt_2) & ~start_for_pe_5_U0_U.if_read)) begin
                            $display("//      Blocked by full output start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_5_U0_U' read by process 'systolic_gemm_systolic_gemm.pe_5_U0',");
                        end
                    end
                    13: begin //  for dep proc 'systolic_gemm_systolic_gemm.collect_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_1_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_2_U0.cS_0_1_blk_n data_FIFO}
                        if ((~pe_2_U0.cS_0_1_blk_n)) begin
                            if (~cS_1_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_1_U' written by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_1_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_1_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_1_U' read by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_1_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                4 : begin // for proc 'systolic_gemm_systolic_gemm.pe_3_U0'
                    case(index2)
                    3: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_2_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_2_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_3_U0.grp_pe_3_Pipeline_PE_LOOP_fu_39.aS_0_2_blk_n data_FIFO}
                        if ((~pe_3_U0.grp_pe_3_Pipeline_PE_LOOP_fu_39.aS_0_2_blk_n)) begin
                            if (~aS_2_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_2_U' written by process 'systolic_gemm_systolic_gemm.pe_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_2_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_2_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_2_U' read by process 'systolic_gemm_systolic_gemm.pe_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_2_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    11: begin //  for dep proc 'systolic_gemm_systolic_gemm.sink_A_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_3_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_3_U0.grp_pe_3_Pipeline_PE_LOOP_fu_39.aS_0_3_blk_n data_FIFO}
                        if ((~pe_3_U0.grp_pe_3_Pipeline_PE_LOOP_fu_39.aS_0_3_blk_n)) begin
                            if (~aS_3_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_3_U' written by process 'systolic_gemm_systolic_gemm.sink_A_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_3_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_3_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_3_U' read by process 'systolic_gemm_systolic_gemm.sink_A_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_3_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_sink_A_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_sink_A_U0_U.if_full_n & systolic_gemm_systolic_gemm_inst.pe_3_U0.ap_start & ~systolic_gemm_systolic_gemm_inst.pe_3_U0.real_start & (trans_in_cnt_3 == trans_out_cnt_3) & ~systolic_gemm_systolic_gemm_inst.start_for_sink_A_U0_U.if_read} start_FIFO}
                        if ((~start_for_sink_A_U0_U.if_full_n & pe_3_U0.ap_start & ~pe_3_U0.real_start & (trans_in_cnt_3 == trans_out_cnt_3) & ~start_for_sink_A_U0_U.if_read)) begin
                            $display("//      Blocked by full output start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_sink_A_U0_U' read by process 'systolic_gemm_systolic_gemm.sink_A_U0',");
                        end
                    end
                    1: begin //  for dep proc 'systolic_gemm_systolic_gemm.feed_B_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_2_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_3_U0.grp_pe_3_Pipeline_PE_LOOP_fu_39.bS_0_2_blk_n data_FIFO}
                        if ((~pe_3_U0.grp_pe_3_Pipeline_PE_LOOP_fu_39.bS_0_2_blk_n)) begin
                            if (~bS_2_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_2_U' written by process 'systolic_gemm_systolic_gemm.feed_B_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_2_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_2_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_2_U' read by process 'systolic_gemm_systolic_gemm.feed_B_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_2_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_3_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_3_U0_U.if_empty_n & systolic_gemm_systolic_gemm_inst.pe_3_U0.ap_idle & ~systolic_gemm_systolic_gemm_inst.start_for_pe_3_U0_U.if_write} start_FIFO}
                        if ((~start_for_pe_3_U0_U.if_empty_n & pe_3_U0.ap_idle & ~start_for_pe_3_U0_U.if_write)) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_3_U0_U' written by process 'systolic_gemm_systolic_gemm.feed_B_U0',");
                        end
                    end
                    7: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_6_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_5_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_3_U0.grp_pe_3_Pipeline_PE_LOOP_fu_39.bS_1_2_blk_n data_FIFO}
                        if ((~pe_3_U0.grp_pe_3_Pipeline_PE_LOOP_fu_39.bS_1_2_blk_n)) begin
                            if (~bS_5_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_5_U' written by process 'systolic_gemm_systolic_gemm.pe_6_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_5_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_5_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_5_U' read by process 'systolic_gemm_systolic_gemm.pe_6_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_5_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_6_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_6_U0_U.if_full_n & systolic_gemm_systolic_gemm_inst.pe_3_U0.ap_start & ~systolic_gemm_systolic_gemm_inst.pe_3_U0.real_start & (trans_in_cnt_3 == trans_out_cnt_3) & ~systolic_gemm_systolic_gemm_inst.start_for_pe_6_U0_U.if_read} start_FIFO}
                        if ((~start_for_pe_6_U0_U.if_full_n & pe_3_U0.ap_start & ~pe_3_U0.real_start & (trans_in_cnt_3 == trans_out_cnt_3) & ~start_for_pe_6_U0_U.if_read)) begin
                            $display("//      Blocked by full output start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_6_U0_U' read by process 'systolic_gemm_systolic_gemm.pe_6_U0',");
                        end
                    end
                    13: begin //  for dep proc 'systolic_gemm_systolic_gemm.collect_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_2_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_3_U0.cS_0_2_blk_n data_FIFO}
                        if ((~pe_3_U0.cS_0_2_blk_n)) begin
                            if (~cS_2_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_2_U' written by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_2_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_2_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_2_U' read by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_2_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                5 : begin // for proc 'systolic_gemm_systolic_gemm.pe_4_U0'
                    case(index2)
                    0: begin //  for dep proc 'systolic_gemm_systolic_gemm.feed_A_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_4_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_4_U0.grp_pe_4_Pipeline_PE_LOOP_fu_39.aS_1_0_blk_n data_FIFO}
                        if ((~pe_4_U0.grp_pe_4_Pipeline_PE_LOOP_fu_39.aS_1_0_blk_n)) begin
                            if (~aS_4_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_4_U' written by process 'systolic_gemm_systolic_gemm.feed_A_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_4_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_4_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_4_U' read by process 'systolic_gemm_systolic_gemm.feed_A_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_4_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_4_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_4_U0_U.if_empty_n & systolic_gemm_systolic_gemm_inst.pe_4_U0.ap_idle & ~systolic_gemm_systolic_gemm_inst.start_for_pe_4_U0_U.if_write} start_FIFO}
                        if ((~start_for_pe_4_U0_U.if_empty_n & pe_4_U0.ap_idle & ~start_for_pe_4_U0_U.if_write)) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_4_U0_U' written by process 'systolic_gemm_systolic_gemm.feed_A_U0',");
                        end
                    end
                    6: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_5_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_5_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_4_U0.grp_pe_4_Pipeline_PE_LOOP_fu_39.aS_1_1_blk_n data_FIFO}
                        if ((~pe_4_U0.grp_pe_4_Pipeline_PE_LOOP_fu_39.aS_1_1_blk_n)) begin
                            if (~aS_5_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_5_U' written by process 'systolic_gemm_systolic_gemm.pe_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_5_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_5_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_5_U' read by process 'systolic_gemm_systolic_gemm.pe_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_5_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    2: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_1_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_3_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_4_U0.grp_pe_4_Pipeline_PE_LOOP_fu_39.bS_1_0_blk_n data_FIFO}
                        if ((~pe_4_U0.grp_pe_4_Pipeline_PE_LOOP_fu_39.bS_1_0_blk_n)) begin
                            if (~bS_3_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_3_U' written by process 'systolic_gemm_systolic_gemm.pe_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_3_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_3_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_3_U' read by process 'systolic_gemm_systolic_gemm.pe_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_3_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    8: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_7_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_6_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_4_U0.grp_pe_4_Pipeline_PE_LOOP_fu_39.bS_2_0_blk_n data_FIFO}
                        if ((~pe_4_U0.grp_pe_4_Pipeline_PE_LOOP_fu_39.bS_2_0_blk_n)) begin
                            if (~bS_6_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_6_U' written by process 'systolic_gemm_systolic_gemm.pe_7_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_6_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_6_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_6_U' read by process 'systolic_gemm_systolic_gemm.pe_7_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_6_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    13: begin //  for dep proc 'systolic_gemm_systolic_gemm.collect_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_3_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_4_U0.cS_1_0_blk_n data_FIFO}
                        if ((~pe_4_U0.cS_1_0_blk_n)) begin
                            if (~cS_3_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_3_U' written by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_3_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_3_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_3_U' read by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_3_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                6 : begin // for proc 'systolic_gemm_systolic_gemm.pe_5_U0'
                    case(index2)
                    5: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_4_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_5_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_5_U0.grp_pe_5_Pipeline_PE_LOOP_fu_39.aS_1_1_blk_n data_FIFO}
                        if ((~pe_5_U0.grp_pe_5_Pipeline_PE_LOOP_fu_39.aS_1_1_blk_n)) begin
                            if (~aS_5_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_5_U' written by process 'systolic_gemm_systolic_gemm.pe_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_5_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_5_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_5_U' read by process 'systolic_gemm_systolic_gemm.pe_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_5_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    7: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_6_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_6_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_5_U0.grp_pe_5_Pipeline_PE_LOOP_fu_39.aS_1_2_blk_n data_FIFO}
                        if ((~pe_5_U0.grp_pe_5_Pipeline_PE_LOOP_fu_39.aS_1_2_blk_n)) begin
                            if (~aS_6_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_6_U' written by process 'systolic_gemm_systolic_gemm.pe_6_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_6_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_6_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_6_U' read by process 'systolic_gemm_systolic_gemm.pe_6_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_6_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    3: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_2_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_4_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_5_U0.grp_pe_5_Pipeline_PE_LOOP_fu_39.bS_1_1_blk_n data_FIFO}
                        if ((~pe_5_U0.grp_pe_5_Pipeline_PE_LOOP_fu_39.bS_1_1_blk_n)) begin
                            if (~bS_4_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_4_U' written by process 'systolic_gemm_systolic_gemm.pe_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_4_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_4_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_4_U' read by process 'systolic_gemm_systolic_gemm.pe_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_4_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_5_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_5_U0_U.if_empty_n & systolic_gemm_systolic_gemm_inst.pe_5_U0.ap_idle & ~systolic_gemm_systolic_gemm_inst.start_for_pe_5_U0_U.if_write} start_FIFO}
                        if ((~start_for_pe_5_U0_U.if_empty_n & pe_5_U0.ap_idle & ~start_for_pe_5_U0_U.if_write)) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_5_U0_U' written by process 'systolic_gemm_systolic_gemm.pe_2_U0',");
                        end
                    end
                    9: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_8_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_7_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_5_U0.grp_pe_5_Pipeline_PE_LOOP_fu_39.bS_2_1_blk_n data_FIFO}
                        if ((~pe_5_U0.grp_pe_5_Pipeline_PE_LOOP_fu_39.bS_2_1_blk_n)) begin
                            if (~bS_7_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_7_U' written by process 'systolic_gemm_systolic_gemm.pe_8_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_7_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_7_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_7_U' read by process 'systolic_gemm_systolic_gemm.pe_8_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_7_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    13: begin //  for dep proc 'systolic_gemm_systolic_gemm.collect_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_4_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_5_U0.cS_1_1_blk_n data_FIFO}
                        if ((~pe_5_U0.cS_1_1_blk_n)) begin
                            if (~cS_4_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_4_U' written by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_4_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_4_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_4_U' read by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_4_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                7 : begin // for proc 'systolic_gemm_systolic_gemm.pe_6_U0'
                    case(index2)
                    6: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_5_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_6_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_6_U0.grp_pe_6_Pipeline_PE_LOOP_fu_39.aS_1_2_blk_n data_FIFO}
                        if ((~pe_6_U0.grp_pe_6_Pipeline_PE_LOOP_fu_39.aS_1_2_blk_n)) begin
                            if (~aS_6_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_6_U' written by process 'systolic_gemm_systolic_gemm.pe_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_6_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_6_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_6_U' read by process 'systolic_gemm_systolic_gemm.pe_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_6_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    11: begin //  for dep proc 'systolic_gemm_systolic_gemm.sink_A_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_7_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_6_U0.grp_pe_6_Pipeline_PE_LOOP_fu_39.aS_1_3_blk_n data_FIFO}
                        if ((~pe_6_U0.grp_pe_6_Pipeline_PE_LOOP_fu_39.aS_1_3_blk_n)) begin
                            if (~aS_7_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_7_U' written by process 'systolic_gemm_systolic_gemm.sink_A_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_7_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_7_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_7_U' read by process 'systolic_gemm_systolic_gemm.sink_A_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_7_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    4: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_3_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_5_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_6_U0.grp_pe_6_Pipeline_PE_LOOP_fu_39.bS_1_2_blk_n data_FIFO}
                        if ((~pe_6_U0.grp_pe_6_Pipeline_PE_LOOP_fu_39.bS_1_2_blk_n)) begin
                            if (~bS_5_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_5_U' written by process 'systolic_gemm_systolic_gemm.pe_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_5_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_5_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_5_U' read by process 'systolic_gemm_systolic_gemm.pe_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_5_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_6_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_6_U0_U.if_empty_n & systolic_gemm_systolic_gemm_inst.pe_6_U0.ap_idle & ~systolic_gemm_systolic_gemm_inst.start_for_pe_6_U0_U.if_write} start_FIFO}
                        if ((~start_for_pe_6_U0_U.if_empty_n & pe_6_U0.ap_idle & ~start_for_pe_6_U0_U.if_write)) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_6_U0_U' written by process 'systolic_gemm_systolic_gemm.pe_3_U0',");
                        end
                    end
                    10: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_8_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_6_U0.grp_pe_6_Pipeline_PE_LOOP_fu_39.bS_2_2_blk_n data_FIFO}
                        if ((~pe_6_U0.grp_pe_6_Pipeline_PE_LOOP_fu_39.bS_2_2_blk_n)) begin
                            if (~bS_8_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_8_U' written by process 'systolic_gemm_systolic_gemm.pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_8_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_8_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_8_U' read by process 'systolic_gemm_systolic_gemm.pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_8_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_U0_U.if_full_n & systolic_gemm_systolic_gemm_inst.pe_6_U0.ap_start & ~systolic_gemm_systolic_gemm_inst.pe_6_U0.real_start & (trans_in_cnt_5 == trans_out_cnt_5) & ~systolic_gemm_systolic_gemm_inst.start_for_pe_U0_U.if_read} start_FIFO}
                        if ((~start_for_pe_U0_U.if_full_n & pe_6_U0.ap_start & ~pe_6_U0.real_start & (trans_in_cnt_5 == trans_out_cnt_5) & ~start_for_pe_U0_U.if_read)) begin
                            $display("//      Blocked by full output start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_U0_U' read by process 'systolic_gemm_systolic_gemm.pe_U0',");
                        end
                    end
                    13: begin //  for dep proc 'systolic_gemm_systolic_gemm.collect_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_5_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_6_U0.cS_1_2_blk_n data_FIFO}
                        if ((~pe_6_U0.cS_1_2_blk_n)) begin
                            if (~cS_5_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_5_U' written by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_5_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_5_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_5_U' read by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_5_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                8 : begin // for proc 'systolic_gemm_systolic_gemm.pe_7_U0'
                    case(index2)
                    0: begin //  for dep proc 'systolic_gemm_systolic_gemm.feed_A_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_8_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_7_U0.grp_pe_7_Pipeline_PE_LOOP_fu_39.aS_2_0_blk_n data_FIFO}
                        if ((~pe_7_U0.grp_pe_7_Pipeline_PE_LOOP_fu_39.aS_2_0_blk_n)) begin
                            if (~aS_8_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_8_U' written by process 'systolic_gemm_systolic_gemm.feed_A_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_8_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_8_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_8_U' read by process 'systolic_gemm_systolic_gemm.feed_A_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_8_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_7_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_7_U0_U.if_empty_n & systolic_gemm_systolic_gemm_inst.pe_7_U0.ap_idle & ~systolic_gemm_systolic_gemm_inst.start_for_pe_7_U0_U.if_write} start_FIFO}
                        if ((~start_for_pe_7_U0_U.if_empty_n & pe_7_U0.ap_idle & ~start_for_pe_7_U0_U.if_write)) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_7_U0_U' written by process 'systolic_gemm_systolic_gemm.feed_A_U0',");
                        end
                    end
                    9: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_8_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_9_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_7_U0.grp_pe_7_Pipeline_PE_LOOP_fu_39.aS_2_1_blk_n data_FIFO}
                        if ((~pe_7_U0.grp_pe_7_Pipeline_PE_LOOP_fu_39.aS_2_1_blk_n)) begin
                            if (~aS_9_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_9_U' written by process 'systolic_gemm_systolic_gemm.pe_8_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_9_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_9_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_9_U' read by process 'systolic_gemm_systolic_gemm.pe_8_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_9_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_8_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_8_U0_U.if_full_n & systolic_gemm_systolic_gemm_inst.pe_7_U0.ap_start & ~systolic_gemm_systolic_gemm_inst.pe_7_U0.real_start & (trans_in_cnt_4 == trans_out_cnt_4) & ~systolic_gemm_systolic_gemm_inst.start_for_pe_8_U0_U.if_read} start_FIFO}
                        if ((~start_for_pe_8_U0_U.if_full_n & pe_7_U0.ap_start & ~pe_7_U0.real_start & (trans_in_cnt_4 == trans_out_cnt_4) & ~start_for_pe_8_U0_U.if_read)) begin
                            $display("//      Blocked by full output start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_8_U0_U' read by process 'systolic_gemm_systolic_gemm.pe_8_U0',");
                        end
                    end
                    5: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_4_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_6_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_7_U0.grp_pe_7_Pipeline_PE_LOOP_fu_39.bS_2_0_blk_n data_FIFO}
                        if ((~pe_7_U0.grp_pe_7_Pipeline_PE_LOOP_fu_39.bS_2_0_blk_n)) begin
                            if (~bS_6_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_6_U' written by process 'systolic_gemm_systolic_gemm.pe_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_6_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_6_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_6_U' read by process 'systolic_gemm_systolic_gemm.pe_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_6_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    12: begin //  for dep proc 'systolic_gemm_systolic_gemm.sink_B_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_9_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_7_U0.grp_pe_7_Pipeline_PE_LOOP_fu_39.bS_3_0_blk_n data_FIFO}
                        if ((~pe_7_U0.grp_pe_7_Pipeline_PE_LOOP_fu_39.bS_3_0_blk_n)) begin
                            if (~bS_9_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_9_U' written by process 'systolic_gemm_systolic_gemm.sink_B_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_9_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_9_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_9_U' read by process 'systolic_gemm_systolic_gemm.sink_B_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_9_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_sink_B_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_sink_B_U0_U.if_full_n & systolic_gemm_systolic_gemm_inst.pe_7_U0.ap_start & ~systolic_gemm_systolic_gemm_inst.pe_7_U0.real_start & (trans_in_cnt_4 == trans_out_cnt_4) & ~systolic_gemm_systolic_gemm_inst.start_for_sink_B_U0_U.if_read} start_FIFO}
                        if ((~start_for_sink_B_U0_U.if_full_n & pe_7_U0.ap_start & ~pe_7_U0.real_start & (trans_in_cnt_4 == trans_out_cnt_4) & ~start_for_sink_B_U0_U.if_read)) begin
                            $display("//      Blocked by full output start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_sink_B_U0_U' read by process 'systolic_gemm_systolic_gemm.sink_B_U0',");
                        end
                    end
                    13: begin //  for dep proc 'systolic_gemm_systolic_gemm.collect_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_6_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_7_U0.cS_2_0_blk_n data_FIFO}
                        if ((~pe_7_U0.cS_2_0_blk_n)) begin
                            if (~cS_6_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_6_U' written by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_6_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_6_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_6_U' read by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_6_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                9 : begin // for proc 'systolic_gemm_systolic_gemm.pe_8_U0'
                    case(index2)
                    8: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_7_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_9_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_8_U0.grp_pe_8_Pipeline_PE_LOOP_fu_39.aS_2_1_blk_n data_FIFO}
                        if ((~pe_8_U0.grp_pe_8_Pipeline_PE_LOOP_fu_39.aS_2_1_blk_n)) begin
                            if (~aS_9_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_9_U' written by process 'systolic_gemm_systolic_gemm.pe_7_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_9_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_9_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_9_U' read by process 'systolic_gemm_systolic_gemm.pe_7_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_9_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_8_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_8_U0_U.if_empty_n & systolic_gemm_systolic_gemm_inst.pe_8_U0.ap_idle & ~systolic_gemm_systolic_gemm_inst.start_for_pe_8_U0_U.if_write} start_FIFO}
                        if ((~start_for_pe_8_U0_U.if_empty_n & pe_8_U0.ap_idle & ~start_for_pe_8_U0_U.if_write)) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_8_U0_U' written by process 'systolic_gemm_systolic_gemm.pe_7_U0',");
                        end
                    end
                    10: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_10_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_8_U0.grp_pe_8_Pipeline_PE_LOOP_fu_39.aS_2_2_blk_n data_FIFO}
                        if ((~pe_8_U0.grp_pe_8_Pipeline_PE_LOOP_fu_39.aS_2_2_blk_n)) begin
                            if (~aS_10_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_10_U' written by process 'systolic_gemm_systolic_gemm.pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_10_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_10_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_10_U' read by process 'systolic_gemm_systolic_gemm.pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_10_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    6: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_5_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_7_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_8_U0.grp_pe_8_Pipeline_PE_LOOP_fu_39.bS_2_1_blk_n data_FIFO}
                        if ((~pe_8_U0.grp_pe_8_Pipeline_PE_LOOP_fu_39.bS_2_1_blk_n)) begin
                            if (~bS_7_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_7_U' written by process 'systolic_gemm_systolic_gemm.pe_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_7_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_7_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_7_U' read by process 'systolic_gemm_systolic_gemm.pe_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_7_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    12: begin //  for dep proc 'systolic_gemm_systolic_gemm.sink_B_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_10_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_8_U0.grp_pe_8_Pipeline_PE_LOOP_fu_39.bS_3_1_blk_n data_FIFO}
                        if ((~pe_8_U0.grp_pe_8_Pipeline_PE_LOOP_fu_39.bS_3_1_blk_n)) begin
                            if (~bS_10_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_10_U' written by process 'systolic_gemm_systolic_gemm.sink_B_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_10_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_10_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_10_U' read by process 'systolic_gemm_systolic_gemm.sink_B_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_10_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    13: begin //  for dep proc 'systolic_gemm_systolic_gemm.collect_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_7_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_8_U0.cS_2_1_blk_n data_FIFO}
                        if ((~pe_8_U0.cS_2_1_blk_n)) begin
                            if (~cS_7_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_7_U' written by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_7_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_7_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_7_U' read by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_7_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                10 : begin // for proc 'systolic_gemm_systolic_gemm.pe_U0'
                    case(index2)
                    9: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_8_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_10_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_U0.grp_pe_Pipeline_PE_LOOP_fu_39.aS_2_2_blk_n data_FIFO}
                        if ((~pe_U0.grp_pe_Pipeline_PE_LOOP_fu_39.aS_2_2_blk_n)) begin
                            if (~aS_10_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_10_U' written by process 'systolic_gemm_systolic_gemm.pe_8_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_10_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_10_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_10_U' read by process 'systolic_gemm_systolic_gemm.pe_8_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_10_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    11: begin //  for dep proc 'systolic_gemm_systolic_gemm.sink_A_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_11_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_U0.grp_pe_Pipeline_PE_LOOP_fu_39.aS_2_3_blk_n data_FIFO}
                        if ((~pe_U0.grp_pe_Pipeline_PE_LOOP_fu_39.aS_2_3_blk_n)) begin
                            if (~aS_11_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_11_U' written by process 'systolic_gemm_systolic_gemm.sink_A_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_11_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_11_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_11_U' read by process 'systolic_gemm_systolic_gemm.sink_A_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_11_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    7: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_6_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_8_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_U0.grp_pe_Pipeline_PE_LOOP_fu_39.bS_2_2_blk_n data_FIFO}
                        if ((~pe_U0.grp_pe_Pipeline_PE_LOOP_fu_39.bS_2_2_blk_n)) begin
                            if (~bS_8_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_8_U' written by process 'systolic_gemm_systolic_gemm.pe_6_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_8_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_8_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_8_U' read by process 'systolic_gemm_systolic_gemm.pe_6_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_8_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_pe_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_pe_U0_U.if_empty_n & systolic_gemm_systolic_gemm_inst.pe_U0.ap_idle & ~systolic_gemm_systolic_gemm_inst.start_for_pe_U0_U.if_write} start_FIFO}
                        if ((~start_for_pe_U0_U.if_empty_n & pe_U0.ap_idle & ~start_for_pe_U0_U.if_write)) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_pe_U0_U' written by process 'systolic_gemm_systolic_gemm.pe_6_U0',");
                        end
                    end
                    12: begin //  for dep proc 'systolic_gemm_systolic_gemm.sink_B_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_11_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_U0.grp_pe_Pipeline_PE_LOOP_fu_39.bS_3_2_blk_n data_FIFO}
                        if ((~pe_U0.grp_pe_Pipeline_PE_LOOP_fu_39.bS_3_2_blk_n)) begin
                            if (~bS_11_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_11_U' written by process 'systolic_gemm_systolic_gemm.sink_B_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_11_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_11_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_11_U' read by process 'systolic_gemm_systolic_gemm.sink_B_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_11_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    13: begin //  for dep proc 'systolic_gemm_systolic_gemm.collect_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_8_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.pe_U0.cS_2_2_blk_n data_FIFO}
                        if ((~pe_U0.cS_2_2_blk_n)) begin
                            if (~cS_8_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_8_U' written by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_8_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_8_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_8_U' read by process 'systolic_gemm_systolic_gemm.collect_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_8_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                11 : begin // for proc 'systolic_gemm_systolic_gemm.sink_A_U0'
                    case(index2)
                    4: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_3_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_3_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.sink_A_U0.aS_0_3_blk_n data_FIFO}
                        if ((~sink_A_U0.aS_0_3_blk_n)) begin
                            if (~aS_3_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_3_U' written by process 'systolic_gemm_systolic_gemm.pe_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_3_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_3_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_3_U' read by process 'systolic_gemm_systolic_gemm.pe_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_3_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_sink_A_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_sink_A_U0_U.if_empty_n & systolic_gemm_systolic_gemm_inst.sink_A_U0.ap_idle & ~systolic_gemm_systolic_gemm_inst.start_for_sink_A_U0_U.if_write} start_FIFO}
                        if ((~start_for_sink_A_U0_U.if_empty_n & sink_A_U0.ap_idle & ~start_for_sink_A_U0_U.if_write)) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_sink_A_U0_U' written by process 'systolic_gemm_systolic_gemm.pe_3_U0',");
                        end
                    end
                    7: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_6_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_7_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.sink_A_U0.aS_1_3_blk_n data_FIFO}
                        if ((~sink_A_U0.aS_1_3_blk_n)) begin
                            if (~aS_7_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_7_U' written by process 'systolic_gemm_systolic_gemm.pe_6_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_7_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_7_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_7_U' read by process 'systolic_gemm_systolic_gemm.pe_6_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_7_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    10: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_U0'
// for dep channel 'systolic_gemm_systolic_gemm.aS_11_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.sink_A_U0.aS_2_3_blk_n data_FIFO}
                        if ((~sink_A_U0.aS_2_3_blk_n)) begin
                            if (~aS_11_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.aS_11_U' written by process 'systolic_gemm_systolic_gemm.pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_11_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~aS_11_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.aS_11_U' read by process 'systolic_gemm_systolic_gemm.pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.aS_11_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    12: begin //  for dep proc 'systolic_gemm_systolic_gemm.sink_B_U0'
// for dep channel '' info is :
// blk sig is {{ap_done_reg_0 & systolic_gemm_systolic_gemm_inst.sink_A_U0.ap_done & ~systolic_gemm_systolic_gemm_inst.sink_B_U0.ap_done} output_sync}
                        if ((ap_done_reg_0 & sink_A_U0.ap_done & ~sink_B_U0.ap_done)) begin
                            $display("//      Blocked by output sync logic with process : 'systolic_gemm_systolic_gemm.sink_B_U0'");
                        end
                    end
                    13: begin //  for dep proc 'systolic_gemm_systolic_gemm.collect_U0'
// for dep channel '' info is :
// blk sig is {{ap_done_reg_0 & systolic_gemm_systolic_gemm_inst.sink_A_U0.ap_done & ~systolic_gemm_systolic_gemm_inst.collect_U0.ap_done} output_sync}
                        if ((ap_done_reg_0 & sink_A_U0.ap_done & ~collect_U0.ap_done)) begin
                            $display("//      Blocked by output sync logic with process : 'systolic_gemm_systolic_gemm.collect_U0'");
                        end
                    end
                    endcase
                end
                12 : begin // for proc 'systolic_gemm_systolic_gemm.sink_B_U0'
                    case(index2)
                    8: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_7_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_9_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.sink_B_U0.bS_3_0_blk_n data_FIFO}
                        if ((~sink_B_U0.bS_3_0_blk_n)) begin
                            if (~bS_9_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_9_U' written by process 'systolic_gemm_systolic_gemm.pe_7_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_9_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_9_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_9_U' read by process 'systolic_gemm_systolic_gemm.pe_7_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_9_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_sink_B_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_sink_B_U0_U.if_empty_n & systolic_gemm_systolic_gemm_inst.sink_B_U0.ap_idle & ~systolic_gemm_systolic_gemm_inst.start_for_sink_B_U0_U.if_write} start_FIFO}
                        if ((~start_for_sink_B_U0_U.if_empty_n & sink_B_U0.ap_idle & ~start_for_sink_B_U0_U.if_write)) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_sink_B_U0_U' written by process 'systolic_gemm_systolic_gemm.pe_7_U0',");
                        end
                    end
                    9: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_8_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_10_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.sink_B_U0.bS_3_1_blk_n data_FIFO}
                        if ((~sink_B_U0.bS_3_1_blk_n)) begin
                            if (~bS_10_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_10_U' written by process 'systolic_gemm_systolic_gemm.pe_8_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_10_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_10_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_10_U' read by process 'systolic_gemm_systolic_gemm.pe_8_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_10_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    10: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_U0'
// for dep channel 'systolic_gemm_systolic_gemm.bS_11_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.sink_B_U0.bS_3_2_blk_n data_FIFO}
                        if ((~sink_B_U0.bS_3_2_blk_n)) begin
                            if (~bS_11_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.bS_11_U' written by process 'systolic_gemm_systolic_gemm.pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_11_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~bS_11_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.bS_11_U' read by process 'systolic_gemm_systolic_gemm.pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.bS_11_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    11: begin //  for dep proc 'systolic_gemm_systolic_gemm.sink_A_U0'
// for dep channel '' info is :
// blk sig is {{ap_done_reg_1 & systolic_gemm_systolic_gemm_inst.sink_B_U0.ap_done & ~systolic_gemm_systolic_gemm_inst.sink_A_U0.ap_done} output_sync}
                        if ((ap_done_reg_1 & sink_B_U0.ap_done & ~sink_A_U0.ap_done)) begin
                            $display("//      Blocked by output sync logic with process : 'systolic_gemm_systolic_gemm.sink_A_U0'");
                        end
                    end
                    13: begin //  for dep proc 'systolic_gemm_systolic_gemm.collect_U0'
// for dep channel '' info is :
// blk sig is {{ap_done_reg_1 & systolic_gemm_systolic_gemm_inst.sink_B_U0.ap_done & ~systolic_gemm_systolic_gemm_inst.collect_U0.ap_done} output_sync}
                        if ((ap_done_reg_1 & sink_B_U0.ap_done & ~collect_U0.ap_done)) begin
                            $display("//      Blocked by output sync logic with process : 'systolic_gemm_systolic_gemm.collect_U0'");
                        end
                    end
                    endcase
                end
                13 : begin // for proc 'systolic_gemm_systolic_gemm.collect_U0'
                    case(index2)
                    2: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_1_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.collect_U0.cS_0_0_blk_n data_FIFO}
                        if ((~collect_U0.cS_0_0_blk_n)) begin
                            if (~cS_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_U' written by process 'systolic_gemm_systolic_gemm.pe_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_U' read by process 'systolic_gemm_systolic_gemm.pe_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'systolic_gemm_systolic_gemm.start_for_collect_U0_U' info is :
// blk sig is {{~systolic_gemm_systolic_gemm_inst.start_for_collect_U0_U.if_empty_n & systolic_gemm_systolic_gemm_inst.collect_U0.ap_idle & ~systolic_gemm_systolic_gemm_inst.start_for_collect_U0_U.if_write} start_FIFO}
                        if ((~start_for_collect_U0_U.if_empty_n & collect_U0.ap_idle & ~start_for_collect_U0_U.if_write)) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'systolic_gemm_systolic_gemm.start_for_collect_U0_U' written by process 'systolic_gemm_systolic_gemm.pe_1_U0',");
                        end
                    end
                    3: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_2_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_1_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.collect_U0.cS_0_1_blk_n data_FIFO}
                        if ((~collect_U0.cS_0_1_blk_n)) begin
                            if (~cS_1_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_1_U' written by process 'systolic_gemm_systolic_gemm.pe_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_1_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_1_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_1_U' read by process 'systolic_gemm_systolic_gemm.pe_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_1_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    4: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_3_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_2_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.collect_U0.cS_0_2_blk_n data_FIFO}
                        if ((~collect_U0.cS_0_2_blk_n)) begin
                            if (~cS_2_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_2_U' written by process 'systolic_gemm_systolic_gemm.pe_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_2_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_2_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_2_U' read by process 'systolic_gemm_systolic_gemm.pe_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_2_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    5: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_4_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_3_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.collect_U0.cS_1_0_blk_n data_FIFO}
                        if ((~collect_U0.cS_1_0_blk_n)) begin
                            if (~cS_3_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_3_U' written by process 'systolic_gemm_systolic_gemm.pe_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_3_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_3_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_3_U' read by process 'systolic_gemm_systolic_gemm.pe_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_3_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    6: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_5_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_4_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.collect_U0.cS_1_1_blk_n data_FIFO}
                        if ((~collect_U0.cS_1_1_blk_n)) begin
                            if (~cS_4_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_4_U' written by process 'systolic_gemm_systolic_gemm.pe_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_4_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_4_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_4_U' read by process 'systolic_gemm_systolic_gemm.pe_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_4_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    7: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_6_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_5_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.collect_U0.cS_1_2_blk_n data_FIFO}
                        if ((~collect_U0.cS_1_2_blk_n)) begin
                            if (~cS_5_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_5_U' written by process 'systolic_gemm_systolic_gemm.pe_6_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_5_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_5_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_5_U' read by process 'systolic_gemm_systolic_gemm.pe_6_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_5_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    8: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_7_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_6_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.collect_U0.cS_2_0_blk_n data_FIFO}
                        if ((~collect_U0.cS_2_0_blk_n)) begin
                            if (~cS_6_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_6_U' written by process 'systolic_gemm_systolic_gemm.pe_7_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_6_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_6_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_6_U' read by process 'systolic_gemm_systolic_gemm.pe_7_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_6_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    9: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_8_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_7_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.collect_U0.cS_2_1_blk_n data_FIFO}
                        if ((~collect_U0.cS_2_1_blk_n)) begin
                            if (~cS_7_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_7_U' written by process 'systolic_gemm_systolic_gemm.pe_8_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_7_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_7_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_7_U' read by process 'systolic_gemm_systolic_gemm.pe_8_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_7_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    10: begin //  for dep proc 'systolic_gemm_systolic_gemm.pe_U0'
// for dep channel 'systolic_gemm_systolic_gemm.cS_8_U' info is :
// blk sig is {~systolic_gemm_systolic_gemm_inst.collect_U0.cS_2_2_blk_n data_FIFO}
                        if ((~collect_U0.cS_2_2_blk_n)) begin
                            if (~cS_8_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'systolic_gemm_systolic_gemm.cS_8_U' written by process 'systolic_gemm_systolic_gemm.pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_8_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cS_8_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'systolic_gemm_systolic_gemm.cS_8_U' read by process 'systolic_gemm_systolic_gemm.pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path systolic_gemm_systolic_gemm.cS_8_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    11: begin //  for dep proc 'systolic_gemm_systolic_gemm.sink_A_U0'
// for dep channel '' info is :
// blk sig is {{ap_done_reg_2 & systolic_gemm_systolic_gemm_inst.collect_U0.ap_done & ~systolic_gemm_systolic_gemm_inst.sink_A_U0.ap_done} output_sync}
                        if ((ap_done_reg_2 & collect_U0.ap_done & ~sink_A_U0.ap_done)) begin
                            $display("//      Blocked by output sync logic with process : 'systolic_gemm_systolic_gemm.sink_A_U0'");
                        end
                    end
                    12: begin //  for dep proc 'systolic_gemm_systolic_gemm.sink_B_U0'
// for dep channel '' info is :
// blk sig is {{ap_done_reg_2 & systolic_gemm_systolic_gemm_inst.collect_U0.ap_done & ~systolic_gemm_systolic_gemm_inst.sink_B_U0.ap_done} output_sync}
                        if ((ap_done_reg_2 & collect_U0.ap_done & ~sink_B_U0.ap_done)) begin
                            $display("//      Blocked by output sync logic with process : 'systolic_gemm_systolic_gemm.sink_B_U0'");
                        end
                    end
                    endcase
                end
            endcase
        end
    endtask

    // report
    initial begin : report_deadlock
        integer cycle_id;
        integer cycle_comp_id;
        integer record_time;
        wait (dl_reset == 1);
        cycle_id = 1;
        record_time = 0;
        while (1) begin
            @ (negedge dl_clock);
            case (CS_fsm)
                ST_DL_DETECTED: begin
                    cycle_comp_id = 2;
                    if (dl_detect_reg != dl_done_reg && stop_report_path == 1'b0) begin
                        if (dl_done_reg == 'b0) begin
                            print_dl_head;
                            record_time = $time;
                        end
                        print_cycle_start(proc_path(origin), cycle_id);
                        cycle_id = cycle_id + 1;
                    end
                    else begin
                        print_dl_end((cycle_id - 1),record_time);
                        @(negedge dl_clock);
                        @(negedge dl_clock);
                        $finish;
                    end
                end
                ST_DL_REPORT: begin
                    if ((|(dl_in_vec)) & ~(|(dl_in_vec & origin_reg)) & ~(|(reported_proc & dl_in_vec))) begin
                        print_cycle_chan_comp(dl_in_vec_reg, dl_in_vec);
                        print_cycle_proc_comp(proc_path(dl_in_vec), cycle_comp_id);
                        cycle_comp_id = cycle_comp_id + 1;
                    end
                    else begin
                        print_cycle_chan_comp(dl_in_vec_reg, dl_in_vec);
                    end
                end
            endcase
        end
    end
 
