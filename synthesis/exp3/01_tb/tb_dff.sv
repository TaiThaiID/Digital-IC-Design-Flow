`timescale 1ns/1ps

//========================================
// Select corner using compiler define
//========================================
`ifdef FF_HVT_1V0
    `define CORNER_NAME "FF HVT 1.0V"
    `define LIB_PATH "/home/yellow/ee3201_16/LAB2/gpdk045_verilog/fast_vdd1v0_basicCells_hvt.v"
    `define NETLIST_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_hvt_1v0/dff_netlist.sv"
    `define SDF_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_hvt_1v0/delay.sdf"
    `define VCD_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_hvt_1v0/dff_wave.vcd"
    `define T_SETUP_RISE 0.025
    `define T_SETUP_FALL 0.019
    `define T_HOLD_RISE  0.000
    `define T_HOLD_FALL  0.000
    `define T_CQ_RISE    0.051
    `define T_CQ_FALL    0.058

`elsif FF_HVT_1V2
    `define CORNER_NAME "FF HVT 1.2V"
    `define LIB_PATH "/home/yellow/ee3201_16/LAB2/gpdk045_verilog/fast_vdd1v2_basicCells_hvt.v"
    `define NETLIST_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_hvt_1v2/dff_netlist.sv"
    `define SDF_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_hvt_1v2/delay.sdf"
    `define VCD_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_hvt_1v2/dff_wave.vcd"
    `define T_SETUP_RISE 0.016
    `define T_SETUP_FALL 0.012
    `define T_HOLD_RISE  0.000  
    `define T_HOLD_FALL  0.000
    `define T_CQ_RISE    0.037
    `define T_CQ_FALL    0.042

`elsif SS_HVT_1V0
    `define CORNER_NAME "SS HVT 1.0V"
    `define LIB_PATH "/home/yellow/ee3201_16/LAB2/gpdk045_verilog/slow_vdd1v0_basicCells_hvt.v"
    `define NETLIST_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ss_hvt_1v0/dff_netlist.sv"
    `define SDF_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ss_hvt_1v0/delay.sdf"
    `define VCD_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ss_hvt_1v0/dff_wave.vcd"
    `define T_SETUP_RISE 0.177
    `define T_SETUP_FALL 0.058
    `define T_HOLD_RISE  0.000  
    `define T_HOLD_FALL  0.051
    `define T_CQ_RISE    0.243
    `define T_CQ_FALL    0.292

`elsif SS_HVT_1V2
    `define CORNER_NAME "SS HVT 1.2V"
    `define LIB_PATH "/home/yellow/ee3201_16/LAB2/gpdk045_verilog/slow_vdd1v2_basicCells_hvt.v"
    `define NETLIST_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ss_hvt_1v2/dff_netlist.sv"
    `define SDF_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ss_hvt_1v2/delay.sdf"
    `define VCD_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ss_hvt_1v2/dff_wave.vcd"
    `define T_SETUP_RISE 0.072
    `define T_SETUP_FALL 0.026
    `define T_HOLD_RISE  0.000
    `define T_HOLD_FALL  0.018
    `define T_CQ_RISE    0.115
    `define T_CQ_FALL    0.135

`elsif FF_LVT_1V0
    `define CORNER_NAME "FF LVT 1.0V"
    `define LIB_PATH "/home/yellow/ee3201_16/LAB2/gpdk045_verilog/fast_vdd1v0_basicCells_lvt.v"
    `define NETLIST_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_lvt_1v0/dff_netlist.sv"
    `define SDF_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_lvt_1v0/delay.sdf"
    `define VCD_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_lvt_1v0/dff_wave.vcd"
    `define T_SETUP_RISE 0.013
    `define T_SETUP_FALL 0.010
    `define T_HOLD_RISE  0.000
    `define T_HOLD_FALL  0.000
    `define T_CQ_RISE    0.029
    `define T_CQ_FALL    0.033

`elsif FF_LVT_1V2
    `define CORNER_NAME "FF LVT 1.2V"
    `define LIB_PATH "/home/yellow/ee3201_16/LAB2/gpdk045_verilog/fast_vdd1v2_basicCells_lvt.v"
    `define NETLIST_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_lvt_1v2/dff_netlist.sv"
    `define SDF_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_lvt_1v2/delay.sdf"
    `define VCD_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ff_lvt_1v2/dff_wave.vcd"
    `define T_SETUP_RISE 0.010
    `define T_SETUP_FALL 0.007
    `define T_HOLD_RISE  0.000
    `define T_HOLD_FALL  0.000
    `define T_CQ_RISE    0.024
    `define T_CQ_FALL    0.027

`elsif SS_LVT_1V0
    `define CORNER_NAME "SS LVT 1.0V"
    `define LIB_PATH "/home/yellow/ee3201_16/LAB2/gpdk045_verilog/slow_vdd1v0_basicCells_lvt.v"
    `define NETLIST_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ss_lvt_1v0/dff_netlist.sv"
    `define SDF_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ss_lvt_1v0/delay.sdf"
    `define VCD_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ss_lvt_1v0/dff_wave.vcd"
    `define T_SETUP_RISE 0.061
    `define T_SETUP_FALL 0.029
    `define T_HOLD_RISE  0.000
    `define T_HOLD_FALL  0.014
    `define T_CQ_RISE    0.106
    `define T_CQ_FALL    0.121

`elsif SS_LVT_1V2
    `define CORNER_NAME "SS LVT 1.2V"
    `define LIB_PATH "/home/yellow/ee3201_16/LAB2/gpdk045_verilog/slow_vdd1v2_basicCells_lvt.v"
    `define NETLIST_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ss_lvt_1v2/dff_netlist.sv"
    `define SDF_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ss_lvt_1v2/delay.sdf"
    `define VCD_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/ss_lvt_1v2/dff_wave.vcd"
    `define T_SETUP_RISE 0.036
    `define T_SETUP_FALL 0.016
    `define T_HOLD_RISE  0.000
    `define T_HOLD_FALL  0.005
    `define T_CQ_RISE    0.068
    `define T_CQ_FALL    0.078

`else
    `define CORNER_NAME "RTL (No Corner Selected)"
    `define LIB_PATH ""
    `define NETLIST_PATH "/home/yellow/ee3201_16/LAB2/Exp3/00_src/dff.sv"
    `define SDF_PATH ""
    `define VCD_PATH "/home/yellow/ee3201_16/LAB2/Exp3/03_outputs/rtl_sim.vcd"
    `define T_SETUP_RISE 0.0
    `define T_SETUP_FALL 0.0
    `define T_HOLD_RISE  0.0
    `define T_HOLD_FALL  0.0
    `define T_CQ_RISE    0.0
    `define T_CQ_FALL    0.0
`endif

