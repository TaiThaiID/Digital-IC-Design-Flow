module MUX21 (
    input  logic A, 
    input  logic B,
    input  logic S, 
    output logic Y
);
   
    assign Y = (S) ? B : A;
endmodule
