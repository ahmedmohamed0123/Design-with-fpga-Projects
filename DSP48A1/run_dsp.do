vlib work
vlog DSP.v DSP_tb.v pipeline_mux.v
vsim -voptargs=+acc work.DSP_testbench
add wave -position insertpoint  \
sim:/DSP_testbench/A \
sim:/DSP_testbench/B \
sim:/DSP_testbench/BCIN \
sim:/DSP_testbench/BCOUT \
sim:/DSP_testbench/C \
sim:/DSP_testbench/CARRYIN \
sim:/DSP_testbench/CARRYOUT \
sim:/DSP_testbench/CARRYOUTF \
sim:/DSP_testbench/CLK \
sim:/DSP_testbench/M \
sim:/DSP_testbench/OPMODE \
sim:/DSP_testbench/P \
sim:/DSP_testbench/PCIN \
sim:/DSP_testbench/PCOUT
run -all
#quit -sim
