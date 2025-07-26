module TSTBENCH1();
parameter  MEM_WIDTH=16;
parameter MEM_DEPTH=1024;
parameter ADDR_SIZE=10;
reg [MEM_WIDTH-1:0] din;
reg [ADDR_SIZE-1:0] addr_wr;
reg [ADDR_SIZE-1:0] addr_rd;
reg wr_en;
reg rd_en;
reg blk_select;
reg clk , rst;
wire [MEM_WIDTH-1:0] dout;
 dpr_sync m1(din,addr_wr,wr_en,rd_en,blk_select,clk,rst, dout,addr_rd);
 integer i;
 initial begin 
    clk=0;
    forever begin
      #1  clk=~clk;
    end
 end
 initial begin
    rst=1;
 @(negedge clk);
 rst=0;
     $readmemh("mem.dat",m1.mem);
     rd_en=0;
     addr_rd=0;
     for(i=0;i<1000;i=i+1) begin
        blk_select=$random;
        din=$random;
        addr_wr=$random;
        wr_en=$random;
        @(negedge clk);
     end
     wr_en=0;
     for(i=0;i<1000;i=i+1) begin
        blk_select=$random;
        addr_rd=$random;
        rd_en=$random;
        @(negedge clk);
     end  
     wr_en=1;
     rd_en=1;
     for(i=0;i<1000;i=i+1) begin
        blk_select=$random;
        addr_rd=$random;
        addr_wr=~addr_rd;
        din=$random;
        @(negedge clk);
     end  
     $stop;
 end

endmodule