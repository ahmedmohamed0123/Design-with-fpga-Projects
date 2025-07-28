vlib work
vlog DSP.v DSP_tb.v pipeline_mux.v
vsim -voptargs=+acc work.DSP_testbench
add wave *
run -all
#quit -sim