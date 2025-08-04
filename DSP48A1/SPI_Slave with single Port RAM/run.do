vlib work
vlog RAM.v SPi_Slave_interface.v Spi_Wrapper.v Spi_Wrapper_tb.v
vsim -voptargs=+acc work.testbench_spi
add wave -position insertpoint  \
sim:/testbench_spi/ss_n_tb \
sim:/testbench_spi/rst_n_tb \
sim:/testbench_spi/mosi_tb \
sim:/testbench_spi/miso_tb \
sim:/testbench_spi/clk_tb
add wave -position insertpoint  \
sim:/testbench_spi/tb/ram/mem
add wave -position insertpoint  \
sim:/testbench_spi/tb/ram/dout
add wave -position insertpoint  \
sim:/testbench_spi/tb/ram/din
add wave -position insertpoint  \
sim:/testbench_spi/tb/spi/tx_valid
add wave -position insertpoint  \
sim:/testbench_spi/tb/spi/tx_data
add wave -position insertpoint  \
sim:/testbench_spi/tb/spi/rx_valid
add wave -position insertpoint  \
sim:/testbench_spi/tb/spi/rx_data  
add wave -position insertpoint  \
sim:/testbench_spi/tb/spi/cs
add wave -position insertpoint  \
sim:/testbench_spi/tb/spi/counter_up
add wave -position insertpoint  \
sim:/testbench_spi/tb/spi/counter_down
run -all
#quit -sim