module exp2(
	input  logic [7:0] i_A,
	input  logic 	    i_clk,
	input  logic 		 i_reset,
	input  logic 		 i_add_sub,
	output logic [7:0] o_S,
	output logic 		 o_overflow,
	output logic		 o_carry
);

	//================================
	// 	Internal Signals
	//================================
	 
	logic [7:0] a_reg;
	logic [7:0] s_reg;
   logic [7:0] sum;
	logic 		overflow_flag; 
	logic 		carry_flag;
	
	
	
	//================================
	// 	Rister blocks
	//================================
	 
   always_ff @(posedge i_clk or negedge i_reset) begin
		if (!i_reset) begin
			a_reg <= 8'b0;
			s_reg <= 8'b0;
		end else begin
			a_reg <= i_A;
			s_reg <= sum;
		end
	end
	
	//================================
	// 	8 bit adder 
	//================================
	logic c_out;
	
	adder8 u_adder8 (
		.a(s_reg),
		.b(a_reg),
		.c_in(i_add_sub),
		.s(sum),
		.c_out(c_out)
	);
	
	//================================
	// 	Logic circuit
	//================================
	
	assign carry_flag 	= c_out;
	assign overflow_flag = i_add_sub? (a_reg[7]^s_reg[7])&(s_reg[7]^sum[7]):(~(a_reg[7]^s_reg[7]))&(a_reg[7]^sum[7]);
   
	//================================
	// 	Output blocks 
	//================================

		always_ff @(posedge i_clk or negedge i_reset) begin
			if (!i_reset) begin
				o_carry <= 1'b0;
				o_overflow <= 1'b0;
			end else begin
				o_carry    <= carry_flag;
				o_overflow <= overflow_flag;
			end
		end
	
	 
		assign o_S = s_reg;
	 
endmodule 