//========================================
// Include files based on corner
//========================================
`ifdef GATE_LEVEL
    `include `NETLIST_PATH
    `include `LIB_PATH
`else
    `include "/home/yellow/ee3201_16/LAB2/Exp3/00_src/dff.sv"
`endif

module tb_dff;

    //========================================
    // Signal Declaration
    //========================================
    logic clk;
    logic d;
    logic q;
    
    //========================================
    // Convert defines to parameters
    //========================================
    parameter real CLK_PERIOD    = 1.0;   // T=1ns => f=1GHz
    parameter real T_SETUP_RISE  = `T_SETUP_RISE;
    parameter real T_SETUP_FALL  = `T_SETUP_FALL;
    parameter real T_HOLD_RISE   = `T_HOLD_RISE;
    parameter real T_HOLD_FALL   = `T_HOLD_FALL;
    parameter real T_CQ_RISE     = `T_CQ_RISE;
    parameter real T_CQ_FALL     = `T_CQ_FALL;
    
    // Calculate test margins automatically based on timing
    parameter real MARGIN_SAFE      = 0.300;   			//Cần chỉnh sửa chỗ này
    parameter real MARGIN_VIOLATION = 0.003;

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
        $sdf_annotate(`SDF_PATH, DUT, , "annotate.log", "MAXIMUM");
        $display("========================================");
        $display("SDF Annotation Enabled");
        $display("File: %s", `SDF_PATH);
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
        $dumpfile(`VCD_PATH);
        $dumpvars(0, tb_dff.DUT);				//Cần coi lại chỗ này coi có .DUT không nhé
    end

    //========================================
    // Test Stimulus
    //========================================
    initial begin
        $display("\n========================================");
        $display("D-FF SETUP/HOLD TIME VERIFICATION");
        $display("Corner: %s", `CORNER_NAME);
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
        // TEST 1: NORMAL OPERATION
        //========================================
        $display(">>> TEST 1: NORMAL OPERATION");
        $display("    D arrives %.3fns before clock edge", MARGIN_SAFE);

        @(posedge clk);
        #(CLK_PERIOD - MARGIN_SAFE);
        d = 1;
        #(CLK_PERIOD * 1.5);

	@(posedge clk);
        #(CLK_PERIOD - MARGIN_SAFE);
        d = 0;
        #(CLK_PERIOD * 1.5);
        

        //========================================
        // TEST 2: SETUP VIOLATION
        //========================================
        $display("\n>>> TEST 2: SETUP VIOLATION");

	$display("    D↑ arrives %.3fns before clock (required: %.3fns)", 
                 T_SETUP_RISE - MARGIN_VIOLATION, T_SETUP_RISE);
        
        @(posedge clk);
        #(CLK_PERIOD - T_SETUP_RISE + MARGIN_VIOLATION);
        d = 1;
        #(CLK_PERIOD * 2);

	$display("    D↓ arrives %.3fns before clock (required: %.3fns)", 
                 T_SETUP_FALL - MARGIN_VIOLATION, T_SETUP_FALL);
        
        @(posedge clk);
        #(CLK_PERIOD - T_SETUP_FALL + MARGIN_VIOLATION);
        d = 0;
        #(CLK_PERIOD * 2);


        //========================================
        // TEST 3: HOLD VIOLATION (if applicable)
        //========================================
        if (T_HOLD_RISE > 0.000 || T_HOLD_FALL > 0.000) begin
            $display("\n>>> TEST 3: HOLD VIOLATION");
            $display("    D changes %.3fns after clock (required: %.3fns stable)", 
                     MARGIN_VIOLATION, T_HOLD_FALL);
            
            @(posedge clk);
            #(CLK_PERIOD - MARGIN_SAFE);		//Cần coi lại mấy chỗ này
            d = 1;
            
            @(posedge clk);
            #(MARGIN_VIOLATION);  // Change before hold time expires
            d = 0;
            #(CLK_PERIOD * 2);
            
        end else begin
            $display("\n>>> TEST 3: HOLD VIOLATION - SKIPPED");
            $display("    Hold time = 0ns for this corner");
        end
        
                
	//========================================
        // TEST 4: EDGE CASES
        //========================================
        $display("\n>>> TEST 4: BOUNDARY CONDITIONS");
        $display("    Testing D change EXACTLY at setup time limit");
        
	// D↑ exactly at setup time
        @(posedge clk);
        #(CLK_PERIOD - T_SETUP_RISE);
        d = 1;
        #(CLK_PERIOD * 2);
        
	// D↓ exactly at setup time
        @(posedge clk);
        #(CLK_PERIOD - T_SETUP_FALL);
        d = 0;
        #(CLK_PERIOD * 2);

        
        //========================================
        // End
        //========================================
        #(CLK_PERIOD * 2);
        $display("\n========================================");
        $display("SIMULATION COMPLETE");
        $display("========================================\n");
        $finish;
    end

    initial begin
        $monitor("Time=%0t ns | clk=%b | d=%b | q=%b", $realtime, clk, d, q);
    end

endmodule