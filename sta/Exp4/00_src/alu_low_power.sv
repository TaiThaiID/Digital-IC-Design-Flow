module alu_low_power (
    input logic [3:0] A,
    input logic [3:0] B,
    input logic [1:0] S,
    input logic clk,
    output logic [3:0] Y
    );

    logic [3:0] add_res, sub_res, and_res, xor_res;
    logic en_add,en_sub,en_and,en_xor;

    // Activate only the necessary logic to reduce switching
    // Generate enable signals for each block
    assign en_add = (S == 2'b00)?1'b1:1'b0;
    assign en_sub = (S == 2'b01)?1'b1:1'b0;
    assign en_and = (S == 2'b10)?1'b1:1'b0;
    assign en_xor = (S == 2'b11)?1'b1:1'b0;

    // Use clock gating to supply clock signals to each logic block
    logic clk_add, clk_sub, clk_andl, clk_xorl;

    // Clock gating using an AND gate
    assign clk_add = clk & en_add;
    assign clk_sub = clk & en_sub;
    assign clk_andl = clk & en_and;
    assign clk_xorl = clk & en_xor;

    // These blocks operate only when en = 1
    always_ff @(posedge clk_add)
        add_res <= A + B;
    always_ff @(posedge clk_sub)
        sub_res <= A - B;
    always_ff @(posedge clk_andl)
        and_res <= A & B;
    always_ff @(posedge clk_xorl)
        xor_res <= A ^ B;
        
    //Output Selection Mux
    always_comb begin
        case (S)
            2'b00: Y = add_res;
            2'b01: Y = sub_res;
            2'b10: Y = and_res;
            2'b11: Y = xor_res;
            default: Y = 4'd0;
        endcase
    end
endmodule