module alu(
	input  logic [7:0] i_op_a,
	input  logic [7:0] i_op_b,
	input  logic [1:0] i_sel,
	output logic [7:0] o_alu_data,
	output logic 		 o_carry
);

	// ALU encoding
	localparam ADD = 2'b00;
	localparam SUB = 2'b01;
	localparam MAX = 2'b10;
	localparam MIN = 2'b11;
	
   	
   //=================================================
   // 8-bit Adder/Subtractor
   //=================================================
   logic [7:0] add_sub_result;
    
    adder8 u_add_sub (
        .a     (i_op_b),
        .b     (i_op_a),
        .c_in  (i_sel[0]),  // 0: ADD, 1: SUB
        .c_out (o_carry),
        .s   (add_sub_result)
    );
		 
	//=================================================
   // Determine MAX and MIN
   //=================================================
	logic [7:0] max_result;
	logic [7:0] min_result;
	
	max_min u_maxmin(
		.i_A(i_op_a),
		.i_B(i_op_b),
		.i_un_en(1'b0),
		.o_min(min_result),
		.o_max(max_result)
	);
	
	//=================================================
   // ALU Mux
   //=================================================
	always_comb begin 
		unique case (i_sel)
				ADD: o_alu_data = add_sub_result;
				SUB: o_alu_data = add_sub_result;
				MAX: o_alu_data = max_result;
				MIN: o_alu_data = min_result;
				default: o_alu_data = 8'b0;
		endcase 
	end 
	
endmodule 