module adder8(
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic       c_in,      
    output logic [7:0] s,
    output logic       c_out 
);

	logic [8:0] carry_tmp;
   logic [7:0] temp;
	
	// Selection ADD or SUB 
    	assign temp = c_in ? ~b : b;

	// carry_tmp in
    	assign carry_tmp[0] = c_in;
		
	//--------8 full-adder-----------//
		full_adder fa0  (.a(a[0]),  .b(temp[0]),  .c_in(carry_tmp[0]),  .s(s[0]),  .c_out(carry_tmp[1]));
      full_adder fa1  (.a(a[1]),  .b(temp[1]),  .c_in(carry_tmp[1]),  .s(s[1]),  .c_out(carry_tmp[2]));
      full_adder fa2  (.a(a[2]),  .b(temp[2]),  .c_in(carry_tmp[2]),  .s(s[2]),  .c_out(carry_tmp[3]));
      full_adder fa3  (.a(a[3]),  .b(temp[3]),  .c_in(carry_tmp[3]),  .s(s[3]),  .c_out(carry_tmp[4]));
      full_adder fa4  (.a(a[4]),  .b(temp[4]),  .c_in(carry_tmp[4]),  .s(s[4]),  .c_out(carry_tmp[5]));
      full_adder fa5  (.a(a[5]),  .b(temp[5]),  .c_in(carry_tmp[5]),  .s(s[5]),  .c_out(carry_tmp[6]));
      full_adder fa6  (.a(a[6]),  .b(temp[6]),  .c_in(carry_tmp[6]),  .s(s[6]),  .c_out(carry_tmp[7]));
      full_adder fa7  (.a(a[7]),  .b(temp[7]),  .c_in(carry_tmp[7]),  .s(s[7]),  .c_out(carry_tmp[8]));

		// carry_tmp out 
   	assign c_out = carry_tmp[8];
		
		
endmodule 
