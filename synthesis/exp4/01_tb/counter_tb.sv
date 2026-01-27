`timescale 1ns/1ps
`ifdef GATE_LEVEL
    `include "/home/yellow/ee3201_16/LAB2/Exp4/03_outputs/counter_netlist.sv" 
    `include "/home/yellow/ee3201_16/LAB2/gpdk045_verilog/slow_vdd1v2_basicCells_hvt.v"
`else
    `include "/home/yellow/ee3201_16/LAB2/Exp4/00_src/counter.sv" 
`endif

module counter_tb;

    parameter T = 200; 
    
    logic clk;
    logic rst;
    logic [1:0] Q;

    counter DUT (
        .clk(clk), 
        .rst(rst), 
        .Q(Q)
    );

`ifdef ANNOTATION
    initial begin
        $sdf_annotate("/home/yellow/ee3201_16/LAB2/Exp4/03_outputs/delay.sdf", DUT, , "annotate.log", "MAXIMUM");
    end
`endif

    initial begin
        clk = 1;
        forever #(T/2) clk = ~clk;
    end

    initial begin
        $dumpfile("counter_wave_T200.vcd");
        $dumpvars(0, counter_tb);

        rst = 1;
        #(T);
        
        rst = 0;
        
        #(5*T);
        
        $finish;
    end

endmodule