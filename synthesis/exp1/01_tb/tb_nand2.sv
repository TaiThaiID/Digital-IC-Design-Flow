`timescale 1ns/1ps

`ifdef GATE_LEVEL

    `include "03_outputs/nand2/sl_1v0_hvt/nand2_netlist.sv"
    
    `include "../gpdk045_verilog/sl_vdd1v0_basicCells_hvt.v"
`else

    `include "00_src/nand2.sv"
`endif

module tb_nand2;

    logic A, B; // 2 Input
    logic Y;    // Output

    
    NAND2 DUT (
        .A (A),
        .B (B),
        .Y (Y)
    );

    `ifdef ANNOTATION
    initial begin
        // 3. Load file Delay SDF
        $sdf_annotate(
            "03_outputs/nand2/sl_1v0_hvt/delay.sdf",  
            DUT,
            ,
            "annotate_nand2.log",
            "MAXIMUM"
        );
    end
    `endif

    
    initial begin
        $dumpfile("nand2_sl_1v0_hvt.vcd");
        $dumpvars(0, tb_nand2.DUT);
    end


    initial begin
  
        A = 0; B = 0;
        #0.2; 

        
        A = 1; B = 0; 
        #0.2;
        
       
        A = 1; B = 1; 
        #0.2;

        A = 1; B = 0;
        #0.2;

       
        A = 0; B = 1; 
        #0.2;

     
        A = 1; B = 1;
        #0.2;

       
        A = 0; B = 1;
        #0.2;

        $finish;
    end

endmodule