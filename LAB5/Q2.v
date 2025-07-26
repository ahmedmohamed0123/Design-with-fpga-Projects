module vending_machine(clk,rst,Q_in,D_in,Dispense,change);
parameter Wait=0;
parameter Q_25=1;
parameter Q_50=2;
input clk,rst,Q_in,D_in;
output  reg Dispense,change;
reg[1:0] CS,NS;
always @(posedge clk , posedge rst) begin
    if(rst) begin
        CS<=Wait;
    end
    else 
    CS<=NS;
end
always@(*) begin
    case (CS)
    Wait: begin
        if(D_in) 
        {NS,Dispense,change}={Wait,1'b1,1'b1};
        else if (Q_in) 
        {NS,Dispense,change}={Q_25,1'b0,1'b0};
    end
    Q_25 : begin
        if(Q_in)
        {NS,Dispense,change}={Q_50,1'b0,1'b0};
        else 
         {NS,Dispense,change}={CS,1'b0,1'b0};
    end
    Q_50: begin
        if(Q_in)
        {NS,Dispense,change}={Wait,1'b1,1'b0};
        else 
         {NS,Dispense,change}={CS,1'b0,1'b0};
    end
    default : {CS,Dispense,change}={Wait,1'b0,1'b0};
        
    endcase
end 
endmodule

