module DSP48A1(A,B,D,C,CLK,CARRYIN,OPMODE,BCIN,RSTA,RSTB,RSTM,RSTP,RSTC,RSTD,RSTCARRYIN,RSTOPMODE,CEA,CEB
,CEM,CEP,CEC,CED,CECARRYIN,CEOPMODE,PCIN,BCOUT,PCOUT,P,M,CARRYOUT,CARRYOUTF);
//Parameters 
 parameter A0REG=0; // number of pipeline registers in path for A =0
 parameter A1REG=1; //  number of pipeline registers in path for A =1
 parameter B0REG=0; //  number of pipeline registers in path for B =0
 parameter B1REG=1; // number of pipeline registers in path for B =1
 parameter CREG=1; // number of pipeline registers in path for C =1
 parameter DREG=1; // number of pipeline registers in path for D =1
 parameter MREG=1; // number of pipeline registers in path for M =1
 parameter PREG=1; // number of pipeline registers in path for P =1
 parameter CARRYINREG=1; // number of pipeline registers in path for CARRYIN =1
 parameter CARRYOUTREG=1; // number of pipeline registers in path for CARRYOUT =1
 parameter OPMODEREG=1; // number of pipeline registers in path for OPMODE =1
 parameter CARRYINSEL="OPMODE5" ;// used to select between CARRYIN or OPMODE[5]
 parameter B_INPUT="DIRECT" ;// used to select between B as input or BCIN
 parameter RSTTYPE= "SYNC";
 //Data ports
 input [17:0] A;
 input [17:0] B;
 input [47:0] C;
 input [17:0] D;
 output [35:0] M;
 output [47:0] P;
 input [17:0] BCIN;
 input CARRYIN; // input to post adder/substractor
 output  CARRYOUT;// carry out from post adder substractor
 output CARRYOUTF;// carry out from fpga
 //Control input signals
 input CLK; // DSP BLOCK
 input [7:0] OPMODE ;// which choose the arithmatic operations
 //Clock enable input ports
 input CEA; // clock enable for A registers
 input CEB; // clock enable for B registers
 input CEC; // clock enable for C registers
 input CECARRYIN; // clock enable for  carry in and carry out registers
 input CED; //clock enable for D registers
 input CEM; //clock enable for M registers
 input CEOPMODE; //clock enable for OPMODE registers
 input CEP; //clock enable for P registers
 //Reset input ports
 input RSTA; //reset for A registers
 input RSTB; //reset for B registers
 input RSTC; //reset for C registers
 input RSTCARRYIN; //reset for CARRYIN registers
 input RSTD; //reset for D registers
 input RSTM; //reset for M registers
 input RSTOPMODE; //reset for OPMODE registers
 input RSTP; //reset for P registers
 //Cascade Ports 
 output [17:0] BCOUT;
 input [47:0] PCIN;
 output [47:0] PCOUT;
 // Design of DSP
  wire[7:0] opmodemux_out;
  pipeline_mux  #(.Width(8),.RSTTYPE(RSTTYPE)) opmode(.in(OPMODE),.clk(CLK),.out(opmodemux_out)
 ,.CE(CEOPMODE),.rst(RSTOPMODE),.sel(OPMODEREG));

  wire [17:0] Dmux_out;
  pipeline_mux  #(.Width(18),.RSTTYPE(RSTTYPE)) D_mux(.in(D),.clk(CLK),.out(Dmux_out)
 ,.CE(CED),.rst(RSTD),.sel(DREG));

 wire [17:0] B0_in;
 assign B0_in=(B_INPUT=="DIRECT")? B : (B_INPUT=="CASCCADE")? BCIN : 0; // input for sirst stage before B0mux
 wire[17:0] B0mux_out; // output for mux before pre adder substractor
