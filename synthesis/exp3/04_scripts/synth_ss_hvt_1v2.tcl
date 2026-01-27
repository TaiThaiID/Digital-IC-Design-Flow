# synth_ss_hvt_1v2.tcl
# Synthesis script for Slow corner, VDD=1.2V, HVT


set_db init_lib_search_path {/home/yellow/ee3201_16/LAB2/gpdk045_lib}
set_db init_hdl_search_path {/home/yellow/ee3201_16/LAB2/Exp3/00_src}  

read_libs slow_vdd1v2_basicCells_hvt.lib		
read_hdl -sv dff.sv

elaborate 

set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium

syn_generic
syn_map


report_timing > ./02_reports/ss_hvt_1v2/timing.rpt
report_power  > ./02_reports/ss_hvt_1v2/power.rpt
report_area   > ./02_reports/ss_hvt_1v2/area.rpt
report_qor    > ./02_reports/ss_hvt_1v2/qor.rpt

write_hdl > ./03_outputs/ss_hvt_1v2/dff_netlist.sv

write_sdf -timescale ns -nonegchecks -recrem split -edges check_edge -setuphold split > ./03_outputs/ss_hvt_1v2/delay.sdf


