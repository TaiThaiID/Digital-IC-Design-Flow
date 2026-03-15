set_max_delay 0.1 -from [all_inputs] -to [all_outputs]
set_input_delay 0.0 -clock [get_clocks *] [all_inputs]
set_output_delay 0.0 -clock [get_clocks *] [all_outputs]

set timing_report_unconstrained true
