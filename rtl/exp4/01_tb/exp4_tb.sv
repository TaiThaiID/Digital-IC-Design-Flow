`timescale 1ns/1ns

module exp4_tb;

    //=================================================
    //  TB Signals
    //=================================================
    logic [7:0] tb_A;
    logic       tb_clk;
    logic       tb_reset;
    logic [1:0] tb_sel;
	 
    logic [7:0] tb_S;
    logic       tb_overflow;
    logic       tb_carry;

    //=================================================
    //  DUT Instantiation
    //=================================================
    exp4 u_dut (
        .i_A        (tb_A),
        .i_clk      (tb_clk),
        .i_reset    (tb_reset),
        .i_sel      (tb_sel),
        .o_S        (tb_S),
        .o_overflow (tb_overflow),
        .o_carry    (tb_carry)
    );

    //=================================================
    //  Clock and Reset Generation
    //=================================================
    initial begin
        tb_clk = 1;
        forever #5 tb_clk = ~tb_clk;
    end

	 initial begin
		  $dumpfile("exp4_tb.vcd");
		  $dumpvars(0, exp4_tb);
	 end

    //=================================================
    //  Verification Task
    //=================================================
    task verify_operation(
		 input string  op_name,
		 input [7:0]   expected_S,
		 input logic   expected_C,
		 input logic   expected_V,
		 input [7:0]   A_prev,
		 input [7:0] 	S_prev
	 );
		 
		 fork begin
			 #11;
			 $display("[%0t ns] TEST: %s", $time, op_name); //cho 2 biến 2 dòng: Unsigned & Signed
			 $display("[Signed]   A = %d, S_in = %d", $signed(A_prev), $signed(S_prev));
			 $display("[Unsigned] A = %d , S_in = %d", A_prev, S_prev);
			 
			 if (tb_S == expected_S && tb_carry == expected_C && tb_overflow == expected_V) begin
				  $display("[PASS] -> Flag result: C = %b | V = %b", tb_carry, tb_overflow);
				  $display("S (Signed) = %d", $signed(tb_S));
				  $display("S (Unsigned) = %d", tb_S);
			 end else begin
				  $display("  [FAIL] -> S = %d, C = %b | V = %b", $signed(tb_S), tb_carry, tb_overflow);
				  $display("           Expected: S = %d, C = %b | V = %b", $signed(expected_S), expected_C, expected_V);
			 end
			 $display("======================================================");
		 end
		 join_none
		 
	 endtask

    //=================================================
    //  Test Sequence
    //=================================================
	 
	 initial begin
		  logic [7:0]   A_prev;
		  logic [7:0] 	 S_prev;
		  
		  $display("======================================================");
        $display("======           STARTING ALU TB                ======");
        $display("======================================================");
		  tb_reset = 1'b0;
        tb_A = 8'b0;
        tb_sel = 2'b0;
        #10;
        tb_reset = 1'b1;
		  #20;
		  
        $display("                     ADD TEST                ");
        $display("======================================================");
		  
		  tb_A = 8'd25;
		  A_prev = tb_A;
		  S_prev = 8'd0;
		  #10;
        verify_operation("ADD Basic", 8'd25, 1'b0, 1'b0, A_prev, S_prev);
		  
		  tb_A = 8'd30;
		  A_prev = tb_A;
		  S_prev = 8'd25;
		  #10;
        verify_operation("ADD Pos+Pos", 8'd55, 1'b0, 1'b0, A_prev, S_prev);
		  
		  tb_A = 8'd100;
		  A_prev = tb_A;
		  S_prev = 8'd55;
		  #10;
        verify_operation("ADD Signed Overflow", 8'd155, 1'b0, 1'b1, A_prev, S_prev);
		  
		  tb_A = 8'd150;
		  A_prev = tb_A;
		  S_prev = 8'd155;
		  #10;
        verify_operation("ADD Signed Overflow & Unsigned Carry", 8'd49, 1'b1, 1'b1, A_prev, S_prev); // 155+150=305 -> 49
		  
		  tb_A = -8'd20;
		  A_prev = tb_A;
		  S_prev = 8'd49;
		  #10;
        verify_operation("ADD Carry Unsigned", 8'd29, 1'b1, 1'b0, A_prev, S_prev); // 49 + (-20)
		  
		  tb_A = -8'd110;
		  A_prev = tb_A;
		  S_prev = 8'd29;
		  #10;
        verify_operation("ADD Basic", -8'd81, 1'b0, 1'b0, A_prev, S_prev); // 29 + (-110)		  
		  
		  tb_sel = 2'b01;
		  tb_A = 8'd50;
		  A_prev = tb_A;
		  S_prev = -8'd81;
		  #10;
        verify_operation("SUB Signed Overflow, no borrow", -8'sd131, 1'b1, 1'b1, A_prev, S_prev); // -81 - 50 = -131
		  
		  // --- SUBTRACT TESTS ---
        $display("                   SUB TEST (S - A)               ");
        $display("======================================================");
		  
		  tb_A = 8'd20;
		  A_prev = tb_A;
		  S_prev = -8'sd131;
		  #10;
        verify_operation("SUB Basic, no borrow", 8'd105, 1'b1, 1'b0, A_prev, S_prev); // 125-20=105, No Borrow (C=1)
		  
		  tb_A = -8'd100;
		  A_prev = tb_A;
		  S_prev = 8'd105;
		  #10;
        verify_operation("SUB Pos-Neg Overflow, borrow", -8'd51, 1'b0, 1'b1, A_prev, S_prev); // 105 - (-100) = 205 -> -51
		  
		  tb_A = 8'd220;
		  A_prev = tb_A;
		  S_prev =  -8'd51;
		  #10;
		  verify_operation("SUB Neg-Neg, borrow", -8'd15, 1'b0, 1'b0, A_prev, S_prev); // 205 - 220 = -15
		  
		  tb_sel = 2'b10;
		  tb_A = 8'd10;
		  A_prev = tb_A;
		  S_prev = -8'd15;
		  #10;
        verify_operation("MAX (A > S)", 8'd10, 1'b0, 1'b0, A_prev, S_prev);
		  
		  // --- MAX/MIN TESTS (Signed) ---
        $display("                     MAX/MIN TEST                ");
        $display("======================================================");
		  
		  tb_sel = 2'b11;
		  tb_A = 8'd20;
		  A_prev = tb_A;
		  S_prev = 8'd10;
		  #10;
        verify_operation("MIN (A > S)", 8'd10, 1'b0, 1'b0, A_prev, S_prev);
		  
		  tb_sel = 2'b10;
		  tb_A = 8'd50;
		  A_prev = tb_A;
		  S_prev = 8'd10;
		  #10;
        verify_operation("MAX (A > S)", 8'd50, 1'b0, 1'b0, A_prev, S_prev);
		  
		  tb_sel = 2'b11;
		  tb_A = -8'd5;
		  A_prev = tb_A;
		  S_prev = 8'd50;
		  #10;
        verify_operation("MIN (A < S)", -8'd5, 1'b0, 1'b0, A_prev, S_prev);
		  
		  tb_sel = 2'b10;
		  tb_A = -8'd5;
		  A_prev = tb_A;
		  S_prev = -8'd5;
		  #10;
        verify_operation("MAX (A = S)", -8'd5, 1'b0, 1'b0, A_prev, S_prev);
		  #10;

		  
        $display("======            SIMULATION ENDED              ======");
        $display("======================================================");
        #10;
		  $finish;
	 end

endmodule 