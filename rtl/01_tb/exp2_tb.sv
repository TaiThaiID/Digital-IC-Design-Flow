`timescale 1ns/1ns
module exp2_tb;

    //================================
    //  Testbench Signals
    //================================
	logic [7:0] A;
	logic [7:0] S;
	logic       clk;
	logic       reset;
	logic       add_sub; // 0 for add, 1 for sub
	logic       overflow;
	logic       carry;
	
	exp2 dut(
		.i_clk 		(clk),
		.i_A 		(A),
		.i_reset	(reset),
		.i_add_sub  (add_sub),
		.o_overflow (overflow),
		.o_carry 	(carry),
		.o_S 		(S)
	);
	
	initial begin
		clk = 1'b1;
		forever #5 clk = ~clk;
	end
	
	initial begin
		$dumpfile("exp2_tb.vcd");
		$dumpvars(0, exp2_tb);
	end
	
	task check_output(
        input [7:0] expected_S,
        input       expected_carry,
        input       expected_overflow,
        input string test_name
    );  
        fork begin
            #1;
				
            $display("[%0t ns] Test Case: %s", $time, test_name);
            
				if (!add_sub) begin
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
				end else begin
					if (overflow || carry) begin
						if (overflow & carry) begin
							$display("The result exceeds the range of 2's complement numbers and S doesn't borrow");
							$display("New S (Signed) = %d", signed'(S));
							$display("S (Unsigned) = %d", S);
						end else if (overflow) begin
							$display("The result is out of range of 2's complement numbers and S < A (borrow)");
							$display("New S (Signed) = %d", signed'(S));
							$display("New S (Unsigned) = %d", S);
						end else begin
							$display("Subtraction is normal and does not require borrowing -> C = 1");
							$display("S (Unsigned) = %d", S);
							$display("S (Signed) = %d", signed'(S));
						end
					end else begin
						$display("S < A (borrow)");
						$display("S (Signed) = %d", signed'(S));
						$display("New S (Unsigned) = %d", S);
					end
				end
			   //
				
				
            if (S === expected_S) $display("[PASS] -> Sum is correct");
            else $display("[FAIL] Sum. Expected: %d, Got: %d", expected_S, S);

            if (carry === expected_carry) $display("[PASS] -> Carry flag is correct.");
            else $display("[FAIL] Carry flag. Expected: %b, Got: %b", expected_carry, carry);

            if (overflow === expected_overflow) $display("[PASS] -> Overflow flag is correct.");
            else $display("[FAIL] Overflow flag. Expected: %b, Got: %b", expected_overflow, overflow);
            $display("Result: C = %d | V = %d", carry, overflow);
				$display("====================================================================");
        end 
        join_none
    endtask
    
    initial begin
		$display("====================================================================");
      $display("         Starting Add Accumulator Test         ");
      $display("====================================================================");
		
		//Initial reset
		reset = 0;
		add_sub = 0;
		#10;
		reset = 1;
		A = 8'd0;
		#10;
		
		//Case 1: V & C = 00
		A = 8'd20;
		#50;
      check_output(100, 1'b0, 1'b0, "Add 20 for 5 clock cycles -> Normally accumulation: C = V = 0");
		#20;
		
		//Reset to ready for next case
		reset = 0;
		A = 8'd0;
		#10;
		reset = 1;
		#10;
		
      $display("         Starting Sub Accumulator Test         ");
      $display("====================================================================");
		
		//Case 1: normally sub accumulator
		A = 8'd100;
		#10; // Give S = 100
		A = 8'd30;
		#5;
		add_sub = 1;
		
		#30;
		check_output(10, 1'b1, 1'b0, "Normal sub, no borrow: S = 100 - 30 for 3 cycles");
		#10;
		
		//Case 2: Carry check
		check_output(-20, 1'b0, 1'b0, "S is less than A, borrow in unsigned: C = 0");
		#20
		
		//Reset to ready for next case
		reset = 0;
		A = 8'd0;
		add_sub = 0;
		#15;
		reset = 1;
		#10;
		
		//Case 3: Overflow check
		A = 8'd100;
		#10; // Give S = 100
		A = -8'sd50;
		#5;
		add_sub = 1;
		#10;
		check_output(150, 1'b0, 1'b1, "Result expected: 100 - (-50) = 150");
		#20;
		
		//Reset to ready for next case
		reset = 0;
		A = 8'd0;
		add_sub = 0;
		#15;
		reset = 1;
		#10;
		
		//Case 4: Overflow and Carry check
		A = -8'sd100;
		#10; // Give S = -100
		A = 8'd50;
		#5;
		add_sub = 1;
		#10;
		check_output(-150, 1'b1, 1'b1, "Result expected: -100 - 50 = -150");
        
      #20;
      $display("                Test Finished                                     ");
      $display("====================================================================");
      $finish;
	end
endmodule