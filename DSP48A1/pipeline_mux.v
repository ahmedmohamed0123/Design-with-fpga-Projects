module pipeline_mux(in,clk,out,CE,rst,sel);
// parameters
parameter Width=18;
parameter RSTTYPE ="SYNC"; // to select type of reset signal if synchronous or assynchronous
//input ports
input[Width-1:0] in; // input before register
input clk,rst; // control signal for dsp (clk) and internal register(rst)
input sel; // selection to select between seq or comb input
input CE; // clock enable for internal register
//output ports
output [Width-1:0] out ; // output after MUX
reg[Width-1:0] in_reg; //output from register
generate
    if(RSTTYPE=="SYNC") begin
      always @(posedge clk ) begin
        if(rst)
        in_reg<=0;
        else if(CE)
        in_reg<=in;
      end
    end
    else if(RSTTYPE==" ASYNC") begin
        always @(posedge clk or posedge rst) begin
              if(rst)
        in_reg<=0;
        else if(CE)
        in_reg<=in;
        end
    end
endgenerate
 assign out=(sel)? in_reg:in; // choose between seq and comb
endmodule

