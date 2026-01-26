`timescale 1ns/1fs

`ifdef GATE_LEVEL
    
    `include "03_outputs/mux21/sl_1v2_hvt/mux21_netlist.sv"
    `include "../gpdk045_verilog/slow_vdd1v2_basicCells_hvt.v"
`else
    `include "00_src/mux21.sv"
`endif

module tb_mux21;

    logic A, B, S;
    logic Y;

    MUX21 DUT ( .A(A), .B(B), .S(S), .Y(Y) );

    `ifdef ANNOTATION
    initial begin
        $sdf_annotate("03_outputs/mux21/sl_1v2_hvt/delay.sdf", DUT, , "annotate_mux21_sl_1v2_hvt.log", "MAXIMUM");
    end
    `endif

    initial begin
        $dumpfile("mux21_sl_1v2_hvt.vcd");
        $dumpvars(0, tb_mux21.DUT);
    end

    initial begin
        // 1. Do Delay A (Giu S=0)
        S = 0; B = 0; A = 0; 
        #1;
        A = 1; 
        #1;
        A = 0; 
        #1;

        // 2. Do Delay B (Giu S=1)
        S = 1; A = 0; B = 0;
        #1;
        B = 1; 
        #1;
        B = 0; 
        #1;

        // 3. Do Delay S (Chuyen tu A=0 sang B=1)
        A = 0; B = 1; S = 0;
        #1;
        S = 1; 
        #1;
        S = 0; 
        #1;

        $finish;
    end
endmodule