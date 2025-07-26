module tesstbench2();
parameter Wait=0;
parameter Q_25=1;
parameter Q_50=2;
reg clk,rst,Q_in,D_in;
wire Dispense,change;
  vending_machine FSM(clk,rst,Q_in,D_in,Dispense,change);
  initial begin
    clk=0;
    forever
    #5 clk=~clk;
  end
  initial begin 
    rst=1;
    D_in=$random;
    Q_in=$random;
    if( Dispense || change) begin 
        $display("Erorr!!");
        @(negedge clk);
    end
    rst=0;
    repeat (10) begin
    D_in=1;
    Q_in=0;
     @(negedge clk);
    D_in=0;
    Q_in=1;
    repeat(3) @(negedge clk);

    end
    $stop;
  end
  endmodule
