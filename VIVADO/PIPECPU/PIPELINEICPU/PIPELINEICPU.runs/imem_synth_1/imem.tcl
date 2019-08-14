# 
# Synthesis run script generated by Vivado
# 

set_param project.vivado.isBlockSynthRun true
set_msg_config -msgmgr_mode ooc_run
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
read_ip -quiet d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem.xci
set_property used_in_implementation false [get_files -all d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem_ooc.xdc]
set_property is_locked true [get_files d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem.xci]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir D:/CoDWork/PIPELINEICPU/PIPELINEICPU.runs/imem_synth_1 -new_name imem -ip [get_ips imem]]

if { $cached_ip eq {} } {

synth_design -top imem -part xc7a100tcsg324-1 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
catch {
 write_checkpoint -force -noxdef -rename_prefix imem_ imem.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ imem_stub.v
 lappend ipCachedFiles imem_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ imem_stub.vhdl
 lappend ipCachedFiles imem_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ imem_sim_netlist.v
 lappend ipCachedFiles imem_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ imem_sim_netlist.vhdl
 lappend ipCachedFiles imem_sim_netlist.vhdl

 config_ip_cache -add -dcp imem.dcp -move_files $ipCachedFiles -use_project_ipc -ip [get_ips imem]
}

rename_ref -prefix_all imem_

write_checkpoint -force -noxdef imem.dcp

catch { report_utilization -file imem_utilization_synth.rpt -pb imem_utilization_synth.pb }

if { [catch {
  file copy -force D:/CoDWork/PIPELINEICPU/PIPELINEICPU.runs/imem_synth_1/imem.dcp d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force D:/CoDWork/PIPELINEICPU/PIPELINEICPU.runs/imem_synth_1/imem.dcp d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force D:/CoDWork/PIPELINEICPU/PIPELINEICPU.runs/imem_synth_1/imem_stub.v d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force D:/CoDWork/PIPELINEICPU/PIPELINEICPU.runs/imem_synth_1/imem_stub.vhdl d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force D:/CoDWork/PIPELINEICPU/PIPELINEICPU.runs/imem_synth_1/imem_sim_netlist.v d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force D:/CoDWork/PIPELINEICPU/PIPELINEICPU.runs/imem_synth_1/imem_sim_netlist.vhdl d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir D:/CoDWork/PIPELINEICPU/PIPELINEICPU.ip_user_files/ip/imem]} {
  catch { 
    file copy -force d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem_stub.v D:/CoDWork/PIPELINEICPU/PIPELINEICPU.ip_user_files/ip/imem
  }
}

if {[file isdir D:/CoDWork/PIPELINEICPU/PIPELINEICPU.ip_user_files/ip/imem]} {
  catch { 
    file copy -force d:/CoDWork/PIPELINEICPU/PIPELINEICPU.srcs/sources_1/ip/imem/imem_stub.vhdl D:/CoDWork/PIPELINEICPU/PIPELINEICPU.ip_user_files/ip/imem
  }
}
