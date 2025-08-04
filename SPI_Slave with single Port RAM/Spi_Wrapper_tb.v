module testbench_spi();
reg clk_tb,rst_n_tb,mosi_tb,ss_n_tb;
wire  miso_tb;
SPI_wrapper tb(mosi_tb,miso_tb,ss_n_tb,clk_tb,rst_n_tb);
initial begin
   clk_tb=0;
    forever #1 clk_tb=~clk_tb;
end
initial begin 
  $readmemh("mem.dat",tb.ram.mem);
    rst_n_tb=0; mosi_tb=1; ss_n_tb=1;
    @(negedge clk_tb);
    // TEST Write address
    rst_n_tb=1;  // to go to CHK_CMD 
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
     rst_n_tb=1;  // to go to write  address state
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    // 0010101011
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
     rst_n_tb=1; 
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    
      rst_n_tb=1; mosi_tb=1; ss_n_tb=1;
@(negedge clk_tb);
@(negedge clk_tb); // return to IDLE
    // TEST write data
     rst_n_tb=1;  // to go to CHK_CMD 
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
     rst_n_tb=1;  // to go to write  data state
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    // 0110101010
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
     rst_n_tb=1; 
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
       rst_n_tb=1; mosi_tb=1; ss_n_tb=1;
@(negedge clk_tb);
@(negedge clk_tb); // return to IDLE
      // test read address
      rst_n_tb=1;  // to go to CHK_CMD 
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
     rst_n_tb=1;  // to go to read adress state
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    // 1010101101
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
     rst_n_tb=1; 
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    
    rst_n_tb=1; mosi_tb=1; ss_n_tb=1;
@(negedge clk_tb);
@(negedge clk_tb); // return to IDLE
   // test read data 
     // dummy data and to make rx_valid=1
      rst_n_tb=1;  // to go to CHK_CMD 
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
     rst_n_tb=1;  // to go to write  state
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    // 1100000111
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
     rst_n_tb=1; 
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=0;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    rst_n_tb=1;  
    mosi_tb=1;
    ss_n_tb=0;
    @(negedge clk_tb);
    ss_n_tb=1; rst_n_tb=1; // return to idle
    @(negedge clk_tb);
    ss_n_tb=0; rst_n_tb=1; // go to chc-cmd
    @(negedge clk_tb);
     ss_n_tb=0; rst_n_tb=1; mosi_tb=1; // go to read data
     @(negedge clk_tb);
    
   @(negedge clk_tb); // another clock for ram to process the data because it's sequential 

rst_n_tb=1; mosi_tb=1; ss_n_tb=0; 
repeat (8) @(negedge clk_tb);
//return to idle 
rst_n_tb=1; mosi_tb=0; ss_n_tb=1;
@(negedge clk_tb);

    $stop;
end
endmodule