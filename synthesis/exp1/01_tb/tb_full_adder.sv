`timescale 1ns/1fs

`ifdef GATE_LEVEL
    `include "03_outputs/full_adder/ff_1v0_hvt/full_adder_netlist.sv"
    `include "../gpdk045_verilog/fast_vdd1v0_basicCells_hvt.v"
`else
    `include "00_src/full_adder.sv"
`endif

module tb_full_adder;

    logic A, B, Cin;
    logic Sum, Cout;

    
    full_adder DUT ( 
        .A(A), 
        .B(B), 
        .Cin(Cin), 
        .S(Sum),      
        .Cout(Cout)   
    );

    `ifdef ANNOTATION
    initial begin
        $sdf_annotate("03_outputs/full_adder/ff_1v0_hvt/delay.sdf", DUT, , "annotate_full_adder_ff_1v0_hvt.log", "MAXIMUM");
    end
    `endif

    initial begin
        $dumpfile("full_adder_ff_1v0_hvt.vcd");
        $dumpvars(0, tb_full_adder.DUT);
    end

    initial begin
        
       
        A = 1; B = 0; Cin = 0;
        #1;
        
        Cin = 1; // Cin len 1 -> Cout len 1 (Delay Rise)
        #1;
        
        Cin = 0; // Cin xuong 0 -> Cout xuong 0 (Delay Fall)
        #1;

    
        
        A = 0; B = 0; Cin = 0;
        #1;

        A = 1; // A len 1 -> S len 1 (Delay Rise)
        #1;

        A = 0; // A xuong 0 -> S xuong 0 (Delay Fall)
        #1;

        $finish;
    end
endmodule
