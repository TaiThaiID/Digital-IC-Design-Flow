create_clock -name clk -period 1.0 [get_ports clk]
set_input_delay 0.2 -clock [get_clocks *] [all_inputs]
set_output_delay 0.3 -clock [get_clocks *] [all_outputs]
set_max_delay 0.5 -from [all_inputs] -to [all_outputs]
set timing_report_unconstrained true