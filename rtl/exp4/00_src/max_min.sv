module max_min(
	input  logic [7:0] i_A,
	input  logic [7:0] i_B,
	input  logic 		 i_un_en,
	output logic [7:0] o_min,
	output logic [7:0] o_max
);

	// --- Internal Signals --- //
	logic 	AltB;

	comparator u_comp(
		.i_a(i_A),
		.i_b(i_B),
		.i_un_en(i_un_en),
		.o_lt(AltB)	
	);
	
	// --- Output --- //
	assign o_min = AltB ? i_A : i_B;
	assign o_max = AltB ? i_B : i_A;


endmodule 