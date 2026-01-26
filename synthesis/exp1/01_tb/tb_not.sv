`timescale 1ns/1ps

`ifdef GATE_LEVEL
  
    `include "03_outputs/not/sl_1v2_lvt/not_netlist.sv"

    `include "../gpdk045_verilog/slow_vdd1v2_basicCells_lvt.v"
`else
    `include "00_src/not.sv"
`endif

module tb_not;

    logic A;
    logic Y;

   
    NOT DUT (
        .A (A),
        .Y (Y)
    );

    `ifdef ANNOTATION
    initial begin
        $sdf_annotate(
            "03_outputs/not/sl_1v2_lvt/delay.sdf",
            DUT,
            ,
            "annotate_not_sl_1v2_lvt.log",
            "MAXIMUM"
        );
    end
    `endif

    initial begin
        $dumpfile("not_sl_1v2_lvt.vcd");
        $dumpvars(0, tb_not.DUT);
    end

    initial begin
        A = 0;
        #0.1 A = 1;
        #0.1 A = 0;
        #0.1 A = 1;
        #0.1 A = 0;
        #0.1 $finish;
    end

endmodule
