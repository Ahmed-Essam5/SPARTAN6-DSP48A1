vlib work
vlog DSP48A1_Project_reg.v DSP48A1_Project.v DSP48A1_Project_tb.v
vsim -voptargs=+acc work.DSP48A1_Project_tb
add wave *
run -all
#quit -sim