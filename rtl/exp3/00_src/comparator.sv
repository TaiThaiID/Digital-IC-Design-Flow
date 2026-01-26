module comparator(
	input  logic [7:0] i_a,
	input  logic [7:0] i_b,
	input  logic 		 i_un_en,   //1: Unsigned , 0: Signed 
	output logic 		 o_lt
);


	// --- Internal Signals ---
     logic [7:0] sum;
 	 logic       c_out;
 	 logic       a_sign, b_sign, sum_sign;
	 logic       overflow;
	 logic       unsigned_less, signed_less;
	
	// --- Sign bits ---
    assign a_sign = i_a[7];
    assign b_sign = i_b[7];
	 
	// --- Subtraction using the 8-bit adder ---
    adder8 u_subtractor (
 	.a     (i_a),
  	.b     (i_b),
  	.c_in  (1'b1),
  	.s     (sum),
  	.c_out (c_out)
	);

	assign sum_sign = sum[7];
	
	 // --- Less Than Check ---

    // 1. Unsigned comparison (i_un_en = 1)
    assign unsigned_less = ~c_out;
	 
	 
	 // 2. Signed comparison (i_un_en = 0)
    assign overflow    = (a_sign ^ b_sign) & (a_sign ^ sum_sign);
    assign signed_less = sum_sign ^ overflow;
	 
	 
	 // 3. Final Selection
    assign o_lt = i_un_en ? unsigned_less : signed_less;
	 


endmodule 

