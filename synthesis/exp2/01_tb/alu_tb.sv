`timescale 1ns/1ps
`ifdef GATE_LEVEL
    `include "/home/yellow/ee3201_16/LAB2/Exp2/03_outputs/alu_netlist.sv" 
    `include "/home/yellow/ee3201_16/LAB2/gpdk045_verilog/slow_vdd1v2_basicCells_hvt.v"
`else
    `include "/home/yellow/ee3201_16/LAB2/Exp2/00_src/alu.sv" 
`endif

module alu_tb;
    parameter T = 20;
    logic [1:0] A, B, S;
    logic [1:0] Y;

    alu DUT (
        .A(A), .B(B), .S(S), .Y(Y)
    );

`ifdef ANNOTATION
    initial begin
        $sdf_annotate("/home/yellow/ee3201_16/LAB2/Exp2/03_outputs/delay.sdf", DUT, , "annotate.log", "MAXIMUM");
    end
`endif

    initial begin
        $dumpfile("alu_wave_nodelay.vcd"); 
        $dumpvars(0, alu_tb.DUT);

        #0;  S=2'b00; A=2'b01; B=2'b00;
        #(T); S=2'b00; A=2'b11; B=2'b01;
        #(T); S=2'b01; A=2'b11; B=2'b00;
        #(T); S=2'b01; A=2'b11; B=2'b11;
        #(T); S=2'b10; A=2'b11; B=2'b01;
        #(T); S=2'b10; A=2'b01; B=2'b10;
        #(T); S=2'b11; A=2'b11; B=2'b01;
        #(T); S=2'b11; A=2'b01; B=2'b10;
        #(T); $finish;
    end
endmodule
