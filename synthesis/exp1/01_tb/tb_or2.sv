`timescale 1ns/1ps

`ifdef GATE_LEVEL

    `include "03_outputs/or2/sl_1v0_hvt/or2_netlist.sv"
    
    `include "../gpdk045_verilog/slow_vdd1v0_basicCells_hvt.v"
`else

    `include "00_src/or2.sv"
`endif

module tb_or2;

    logic A, B; // 2 Input
    logic Y;    // Output

    
    OR2 DUT (
        .A (A),
        .B (B),
        .Y (Y)
    );

    `ifdef ANNOTATION
    initial begin
      
        $sdf_annotate(
            "03_outputs/or2/sl_1v0_hvt/delay.sdf",  
            DUT,
            ,
            "annotate_or2.log",
            "MAXIMUM"
        );
    end
    `endif


    initial begin
        $dumpfile("or2_sl_1v0_hvt.vcd");
        $dumpvars(0, tb_or2.DUT);
    end


    initial begin
  
        A = 0; B = 0;
        #0.2; 
        
       
        A = 1; B = 0;
        #0.2;

     
        A = 0; B = 0;
        #0.2;

      
        A = 0; B = 1;
        #0.2;

        
        A = 0; B = 0;
        #0.2;

        $finish;
    end

endmodule