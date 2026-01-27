`timescale 1ns/1ps

`ifdef GATE_LEVEL
    `include "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_hvt_1v0/dff_netlist.sv" 
    `include "/home/yellow/ee3201_16/LAB2/gpdk045_verilog/fast_vdd1v0_basicCells_hvt.v"
`else
    `include "/home/yellow/ee3201_16/LAB2/Exp3/00_src/dff.sv" 
`endif

module tb_ff_hvt_1v0;

    //========================================
    // Signal Declaration
    //========================================
    logic clk;
    logic d;
    logic q;
    
    //========================================
    // Timing Parameters (from SDF)
    //========================================
    parameter real CLK_PERIOD    = 1.0;     // 1ns = 1GHz
    parameter real T_SETUP_RISE  = 0.025;   
    parameter real T_SETUP_FALL  = 0.019;   
    parameter real T_HOLD_RISE   = 0.000;   
    parameter real T_HOLD_FALL   = 0.000;   
    parameter real T_CQ_RISE     = 0.051;   
    parameter real T_CQ_FALL     = 0.058;   

    //========================================
    // DUT Instantiation
    //========================================
    dff DUT (
        .clk(clk),
        .d(d),
        .q(q)
    );

    //========================================
    // SDF Annotation
    //========================================
    `ifdef ANNOTATION
    initial begin
        $sdf_annotate("/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_hvt_1v0/delay.sdf", 
                      DUT, , "annotate.log", "MAXIMUM");
        $display("========================================");
        $display("SDF Annotation Enabled");
        $display("========================================");
    end
    `endif

    //========================================
    // Clock Generation
    //========================================
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    //========================================
    // Waveform Dump
    //========================================
    initial begin
        $dumpfile("/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_hvt_1v0/dff_wave.vcd");
        $dumpvars(0, tb_ff_hvt_1v0);
    end

    //========================================
    // Test Stimulus
    //========================================
    initial begin
        $display("\n========================================");
        $display("D-FF SETUP/HOLD TIME VERIFICATION");
        $display("Corner: FF HVT 1.0V");
        $display("========================================");
        $display("Clock Period     : %.3f ns", CLK_PERIOD);
        $display("Setup Time (D↑)  : %.3f ns", T_SETUP_RISE);
        $display("Setup Time (D↓)  : %.3f ns", T_SETUP_FALL);
        $display("Hold Time (D↑)   : %.3f ns", T_HOLD_RISE);
        $display("Hold Time (D↓)   : %.3f ns", T_HOLD_FALL);
        $display("Clock-to-Q (Q↑)  : %.3f ns", T_CQ_RISE);
        $display("Clock-to-Q (Q↓)  : %.3f ns", T_CQ_FALL);
        $display("========================================\n");
        
        d = 0;
        #(CLK_PERIOD * 3);
        
        //========================================
        // TEST 1: NORMAL OPERATION - PASS
        //========================================
        $display(">>> TEST 1: NORMAL OPERATION ✓");
        $display("    D arrives 0.05ns BEFORE clock edge (safe margin)");
        
        // Test 1a: D↑ with safe margin
        @(posedge clk);  // Sync to clock
        #(CLK_PERIOD - 0.05);  // D changes 0.05ns before next clock
        d = 1;
        #(CLK_PERIOD * 1.5);
        
        // Test 1b: D↓ with safe margin  
        @(posedge clk);
        #(CLK_PERIOD - 0.05);
        d = 0;
        #(CLK_PERIOD * 1.5);
        
        //========================================
        // TEST 2: SETUP VIOLATION - D arrives TOO LATE
        //========================================
        $display("\n>>> TEST 2: SETUP VIOLATION ✗");
        $display("    D↑ arrives 0.020ns before clock (< 0.025ns required)");
        
        // Test 2a: Setup violation for D↑
        @(posedge clk);
        #(CLK_PERIOD - 0.020);  // Only 0.020ns before clock (need 0.025ns!)
        d = 1;
        #(CLK_PERIOD * 2);
        
        $display("    D↓ arrives 0.014ns before clock (< 0.019ns required)");
        
        // Test 2b: Setup violation for D↓
        @(posedge clk);
        #(CLK_PERIOD - 0.014);  // Only 0.014ns before clock (need 0.019ns!)
        d = 0;
        #(CLK_PERIOD * 2);
        
        //========================================
        // TEST 3: HOLD VIOLATION (if hold_time > 0)
        //========================================
        if (T_HOLD_RISE > 0.0001 || T_HOLD_FALL > 0.0001) begin
            $display("\n>>> TEST 3: HOLD VIOLATION ✗");
            $display("    D changes TOO SOON after clock edge");
            
            // Test 3a: D stable before clock, but changes too soon after
            @(posedge clk);
            #(CLK_PERIOD - 0.05);
            d = 1;  // D arrives safely
            
            @(posedge clk);  // Clock edge
            #(T_HOLD_RISE / 2);  // Change before hold time expires
            d = 0;
            #(CLK_PERIOD * 2);
            
        end else begin
            $display("\n>>> TEST 3: HOLD VIOLATION - SKIPPED");
            $display("    Hold time = 0.000ns for this corner");
            $display("    Cannot demonstrate hold violation meaningfully");
        end
        
        //========================================
        // TEST 4: MEASURE PROPAGATION DELAY
        //========================================
        $display("\n>>> TEST 4: CLOCK-TO-Q PROPAGATION DELAY");
        $display("    Expected t_cq(Q↑): %.3f ns", T_CQ_RISE);
        $display("    Expected t_cq(Q↓): %.3f ns", T_CQ_FALL);
        
        // Measure t_cq for Q rising
        d = 0;
        #(CLK_PERIOD * 2);
        
        @(posedge clk);
        #(CLK_PERIOD - 0.1);
        d = 1;  // Set D high before clock
        #(CLK_PERIOD * 2);  // Wait to see Q change
        
        // Measure t_cq for Q falling
        @(posedge clk);
        #(CLK_PERIOD - 0.1);
        d = 0;  // Set D low before clock
        #(CLK_PERIOD * 2);
        
        //========================================
        // TEST 5: EDGE CASE - D changes exactly at setup time
        //========================================
        $display("\n>>> TEST 5: EDGE CASE - D at boundary");
        $display("    D changes EXACTLY at setup time limit");
        
        @(posedge clk);
        #(CLK_PERIOD - T_SETUP_RISE);  // Exactly at setup time
        d = 1;
        #(CLK_PERIOD * 2);
        
        @(posedge clk);
        #(CLK_PERIOD - T_SETUP_FALL);  // Exactly at setup time
        d = 0;
        #(CLK_PERIOD * 2);
        
        //========================================
        // End Simulation
        //========================================
        #(CLK_PERIOD * 2);
        $display("\n========================================");
        $display("SIMULATION COMPLETE");
        $display("========================================\n");
        $finish;
    end

    //========================================
    // Monitor
    //========================================
    initial begin
        $monitor("Time=%0t ns | clk=%b | d=%b | q=%b", $realtime, clk, d, q);
    end

endmodule