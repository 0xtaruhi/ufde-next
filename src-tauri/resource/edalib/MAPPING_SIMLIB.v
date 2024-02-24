// 
//
//

`timescale 1 ps/1 ps

module TBUF(Y,OE,A);
	output Y;
	input OE,A;
	assign A = OE? Y: 1'bz;
endmodule	

module AND2(Y,A,B);
    output Y;
    input A,B;
    and(Y,A,B);
endmodule

module AND3(Y,A,B,C);
    output Y;
    input A,B,C;
    wire Y1;
    and(Y1,A,B);
    and(Y,Y1,C);
endmodule

module AND4(Y,A,B,C,D);
    output Y;
    input A,B,C,D;
    assign Y=A&B&C&D;
endmodule

module AOI21(Y,A0,A1,B0);
    output Y;
    input A0,A1,B0;
    wire Y1;
    and(Y1,A0,A1);
    nor(Y,Y1,B0);
endmodule

module AOI211(Y,A0,A1,B0,C0);
    output Y;
    input A0,A1,B0,C0;
    assign Y=~((A0&A1)|B0|C0);
endmodule

module AOI22(Y,A0,A1,B0,B1);
    output Y;
    input A0,A1,B0,B1;
    assign Y=~((A0&A1)|(B0&B1));
endmodule

module AOI221(Y,A0,A1,B0,B1,C0);
    output Y;
    input A0,A1,B0,B1,C0;
    assign Y=~((A0&A1)|(B0&B1)|C0);
endmodule

module AOI222(Y,A0,A1,B0,B1,C0,C1);
    output Y;
    input A0,A1,B0,B1,C0,C1;
    assign Y=~((A0&A1)|(B0&B1)|(C0&C1));
endmodule

module AOI2BB1(Y,A0N,A1N,B0);
    output Y;
    input A0N,A1N,B0;
    assign Y=~((~A0N&~A1N)|B0);
endmodule

module AOI2BB2(Y,A0N,A1N,B0,B1);
    output Y;
    input A0N,A1N,B0,B1;
    assign Y=~((~A0N&~A1N)|(B0&B1));
endmodule

module AOI31(Y,A0,A1,A2,B0);
    output Y;
    input A0,A1,A2,B0;
    assign Y=~((A0&A1&A2)|B0);
endmodule

module AOI32(Y,A0,A1,A2,B0,B1);
    output Y;
    input A0,A1,A2,B0,B1;
    assign Y=~((A0&A1&A2)|(B0&B1));
endmodule

module AOI33(Y,A0,A1,A2,B0,B1,B2);
    output Y;
    input A0,A1,A2,B0,B1,B2;
    assign Y=~((A0&A1&A2)|(B0&B1&B2));
endmodule


module BUF (O, I);

  output O;
  input I;

  buf (O, I);

endmodule


module IBUF (O, I);

  output O;
  input I;

  buf (O, I);

endmodule


module OBUF (O, I);

  output O;
  input I;

  buf (O, I);

endmodule


module CLKBUF (O, I);

  output O;
  input I;

  buf (O, I);

endmodule

module INV(Y,A);
    output Y;
    input A;
    not(Y,A);
endmodule

module MX2(Y,A,B,S0);
    output Y;
    input A,B,S0;
    assign Y=(~S0&A)|(S0&B);
endmodule

module MXI2(Y,A,B,S0);
    output Y;
    input A,B,S0;
    assign Y=~((~S0&A)|(S0&B));
endmodule

module MX4(Y,A,B,C,D,S0,S1);
    output Y;
    input A,B,C,D,S0,S1;
    reg Y;
    always @(A or B or C or D or S0 or S1)
    case({S1,S0})
        2'b00:Y=A;
        2'b01:Y=B;
        2'b10:Y=C;
        default:Y=D;
endcase
endmodule

module NAND2(Y,A,B);
    output Y;
    input A,B;
    nand(Y,A,B);
endmodule

module NAND2B(Y,AN,B);
    output Y;
    input AN,B;
    nand(Y,~AN,B);
endmodule

module NAND3(Y,A,B,C);
    output Y;
    input A,B,C;
    assign Y=~(A&B&C);
endmodule
  
module NAND3B(Y,AN,B,C);
    output Y;
    input AN,B,C;
    assign Y=~(~AN&B&C);
endmodule

module NAND4(Y,A,B,C,D);
    output Y;
    input A,B,C,D;
    assign Y=~A|~B|~C|~D;
endmodule
 
module NAND4B(Y,AN,B,C,D);
    output Y;
    input AN,B,C,D;
    assign Y=AN|~B|~C|~D;
endmodule

module NAND4BB(Y,AN,BN,C,D);
    output Y;
    input AN,BN,C,D;
    assign Y=AN|BN|~C|~D;
endmodule

module NOR2(Y,A,B);
    output Y;
    input A,B;
    nor(Y,A,B);
endmodule

module NOR2B(Y,AN,B);
    output Y;
    input AN,B;
    nor(Y,~AN,B);
endmodule 

module NOR3(Y,A,B,C);
    output Y;
    input A,B,C;
    assign Y=~(A|B|C);
endmodule 

module NOR3B(Y,AN,B,C);
    output Y;
    input AN,B,C;
    assign Y=~(~AN|B|C);
endmodule 

module NOR4(Y,A,B,C,D);
    output Y;
    input A,B,C,D;
    assign Y=~(A|B|C|D);
endmodule 

module NOR4B(Y,AN,B,C,D);
    output Y;
    input AN,B,C,D;
    assign Y=~(~AN|B|C|D);
endmodule 

module NOR4BB(Y,AN,BN,C,D);
    output Y;
    input AN,BN,C,D;
    assign Y=~(~AN|~BN|C|D);
endmodule

module OAI21(Y,A0,A1,B0);
    output Y;
    input A0,A1,B0;
    assign Y=~((A0|A1)&B0);
endmodule

module OAI211(Y,A0,A1,B0,C0);
    output Y;
    input A0,A1,B0,C0;
    assign Y=~((A0|A1)&B0&C0);
endmodule

module OAI22(Y,A0,A1,B0,B1);
    output Y;
    input A0,A1,B0,B1;
    assign Y=~((A0|A1)&(B0|B1));
endmodule

module OAI221(Y,A0,A1,B0,B1,C0);
    output Y;
    input A0,A1,B0,B1,C0;
    assign Y=~((A0|A1)&(B0|B1)&C0);
endmodule

module OAI222(Y,A0,A1,B0,B1,C0,C1);
    output Y;
    input A0,A1,B0,B1,C0,C1;
    assign Y=~((A0|A1)&(B0|B1)&(C0|C1));
endmodule

module OAI2BB1(Y,A0N,A1N,B0);
    output Y;
    input A0N,A1N,B0;
    assign Y=~((~A0N|~A1N)&B0);
endmodule

module OAI2BB2(Y,A0N,A1N,B0,B1);
    output Y;
    input A0N,A1N,B0,B1;
    assign Y=~((~A0N|~A1N)&(B0|B1));
endmodule

module OAI31(Y,A0,A1,A2,B0);
    output Y;
    input A0,A1,A2,B0;
    assign Y=~((A0|A1|A2)&B0);
endmodule

module OAI32(Y,A0,A1,A2,B0,B1);
    output Y;
    input A0,A1,A2,B0,B1;
    assign Y=~((A0|A1|A2)&(B0|B1));
endmodule

module OAI33(Y,A0,A1,A2,B0,B1,B2);
    output Y;
    input A0,A1,A2,B0,B1,B2;
    assign Y=~((A0|A1|A2)&(B0|B1|B2));
endmodule

module OR2(Y,A,B);
    output Y;
    input A,B;
    or(Y,A,B);
endmodule

module OR3(Y,A,B,C);
    output Y;
    input A,B,C;
    assign Y=A|B|C;
endmodule

module OR4(Y,A,B,C,D);
    output Y;
    input A,B,C,D;
    assign Y=A|B|C|D;
endmodule

module XOR2(Y,A,B);
    output Y;
    input A,B;
    xor(Y,A,B);
endmodule

module XNOR2(Y,A,B);
    output Y;
    input A,B;
    xnor(Y,A,B);
endmodule

module ADDF(S,CO,A,B,CI);
    output S,CO;
    input A,B,CI;
    assign {CO,S} = A+B+CI;
endmodule

module LOGIC_0 (LOGIC_0_PIN);

  output LOGIC_0_PIN;

  assign LOGIC_0_PIN = 1'b0;

endmodule

module LOGIC_1 (LOGIC_1_PIN);

  output LOGIC_1_PIN;

  assign LOGIC_1_PIN = 1'b1;

endmodule

//
//  The DFFHQ cell is a high-speed, positive-edge
//  triggered, static D-type flip-flop. The cell has a single
//  output (Q) and fast clock-to-out path.
//
module DFFHQ(Q,CK,D);
    output Q;
    input CK,D;
    reg Q;
    initial Q = 1'b0;
    always @(posedge CK)
    begin
        Q <= D;
    end
endmodule

//
//  The DFFRHQ cell is a high-speed, positive-edge
//  triggered, static D-type flip-flop with asynchronous
//  active-low reset (RN). The cell has a single output
//  (Q) and fast clock-to-out path.
//
module DFFRHQ(Q,CK,RN,D);
    output Q;
    input CK,RN,D;
    reg Q;
    initial Q = 1'b0;
    always @(posedge CK or negedge RN)
    begin
        if ( RN == 0 )
        	Q <= 0;
        else
        	Q <= D;
    end
endmodule

//
//  The DFFSHQ cell is a high-speed, positive-edge
//  triggered, static D-type flip-flop with asynchronous
//  active-low set (SN). The cell has a single output (Q)
//  and fast clock-to-out path.
//
module DFFSHQ(Q,CK,SN,D);
    output Q;
    input CK,SN,D;
    reg Q;
    initial Q = 1'b0;
    always @(posedge CK or negedge SN)
    begin
        if ( SN == 0 )
        	Q <= 1;
        else
        	Q <= D;
    end
endmodule

//
//  The DFFNRHQ cell is a high-speed, negedge
//  triggered, static D-type flip-flop with asynchronous
//  active-low reset (RN). The cell has a single output
//  (Q) and fast clock-to-out path.
//
module DFFNRHQ(Q,CKN,RN,D);
    output Q;
    input CKN,RN,D;
    reg Q;
    initial Q = 1'b0;
    always @(negedge CKN or negedge RN)
    begin
        if ( RN == 0 )
        	Q <= 0;
        else
        	Q <= D;
    end
endmodule

//
//  The DFFNSHQ cell is a high-speed, negedge
//  triggered, static D-type flip-flop with asynchronous
//  active-low set (SN). The cell has a single output (Q)
//  and fast clock-to-out path.
//
module DFFNSHQ(Q,CKN,SN,D);
    output Q;
    input CKN,SN,D;
    reg Q;
    initial Q = 1'b0;
    always @(negedge CKN or negedge SN)
    begin
        if ( SN == 0 )
        	Q <= 1;
        else
        	Q <= D;
    end
endmodule

//
//   Description : negedge D Flip Flop 
//
module DFFNHQ(Q,CKN,D);
    output Q;
    input CKN,D;
    reg Q;
    initial Q = 1'b0;
    always @(negedge CKN)
    begin
        Q <= D;
    end
endmodule

//
//   Description : Flip-Flop with Positive-Edge Clock and Clock Enable
//
module EDFFHQ(Q,CK,D,E);
    output Q;
    input CK,D,E;
    reg Q;
    initial Q = 1'b0;
    always @(posedge CK)
    begin
        if ( E )
            Q <= D;
    end
endmodule

//
//   Description : Flip-Flop with Positive-Edge Clock and Clock Enable
//                 and Synchronous Reset 
//
module EDFFTRHQ(Q,CK,D,E,RN);
    output Q;
    input CK,D,E,RN;
    reg Q;
    initial Q = 1'b0;
    always @(posedge CK)
    begin
        if(!RN)
            Q <= 0;
        else
            if(E)
                Q <= D;
    end
endmodule

//
//   Description : Flip-Flop with Positive-Edge Clock and Clock Enable
//                 and Synchronous Set 
//
module EDFFTSHQ(Q,CK,D,E,SN);
    output Q;
    input CK,D,E,SN;
    reg Q;
    initial Q = 1'b0;
    always @(posedge CK)
    begin
        if(!SN)
            Q <= 1;
        else
            if(E)
                Q <= D;
    end
endmodule

//
//   Description : Latch with high G passing
//
module TLATHQ(Q,G,D);
    output Q;
    input G,D;
    reg Q;
    initial Q = 1'b0;
    always @(G or D)
    begin
        if(G)
            Q <= D;
    end
endmodule


module LUT2 (O, ADR0, ADR1);

  parameter INIT = 4'h0;

  output O;
  input ADR0, ADR1;

  wire out, a0, a1;

  buf b0 (a0, ADR0);
  buf b1 (a1, ADR1);

  lut2_mux4 (O, INIT[3], INIT[2], INIT[1], INIT[0], a1, a0);

  specify

	(ADR0 => O) = (0:0:0, 0:0:0);
	(ADR1 => O) = (0:0:0, 0:0:0);
	specparam PATHPULSE$ = 0;

  endspecify

endmodule

primitive lut2_mux4 (o, d3, d2, d1, d0, s1, s0);

  output o;
  input d3, d2, d1, d0;
  input s1, s0;

  table

    // d3  d2  d1  d0  s1  s0 : o;

       ?   ?   ?   1   0   0  : 1;
       ?   ?   ?   0   0   0  : 0;
       ?   ?   1   ?   0   1  : 1;
       ?   ?   0   ?   0   1  : 0;
       ?   1   ?   ?   1   0  : 1;
       ?   0   ?   ?   1   0  : 0;
       1   ?   ?   ?   1   1  : 1;
       0   ?   ?   ?   1   1  : 0;

       ?   ?   0   0   0   x  : 0;
       ?   ?   1   1   0   x  : 1;
       0   0   ?   ?   1   x  : 0;
       1   1   ?   ?   1   x  : 1;

       ?   0   ?   0   x   0  : 0;
       ?   1   ?   1   x   0  : 1;
       0   ?   0   ?   x   1  : 0;
       1   ?   1   ?   x   1  : 1;

       0   0   0   0   x   x  : 0;
       1   1   1   1   x   x  : 1;

  endtable

endprimitive


module LUT3 (O, ADR0, ADR1, ADR2);

  parameter INIT = 8'h00;

  output O;
  input ADR0, ADR1, ADR2;

  wire out0, out1, a0, a1, a2;

  buf b0 (a0, ADR0);
  buf b1 (a1, ADR1);
  buf b2 (a2, ADR2);

  lut3_mux4 (out1, INIT[7], INIT[6], INIT[5], INIT[4], a1, a0);
  lut3_mux4 (out0, INIT[3], INIT[2], INIT[1], INIT[0], a1, a0);
  lut3_mux4 (O, 1'b0, 1'b0, out1, out0, 1'b0, a2);

  specify

	(ADR0 => O) = (0:0:0, 0:0:0);
	(ADR1 => O) = (0:0:0, 0:0:0);
	(ADR2 => O) = (0:0:0, 0:0:0);
	specparam PATHPULSE$ = 0;

  endspecify

endmodule

primitive lut3_mux4 (o, d3, d2, d1, d0, s1, s0);

  output o;
  input d3, d2, d1, d0;
  input s1, s0;

  table

    // d3  d2  d1  d0  s1  s0 : o;

       ?   ?   ?   1   0   0  : 1;
       ?   ?   ?   0   0   0  : 0;
       ?   ?   1   ?   0   1  : 1;
       ?   ?   0   ?   0   1  : 0;
       ?   1   ?   ?   1   0  : 1;
       ?   0   ?   ?   1   0  : 0;
       1   ?   ?   ?   1   1  : 1;
       0   ?   ?   ?   1   1  : 0;

       ?   ?   0   0   0   x  : 0;
       ?   ?   1   1   0   x  : 1;
       0   0   ?   ?   1   x  : 0;
       1   1   ?   ?   1   x  : 1;

       ?   0   ?   0   x   0  : 0;
       ?   1   ?   1   x   0  : 1;
       0   ?   0   ?   x   1  : 0;
       1   ?   1   ?   x   1  : 1;

       0   0   0   0   x   x  : 0;
       1   1   1   1   x   x  : 1;

  endtable

endprimitive


module LUT4 (O, ADR0, ADR1, ADR2, ADR3);

  parameter INIT = 16'h0000;

  output O;
  input ADR0, ADR1, ADR2, ADR3;

  wire out0, out1, out2, out3, a0, a1, a2, a3;

  buf b0 (a0, ADR0);
  buf b1 (a1, ADR1);
  buf b2 (a2, ADR2);
  buf b3 (a3, ADR3);

  lut4_mux4 (out3, INIT[15], INIT[14], INIT[13], INIT[12], a1, a0);
  lut4_mux4 (out2, INIT[11], INIT[10], INIT[9], INIT[8], a1, a0);
  lut4_mux4 (out1, INIT[7], INIT[6], INIT[5], INIT[4], a1, a0);
  lut4_mux4 (out0, INIT[3], INIT[2], INIT[1], INIT[0], a1, a0);
  lut4_mux4 (O, out3, out2, out1, out0, a3, a2);

  specify

	(ADR0 => O) = (0:0:0, 0:0:0);
	(ADR1 => O) = (0:0:0, 0:0:0);
	(ADR2 => O) = (0:0:0, 0:0:0);
	(ADR3 => O) = (0:0:0, 0:0:0);
	specparam PATHPULSE$ = 0;

  endspecify

endmodule

primitive lut4_mux4 (o, d3, d2, d1, d0, s1, s0);

  output o;
  input d3, d2, d1, d0;
  input s1, s0;

  table

    // d3  d2  d1  d0  s1  s0 : o;

       ?   ?   ?   1   0   0  : 1;
       ?   ?   ?   0   0   0  : 0;
       ?   ?   1   ?   0   1  : 1;
       ?   ?   0   ?   0   1  : 0;
       ?   1   ?   ?   1   0  : 1;
       ?   0   ?   ?   1   0  : 0;
       1   ?   ?   ?   1   1  : 1;
       0   ?   ?   ?   1   1  : 0;

       ?   ?   0   0   0   x  : 0;
       ?   ?   1   1   0   x  : 1;
       0   0   ?   ?   1   x  : 0;
       1   1   ?   ?   1   x  : 1;

       ?   0   ?   0   x   0  : 0;
       ?   1   ?   1   x   0  : 1;
       0   ?   0   ?   x   1  : 0;
       1   ?   1   ?   x   1  : 1;

       0   0   0   0   x   x  : 0;
       1   1   1   1   x   x  : 1;

  endtable

endprimitive

module LUT5 (O, ADR0, ADR1, ADR2, ADR3, ADR4);

  parameter INIT_1 = 16'h0000;
  parameter INIT_2 = 16'h0000;
  
  input ADR0, ADR1, ADR2, ADR3, ADR4;

  output O;

  reg O;
  reg tmp;

  wire [31:0] INIT;
  assign INIT = { INIT_1, INIT_2 };

  always @( ADR4 or ADR3 or  ADR2 or  ADR1 or  ADR0 )  begin
 
    tmp =  ADR0 ^ ADR1  ^ ADR2 ^ ADR3 ^ ADR4;

    if ( tmp == 0 || tmp == 1)

        O = INIT[{ADR4, ADR3, ADR2, ADR1, ADR0}];

    else 
    
      O =  lut4_mux4 ( 
                        { lut6_mux8 ( INIT_1[15:8], {ADR2, ADR1, ADR0}),
                          lut6_mux8 ( INIT_1[7:0], {ADR2, ADR1, ADR0}),
                          lut6_mux8 ( INIT_2[15:8], {ADR2, ADR1, ADR0}),
                          lut6_mux8 ( INIT_2[7:0], {ADR2, ADR1, ADR0}) }, { ADR4, ADR3});
  end

  function lut6_mux8;
  input [7:0] d;
  input [2:0] s;
   
  begin

       if ((s[2]^s[1]^s[0] ==1) || (s[2]^s[1]^s[0] ==0))
           
           lut6_mux8 = d[s];

         else
           if ( ~(|d))
                 lut6_mux8 = 1'b0;
           else if ((&d))
                 lut6_mux8 = 1'b1;
           else if (((s[1]^s[0] ==1'b1) || (s[1]^s[0] ==1'b0)) && (d[{1'b0,s[1:0]}]===d[{1'b1,s[1:0]}]))
                 lut6_mux8 = d[{1'b0,s[1:0]}];
           else if (((s[2]^s[0] ==1) || (s[2]^s[0] ==0)) && (d[{s[2],1'b0,s[0]}]===d[{s[2],1'b1,s[0]}]))
                 lut6_mux8 = d[{s[2],1'b0,s[0]}];
           else if (((s[2]^s[1] ==1) || (s[2]^s[1] ==0)) && (d[{s[2],s[1],1'b0}]===d[{s[2],s[1],1'b1}]))
                 lut6_mux8 = d[{s[2],s[1],1'b0}];
           else if (((s[0] ==1) || (s[0] ==0)) && (d[{1'b0,1'b0,s[0]}]===d[{1'b0,1'b1,s[0]}]) &&
              (d[{1'b0,1'b0,s[0]}]===d[{1'b1,1'b0,s[0]}]) && (d[{1'b0,1'b0,s[0]}]===d[{1'b1,1'b1,s[0]}]))
                 lut6_mux8 = d[{1'b0,1'b0,s[0]}];
           else if (((s[1] ==1) || (s[1] ==0)) && (d[{1'b0,s[1],1'b0}]===d[{1'b0,s[1],1'b1}]) &&
              (d[{1'b0,s[1],1'b0}]===d[{1'b1,s[1],1'b0}]) && (d[{1'b0,s[1],1'b0}]===d[{1'b1,s[1],1'b1}]))
                 lut6_mux8 = d[{1'b0,s[1],1'b0}];
           else if (((s[2] ==1) || (s[2] ==0)) && (d[{s[2],1'b0,1'b0}]===d[{s[2],1'b0,1'b1}]) &&
              (d[{s[2],1'b0,1'b0}]===d[{s[2],1'b1,1'b0}]) && (d[{s[2],1'b0,1'b0}]===d[{s[2],1'b1,1'b1}]))
                 lut6_mux8 = d[{s[2],1'b0,1'b0}];
           else
                 lut6_mux8 = 1'bx;
   end
  endfunction


  function lut4_mux4;
  input [3:0] d;
  input [1:0] s;
   
  begin

       if ((s[1]^s[0] ==1) || (s[1]^s[0] ==0))

           lut4_mux4 = d[s];

         else if ((d[0] === d[1]) && (d[2] === d[3])  && (d[0] === d[2]) )
           lut4_mux4 = d[0];
         else if ((s[1] == 0) && (d[0] === d[1]))
           lut4_mux4 = d[0];
         else if ((s[1] == 1) && (d[2] === d[3]))
           lut4_mux4 = d[2];
         else if ((s[0] == 0) && (d[0] === d[2]))
           lut4_mux4 = d[0];
         else if ((s[0] == 1) && (d[1] === d[3]))
           lut4_mux4 = d[1];
         else
           lut4_mux4 = 1'bx;

   end
  endfunction

endmodule

module IPAD (PAD);

  input PAD;

endmodule

module OPAD (PAD);

  output PAD;

endmodule

module IOPAD (PAD);

  inout PAD;

endmodule

