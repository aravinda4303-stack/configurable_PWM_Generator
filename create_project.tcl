# Run from the Vivado Tcl Console:
# source scripts/create_project.tcl
#
# Update PART to match the exact Artix-7 FPGA fitted to your board.
set project_name "PWM_Generator_Artix7"
set project_dir  "./vivado_project"
set part_name    "xc7a35tcpg236-1"

create_project $project_name $project_dir -part $part_name -force

add_files [list \
    "./rtl/pwm_generator.v" \
]

add_files -fileset sim_1 [list \
    "./sim/tb_pwm_generator.v" \
]

add_files -fileset constrs_1 [list \
    "./constraints/Artix7_Master.xdc" \
]

set_property top pwm_generator [current_fileset]
set_property top tb_pwm_generator [get_filesets sim_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "Project created. Check the FPGA part and XDC pin assignments before implementation."
