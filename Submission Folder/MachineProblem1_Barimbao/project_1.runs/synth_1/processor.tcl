# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a35ticsg324-1L

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/CJ/Desktop/project_1/project_1.cache/wt [current_project]
set_property parent.project_path C:/Users/CJ/Desktop/project_1/project_1.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:arty-a7-35:part0:1.0 [current_project]
set_property ip_output_repo c:/Users/CJ/Desktop/project_1/project_1.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_mem {
  C:/Users/CJ/Desktop/project_1/project_1.srcs/sources_1/imports/memory_model/datamem.mem
  C:/Users/CJ/Desktop/project_1/project_1.srcs/sources_1/imports/memory_model/progmem.mem
}
read_verilog -library xil_defaultlib {
  C:/Users/CJ/Desktop/project_1/project_1.srcs/sources_1/new/alu.v
  C:/Users/CJ/Desktop/project_1/project_1.srcs/sources_1/new/controller.v
  C:/Users/CJ/Desktop/project_1/project_1.srcs/sources_1/new/pc.v
  C:/Users/CJ/Desktop/project_1/project_1.srcs/sources_1/new/register_file.v
  C:/Users/CJ/Desktop/project_1/project_1.srcs/sources_1/new/sign_extend.v
  C:/Users/CJ/Desktop/project_1/project_1.srcs/sources_1/new/processor.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top processor -part xc7a35ticsg324-1L


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef processor.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file processor_utilization_synth.rpt -pb processor_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
