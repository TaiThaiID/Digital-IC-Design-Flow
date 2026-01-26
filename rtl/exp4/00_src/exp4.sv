module exp4(
	input  logic [7:0] i_A,
	input  logic 	    i_clk,
	input  logic 		 i_reset,
	input  logic [1:0]		 i_sel,
	output logic [7:0] o_S,
	output logic 		 o_overflow,
	output logic		 o_carry
);

   //================================
	// 	Internal Signals
	//================================
	 
	logic [7:0] a_reg;
	logic [7:0] s_reg;
   logic [7:0] alu_data;
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
				s_reg <= alu_data;
			end
	end
	
   //================================
	// 	ALU implement
	//================================
	logic 	c_out;
	
	alu u_alu(
		.i_op_a(a_reg),
		.i_op_b(s_reg),
		.i_sel(i_sel),
		.o_alu_data(alu_data),
		.o_carry(c_out)	
	);
	
	//================================
	// 	Logic circuit
	//================================
	
	always_comb begin 
			if (i_sel[1]) begin
				carry_flag 	  = 1'b0;
				overflow_flag = 1'b0;
			end else begin 
				carry_flag    = c_out;
				overflow_flag = i_sel[0]? (a_reg[7]^s_reg[7])&(s_reg[7]^alu_data[7]):(~(a_reg[7]^s_reg[7]))&(a_reg[7]^alu_data[7]);
			end 
	end 

	
	
	
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
