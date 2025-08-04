module SPI_wrapper (MOSI,MISO,SS_n,clk,rst_n); 
input MOSI,SS_n,clk,rst_n;
output  MISO;
wire rx_valid_internal ;
wire tx_valid_internal;
wire [7:0] tx_data_internal;
wire[9:0] rx_data_internal;
RAM  ram(.din(rx_data_internal),.rx_valid(rx_valid_internal),.clk(clk),.rst_n(rst_n),.dout(tx_data_internal),.tx_valid(tx_valid_internal));
SPI_Slave spi(.MOSI(MOSI),.MISO(MISO),.SS_n(SS_n),.clk(clk),.rst_n(rst_n),.rx_data(rx_data_internal),.rx_valid(rx_valid_internal)
,.tx_valid(tx_valid_internal),.tx_data(tx_data_internal));
endmodule
