# 
# Synthesis run script generated by Vivado
# 

create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/CoDWork/PIPELINEICPU/PIPELINEICPU.cache/wt [current_project]
set_property parent.project_path D:/CoDWork/PIPELINEICPU/PIPELINEICPU.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo d:/CoDWork/PIPELINEICPU/PIPELINEICPU.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files D:/CoDWork/PIPECPU/studentnosorting.coe
read_verilog -library xil_defaultlib {
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/FPGATop/MIO_BUS.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/FPGATop/Multi_CH32.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/cla.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/FPGATop/clk_div.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/dffe32.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/dm.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/mod.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/mux.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/pipedereg.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/pipeemreg.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/pipeexe.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/pipeid.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/pipeidcu.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/pipeif.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/pipeir.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/pipelinedcpu.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/pipemwreg.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/pipepc.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/PIPECPU/regfile.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/FPGATop/seg7x16.v
  D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/imports/CoDWork/FPGATop/SCPU_Top.v
}
read_ip -quiet D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem.xci
set_property used_in_implementation false [get_files -all d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem_ooc.xdc]
set_property is_locked true [get_files D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem.xci]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/constrs_1/imports/CoDWork/Nexys4DDR_CPU.xdc
set_property used_in_implementation false [get_files D:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/constrs_1/imports/CoDWork/Nexys4DDR_CPU.xdc]


synth_design -top IP2SOC_Top -part xc7a100tcsg324-1


write_checkpoint -force -noxdef IP2SOC_Top.dcp

catch { report_utilization -file IP2SOC_Top_utilization_synth.rpt -pb IP2SOC_Top_utilization_synth.pb }
