module DSP_testbench();
parameter A0REG=0; 
 parameter A1REG=1; 
 parameter B0REG=0; 
 parameter B1REG=1; 
 parameter CREG=1; 
 parameter DREG=1; 
 parameter MREG=1; 
 parameter PREG=1; 
 parameter CARRYINREG=1; 
 parameter CARRYOUTREG=1; 
 parameter OPMODEREG=1; 
 parameter CARRYINSEL="OPMODE5" ;
 parameter B_INPUT="DIRECT" ;
 parameter RSTTYPE= "SYNC";
 reg [17:0] A;
 reg [17:0] B;
 reg [47:0] C;
 reg [17:0] D;
 wire [35:0] M;
 wire [47:0] P;
 reg [17:0] BCIN;
 reg CARRYIN; 
 wire CARRYOUT;
 wire CARRYOUTF;
 reg CLK; 
 reg [7:0] OPMODE ;
 reg CEA; 
 reg CEB; 
 reg CEC; 
 reg CECARRYIN; 
 reg CED; 
 reg CEM; 
 reg CEOPMODE; 
 reg CEP; 
 reg RSTA; 
 reg RSTB; 
 reg RSTC; 
 reg RSTCARRYIN; 
 reg RSTD; 
 reg RSTM; 
 reg RSTOPMODE; 
 reg RSTP; 
 wire BCOUT;
 reg PCIN;
 wire PCOUT;
  DSP48A1 #(A0REG,A1REG,B0REG,B1REG,CREG,DREG,MREG,PREG,CARRYINREG,CARRYOUTREG,OPMODEREG,CARRYINSEL
  ,B_INPUT,RSTTYPE) testbench(A,B,D,C,CLK,CARRYIN,OPMODE,BCIN,RSTA,RSTB,RSTM,RSTP,RSTC,RSTD,RSTCARRYIN
  ,RSTOPMODE,CEA,CEB,CEM,CEP,CEC,CED,CECARRYIN,CEOPMODE,PCIN,BCOUT,PCOUT,P,M,CARRYOUT,CARRYOUTF,BCIN);
  reg [47:0] P_expected;
  reg[35:0] M_expected;
  reg[17:0] BCOUT_expected;
  reg[47:0] PCOUT_expected;
  reg CARRYOUT_expected;
  reg CARRYOUTF_expected;

  initial begin
    CLK=0;
    forever begin
        #3 CLK=~CLK;
    end
  end
  initial begin 
    RSTA=1;
    RSTB=1;
    RSTM=1;
    RSTP=1;
    RSTC=1;
    RSTD=1;
    RSTCARRYIN=1;
    RSTOPMODE=1;
    A=$random;
    B=$random;
    D=$random;
    C=$random;
    CARRYIN=$random;
    OPMODE=$random;
    CEA=$random;
    CEB=$random;
    CEM=$random;
    CEP=$random;
    CEC=$random;
    CED=$random;
    CECARRYIN=$random;
    CEOPMODE=$random;
    PCIN=$random;
    BCIN=$random;
    P_expected=0;
    BCOUT_expected=0;
    PCOUT_expected=0;
    M_expected=0;
    CARRYOUT_expected=0;
    CARRYOUTF_expected=0;
    @(negedge CLK);
    if ((P_expected==P ) && (BCOUT_expected== BCOUT) && (PCOUT_expected== PCOUT) &&
    (M_expected==M) && (CARRYOUT_expected==CARRYOUT) && ( CARRYOUTF_expected==CARRYOUTF))  begin
        $display( " RESET done for all outputs ");
    end 
    else begin
        $display("ERorr !!");
        $stop;
    end
    RSTA=0;
    RSTB=0;
    RSTM=0;
    RSTP=0;
    RSTC=0;
    RSTD=0;
     RSTCARRYIN=0;
    RSTOPMODE=0;
    CEA=1;
    CEB=1;
    CEM=1;
    CEP=1;
    CEC=1;
    CED=1;
    CECARRYIN=1;
    CEOPMODE=1;
    repeat(20) begin
    OPMODE= 8'b11011101;
    A = 20;
    B = 10;
    C = 350;
    D = 25;
    BCIN=$random;
    PCIN=$random;
    CARRYIN=$random;
     P_expected= 48'h32;
    BCOUT_expected=18'hf;
    PCOUT_expected= 48'h32;
    M_expected=36'h12c;
    CARRYOUT_expected=0;
    CARRYOUTF_expected=0;
    repeat(4) @(negedge CLK);
    if ((P_expected==P ) && (BCOUT_expected== BCOUT) && (PCOUT_expected== PCOUT) &&
    (M_expected==M) && (CARRYOUT_expected==CARRYOUT) && ( CARRYOUTF_expected==CARRYOUTF))  begin
        $display( " Path1 work perfect");
    end 
    else begin
        $display("ERorr !!");
        $stop;
    end
    end
     $stop;
   repeat(20) begin
    OPMODE=  8'b00010000;
    A = 20;
    B = 10;
    C = 350;
    D = 25;
    BCIN=$random;
    PCIN=$random;
    CARRYIN=$random;
     P_expected= 0 ;
    BCOUT_expected= 18'h23;
    PCOUT_expected= 0;
    M_expected= 36'h2bc;
    CARRYOUT_expected=0;
    CARRYOUTF_expected=0;
    repeat(3) @(negedge CLK);
    if ((P_expected==P ) && (BCOUT_expected== BCOUT) && (PCOUT_expected== PCOUT) &&
    (M_expected==M) && (CARRYOUT_expected==CARRYOUT) && ( CARRYOUTF_expected==CARRYOUTF))  begin
        $display( " Path 2 work perfect");
    end 
    else begin
        $display("ERorr !!");
        $stop;
    end
    end
     $stop;  
     repeat(20) begin
    OPMODE=   8'b00001010;
    A = 20;
    B = 10;
    C = 350;
    D = 25;
    BCIN=$random;
    PCIN=$random;
    CARRYIN=$random;
     P_expected=PCOUT_expected  ;
    BCOUT_expected= 18'ha;
    M_expected= 36'hc8;
    CARRYOUT_expected=CARRYOUTF_expected;
    repeat(3) @(negedge CLK);
    if ((P_expected==P ) && (BCOUT_expected== BCOUT) && (PCOUT_expected== PCOUT) &&
    (M_expected==M) && (CARRYOUT_expected==CARRYOUT) && ( CARRYOUTF_expected==CARRYOUTF))  begin
        $display( " Path 3 work perfect");
    end 
    else begin
        $display("ERorr !!");
        $stop;
    end
    end
     $stop;  
      repeat(20) begin
    OPMODE= 8'b10100111;
    A = 5;
    B = 6;
    C = 350;
    D = 25;
    PCIN=3000;
     BCIN=$random;
    CARRYIN=$random;
     P_expected=48'hfe6fffec0bb1  ;
     PCOUT_expected=48'hfe6fffec0bb1 ;
    BCOUT_expected=  18'h6;
    M_expected=  36'h1e;
    CARRYOUT_expected=1;
    CARRYOUTF_expected=1;
    repeat(3) @(negedge CLK);
    if ((P_expected==P ) && (BCOUT_expected== BCOUT) && (PCOUT_expected== PCOUT) &&
    (M_expected==M) && (CARRYOUT_expected==CARRYOUT) && ( CARRYOUTF_expected==CARRYOUTF))  begin
        $display( " Path 4 work perfect");
    end 
    else begin
        $display("ERorr !!");
        $stop;
    end
    end
     $stop;  
  end
  endmodule