pipeline_mux  #(.Width(18),.RSTTYPE(RSTTYPE)) B0_mux(.in(B0_in),.clk(CLK),.out(B0mux_out)
 ,.CE(CEB),.rst(RSTB),.sel(B0REG)); 
 
 wire [17:0] ADDER1;// output from pre adder substractor
 assign ADDER1= (opmodemux_out[6])? Dmux_out - B0mux_out : Dmux_out + B0mux_out;


 wire [17:0] A0mux_out;// output from first stage for A input
 pipeline_mux #(.Width(18),.RSTTYPE(RSTTYPE)) A0_mux(.in(A),.clk(CLK),.out(A0mux_out),.CE(CEA),
 .rst(RSTA),.sel(A0REG));

 wire [17:0] mux_OPMODED4;// output for mux after pre adder substactor
 assign mux_OPMODED4=(opmodemux_out[4])? ADDER1 : B0mux_out;
 wire [17:0] B1mux_out;//output for second stage after pre adder substractor
 pipeline_mux #(.Width(18),.RSTTYPE(RSTTYPE)) B1_mux(.in(mux_OPMODED4),.clk(CLK),.out(B1mux_out),
 .CE(CEB),.rst(RSTB),.sel(B1REG));
 assign BCOUT=B1mux_out;

wire [17:0] A1mux_out;
pipeline_mux #(.Width(18),.RSTTYPE(RSTTYPE)) A1_mux(.in(A0mux_out),.clk(CLK),.out(A1mux_out),
.CE(CEA),.rst(RSTA),.sel(A1REG));

wire [35:0] multiplier_out;
assign multiplier_out= B1mux_out * A1mux_out;
pipeline_mux #(.Width(36),.RSTTYPE(RSTTYPE)) M_mux(.in(multiplier_out),.clk(CLK),.out(M),
.CE(CEM),.rst(RSTM),.sel(MREG));
assign M_mux_out=multiplier_out;
wire[47:0] Xmux_out;//output of mux x
 
 assign Xmux_out=(opmodemux_out[1:0]==2'b00)? 0 :(opmodemux_out[1:0]==2'b01)? {12'b0,M}:
(opmodemux_out[1:0]==2'b10)?PCOUT:{D[11:0],A[17:0],B[17:0]} ;// impelementation of Mux x
 
 
 wire[47:0] Cmux_out;//output of first stage of input C path
 pipeline_mux #(.Width(48),.RSTTYPE(RSTTYPE)) C_mux(.in(C),.clk(CLK),.out(Cmux_out),.CE(CEC)
,.rst(RSTC),.sel(CREG));

 wire[47:0] Zmux_out;//output of Z mux
 assign Zmux_out=(opmodemux_out[3:2]==2'b00)? 0:(opmodemux_out[3:2]==2'b01)?PCIN:
(opmodemux_out[3:2]==2'b10)? PCOUT :Cmux_out; //impelementation of MUX Z

wire CY1;// input to register to select carry in or opmode5
assign CY1 =(CARRYINSEL=="OPMODE5")? opmodemux_out[5] : (CARRYINSEL=="CARRYIN")? CARRYIN :0;

wire CIN;//output of pipeline_mux and input to post adder substractor
 pipeline_mux #(.Width(1),.RSTTYPE(RSTTYPE)) CARRYIN_mux(.in(CY1),.clk(CLK),.out(CIN),.CE(CECARRYIN)
,.rst(RSTCARRYIN),.sel(CARRYINREG));

wire[47:0] ADDER2;// output of post adder substractor
wire CYO;// carry out from post adder substractor
assign {CYO,ADDER2} =(opmodemux_out[7])? Zmux_out - (Xmux_out + CIN) : Zmux_out + (Xmux_out + CIN);
pipeline_mux #(.Width(1),.RSTTYPE(RSTTYPE)) CARRYOUT_mux(.in(CYO),.clk(CLK),.out(CARRYOUT),
.CE(CECARRYIN),.rst(RSTCARRYIN),.sel(CARRYOUTREG));
assign CARRYOUTF=CARRYOUT;
pipeline_mux #(.Width(48),.RSTTYPE(RSTTYPE)) P_mux(.in(ADDER2),.clk(CLK),.out(PCOUT),
.CE(CEP),.rst(RSTP),.sel(PREG));
assign P=PCOUT;
 
 endmodule




