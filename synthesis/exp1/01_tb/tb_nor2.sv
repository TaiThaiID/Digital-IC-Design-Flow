`timescale 1ns/1ps

`ifdef GATE_LEVEL
    `include "03_outputs/nor2/ff_1v2_lvt/nor2_netlist.sv"
    `include "../gpdk045_verilog/fast_vdd1v2_basicCells_lvt.v"
`else
    `include "00_src/nor2.sv"
`endif

module tb_nor2;

    logic A, B;
    logic Y;

    NOR2 DUT ( .A(A), .B(B), .Y(Y) );

    `ifdef ANNOTATION
    initial begin
        $sdf_annotate("03_outputs/nor2/ff_1v2_lvt/delay.sdf", DUT, , "annotate_nor2.log", "MAXIMUM");
    end
    `endif

    initial begin
        $dumpfile("nor2_ff_1v2_lvt.vcd");
        $dumpvars(0, tb_nor2.DUT);
    end

    initial begin
        // 1. Do Delay A (Giu B=0)
        A = 0; B = 0; 
        #1;
        A = 1; 
        #1;
        A = 0; 
        #1;

        // 2. Do Delay B (Giu A=0)
        A = 0; B = 0;
        #1;
        B = 1; 
        #1;
        B = 0; 
        #1;

        $finish;
    end
endmodule
