module RAM(din,rx_valid,clk,rst_n,dout,tx_valid);
parameter MEM_DEPTH=256;
parameter ADDR_SIZE=8;
input rx_valid ,clk,rst_n;
input[9:0] din;
output reg tx_valid;
output reg [7:0] dout;
reg [ADDR_SIZE-1:0] ADDR_read; // Address for read operation 
reg [ADDR_SIZE-1:0] ADDR_write; // Address for write operation 
reg [7:0] mem[MEM_DEPTH-1:0]; // array of 256 registers , each register its size is 8 
always @(posedge clk ) begin
    if(~rst_n)
    dout<=0;
   else begin
 if(rx_valid)   begin  // to assign value of din
   case (din[9:8])
   2'b00 : ADDR_write<=din[7:0]; // assign the write address
   2'b01: mem[ADDR_write]<=din[7:0];
   2'b10: begin
    ADDR_read<=din[7:0]; //assign read address
       tx_valid<=0;
   end
   2'b11: begin 
    dout<=mem[ADDR_read];
    tx_valid<=1;
   end
   endcase
 end
   end
end
endmodule 

