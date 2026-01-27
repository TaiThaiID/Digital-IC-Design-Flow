# synth_ff_hvt_1v0.tcl
# Synthesis script for Fast corner, VDD=1.0V, HVT


set_db init_lib_search_path {/home/yellow/ee3201_16/LAB2/gpdk045_lib}
set_db init_hdl_search_path {/home/yellow/ee3201_16/LAB2/Exp3/00_src}  

read_libs fast_vdd1v0_basicCells_hvt.lib
read_hdl -sv dff.sv

elaborate 

set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium

syn_generic
syn_map


report_timing > ./02_reports/ff_hvt_1v0/timing.rpt
report_power  > ./02_reports/ff_hvt_1v0/power.rpt
report_area   > ./02_reports/ff_hvt_1v0/area.rpt
report_qor    > ./02_reports/ff_hvt_1v0/qor.rpt

write_hdl > ./03_outputs/ff_hvt_1v0/dff_netlist.sv

write_sdf -timescale ns -nonegchecks -recrem split -edges check_edge -setuphold split > ./03_outputs/ff_hvt_1v0/delay.sdf


