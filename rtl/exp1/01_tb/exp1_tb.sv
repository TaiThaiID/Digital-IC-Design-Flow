`timescale 1ns/1ns
module exp1_tb;

	logic [7:0] A;
	logic [7:0] S;
	logic 		clk;
	logic 		reset;
	logic 		overflow;
	logic 		carry;
	
	exp1 dut(
		.i_clk 		(clk),
		.i_A 			(A),
		.i_reset		(reset),
		.o_overflow (overflow),
		.o_carry 	(carry),
		.o_S 			(S)
	);
	
	initial begin
		clk = 1'b1;
		forever #5 clk = ~clk;
	end

	initial begin
		$dumpfile("exp1_tb.vcd");
		$dumpvars(0, exp1_tb);
	end
	
	task check_output(
        input [7:0] expected_S,
        input       expected_carry,
        input       expected_overflow,
        input string test_name
    );  
		  fork begin
			  #10;
			  $display("[%0t ns] Test Case: %s", $time, test_name);
			  if (overflow || carry) begin
					if (overflow & carry) begin
						$display("The result is both out of range of 2's complement numbers and beyond the range of an unsigned 8-bit number");
						$display("New S (Signed) = %d", signed'(S));
						$display("New S (Unsigned) = %d", S);
					end else if (overflow) begin
						$display("The result is out of range of 2's complement numbers -> V = 1");
						$display("New S (Signed) = %d", signed'(S));
						$display("S (Unsigned) = %d", S);
					end else begin
						$display("The result is beyond the range of an unsigned 8-bit number -> C = 1");
						$display("New S (Unsigned) = %d", S);
						$display("S (Signed) = %d", signed'(S));
					end
			  end else begin
					$display("S (Signed) = %d", signed'(S));
					$display("S (Unsigned) = %d", S);
			  end
			  
			  if (S === expected_S) $display("[PASS] -> Sum is correct");
			  else $display("[FAIL] Sum. Expected: %d, Got: %d", expected_S, S);

			  if (carry === expected_carry) $display("[PASS] Carry flag is correct.");
			  else $display("[FAIL] Carry flag. Expected: %b, Got: %b", expected_carry, carry);

			  if (overflow === expected_overflow) $display("[PASS] Overflow flag is correct.");
			  else $display("[FAIL] Overflow flag. Expected: %b, Got: %b", expected_overflow, overflow);
			  $display("Result: C = %d | V = %d", carry, overflow);
			  $display("====================================================================");
		  end 
		  join_none
    endtask
	 
		initial begin
		$display("====================================================================");
      $display("				Starting Accumulator Test    					      ");
      $display("====================================================================");
		
		//Initial reset
		reset = 0;
		#10;
		reset = 1;
		A = 8'd0;
		#20;
		
		//Case 1: V & C = 00
		A = 8'd20;
		#50;
      check_output(100, 1'b0, 1'b0, "Add 20 for 5 clock cycle -> Normally accumulation: C = V = 0");
		#20;
		
		//Reset to ready for next case
		reset = 0;
		#10;
		reset = 1;
		A = 8'd0;
		#20;
		
		//Case 2: Overflow check
		A = 8'd80;
		#20;
      check_output(160, 1'b0, 1'b1, "Sum expected: 80 + 80 = 160");
		#20;
		
		
		//Reset to ready for next case
		reset = 0;
		#10;
		reset = 1;
		A = 8'd0;
		#20;
		
		//Case 3: Carry check
		A = 8'd180;
		#10;
		A = 8'd80;
		#10
      check_output(260, 1'b1, 1'b0, "Sum expected: 180 (-76) + 80 = 260 (4)");
		#20;
		
		//Reset to ready for next case
		reset = 0;
		#10;
		reset = 1;
		A = 8'd0;
		#20;
		
		//Case 2: V & C = 11
		A = -8'sd100;
		#20;
		check_output(-8'sd200, 1'b1, 1'b1, "Sum expected: 156 (-100) + 156 (-100) = 312 (-200)");
		#20;
      
      $display("				Test Finished  	     			    	     ");
      $display("====================================================================");
      $finish;
	end
endmodule
