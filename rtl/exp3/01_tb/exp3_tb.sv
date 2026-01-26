//==============================================================================
// TESTBENCH (tb_exp3)
//==============================================================================
`timescale 1ns / 1ns

module exp3_tb;

    // --- Testbench Signals ---
    logic [7:0] i_A;
    logic [7:0] i_B;
    logic       i_un_en;
    
    logic [7:0] o_min; 
    logic [7:0] o_max;

    // --- Instantiate the Design Under Test (DUT) ---
    exp3 dut (
        .i_A      (i_A),
        .i_B      (i_B),
        .i_un_en  (i_un_en),
        .o_min    (o_min),
        .o_max    (o_max)
    );

    initial begin
    	$dumpfile("exp3_tb.vcd");
	$dumpvars(0,exp3_tb);
    end

	task comparator(
			input string opname,
			input logic [7:0] i_A,
			input logic [7:0] i_B,
			input logic [7:0] min_expected,
			input logic [7:0] max_expected
	 );
	 
	 if(i_un_en) begin
		 $display("[%0t ns] %s, A = %d, B = %d", $time, opname, i_A, i_B);
		 if (o_min == min_expected & o_max == max_expected) begin
				$display("[PASS] -> Min = %d, Max = %d", o_min, o_max);
		 end else begin
				$display("[FAIL] Result: Min = %d, Max = %d", o_min, o_max);
				$display("Expected: Min = %d, Max = %d", min_expected, max_expected);
		 end
	 end else begin
		 $display("[%0t ns] Test: %s, A = %d, B = %d", $time, opname, signed'(i_A), signed'(i_B));
		 if (o_min == min_expected & o_max == max_expected) begin
				$display("[PASS] -> Min = %d, Max = %d", signed'(o_min), signed'(o_max));
		 end else begin
				$display("[FAIL] Result: Min = %d, Max = %d", signed'(o_min), signed'(o_max));
				$display("Expected: Min = %d, Max = %d", signed'(min_expected), signed'(max_expected));
		 end
	 end
	 $display("====================================================================");
	 endtask
	 
	 // --- Stimulus (Waveform) Block ---
    initial begin
        // 1. Initialize Inputs
        i_A = 8'd0;
        i_B = 8'd0;
        i_un_en = 1'b0;
		  $display("====================================================================");
		  $display("         Starting Comparison Test         ");
        $display("====================================================================");
        #10;

        // --- Test Case 1: Unsigned Comparison (i_un_en = 1) ---
        $display("         1/ Starting Unsigned Comparison Test         ");
        $display("====================================================================");
        i_un_en = 1'b1;

        // Test 1a: A < B (10 < 20)
        i_A = 8'd10;
        i_B = 8'd20;
        #10; 
        comparator("Test 1a: A < B", 8'd10, 8'd20, 8'd10, 8'd20);

        // Test 1b: A > B (30 > 15)
        i_A = 8'd30;
        i_B = 8'd15;
        #10;
        comparator("Test 1b: A > B", 8'd30, 8'd15, 8'd15, 8'd30);

        // Test 1c: A == B (50 == 50)
        i_A = 8'd50;
        i_B = 8'd50;
        #10;
        comparator("Test 1c: A = B", 8'd50, 8'd50, 8'd50, 8'd50);

        // Test 1d: Edge case (255 > 0)
        i_A = 8'hFF; // 255
        i_B = 8'h00; // 0
        #10;
        comparator("Test 1d: Edge case (255 > 0)", 8'hFF, 8'h00, 8'h00, 8'hFF);

		  
		  
        // --- Test Case 2: Signed Comparison (i_un_en = 0) ---
        $display("         2/ Starting Signed Comparison Test         ");
        $display("====================================================================");
        i_un_en = 1'b0;
        #10; 

        // Test 2a: A < B (pos, pos) (10 < 20)
        i_A = 8'd10; // 10
        i_B = 8'd20; // 20
        #10;
        comparator("Test 2a: A < B (pos, pos)", 8'd10, 8'd20, 8'd10, 8'd20);

        // Test 2b: A < B (neg, pos) (-5 < 5)
        // **CHANGED**: Replaced 8'sd-5 with 8'hFB
        i_A = 8'hFB; // -5
        i_B = 8'h05; // 5
        #10;
        comparator("Test 2b: A < B (neg, pos)", 8'hFB, 8'h05, 8'hFB, 8'h05);
        
        // Test 2c: A > B (pos, neg) (5 > -5)
        // **CHANGED**: Replaced 8'sd-5 with 8'hFB
        i_A = 8'h05; // 5
        i_B = 8'hFB; // -5
        #10;
        comparator("Test 2c: A > B (pos, neg)", 8'h05, 8'hFB, 8'hFB, 8'h05);
        
        // Test 2d: A < B (neg, neg) (-10 < -5)
        // **CHANGED**: Replaced with hex values
        i_A = 8'hF6; // -10
        i_B = 8'hFB; // -5
        #10;
        comparator("Test 2d: A < B (neg, neg)", 8'hF6, 8'hFB, 8'hF6, 8'hFB);
        
        // Test 2e: A > B (neg, neg) (-5 > -10)
        // **CHANGED**: Replaced with hex values
        i_A = 8'hFB; // -5
        i_B = 8'hF6; // -10
        #10;
        comparator("Test 2e: A > B (neg, neg)", 8'hFB, 8'hF6, 8'hF6, 8'hFB);

        // Test 2f: A == B (neg, neg) (-20 == -20)
        // **CHANGED**: Replaced 8'sd-20 with 8'hEC
        i_A = 8'hEC; // -20
        i_B = 8'hEC; // -20
        #10;
        comparator("Test 2f: A == B (neg, neg)", 8'hEC, 8'hEC, 8'hEC, 8'hEC);
		  
		  // Test 2g: Compare with 0
        i_A = 8'hFB; // -5
        i_B = 8'h00; // 0
        #10;
        comparator("Test 2g: Compare with 0", 8'hFB, 8'h00, 8'hFB, 8'h00);
		  
		  // Test 2h: Edge case 1
        i_A = 8'h7F; // 127
        i_B = 8'h80; // -128
        #10;
        comparator("Test 2h: Edge case 1", 8'h7F, 8'h80, 8'h80, 8'h7F);
		  
		  // Test 2i: Compare nearly negs
        i_A = 8'h81; // -127
        i_B = 8'h80; // -128
        #10;
        comparator("Test 2i: Compare nearly negs", 8'h81, 8'h80, 8'h80, 8'h81);
		  
		  // Test 2j: Compare 0 with -1
        i_A = 8'h00; // 0
        i_B = 8'hFF; // -1
        #10;
        comparator("Test 2j: Compare 0 with -1", 8'h00, 8'hFF, 8'hFF, 8'h00);

        #20;
        $display("                Test Finished                                     ");
        $display("====================================================================");
        $finish;
    end
    

    /*initial begin
        $monitor("Time=%0t: [MONITOR] i_A=%d, i_B=%d, un_en=%b | o_min=%d, o_max=%d", 
                 $time, i_A, i_B, i_un_en, o_min, o_max);
    end*/

endmodule
