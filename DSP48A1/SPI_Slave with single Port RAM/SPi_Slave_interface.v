module SPI_Slave(MOSI,SS_n,clk,rst_n,rx_data,tx_valid,tx_data,MISO,rx_valid);
input MOSI,SS_n,clk,rst_n,tx_valid;
input [7:0] tx_data;
output reg MISO,rx_valid;
output  reg [9:0] rx_data;
parameter IDLE=3'b000;
parameter CHK_CMD=3'b001;
parameter WRITE=3'b010;
parameter READ_ADD=3'b011;
parameter  READ_DATA=3'b100;
reg ADDRESS_read; // this is signal to increment when  reading an address
reg[3:0] counter_up;
reg[3:0] counter_down;
reg [9:0]  shift_reg_parallel;// use it to convert from series to parallel
(* fsm_encoding = "sequential" *)  // Synthesis attribute 
reg [2:0] cs ,ns;
always@(posedge clk) begin 
    if(~rst_n)
     cs<=IDLE;
     else 
     cs<=ns;
end
always@(*) begin 
    case(cs)
    IDLE: begin 
        if(SS_n)
        ns=IDLE;
        else 
        ns=CHK_CMD;
    end
   CHK_CMD : begin 
    if (SS_n==0 && MOSI==0)
    ns =WRITE;
    else if(SS_n==0 && MOSI==1) begin 
        casex(ADDRESS_read)
        1'b0 : ns=READ_ADD;
        1'b1: ns=READ_DATA;
        1'bx: ns=READ_ADD;
        endcase
    end
   end
   WRITE: begin
     if(SS_n==0 )
     ns=WRITE;
     else begin
        ns=IDLE;
     end
   end
   READ_ADD :  begin 
    ADDRESS_read=1;
    if(SS_n==0) begin
    ns=READ_ADD;
    end
    else begin
        ns=IDLE;
    end
   end
   READ_DATA : begin 
    ADDRESS_read=0;
    if(SS_n==0)
    ns=READ_DATA;
    else begin
        ns=IDLE;
    end
   end
   default  : ns=IDLE;
    endcase
end
always @(posedge clk) begin
   case(cs)
    IDLE: rx_valid<=0;
    CHK_CMD : begin
         counter_up<=0;
         counter_down<=0;
         shift_reg_parallel<=0;
         rx_valid<=0;
    end
    WRITE , READ_ADD : begin 
        shift_reg_parallel[9-counter_up]<=MOSI;
        counter_up<=counter_up+1;
        if(counter_up==10) begin
            counter_up<=0;
            rx_data<=shift_reg_parallel;
            rx_valid<=1;
        end
    end
   READ_DATA : begin 
       MISO<=tx_data[7-counter_down];
        counter_down<=counter_down+1;
        if(counter_down==8) begin
            counter_down<=0;
        end
    end
   endcase
end
endmodule
