//////modified at 2012/09/21
`timescale 1 ns/1 ns

module BLOCKRAM (DINA0,  DINB0,  DOUTA0,  DOUTB0,  ADDRA_0,  ADDRB_0, 
                 DINA1,  DINB1,  DOUTA1,  DOUTB1,  ADDRA_1,  ADDRB_1, 
                 DINA2,  DINB2,  DOUTA2,  DOUTB2,  ADDRA_2,  ADDRB_2, 
                 DINA3,  DINB3,  DOUTA3,  DOUTB3,  ADDRA_3,  ADDRB_3, 
                 DINA4,  DINB4,  DOUTA4,  DOUTB4,  ADDRA_4,  ADDRB_4, 
                 DINA5,  DINB5,  DOUTA5,  DOUTB5,  ADDRA_5,  ADDRB_5, 
                 DINA6,  DINB6,  DOUTA6,  DOUTB6,  ADDRA_6,  ADDRB_6, 
                 DINA7,  DINB7,  DOUTA7,  DOUTB7,  ADDRA_7,  ADDRB_7, 
                 DINA8,  DINB8,  DOUTA8,  DOUTB8,  ADDRA_8,  ADDRB_8, 
                 DINA9,  DINB9,  DOUTA9,  DOUTB9,  ADDRA_9,  ADDRB_9, 
                 DINA10, DINB10, DOUTA10, DOUTB10, ADDRA_10, ADDRB_10,
                 DINA11, DINB11, DOUTA11, DOUTB11, ADDRA_11, ADDRB_11,
                 DINA12, DINB12, DOUTA12, DOUTB12, 
                 DINA13, DINB13, DOUTA13, DOUTB13, 
                 DINA14, DINB14, DOUTA14, DOUTB14, 
                 DINA15, DINB15, DOUTA15, DOUTB15, 
                 CKA, AEN, RSTA, AWE, CKB, BEN, RSTB, BWE);

    input  DINA0,  DINB0,  ADDRA_0,  ADDRB_0,  
           DINA1,  DINB1,  ADDRA_1,  ADDRB_1,  
           DINA2,  DINB2,  ADDRA_2,  ADDRB_2,  
           DINA3,  DINB3,  ADDRA_3,  ADDRB_3,  
           DINA4,  DINB4,  ADDRA_4,  ADDRB_4,  
           DINA5,  DINB5,  ADDRA_5,  ADDRB_5,  
           DINA6,  DINB6,  ADDRA_6,  ADDRB_6,  
           DINA7,  DINB7,  ADDRA_7,  ADDRB_7,  
           DINA8,  DINB8,  ADDRA_8,  ADDRB_8,  
           DINA9,  DINB9,  ADDRA_9,  ADDRB_9,  
           DINA10, DINB10, ADDRA_10, ADDRB_10, 
           DINA11, DINB11, ADDRA_11, ADDRB_11, 
           DINA12, DINB12,
           DINA13, DINB13,
           DINA14, DINB14,
           DINA15, DINB15;
         
    output DOUTA0,  DOUTB0, 
           DOUTA1,  DOUTB1, 
           DOUTA2,  DOUTB2,  
           DOUTA3,  DOUTB3,  
           DOUTA4,  DOUTB4,  
           DOUTA5,  DOUTB5,  
           DOUTA6,  DOUTB6,  
           DOUTA7,  DOUTB7,  
           DOUTA8,  DOUTB8,  
           DOUTA9,  DOUTB9,  
           DOUTA10, DOUTB10, 
           DOUTA11, DOUTB11, 
           DOUTA12, DOUTB12, 
           DOUTA13, DOUTB13, 
           DOUTA14, DOUTB14, 
           DOUTA15, DOUTB15;
                         
    input AEN, CKA, AWE, RSTA;
    input BEN, CKB, BWE, RSTB;
                         
    wire clka_w,wea_w,rsta_w,ena_w;
    wire clkb_w,web_w,rstb_w,enb_w;
    
    wire [11:0]addr_a,addr_b;                  
                         
    parameter INIT_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    
    /*
    BLOCKRAM_4M	porta_attr(DIA15, DIA14, DIA13, DIA12, DIA11, DIA10, DIA9, DIA8, DIA7, DIA6, DIA5, DIA4, DIA3, DIA2, DIA1, DIA0, 
    	                       DOA15, DOA14, DOA13, DOA12, DOA11, DOA10, DOA9, DOA8, DOA7, DOA6, DOA5, DOA4, DOA3, DOA2, DOA1, DOA0,  
                             ADDRA11, ADDRA10, ADDRA9, ADDRA8, ADDRA7, ADDRA6, ADDRA5, ADDRA4, ADDRA3, ADDRA2, ADDRA1, ADDRA0,                           
                             ena_w, rsta_w, wea_w, clka_w);
                             
    BLOCKRAM_4M	portb_attr(DIB15, DIB14, DIB13, DIB12, DIB11, DIB10, DIB9, DIB8, DIB7, DIB6, DIB5, DIB4, DIB3, DIB2, DIB1, DIB0, 
    	                       DOB15, DOB14, DOB13, DOB12, DOB11, DOB10, DOB9, DOB8, DOB7, DOB6, DOB5, DOB4, DOB3, DOB2, DOB1, DOB0,  
                             ADDRB11, ADDRB10, ADDRB9, ADDRB8, ADDRB7, ADDRB6, ADDRB5, ADDRB4, ADDRB3, ADDRB2, ADDRB1, ADDRB0,                       
                             enb_w, rstb_w, web_w, clkb_w);
    */
    BLOCKRAM_4M	porta_attr(DINA15, DINA14, DINA13, DINA12, DINA11, DINA10, DINA9, DINA8, DINA7, DINA6, DINA5, DINA4, DINA3, DINA2, DINA1, DINA0, 
    	                       DOUTA15, DOUTA14, DOUTA13, DOUTA12, DOUTA11, DOUTA10, DOUTA9, DOUTA8, DOUTA7, DOUTA6, DOUTA5, DOUTA4, DOUTA3, DOUTA2, DOUTA1, DOUTA0,  
                             addr_a[11], addr_a[10], addr_a[9], addr_a[8], addr_a[7], addr_a[6], addr_a[5], addr_a[4], addr_a[3], addr_a[2], addr_a[1], addr_a[0],                     
                             ena_w, rsta_w, wea_w, clka_w);
                             
    BLOCKRAM_4M	portb_attr(DINB15, DINB14, DINB13, DINB12, DINB11, DINB10, DINB9, DINB8, DINB7, DINB6, DINB5, DINB4, DINB3, DINB2, DINB1, DINB0, 
    	                       DOUTB15, DOUTB14, DOUTB13, DOUTB12, DOUTB11, DOUTB10, DOUTB9, DOUTB8, DOUTB7, DOUTB6, DOUTB5, DOUTB4, DOUTB3, DOUTB2, DOUTB1, DOUTB0,  
                             addr_b[11], addr_b[10], addr_b[9], addr_b[8], addr_b[7], addr_b[6], addr_b[5], addr_b[4], addr_b[3], addr_b[2], addr_b[1], addr_b[0],                                       
                             enb_w, rstb_w, web_w, clkb_w);
    
    CLKAMUX		clkamux(.out(clka_w), ._1(CKA), ._0(CKA));
    CLKBMUX		clkbmux(.out(clkb_w), ._1(CKB), ._0(CKB));
    WEAMUX		weamux(.out(wea_w), .WEA_B(AWE), .WEA(AWE), ._1(1'b1), ._0(1'b0));
    WEBMUX		webmux(.out(web_w), .WEB_B(BWE), .WEB(BWE), ._1(1'b1), ._0(1'b0));
    ENAMUX		enamux(.out(ena_w), .ENA_B(AEN), .ENA(AEN), ._1(1'b1), ._0(1'b0) );
    ENBMUX		enbmux(.out(enb_w), .ENB_B(BEN), .ENB(BEN), ._1(1'b1), ._0(1'b0) );
    RSTAMUX		rstamux(.out(rsta_w), .RSTA_B(RSTA), .RSTA(RSTA), ._1(1'b1), ._0(1'b0));
    RSTBMUX		rstbmux(.out(rstb_w), .RSTB_B(RSTB), .RSTB(RSTB), ._1(1'b1), ._0(1'b0));

    BLOCK_ADDR_WIRE  addr_a_0  (.REAL_ADDR(ADDRA_0),  .ADDR_OUT(addr_a[0]));
    BLOCK_ADDR_WIRE  addr_a_1  (.REAL_ADDR(ADDRA_1),  .ADDR_OUT(addr_a[1]));
    BLOCK_ADDR_WIRE  addr_a_2  (.REAL_ADDR(ADDRA_2),  .ADDR_OUT(addr_a[2]));
    BLOCK_ADDR_WIRE  addr_a_3  (.REAL_ADDR(ADDRA_3),  .ADDR_OUT(addr_a[3]));
    BLOCK_ADDR_WIRE  addr_a_4  (.REAL_ADDR(ADDRA_4),  .ADDR_OUT(addr_a[4]));
    BLOCK_ADDR_WIRE  addr_a_5  (.REAL_ADDR(ADDRA_5),  .ADDR_OUT(addr_a[5]));
    BLOCK_ADDR_WIRE  addr_a_6  (.REAL_ADDR(ADDRA_6),  .ADDR_OUT(addr_a[6]));
    BLOCK_ADDR_WIRE  addr_a_7  (.REAL_ADDR(ADDRA_7),  .ADDR_OUT(addr_a[7]));
    BLOCK_ADDR_WIRE  addr_a_8  (.REAL_ADDR(ADDRA_8),  .ADDR_OUT(addr_a[8]));
    BLOCK_ADDR_WIRE  addr_a_9  (.REAL_ADDR(ADDRA_9),  .ADDR_OUT(addr_a[9]));
    BLOCK_ADDR_WIRE  addr_a_10 (.REAL_ADDR(ADDRA_10), .ADDR_OUT(addr_a[10]));
    BLOCK_ADDR_WIRE  addr_a_11 (.REAL_ADDR(ADDRA_11), .ADDR_OUT(addr_a[11]));
    
    BLOCK_ADDR_WIRE  addr_b_0  (.REAL_ADDR(ADDRB_0),  .ADDR_OUT(addr_b[0]));
    BLOCK_ADDR_WIRE  addr_b_1  (.REAL_ADDR(ADDRB_1),  .ADDR_OUT(addr_b[1]));
    BLOCK_ADDR_WIRE  addr_b_2  (.REAL_ADDR(ADDRB_2),  .ADDR_OUT(addr_b[2]));
    BLOCK_ADDR_WIRE  addr_b_3  (.REAL_ADDR(ADDRB_3),  .ADDR_OUT(addr_b[3]));
    BLOCK_ADDR_WIRE  addr_b_4  (.REAL_ADDR(ADDRB_4),  .ADDR_OUT(addr_b[4]));
    BLOCK_ADDR_WIRE  addr_b_5  (.REAL_ADDR(ADDRB_5),  .ADDR_OUT(addr_b[5]));
    BLOCK_ADDR_WIRE  addr_b_6  (.REAL_ADDR(ADDRB_6),  .ADDR_OUT(addr_b[6]));
    BLOCK_ADDR_WIRE  addr_b_7  (.REAL_ADDR(ADDRB_7),  .ADDR_OUT(addr_b[7]));
    BLOCK_ADDR_WIRE  addr_b_8  (.REAL_ADDR(ADDRB_8),  .ADDR_OUT(addr_b[8]));
    BLOCK_ADDR_WIRE  addr_b_9  (.REAL_ADDR(ADDRB_9),  .ADDR_OUT(addr_b[9]));
    BLOCK_ADDR_WIRE  addr_b_10 (.REAL_ADDR(ADDRB_10), .ADDR_OUT(addr_b[10]));
    BLOCK_ADDR_WIRE  addr_b_11 (.REAL_ADDR(ADDRB_11), .ADDR_OUT(addr_b[11]));
    
    
    
endmodule



`timescale 1 ns/1 ns

module BLOCKRAM_4M (DI[15],DI[14],DI[13],DI[12],DI[11],DI[10],DI[9],DI[8],DI[7],DI[6],DI[5],DI[4],DI[3],DI[2],DI[1],DI[0],
			  DO[15],DO[14],DO[13],DO[12],DO[11],DO[10],DO[9],DO[8],DO[7],DO[6],DO[5],DO[4],DO[3],DO[2],DO[1],DO[0],	 
			  ADDR[11],ADDR[10],ADDR[9],ADDR[8],ADDR[7],ADDR[6],ADDR[5],ADDR[4],ADDR[3],ADDR[2],ADDR[1],ADDR[0],	
			  EN, RST, WE, CLK);

    
    parameter CONF="1024X4";
    integer DATA_WIDTH;

    output[15:0] DO;
    input [11:0] ADDR;
    input [15:0] DI;
    
    input EN, CLK, WE, RST;
    
    integer i;
     
    
    reg [4095:0] mem;

    reg [8:0] count;
    
    //reg [11:0] addr_init=12'b0;
    
    reg [15:0] do_out = 0;
    
    wire [11:0] addr_int;
    wire [15:0] di_int;

    buf b_do [15:0] (DO, do_out);
    buf b_di [15:0] (di_int, DI);
    
    buf b_addr [11:0] (addr_int, ADDR);
    
 initial
    begin
	

	
	for (count = 0; count < 256; count = count + 1)
	begin
	    mem[count]		 <= BLOCKRAM.INIT_00[count];
	    mem[256 * 1 + count] <= BLOCKRAM.INIT_01[count];
	    mem[256 * 2 + count] <= BLOCKRAM.INIT_02[count];
	    mem[256 * 3 + count] <= BLOCKRAM.INIT_03[count];
	    mem[256 * 4 + count] <= BLOCKRAM.INIT_04[count];
	    mem[256 * 5 + count] <= BLOCKRAM.INIT_05[count];
	    mem[256 * 6 + count] <= BLOCKRAM.INIT_06[count];
	    mem[256 * 7 + count] <= BLOCKRAM.INIT_07[count];
	    mem[256 * 8 + count] <= BLOCKRAM.INIT_08[count];
	    mem[256 * 9 + count] <= BLOCKRAM.INIT_09[count];
	    mem[256 * 10 + count] <=BLOCKRAM.INIT_0A[count];
	    mem[256 * 11 + count] <=BLOCKRAM.INIT_0B[count];
	    mem[256 * 12 + count] <=BLOCKRAM.INIT_0C[count];
	    mem[256 * 13 + count] <=BLOCKRAM.INIT_0D[count];
	    mem[256 * 14 + count] <=BLOCKRAM.INIT_0E[count];
	    mem[256 * 15 + count] <=BLOCKRAM.INIT_0F[count];
	end
	
		case(CONF)
			"4096X1":	 DATA_WIDTH=1;
			"2048X2":	 DATA_WIDTH=2;
			"1024X4":	 DATA_WIDTH=4;
			"512X8":	 DATA_WIDTH=8;
			"256X16":	 DATA_WIDTH=16;
			"#OFF":	 DATA_WIDTH=0;	
		endcase		

    end 
	


always @(posedge CLK)
    begin
	if (EN == 1'b1)
	    if (RST == 1'b1)
		    for(i=0;i<DATA_WIDTH;i=i+1)
			    do_out[i] <= 0;
	    else
		if (WE == 1'b1)
		    for(i=0;i<DATA_WIDTH;i=i+1)
			    do_out[i] <= di_int[i];
		else
		    begin
			for(i=0;i<DATA_WIDTH;i=i+1)
			    do_out[i] <= mem[addr_int + i];
		    end
    end

    always @(posedge CLK)
    begin
	if (EN == 1'b1 && WE == 1'b1)
	    begin
                for(i=0;i<DATA_WIDTH;i=i+1)
			  mem[addr_int + i] <= di_int[i];

	    end
    end

endmodule


`timescale 1 ns/1 ns

module BLOCK_ADDR_WIRE (REAL_ADDR, ADDR_OUT);

input REAL_ADDR;
output ADDR_OUT;
reg ADDR_OUT; 

initial
	ADDR_OUT=1'b0;
	
always @(REAL_ADDR)
begin
	if (REAL_ADDR==1'bz)
		ADDR_OUT = 1'b0;
	else
		ADDR_OUT = REAL_ADDR;
end

endmodule/*
BXMUX.module
a four-input mux
Mike Zou <zxhmike@gmail.com>
*/
module BXMUX(out,BX_B,BX,_1,_0);
	output reg out;
	input BX_B,BX,_1,_0;
	parameter CONF="#OFF";
	
	always @ (BX_B or BX or _1 or _0)
		case (CONF)
			"BX_B": out=~BX;
			"BX": out=BX;
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
BYMUX.module
a four-input mux
Mike Zou <zxhmike@gmail.com>
*/
module BYMUX(out,BY_B,BY,_1,_0);
	output reg out;
	input BY_B,BY,_1,_0;
	parameter CONF="#OFF";
	
	always @ (BY_B or BY or _1 or _0)
		case (CONF)
			"BY_B": out=~BY;
			"BY": out=BY;
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
CEMUX.module
a four-input mux
Mike Zou <zxhmike@gmail.com>
*/
module CEMUX(out,CE_B,CE,_1,_0);
	output reg out;
	input CE_B,CE,_1,_0;
	parameter CONF="#OFF";
	
	always @ (CE_B or CE or _1 or _0)
		case (CONF)
			"CE_B": out=~CE;
			"CE": out=CE;
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'b1;
			default:out=1'bx;
		endcase
endmodule
/*
CKINV.v
a two-input mux
Mike Zou <zxhmike@gmail.com>
*/
module CKINV(out,_1,_0);
	output reg out;
	input _1,_0;
	parameter CONF="#OFF";
	
	always @ (_1 or _0)
		case (CONF)
			"1": out=_1;
			"0": out=~_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
CKINV.v
a two-input mux
Mike Zou <zxhmike@gmail.com>
*/
module CLKAMUX(out,_1,_0);
	output reg out;
	input _1,_0;
	parameter CONF="#OFF";
	
	always @ (_1 or _0)
		case (CONF)
			"1": out=_1;
			"0": out=~_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
CKINV.v
a two-input mux
Mike Zou <zxhmike@gmail.com>
*/
module CLKBMUX(out,_1,_0);
	output reg out;
	input _1,_0;
	parameter CONF="#OFF";
	
	always @ (_1 or _0)
		case (CONF)
			"1": out=_1;
			"0": out=~_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
COUTUSED.v
a one-input mux
Mike Zou <zxhmike@gmail.com>
*/
module COUTUSED(out,_0);
	output reg out;
	input _0;
	parameter CONF="#OFF";
	
	always @ (_0)
		case (CONF)
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
CY0F.module
a four-input mux
Mike Zou <zxhmike@gmail.com>
*/
module CY0F(out,PROD,F1,_1,_0);
	output reg out;
	input PROD,F1,_1,_0;
	parameter CONF="#OFF";
	
	always @ (PROD or F1 or _1 or _0)
		case (CONF)
			"PROD": out=PROD;
			"F1": out=F1;
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
CY0G.module
a four-input mux
Mike Zou <zxhmike@gmail.com>
*/
module CY0G(out,PROD,G1,_1,_0);
	output reg out;
	input PROD,G1,_1,_0;
	parameter CONF="#OFF";
	
	always @ (PROD or G1 or _1 or _0)
		case (CONF)
			"PROD": out=PROD;
			"G1": out=G1;
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
CYINIT.v
a two-input mux
Mike Zou <zxhmike@gmail.com>
*/
module CYINIT(out,BX,CIN);
	output reg out;
	input BX,CIN;
	parameter CONF="#OFF";
	
	always @ (BX or CIN)
		case (CONF)
			"BX": out=BX;
			"CIN": out=CIN;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
CYMUX
*/
module CYMUX(out,_0,_1,S0);
	output reg out;
	input _0,_1,S0;
	
	always @ (S0 or _0 or _1)
		case (S0)
			1'b0: out=_0;
			1'b1: out=_1;
			default: out=1'bx;
		endcase
endmodule
/*
CYSELF.v
a two-input mux
Mike Zou <zxhmike@gmail.com>
*/
module CYSELF(out,_1,F);
	output reg out;
	input _1,F;
	parameter CONF="#OFF";
	
	always @ (_1 or F)
		case (CONF)
			"1": out=_1;
			"F": out=F;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
CYSELG.v
a two-input mux
Mike Zou <zxhmike@gmail.com>
*/
module CYSELG(out,_1,G);
	output reg out;
	input _1,G;
	parameter CONF="#OFF";
	
	always @ (_1 or G)
		case (CONF)
			"1": out=_1;
			"G": out=G;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
DGEN.module
a dgen in slice
Mike Zou <zxhmike@gmail.com>
*/
module DGEN(DG,BY,BX,DF);
	parameter CONF="#OFF";
	output DG;
	input BY,BX,DF;
	//The following line is only used for test slice
	assign DG=(CONF=="#OFF")?1'bz:BY;
endmodule
//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	DISABLE_ATTR();
parameter	CONF = "#OFF";

endmodule

`timescale  1 ps / 1 ps

module DLL (
	CK0, CK180, CK270, CK2X, CK2X90, CK90, CKDV, LOCKED, 
	CKFB, CKIN, RST);

parameter real CLKDV_DIVIDE = 2.0;
parameter DUTY_CYCLE_CORRECTION = "TRUE";
parameter FACTORY_JF = 16'hC080;		// non-simulatable
parameter integer MAXPERCLKIN = 40000;			// simulation parameter
parameter integer SIM_CLKIN_CYCLE_JITTER = 300;		// simulation parameter
parameter integer SIM_CLKIN_PERIOD_JITTER = 1000;	// simulation parameter
parameter LOC = "UNPLACED";
parameter STARTUP_WAIT = "FALSE";		// non-simulatable

input CKFB, CKIN, RST;

output CK0, CK180, CK270, CK2X, CK2X90, CK90, CKDV, LOCKED;

reg CK0, CK180, CK270, CK2X, CK2X90, CK90, CKDV;

wire clkfb_in, clkin_in, rst_in;
wire clk0_out;
reg clk2x_out, clkdv_out, locked_out;

reg [1:0] clkfb_type;
reg [8:0] divide_type;
reg clk1x_type;

reg lock_period, lock_delay, lock_clkin, lock_clkfb;
reg [1:0] lock_out;
reg lock_fb;
reg fb_delay_found;
reg clock_stopped;

reg clkin_ps;
reg clkin_fb;

time clkin_edge;
time clkin_ps_edge;
time delay_edge;
time clkin_period [2:0];
time period;
time period_ps;
time period_orig;
time clkout_delay;
time fb_delay;
time period_dv_high, period_dv_low;
time cycle_jitter, period_jitter;

reg clkin_window, clkfb_window;
reg clkin_5050;
reg [2:0] rst_reg;
reg [23:0] i, n, d, p;

reg notifier;

initial begin
    #1;
    if ($realtime == 0) begin
	$display ("Simulator Resolution Error : Simulator resolution is set to a value greater than 1 ps.");
	$display ("In order to simulate the X_CLKDLLE, the simulator resolution must be set to 1ps or smaller.");
	$finish;
    end
end

initial begin
    case (CLKDV_DIVIDE)
	1.5  : divide_type <= 'd3;
	2.0  : divide_type <= 'd4;
	2.5  : divide_type <= 'd5;
	3.0  : divide_type <= 'd6;
	3.5  : divide_type <= 'd7;
	4.0  : divide_type <= 'd8;
	4.5  : divide_type <= 'd9;
	5.0  : divide_type <= 'd10;
	5.5  : divide_type <= 'd11;
	6.0  : divide_type <= 'd12;
	6.5  : divide_type <= 'd13;
	7.0  : divide_type <= 'd14;
	7.5  : divide_type <= 'd15;
	8.0  : divide_type <= 'd16;
	9.0  : divide_type <= 'd18;
	10.0 : divide_type <= 'd20;
	11.0 : divide_type <= 'd22;
	12.0 : divide_type <= 'd24;
	13.0 : divide_type <= 'd26;
	14.0 : divide_type <= 'd28;
	15.0 : divide_type <= 'd30;
	16.0 : divide_type <= 'd32;
	default : begin
	    $display("Attribute Syntax Error : The attribute CLKDV_DIVIDE on X_CLKDLLE instance %m is set to %0.1f.  Legal values for this attribute are 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0, 7.5, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, or 16.0.", CLKDV_DIVIDE);
	    $finish;
	end
    endcase

    clkfb_type <= 2;

    period_jitter <= SIM_CLKIN_PERIOD_JITTER;
    cycle_jitter <= SIM_CLKIN_CYCLE_JITTER;

    case (DUTY_CYCLE_CORRECTION)
	"false" : clk1x_type <= 0;
	"FALSE" : clk1x_type <= 0;
	"true"  : clk1x_type <= 1;
	"TRUE"  : clk1x_type <= 1;
	default : begin
	    $display("Attribute Syntax Error : The attribute DUTY_CYCLE_CORRECTION on X_CKDLLE instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", DUTY_CYCLE_CORRECTION);
	    $finish;
	end
    endcase

    case (STARTUP_WAIT)
	"false" : ;
	"FALSE" : ;
	"true"  : ;
	"TRUE"  : ;
	default : begin
	    $display("Attribute Syntax Error : The attribute STARTUP_WAIT on X_CKDLLE instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", STARTUP_WAIT);
	    $finish;
	end
    endcase
end

//
// input wire delays
//

buf b_clkin (clkin_in, CKIN);
buf b_clkfb (clkfb_in, CKFB);
buf b_rst (rst_in, RST);
buf b_locked (LOCKED, locked_out);


x_clkdlle_maximum_period_check #("CLKIN", MAXPERCLKIN) i_max_clkin (clkin_in, rst_in);

always @(clkin_in or rst_in) begin
    if (rst_in == 1'b0)
	clkin_ps <= clkin_in;
    else if (rst_in == 1'b1) begin
	clkin_ps <= 1'b0;
	@(negedge rst_reg[2]);
    end
end

always @(clkin_ps or lock_fb) begin
    clkin_fb <= #(period_ps) clkin_ps & lock_fb;
end

always @(posedge clkin_ps) begin
    clkin_ps_edge <= $time;
    if (($time - clkin_ps_edge) <= (1.5 * period_ps))
	period_ps <= $time - clkin_ps_edge;
    else if ((period_ps == 0) && (clkin_ps_edge != 0))
	period_ps <= $time - clkin_ps_edge;
end

always @(posedge clkin_ps) begin
    lock_fb <= lock_period;
end

always @(period or fb_delay)
    clkout_delay <= period - fb_delay;

//
// generate master reset signal
//

always @(posedge clkin_in) begin
    rst_reg[0] <= rst_in;
    rst_reg[1] <= rst_reg[0] & rst_in;
    rst_reg[2] <= rst_reg[1] & rst_reg[0] & rst_in;
end

time rst_tmp1, rst_tmp2;
initial
begin
rst_tmp1 = 0;
rst_tmp2 = 0;
end


always @(posedge rst_in or negedge rst_in)
begin
   if (rst_in ==1) 
      rst_tmp1 <= $time;
   else if (rst_in==0 ) begin
      rst_tmp2 = $time - rst_tmp1; 
      if (rst_tmp2 < 2000 && rst_tmp2 != 0) 
        $display("Input Error : RST on instance %m must be asserted at least for 2 ns.");
   end
end

initial begin
    clk2x_out <= 0;
    clkdv_out <= 0;
    clkin_5050 <= 0;
    clkfb_window <= 0;
    clkin_period[0] <= 0;
    clkin_period[1] <= 0;
    clkin_period[2] <= 0;
    clkin_ps_edge <= 0;
    clkin_window <= 0;
    clkout_delay <= 0;
    clock_stopped <= 1;
    fb_delay  <= 0;
    fb_delay_found <= 0;
    lock_clkfb <= 0;
    lock_clkin <= 0;
    lock_delay <= 0;
    lock_fb <= 0;
    lock_out <= 2'b00;
    lock_period <= 0;
    locked_out <= 0;
    period <= 0;
    period_ps <= 0;
    period_orig <= 0;
    rst_reg <= 3'b000;
end

always @(rst_in) begin
    clkin_5050 <= 0;
    clkfb_window <= 0;
    clkin_period[0] <= 0;
    clkin_period[1] <= 0;
    clkin_period[2] <= 0;
    clkin_ps_edge <= 0;
    clkin_window <= 0;
    clkout_delay <= 0;
    clock_stopped <= 1;
    fb_delay  <= 0;
    fb_delay_found <= 0;
    lock_clkfb <= 0;
    lock_clkin <= 0;
    lock_delay <= 0;
    lock_fb <= 0;
    lock_out <= 2'b00;
    lock_period <= 0;
    locked_out <= 0;
    period_ps <= 0;
end

//
// determine clock period
//

always @(posedge clkin_ps) begin
    clkin_edge <= $time;
    clkin_period[2] <= clkin_period[1];
    clkin_period[1] <= clkin_period[0];
    if (clkin_edge != 0)
	clkin_period[0] <= $time - clkin_edge;
end

always @(negedge clkin_ps) begin
    if (lock_period == 1'b0) begin
	if ((clkin_period[0] != 0) &&
		(clkin_period[0] - cycle_jitter <= clkin_period[1]) &&
		(clkin_period[1] <= clkin_period[0] + cycle_jitter) &&
		(clkin_period[1] - cycle_jitter <= clkin_period[2]) &&
		(clkin_period[2] <= clkin_period[1] + cycle_jitter)) begin
	    lock_period <= 1;
	    period_orig <= (clkin_period[0] +
			    clkin_period[1] +
			    clkin_period[2]) / 3;
	    period <= clkin_period[0];
	end
    end
    else if (lock_period == 1'b1) begin
	if (100000000 < (clkin_period[0] / 1000)) begin
	    $display("Warning : CLKIN stopped toggling on instance %m exceeds %d ms.  Current CLKIN Period = %1.3f ns.", 100, clkin_period[0] / 1000.0);
	    lock_period <= 0;
	    @(negedge rst_reg[2]);
	end
	else if ((period_orig * 2 < clkin_period[0]) && clock_stopped == 1'b0) begin
	    clkin_period[0] = clkin_period[1];
	    clock_stopped = 1'b1;
	end
	else if ((clkin_period[0] < period_orig - period_jitter) ||
		(period_orig + period_jitter < clkin_period[0])) begin
	    $display("Warning : Input Clock Period Jitter on instance %m exceeds %1.3f ns.  Locked CLKIN Period = %1.3f.  Current CLKIN Period = %1.3f.", period_jitter / 1000.0, period_orig / 1000.0, clkin_period[0] / 1000.0);
	    lock_period <= 0;
	    @(negedge rst_reg[2]);
	end
	else if ((clkin_period[0] < clkin_period[1] - cycle_jitter) ||
		(clkin_period[1] + cycle_jitter < clkin_period[0])) begin
	    $display("Warning : Input Clock Cycle-Cycle Jitter on instance %m exceeds %1.3f ns.  Previous CLKIN Period = %1.3f.  Current CLKIN Period = %1.3f.", cycle_jitter / 1000.0, clkin_period[1] / 1000.0, clkin_period[0] / 1000.0);
	    lock_period <= 0;
	    @(negedge rst_reg[2]);
	end
	else begin
	    period <= clkin_period[0];
	    clock_stopped = 1'b0;
	end
    end
end

//
// determine clock delay
//

always @(posedge lock_period) begin
    if (lock_period && clkfb_type != 0) begin
	if (clkfb_type == 1) begin
	    @(posedge CK0 or rst_in)
		delay_edge = $time;
	end
	else if (clkfb_type == 2) begin
	    @(posedge CK2X or rst_in)
		delay_edge = $time;
	end
	@(posedge clkfb_in or rst_in)
	fb_delay = ($time - delay_edge) % period_orig;
    end
    fb_delay_found = 1;
end

//
// determine feedback lock
//

always @(posedge clkfb_in) begin
    #0  clkfb_window <= 1;
    #cycle_jitter clkfb_window <= 0;
end

always @(posedge clkin_fb) begin
    #0  clkin_window <= 1;
    #cycle_jitter clkin_window <= 0;
end

always @(posedge clkin_fb) begin
    #1
    if (clkfb_window && fb_delay_found)
	lock_clkin <= 1;
    else
	lock_clkin <= 0;
end

always @(posedge clkfb_in) begin
    #1
    if (clkin_window && fb_delay_found)
	lock_clkfb <= 1;
    else
	lock_clkfb <= 0;
end

always @(negedge clkin_fb) begin
    lock_delay <= lock_clkin || lock_clkfb;
end

//
// generate lock signal
//

always @(posedge clkin_ps) begin
    lock_out[0] <= lock_period & lock_delay & lock_fb;
    lock_out[1] <= lock_out[0];
    locked_out <= lock_out[1];
end

//
// generate the clk1x_out
//

always @(posedge clkin_ps) begin
    clkin_5050 <= 1;
    #(period / 2)
    clkin_5050 <= 0;
end

assign clk0_out = (clk1x_type) ? clkin_5050 : clkin_ps;

//
// generate the clk2x_out
//

always @(posedge clkin_ps) begin
    clk2x_out <= 1;
    #(period / 4)
    clk2x_out <= 0;
    if (lock_out[0]) begin
	#(period / 4)
	clk2x_out <= 1;
	#(period / 4)
	clk2x_out <= 0;
    end
    else begin
	#(period / 2);
    end
end

//
// generate the clkdv_out
//

always @(period) begin
//    period_dv_high = (period / 2) * (divide_type / 2);
//    period_dv_low = (period / 2) * (divide_type / 2 + divide_type % 2);
        period_dv_high = (period * divide_type) / 4;
        period_dv_low = (period * divide_type) / 4;

end

always @(posedge clkin_ps) begin
    if (lock_out[0]) begin
	clkdv_out = 1'b1;
	#(period_dv_high);
	clkdv_out = 1'b0;
	#(period_dv_low);
	clkdv_out = 1'b1;
	#(period_dv_high);
	clkdv_out = 1'b0;
	#(period_dv_low - period / 2);
    end
end

//
// generate all output signal
//

always @(clk0_out) begin
    CK0 <= #(clkout_delay) clk0_out;
end

always @(clk0_out) begin
    CK90 <= #(clkout_delay + period / 4) clk0_out;
end

always @(clk0_out) begin
    CK180 <= #(clkout_delay + period / 2) clk0_out;
end

always @(clk0_out) begin
    CK270 <= #(clkout_delay + (3 * period) / 4) clk0_out;
end

always @(clk2x_out) begin
    CK2X <= #(clkout_delay) clk2x_out;
end

always @(clk2x_out) begin
    CK2X90 <= #(clkout_delay + period / 4) clk2x_out;
end

always @(clkdv_out) begin
    CKDV <= #(clkout_delay) clkdv_out;
end

specify
	(CKIN => LOCKED) = (0:0:0, 0:0:0);

	$period (posedge CKIN, 1111, notifier);
	$width (posedge CKIN, 0, 0, notifier);
	$width (negedge CKIN, 0, 0, notifier);
	$width (posedge RST, 0, 0, notifier);

	specparam PATHPULSE$ = 0;
endspecify

endmodule

//////////////////////////////////////////////////////

module x_clkdlle_maximum_period_check (clock, rst);
parameter clock_name = "";
parameter maximum_period = 0;
input clock;
input rst;

time clock_edge;
time clock_period;

initial begin
    clock_edge <= 0;
    clock_period <= 0;
end

always @(posedge clock) begin
    clock_edge <= $time;
    clock_period <= $time - clock_edge;
    if (clock_period > maximum_period && rst == 0) begin
	$display("Warning : Input clock period of, %1.3f ns, on the %s port of instance %m exceeds allotted value of %1.3f ns at simulation time %1.3f ns.", clock_period/1000.0, clock_name, maximum_period/1000.0, $time/1000.0);
    end
end
endmodule

//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	DRIVEATTRBOX();
parameter	CONF = "#OFF";

endmodule/*
DXMUX.v
a two-input mux
Mike Zou <zxhmike@gmail.com>
*/
module DXMUX(out,_1,_0);
	output reg out;
	input _1,_0;
	parameter CONF="#OFF";
	
	always @ (_1 or _0)
		case (CONF)
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
DYMUX.v
a two-input mux
Mike Zou <zxhmike@gmail.com>
*/
module DYMUX(out,_1,_0);
	output reg out;
	input _1,_0;
	parameter CONF="#OFF";
	
	always @ (_1 or _0)
		case (CONF)
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule

`timescale 1 ns/1 ns

module ENAMUX (ENA_B, ENA, _1, _0, out );

    input ENA_B, ENA, _1, _0;
    output reg out;
    parameter CONF="#OFF";
	
	always @ (ENA_B or ENA or _1 or _0)
		case (CONF)
			"ENA_B": out=~ENA;
			"ENA": out=ENA;
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule



`timescale 1 ns/1 ns

module ENBMUX (ENB_B, ENB, _1, _0, out );

    input ENB_B, ENB, _1, _0;
    output reg out;
    parameter CONF="#OFF";
	
	always @ (ENB_B or ENB or _1 or _0)
		case (CONF)
			"ENB_B": out=~ENB;
			"ENB": out=ENB;
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule


/*
mux2-1.v
a two-input mux with control bit
Mike Zou <zxhmike@gmail.com>
*/
module F5MUX(out,F,G,NO_NAME);
	output reg out;
	input F,G,NO_NAME;
	
	always @ (F or G or NO_NAME)
		case (NO_NAME)
			1'b0: out=G;
			1'b1: out=F;
			default: out=1'bx;
		endcase
endmodule
/*
F5USED.v
a one-input mux
Mike Zou <zxhmike@gmail.com>
*/
module F5USED(out,_0);
	output reg out;
	input _0;
	parameter CONF="#OFF";
	
	always @ (_0)
		case (CONF)
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
F6MUX.v
a two-input mux
Mike Zou <zxhmike@gmail.com>
*/
module F6MUX(out,_1,in1);
	output reg out;
	input _1,in1;
	parameter CONF="#OFF";
	
	always @ (_1 or in1)
		case (CONF)
			"1": out=_1;
			"in1": out=in1;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
FAND.v
Mike Zou <zxhmike@gmail.com>
a AND gate
*/
module FAND(out,INO,IN1);
	output out;
	input INO,IN1;
	assign out=INO&IN1;
endmodule
//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	FFATTRBOX();
parameter	CONF = "#OFF";

endmodule/*
FFXY.module
written by Zuozhou Zhang
09212020070@fudan.edu.cn
*/
`timescale 1 ps/1 ps

module FFXY (Q,D,CE,CK,INIT,REV);

    parameter TYPE= "#OFF";					//"#FF/#LATCH";
    parameter INIT_VALUE= "#OFF";		//"LOW/HIGH";
    parameter SYNC_ATTR= "#OFF";		//"ASYNC/SYNC";
    
    output Q;
    input  D,CE,CK,INIT,REV;
    
    reg IS_FF;
    reg INIT_BIT;
    reg IS_ASYNC;

		wire q_ff_async;
		wire q_ff_sync;
		wire q_latch_async;
		wire q_latch_sync;


initial
	begin	
		case(TYPE)
			"#FF":	 	 IS_FF=1'b1;
			"#LATCH":	 IS_FF=1'b0;
		endcase		
		case(INIT_VALUE)
			"LOW":	   INIT_BIT=1'b0;
			"HIGH":	   INIT_BIT=1'b1;
		endcase
		case(SYNC_ATTR)
			"ASYNC":	 IS_ASYNC=1'b1;
			"SYNC":	   IS_ASYNC=1'b0;
		endcase			
		
		
	end

FFXY_FF_A			ff_async		(.Q(q_ff_async),		.D(D),.CE(CE),.CK(CK),.INIT(INIT),.REV(REV));
FFXY_FF_S			ff_sync			(.Q(q_ff_sync),			.D(D),.CE(CE),.CK(CK),.INIT(INIT),.REV(REV));
FFXY_LATCH_A	latch_async	(.Q(q_latch_async),	.D(D),.CE(CE),.CK(CK),.INIT(INIT),.REV(REV));
FFXY_LATCH_S	latch_sync	(.Q(q_latch_sync),	.D(D),.CE(CE),.CK(CK),.INIT(INIT),.REV(REV));

FFXY_MUX			ffxy_mux		(.I0(q_ff_async), .I1(q_ff_sync), .I2(q_latch_async), .I3(q_latch_sync), .C0(IS_FF), .C1(IS_ASYNC), .O(Q));



endmodule

module FFXY_MUX (I0,I1,I2,I3,C0,C1,O);
    
    output O;
    input  I0,I1,I2,I3,C0,C1;

		reg O;

   	always @ (I0 or I1 or I2 or I3 or C0 or C1)
   	begin
			case ({C0,C1})				//TYPE
				2'b00: O=I3;				//FFXY_LATCH_S				
				2'b01: O=I2;				//FFXY_LATCH_A	
				2'b10: O=I1;				//FFXY_FF_S	
				2'b11: O=I0;				//FFXY_FF_A	
				default: O=1'bx;
			endcase
		end
		
endmodule




/*
FFXY_FF_A.module
written by Zuozhou Zhang
09212020070@fudan.edu.cn
*/

module FFXY_FF_A (Q,D,CE,CK,INIT,REV);
    
    output Q;
    input  D,CE,CK,INIT,REV;

		reg Q;

always @(posedge CK or posedge INIT)         
         begin 
                 if(INIT)
                   Q=FFXY.INIT_BIT;
                 else if(CE)
                   Q=D;      
         end                                  
endmodule
/*
FFXY_FF_S.v
written by Zuozhou Zhang
09212020070@fudan.edu.cn
*/


module FFXY_FF_S (Q,D,CE,CK,INIT,REV);
    
    output Q;
    input  D,CE,CK,INIT,REV;

		reg Q;

always @(posedge CK)  
         begin
                 if(INIT)
                   Q=FFXY.INIT_BIT;
                 else if(CE)
                   Q=D;               
         end           
endmodule
/*
FFXY_LATCH_A.module
written by Zuozhou Zhang
09212020070@fudan.edu.cn
*/
 

module FFXY_LATCH_A (Q,D,CE,CK,INIT,REV);
    
    output Q;
    input  D,CE,CK,INIT,REV;

		reg Q;
		
	

always @(CK or INIT or D)  
    begin
                 if(INIT)
                    Q=FFXY.INIT_BIT;
                else if(CK)
                 	if(CE)
                   Q=D;    

     end               
endmodule
/*
FFXY_LATCH_S.v
written by Zuozhou Zhang
09212020070@fudan.edu.cn
*/


module FFXY_LATCH_S (Q,D,CE,CK,INIT,REV);
    
    output Q;
    input  D,CE,CK,INIT,REV;

		reg Q;

always @(CK or D)  
    begin
                 if(CK)
                 begin
                 			if(INIT)
                    				begin
                    						Q<=FFXY.INIT_BIT;
                    				end
                 			else if(CE)
                 						begin
 							                  Q<=D;
 							              end
                 end     
     end       
           
                        
endmodule



/*

case(TYPE)
		"#FF": 		case(SYNC_ATTR)
								"SYNC":			always @(posedge CK )
											        if (INIT)
												     			Q =  INIT_BIT;
											        else if (CE)
												     			Q <=  D;
								
								"ASYNC":		always @(posedge CK or posedge INIT)
											        if (INIT)
												     			Q <=  INIT_BIT;
											        else if (CE)
												     			Q <=  D;
							endcase
		"#LATCH":	case(SYNC_ATTR)
								"SYNC":			always @(CK or D)
											        if (INIT && CK)
												     			Q <=  INIT_BIT;
											        else if (CE && CK)
												     			Q <=  D;
								
								"ASYNC":		always @(CK or INIT or D)
											        if (INIT)
												     			Q <=  INIT_BIT;
											        else if (CE && CK)
												     			Q <=  D;
//								default:   
//								            q_out <= 1'bx;
							endcase

//		default:   Q=1'bx;
endcase*/



/*module FFXY (Q,D,CE,CK,INIT,REV);

    parameter TYPE= "#OFF";					//"#FF/#LATCH";
    parameter INIT_VALUE= "#OFF";		//"LOW/HIGH";
    parameter SYNC_ATTR= "#OFF";		//"ASYNC/SYNC";
    
    always
    begin
    	case(TYPE)
    		"#FF" : 
  	end

endmodule
*/







/*always @(D or CE or CK or INIT)
	begin
		case(TYPE)
			"#FF":	case(SYNC_ATTR)
									"#ASYNC": 	Q=q_ff_async;
									"#SYNC": 		Q=q_ff_sync;
							endcase
			"#LATCH":	case(SYNC_ATTR)
									"#ASYNC": 	Q=q_latch_async;
									"#SYNC": 		Q=q_latch_sync;
							endcase							
		endcase
	end
									
		
endmodule	
*//*
FXMUX.module
a three-input mux
Mike Zou <zxhmike@gmail.com>
*/
module FXMUX(out,F5,FXOR,F);
	output reg out;
	input F5,FXOR,F;
	parameter CONF="#OFF";
	
	always @ (F5 or FXOR or F)
		case (CONF)
			"F5": out=F5;
			"FXOR": out=FXOR;
			"F": out=F;
			"#OFF":out=1'bz;
			default: out=1'bx;
		endcase
endmodule
/*
GAND.v
Mike Zou <zxhmike@gmail.com>
a AND gate
*/
module GAND(out,IN0,IN1);
	output out;
	input IN0,IN1;
	assign out=IN0&IN1;
endmodule
module GCLK (
    CE,
    IN,
    OUT
  );      
  
  input CE,IN;         
  output  OUT;   
  wire 	ce_out;
  


		DISABLE_ATTR		disable_attr 	(); 

		CEMUX 					cemux(
		                    .out(ce_out),
		                    .CE_B(),
		                    .CE(),
		                    ._1(1'b1),
		                    ._0(1'b0)
		);
		
		assign OUT = ce_out ? IN : 1'bz;
  
endmodule                 
                    module GCLKIOB(
    PAD,
    GCLKOUT
  );      
  
  input PAD;         
  output  GCLKOUT;   
  

IOATTRBOX		ioattrbox (); 

assign GCLKOUT=PAD;
  
endmodule                 
                    /*
GYMUX.module
a three-input mux
Mike Zou <zxhmike@gmail.com>
*/
module GYMUX(out,F6,GXOR,G);
	output reg out;
	input F6,GXOR,G;
	parameter CONF="#OFF";
	
	always @ (F6 or GXOR or G)
		case (CONF)
			"F6": out=F6;
			"GXOR": out=GXOR;
			"G": out=G;
			"#OFF":out=1'bz;
			default: out=1'bx;
		endcase
endmodule
//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	ICEMUX();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	ICKINV();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	IFF();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	IFFINITATTR();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	IFFMUX();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	IINITMUX();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	IMUX();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	IOATTRBOX();
parameter	CONF = "#OFF";

endmodule


module IOB (
    TRI,
    TRICE,
    OUT,
    OUTCE,
    INCE,
    CLK,
    SR,
    IN,
    IQ,
    PAD
  );      
  
  input OUT, TRI,INCE,SR, TRICE,OUTCE,CLK;         
  output  IN,IQ;   
  
  inout PAD;

DRIVEATTRBOX		driveattrbox  (); 
FFATTRBOX       ffattrbox     (); 
ICEMUX          icemux        (); 
ICKINV          ickinv        (); 
IFF             iff           (); 
IFFINITATTR     iffinitattr   (); 
IFFMUX          iffmux        (); 
IINITMUX        iinitmux      (); 
IMUX            imux          (); 
IOATTRBOX       ioattrbox     (); 
OCEMUX          ocemux        (); 
OCKINV          ockinv        (); 
OFF             off           (); 
OFFATTRBOX      offattrbox    (); 
OINITMUX        oinitmux      (); 
OMUX            omux          (); 
OUTMUX          outmux        (); 
PULL            pull          (); 
SLEW            slew          (); 
SRMUX           srmux         (); 
TCEMUX          tcemux        (); 
TCKINV          tckinv        (); 
TFF             tff           (); 
TFFATTRBOX      tffattrbox    (); 
TINITMUX        tinitmux      (); 
TRIMUX          trimux        (); 
TSEL            tsel          (); 

assign PAD=OUT;
assign IN=PAD;
  
  
endmodule                 
                   

`timescale  100 ps / 10 ps


module LUT (O, I0, I1, I2, I3);

  parameter INIT = 16'h0000;
  parameter CONF = "#OFF";

  input I0, I1, I2, I3;

  output O;

  reg O;

	initial
		O=INIT[0];

 		
  always @(  I3 or  I2 or  I1 or  I0 )  begin
  casex({I3, I2, I1, I0})
  	4'b0000: O=INIT[0];
  	4'b0001: O=INIT[1];
  	4'b0010: O=INIT[2];
  	4'b0011: O=INIT[3];
  	4'b0100: O=INIT[4];
  	4'b0101: O=INIT[5];
  	4'b0110: O=INIT[6];
  	4'b0111: O=INIT[7];
  	4'b1000: O=INIT[8];
  	4'b1001: O=INIT[9];
  	4'b1010: O=INIT[10];
  	4'b1011: O=INIT[11];
  	4'b1100: O=INIT[12];
  	4'b1101: O=INIT[13];
  	4'b1110: O=INIT[14];
  	4'b1111: O=INIT[15];   
  	default: O=1'bz;
  	endcase
end

endmodule
//Generated by generate_verilog.pl
//Sun Jun 13 17:37:03 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	NOUSE();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	OCEMUX();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	OCKINV();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	OFF();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	OFFATTRBOX();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	OINITMUX();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	OMUX();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	OUTMUX();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	PULL();
parameter	CONF = "#OFF";

endmodule/*
REVUSED.v
a one-input mux
Mike Zou <zxhmike@gmail.com>
*/
module REVUSED(out,_0);
	output reg out;
	input _0;
	parameter CONF="#OFF";
	
	always @ (_0)
		case (CONF)
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule

`timescale 1 ns/1 ns

module RSTAMUX (RSTA_B, RSTA, _1, _0, out );

    input RSTA_B, RSTA, _1, _0;
    output reg out;
    parameter CONF="#OFF";
	
	always @ (RSTA_B or RSTA or _1 or _0)
		case (CONF)
			"RSTA_B": out=~RSTA;
			"RSTA": out=RSTA;
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule



`timescale 1 ns/1 ns

module RSTBMUX (RSTB_B, RSTB, _1, _0, out );

    input RSTB_B, RSTB, _1, _0;
    output reg out;
    parameter CONF="#OFF";
	
	always @ (RSTB_B or RSTB or _1 or _0)
		case (CONF)
			"RSTB_B": out=~RSTB;
			"RSTB": out=RSTB;
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule


//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	SLEW();
parameter	CONF = "#OFF";

endmodule/*
slice.v
Mike Zou <zxhmike@gmail.com>
This is a slice in FPGA.
*/
/*
`include "SRFFMUX.v"
`include "CYSELF.v"
`include "BYMUX.v"
`include "FFX.v"
`include "CYSELG.v"
`include "F5USED.v"
`include "CYINIT.v"
`include "DGEN.v"
`include "XORF.v"
`include "GAND.v"
`include "CKINV.v"
`include "WSGEN.v"
`include "CY0G.v"
`include "G.v"
`include "GYMUX.v"
`include "XUSED.v"
`include "F.v"
`include "SRMUX.v"
`include "F5MUX.v"
`include "YUSED.v"
`include "DXMUX.v"
`include "XORG.v"
`include "COUTUSED.v"
`include "XBUSED.v"
`include "FFY.v"
`include "REVUSED.v"
`include "FAND.v"
`include "CY0F.v"
`include "CYMUXG.v"
`include "DYMUX.v"
`include "YBMUX.v"
`include "F6MUX.v"
`include "BXMUX.v"
`include "FXMUX.v"
`include "CEMUX.v"
`include "CYMUXF.v"
*/
module SLICE(	COUT,
							YB,
							Y,
							YQ,
							XB,
							F5,
							X,
							XQ,
							G4,
							G3,
							G2,
							G1,
							BY,
							F5IN,
							F4,
							F3,
							F2,
							F1,
							BX,
							CE,
							CLK,
							SR,
							CIN
);      

		input 	G4;
		input 	G3;
		input 	G2;
		input 	G1;
		input 	BY;
		input 	F5IN;
		input 	F4;
		input 	F3;
		input 	F2;
		input 	F1;
		input 	BX;
		input 	CE;
		input 	CLK;
		input 	SR;
		input 	CIN;
		
		output 	YB;
		output 	COUT;
		output 	Y;
		output 	YQ;
		output 	XB;
		output 	F5;
		output 	X;
		output 	XQ;
		
		wire 		net_BYMUX_out_YBMUX__0_DYMUX__0_DGEN_BY_F6MUX_in1_REVUSED__0;
		wire 		net_BXMUX_out_DGEN_BX_WSGEN_A5_F5MUX_NO_NAME_CYINIT_BX_DXMUX__0;
		wire 		net_CEMUX_out_FFX_CE_FFY_CE;
		wire 		net_CKINV_out_WSGEN_XK_FFX_CK_FFY_CK;
		wire 		net_SRMUX_out_WSGEN_WE_SRFFMUX__0;
		wire 		net_G_D_CYSELG_G_XORG_in1_F5MUX_G_GYMUX_G;
		wire 		net_GAND_out_CY0G_PROD;
		wire 		net_DGEN_DG_G_DI;
		wire 		net_DGEN_DF_F_DI;
		wire 		net_WSGEN_WSG_G_WS;
		wire 		net_WSGEN_WSF_F_WS;
		wire 		net_F_D_FAND_IN1_CYSELF_F_F5MUX_F_XORF_IN1_FXMUX_F;
		wire 		net_FAND_out_CY0F_PROD;
		wire 		net_CYSELG_out_CYMUXG_S0;
		wire 		net_CY0G_out_CYMUXG__0;
		wire 		net_CYSELF_out_CYMUXF_S0;
		wire 		net_CYINIT_out_CYMUXF__1_XORF_IN0;
		wire 		net_CY0F_out_CYMUXF__0;
		wire 		net_CYMUXG_out_COUTUSED__0_YBMUX__1;
		wire 		net_XORG_out_GYMUX_GXOR;
		wire 		net_F5MUX_out_F6MUX__1_FXMUX_F5_F5USED__0;
		wire 		net_CYMUXF_out_XBUSED__0_XORG_IN_CYMUXG__1;
		wire 		net_XORF_out_FXMUX_FXOR;
		wire 		net_GYMUX_out_YUSED__0_DYMUX__1;
		wire 		net_F6MUX_out_GYMUX_F6;
		wire 		net_FXMUX_out_XUSED__0_DXMUX__1;		
		wire 		net_DYMUX_out_FFY_D;
		wire 		net_REVUSED_out_FFY_REV_FFX_REV;
		wire 		net_DXMUX_out_FFX_D;
		wire 		net_SRFFMUX_out_FFY_INIT_FFX_INIT;
		
		SRFFMUX srffmux(
		                    .out(net_SRFFMUX_out_FFY_INIT_FFX_INIT),
		                    ._0(net_SRMUX_out_WSGEN_WE_SRFFMUX__0)
		);
		
		CYSELF cyself(
		                    .out(net_CYSELF_out_CYMUXF_S0),
		                    ._1(1),
		                    .F(net_F_D_FAND_IN1_CYSELF_F_F5MUX_F_XORF_IN1_FXMUX_F)
		);
		
		BYMUX bymux(
		                    .out(net_BYMUX_out_YBMUX__0_DYMUX__0_DGEN_BY_F6MUX_in1_REVUSED__0),
		                    .BY_B(BY),
		                    .BY(BY),
		                    ._1(1),
		                    ._0(0)
		);
		
		FFXY ffx(
		                    .Q(XQ),
		                    .D(net_DXMUX_out_FFX_D),
		                    .CE(net_CEMUX_out_FFX_CE_FFY_CE),
		                    .CK(net_CKINV_out_WSGEN_XK_FFX_CK_FFY_CK),
		                    .INIT(net_SRFFMUX_out_FFY_INIT_FFX_INIT),
		                    .REV(net_REVUSED_out_FFY_REV_FFX_REV)
		);
		
		CYSELG cyselg(
		                    .out(net_CYSELG_out_CYMUXG_S0),
		                    ._1(1),
		                    .G(net_G_D_CYSELG_G_XORG_in1_F5MUX_G_GYMUX_G)
		);
		
		F5USED f5used(
		                    .out(F5),
		                    ._0(net_F5MUX_out_F6MUX__1_FXMUX_F5_F5USED__0)
		);
		
		CYINIT cyinit(
		                    .out(net_CYINIT_out_CYMUXF__1_XORF_IN0),
		                    .BX(net_BXMUX_out_DGEN_BX_WSGEN_A5_F5MUX_NO_NAME_CYINIT_BX_DXMUX__0),
		                    .CIN(CIN)
		);
		
		/*
		DGEN dgen(
		                    .DG(net_DGEN_DG_G_DI),
		                    .BY(net_BYMUX_out_YBMUX__0_DYMUX__0_DGEN_BY_F6MUX_in1_REVUSED__0),
		                    .BX(net_BXMUX_out_DGEN_BX_WSGEN_A5_F5MUX_NO_NAME_CYINIT_BX_DXMUX__0),
		                    .DF(net_DGEN_DF_F_DI)
		);
		*/
		
		XORF xorf(
		                    .out(net_XORF_out_FXMUX_FXOR),
		                    .IN0(net_CYINIT_out_CYMUXF__1_XORF_IN0),
		                    .IN1(net_F_D_FAND_IN1_CYSELF_F_F5MUX_F_XORF_IN1_FXMUX_F)
		);
		
		GAND gand(
		                    .out(net_GAND_out_CY0G_PROD),
		                    .IN0(G2),
		                    .IN1(G1)
		);
		
		CKINV ckinv(
		                    .out(net_CKINV_out_WSGEN_XK_FFX_CK_FFY_CK),
		                    ._1(CLK),
		                    ._0(CLK)
		);
		
		/*
		WSGEN wsgen(
		                    .WSG(net_WSGEN_WSG_G_WS),
		                    .A5(net_BXMUX_out_DGEN_BX_WSGEN_A5_F5MUX_NO_NAME_CYINIT_BX_DXMUX__0),
		                    .WE(net_SRMUX_out_WSGEN_WE_SRFFMUX__0),
		                    .XK(net_CKINV_out_WSGEN_XK_FFX_CK_FFY_CK),
		                    .WSF(net_WSGEN_WSF_F_WS)
		);
		*/
		
		CY0G cy0g(
		                    .out(net_CY0G_out_CYMUXG__0),
		                    .PROD(net_GAND_out_CY0G_PROD),
		                    .G1(G1),
		                    ._1(1),
		                    ._0(0)
		);
		
		LUT g(
		                    .O(net_G_D_CYSELG_G_XORG_in1_F5MUX_G_GYMUX_G),
		                    .I3(G4),
		                    .I2(G3),
		                    .I1(G2),
		                    .I0(G1)//,
		//                    .WS(net_WSGEN_WSG_G_WS),
		//                    .DI(net_DGEN_DG_G_DI)
		);
		
		GYMUX gymux(
		                    .out(net_GYMUX_out_YUSED__0_DYMUX__1),
		                    .F6(net_F6MUX_out_GYMUX_F6),
		                    .GXOR(net_XORG_out_GYMUX_GXOR),
		                    .G(net_G_D_CYSELG_G_XORG_in1_F5MUX_G_GYMUX_G)
		);
		
		XUSED xused(
		                    .out(X),
		                    ._0(net_FXMUX_out_XUSED__0_DXMUX__1)
		);
		
		LUT f(
		                    .O(net_F_D_FAND_IN1_CYSELF_F_F5MUX_F_XORF_IN1_FXMUX_F),
		                    .I3(F4),
		                    .I2(F3),
		                    .I1(F2),
		                    .I0(F1)//,
		//                    .WS(net_WSGEN_WSF_F_WS),
		//                    .DI(net_DGEN_DF_F_DI)
		);
		
		SRMUX srmux(
		                    .out(net_SRMUX_out_WSGEN_WE_SRFFMUX__0),
		                    .SR_B(SR),
		                    .SR(SR),
		                    ._1(1),
		                    ._0(0)
		);
		
		F5MUX f5mux(
		                    .out(net_F5MUX_out_F6MUX__1_FXMUX_F5_F5USED__0),
		                    .F(net_F_D_FAND_IN1_CYSELF_F_F5MUX_F_XORF_IN1_FXMUX_F),
		                    .G(net_G_D_CYSELG_G_XORG_in1_F5MUX_G_GYMUX_G),
		                    .NO_NAME(net_BXMUX_out_DGEN_BX_WSGEN_A5_F5MUX_NO_NAME_CYINIT_BX_DXMUX__0)
		);
		
		YUSED yused(
		                    .out(Y),
		                    ._0(net_GYMUX_out_YUSED__0_DYMUX__1)
		);
		
		DXMUX dxmux(
		                    .out(net_DXMUX_out_FFX_D),
		                    ._1(net_FXMUX_out_XUSED__0_DXMUX__1),
		                    ._0(net_BXMUX_out_DGEN_BX_WSGEN_A5_F5MUX_NO_NAME_CYINIT_BX_DXMUX__0)
		);
		
		XORG xorg(
		                    .out(net_XORG_out_GYMUX_GXOR),
		                    .IN(net_CYMUXF_out_XBUSED__0_XORG_IN_CYMUXG__1),
		                    .in1(net_G_D_CYSELG_G_XORG_in1_F5MUX_G_GYMUX_G)
		);
		
		COUTUSED coutused(
		                    .out(COUT),
		                    ._0(net_CYMUXG_out_COUTUSED__0_YBMUX__1)
		);
		
		XBUSED xbused(
		                    .out(XB),
		                    ._0(net_CYMUXF_out_XBUSED__0_XORG_IN_CYMUXG__1)
		);
		
		FFXY ffy(
		                    .Q(YQ),
		                    .D(net_DYMUX_out_FFY_D),
		                    .CE(net_CEMUX_out_FFX_CE_FFY_CE),
		                    .CK(net_CKINV_out_WSGEN_XK_FFX_CK_FFY_CK),
		                    .INIT(net_SRFFMUX_out_FFY_INIT_FFX_INIT),
		                    .REV(net_REVUSED_out_FFY_REV_FFX_REV)
		);
		
		REVUSED revused(
		                    .out(net_REVUSED_out_FFY_REV_FFX_REV),
		                    ._0(net_BYMUX_out_YBMUX__0_DYMUX__0_DGEN_BY_F6MUX_in1_REVUSED__0)
		);
		
		FAND fand(
		                    .out(net_FAND_out_CY0F_PROD),
		                    .INO(F2),
		                    .IN1(net_F_D_FAND_IN1_CYSELF_F_F5MUX_F_XORF_IN1_FXMUX_F)
		);
		
		CY0F cy0f(
		                    .out(net_CY0F_out_CYMUXF__0),
		                    .PROD(net_FAND_out_CY0F_PROD),
		                    .F1(F1),
		                    ._1(1),
		                    ._0(0)
		);
		
		CYMUX cymuxg(
		                    .out(net_CYMUXG_out_COUTUSED__0_YBMUX__1),
		                    ._0(net_CY0G_out_CYMUXG__0),
		                    ._1(net_CYMUXF_out_XBUSED__0_XORG_IN_CYMUXG__1),
		                    .S0(net_CYSELG_out_CYMUXG_S0)
		);
		
		DYMUX dymux(
		                    .out(net_DYMUX_out_FFY_D),
		                    ._1(net_GYMUX_out_YUSED__0_DYMUX__1),
		                    ._0(net_BYMUX_out_YBMUX__0_DYMUX__0_DGEN_BY_F6MUX_in1_REVUSED__0)
		);
		
		YBMUX ybmux(
		                    .out(YB),
		                    ._1(net_CYMUXG_out_COUTUSED__0_YBMUX__1),
		                    ._0(net_BYMUX_out_YBMUX__0_DYMUX__0_DGEN_BY_F6MUX_in1_REVUSED__0)
		);
		
		F6MUX f6mux(
		                    .out(net_F6MUX_out_GYMUX_F6),
		                    ._1(net_F5MUX_out_F6MUX__1_FXMUX_F5_F5USED__0),
		                    .in1(net_BYMUX_out_YBMUX__0_DYMUX__0_DGEN_BY_F6MUX_in1_REVUSED__0)
		);
		
		BXMUX bxmux(
		                    .out(net_BXMUX_out_DGEN_BX_WSGEN_A5_F5MUX_NO_NAME_CYINIT_BX_DXMUX__0),
		                    .BX_B(BX),
		                    .BX(BX),
		                    ._1(1),
		                    ._0(0)
		);
		
		FXMUX fxmux(
		                    .out(net_FXMUX_out_XUSED__0_DXMUX__1),
		                    .F5(net_F5MUX_out_F6MUX__1_FXMUX_F5_F5USED__0),
		                    .FXOR(net_XORF_out_FXMUX_FXOR),
		                    .F(net_F_D_FAND_IN1_CYSELF_F_F5MUX_F_XORF_IN1_FXMUX_F)
		);
		
		CEMUX cemux(
		                    .out(net_CEMUX_out_FFX_CE_FFY_CE),
		                    .CE_B(CE),
		                    .CE(CE),
		                    ._1(1),
		                    ._0(0)
		);
		
		CYMUX cymuxf(
		                    .out(net_CYMUXF_out_XBUSED__0_XORG_IN_CYMUXG__1),
		                    ._0(net_CY0F_out_CYMUXF__0),
		                    ._1(net_CYINIT_out_CYMUXF__1_XORF_IN0),
		                    .S0(net_CYSELF_out_CYMUXF_S0)
		);
		
		
		NOUSE 	ffxy 		();
		NOUSE 	initx 	();
		NOUSE 	inity 	();
		NOUSE 	initxy 	();
		NOUSE 	ramconfig 	();
		NOUSE 	sync_attr 	();
		

endmodule
/*
SRFFMUX.v
a one-input mux
Mike Zou <zxhmike@gmail.com>
*/
module SRFFMUX(out,_0);
	output reg out;
	input _0;
	parameter CONF="#OFF";
	
	always @ (_0)
		case (CONF)
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
SRMUX.module
a four-input mux
Mike Zou <zxhmike@gmail.com>
*/
module SRMUX(out,SR_B,SR,_1,_0);
	output reg out;
	input SR_B,SR,_1,_0;
	parameter CONF="#OFF";
	
	always @ (SR_B or SR or _1 or _0)
		case (CONF)
			"SR_B": out=~SR;
			"SR": out=SR;
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	TCEMUX();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	TCKINV();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	TFF();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	TFFATTRBOX();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	TINITMUX();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	TRIMUX();
parameter	CONF = "#OFF";

endmodule//Generated by generate_verilog.pl
//Sun Jun 13 17:32:16 2010
//Design by Zuozhou Zhang
//Email: makeboats@gmail.com

`timescale 1 ns/1 ns

module	TSEL();
parameter	CONF = "#OFF";

endmodule
`timescale 1 ns/1 ns

module WEAMUX (WEA_B, WEA, _1, _0, out );

    input WEA_B, WEA, _1, _0;
    output reg out;
    parameter CONF="#OFF";
	
	always @ (WEA_B or WEA or _1 or _0)
		case (CONF)
			"WEA_B": out=~WEA;
			"WEA": out=WEA;
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule



`timescale 1 ns/1 ns

module WEBMUX (WEB_B, WEB, _1, _0, out );

    input WEB_B, WEB, _1, _0;
    output reg out;
    parameter CONF="#OFF";
	
	always @ (WEB_B or WEB or _1 or _0)
		case (CONF)
			"WEB_B": out=~WEB;
			"WEB": out=WEB;
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule


/*
WSGEN.module
a wsgen in slice
Mike Zou <zxhmike@gmail.com>
*/
module WSGEN(WSG,A5,WE,XK,WSF);
	parameter CONF="#OFF";
	output WSG;
	input A5,WE,XK,WSF;
	//The following line is only used for test slice
	assign WSG=(CONF=="#OFF")?1'bz:A5;
endmodule
/*
XBUSED.v
a one-input mux
Mike Zou <zxhmike@gmail.com>
*/
module XBUSED(out,_0);
	output reg out;
	input _0;
	parameter CONF="#OFF";
	
	always @ (_0)
		case (CONF)
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
XORF.v
Mike Zou <zxhmike@gmail.com>
a XOR gate
*/
module XORF(out,IN0,IN1);
	output out;
	input IN0,IN1;
	assign out=IN0^IN1;
endmodule
/*
XORG.v
Mike Zou <zxhmike@gmail.com>
a XOR gate
*/
module XORG(out,IN,in1);
	output out;
	input IN,in1;
	assign out=IN^in1;
endmodule
/*
XUSED.v
a one-input mux
Mike Zou <zxhmike@gmail.com>
*/
module XUSED(out,_0);
	output reg out;
	input _0;
	parameter CONF="#OFF";

	always @ (_0)
		case (CONF)
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
	
endmodule
/*
YBMUX.v
a two-input mux
Mike Zou <zxhmike@gmail.com>
*/
module YBMUX(out,_1,_0);
	output reg out;
	input _1,_0;
	parameter CONF="#OFF";
	
	always @ (_1 or _0)
		case (CONF)
			"1": out=_1;
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule
/*
YUSED.v
a one-input mux
Mike Zou <zxhmike@gmail.com>
*/
module YUSED(out,_0);
	output reg out;
	input _0;
	parameter CONF="#OFF";
	
	always @ (_0)
		case (CONF)
			"0": out=_0;
			"#OFF":out=1'bz;
			default:out=1'bx;
		endcase
endmodule


module SPS6B3X4H1(
IN4, IN5, IN0, IN1, IN2, IN3, OUT, _1
);
		input IN4, IN5, IN0, IN1, IN2, IN3, _1;
		output reg OUT;
		parameter CONF = "010";

		always @ (IN4 or IN5 or IN0 or IN1 or IN2 or IN3 or _1)
			case (CONF) 
				"111" : OUT = IN0 ;
				"110" : OUT = IN1 ;
				"101" : OUT = IN2 ;
				"100" : OUT = IN3 ;
				"011" : OUT = IN4 ;
				"010" : OUT = IN5 ;
				"010" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

/*wrong
module REG6B5X1H1(
CK, GSR, E, D, SR, Q, BY, _1
);
		parameter CONF = "11111";

		always @ ()
			case (CONF) 
				"11111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule
*/

module SPS2T2X7H1(
IN0, IN1, OUT, _1
);
		input IN0, IN1, _1;
		output reg OUT;
		parameter CONF = "11";

		always @ (IN0 or IN1 or _1)
			case (CONF) 
				"00" : OUT = IN0 ;
				"01" : OUT = IN1 ;
				"11" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS16T10X11H2(
IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN14, IN11, IN12, IN13, IN10, OUT, _1
);
		input IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN14, IN11, IN12, IN13, IN10, _1;
		output reg OUT;
		parameter CONF = "1111111111";

		always @ (IN15 or IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN14 or IN11 or IN12 or IN13 or IN10 or _1)
			case (CONF) 
				"0011111110" : OUT = IN0 ;
				"0011111101" : OUT = IN1 ;
				"0011111011" : OUT = IN2 ;
				"0011110111" : OUT = IN3 ;
				"0011101111" : OUT = IN4 ;
				"0011011111" : OUT = IN5 ;
				"0010111111" : OUT = IN6 ;
				"0001111111" : OUT = IN7 ;
				"0111111110" : OUT = IN8 ;
				"0111111101" : OUT = IN9 ;
				"0111111011" : OUT = IN10 ;
				"0111110111" : OUT = IN11 ;
				"0111101111" : OUT = IN12 ;
				"0111011111" : OUT = IN13 ;
				"0110111111" : OUT = IN14 ;
				"0101111111" : OUT = IN15 ;
				"1111111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS16T10X11H1(
IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN14, IN11, IN12, IN13, IN10, OUT, _1
);
		input IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN14, IN11, IN12, IN13, IN10, _1;
		output reg OUT;
		parameter CONF = "1111111111";

		always @ (IN15 or IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN14 or IN11 or IN12 or IN13 or IN10 or _1)
			case (CONF) 
				"0111111110" : OUT = IN0 ;
				"0111111101" : OUT = IN1 ;
				"0111111011" : OUT = IN2 ;
				"0111110111" : OUT = IN3 ;
				"0111101111" : OUT = IN4 ;
				"0111011111" : OUT = IN5 ;
				"0110111111" : OUT = IN6 ;
				"0101111111" : OUT = IN7 ;
				"0011111110" : OUT = IN8 ;
				"0011111101" : OUT = IN9 ;
				"0011111011" : OUT = IN10 ;
				"0011110111" : OUT = IN11 ;
				"0011101111" : OUT = IN12 ;
				"0011011111" : OUT = IN13 ;
				"0010111111" : OUT = IN14 ;
				"0001111111" : OUT = IN15 ;
				"1111111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

/*wrong
module CAPTURE1B0X1H1(
CAPTURE
);

endmodule
*/

module SPBU1AND1X10H1(
OUT, IN
);
		input IN;
		output reg OUT;
		parameter CONF = "1";

		always @ (IN)
			case (CONF) 
				"0" : OUT = IN ;
				"1" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPBU1NAND1X35H1(
OUT, IN
);
		input IN;
		output reg OUT;
		parameter CONF = "1";

		always @ (IN)
			case (CONF) 
				"0" : OUT = IN ;
				"1" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS28N6X0H2(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, OUT, IN23, IN22, IN21, IN20, IN27, IN26, IN25, IN24, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, IN23, IN22, IN21, IN20, IN27, IN26, IN25, IN24, _1;
		output reg OUT;
		parameter CONF = "111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN18 or IN19 or IN16 or IN17 or IN14 or IN15 or IN12 or IN13 or IN10 or IN11 or IN23 or IN22 or IN21 or IN20 or IN27 or IN26 or IN25 or IN24 or _1)
			case (CONF) 
				"000111" : OUT = IN0 ;
				"001000" : OUT = IN1 ;
				"001011" : OUT = IN2 ;
				"001101" : OUT = IN3 ;
				"001111" : OUT = IN4 ;
				"001100" : OUT = IN5 ;
				"001010" : OUT = IN6 ;
				"010000" : OUT = IN7 ;
				"010011" : OUT = IN8 ;
				"010101" : OUT = IN9 ;
				"010111" : OUT = IN10 ;
				"010100" : OUT = IN11 ;
				"010010" : OUT = IN12 ;
				"011000" : OUT = IN13 ;
				"011011" : OUT = IN14 ;
				"011101" : OUT = IN15 ;
				"011111" : OUT = IN16 ;
				"011100" : OUT = IN17 ;
				"011010" : OUT = IN18 ;
				"100000" : OUT = IN19 ;
				"100011" : OUT = IN20 ;
				"100101" : OUT = IN21 ;
				"100111" : OUT = IN22 ;
				"100100" : OUT = IN23 ;
				"100010" : OUT = IN24 ;
				"101111" : OUT = IN25 ;
				"110111" : OUT = IN26 ;
				"111111" : OUT = IN27 ;
				"111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS28B11X11H1(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, OUT, IN23, IN22, IN21, IN20, IN27, IN26, IN25, IN24, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, IN23, IN22, IN21, IN20, IN27, IN26, IN25, IN24, _1;
		output reg OUT;
		parameter CONF = "11111111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN18 or IN19 or IN16 or IN17 or IN14 or IN15 or IN12 or IN13 or IN10 or IN11 or IN23 or IN22 or IN21 or IN20 or IN27 or IN26 or IN25 or IN24 or _1)
			case (CONF) 
				"11101111110" : OUT = IN0 ;
				"11101111101" : OUT = IN1 ;
				"11101111011" : OUT = IN2 ;
				"11101110111" : OUT = IN3 ;
				"11101101111" : OUT = IN4 ;
				"11101011111" : OUT = IN5 ;
				"11100111111" : OUT = IN6 ;
				"11011111110" : OUT = IN7 ;
				"11011111101" : OUT = IN8 ;
				"11011111011" : OUT = IN9 ;
				"11011110111" : OUT = IN10 ;
				"11011101111" : OUT = IN11 ;
				"11011011111" : OUT = IN12 ;
				"11010111111" : OUT = IN13 ;
				"10111111110" : OUT = IN14 ;
				"10111111101" : OUT = IN15 ;
				"10111111011" : OUT = IN16 ;
				"10111110111" : OUT = IN17 ;
				"10111101111" : OUT = IN18 ;
				"10111011111" : OUT = IN19 ;
				"10110111111" : OUT = IN20 ;
				"01111111110" : OUT = IN21 ;
				"01111111101" : OUT = IN22 ;
				"01111111011" : OUT = IN23 ;
				"01111110111" : OUT = IN24 ;
				"01111101111" : OUT = IN25 ;
				"01111011111" : OUT = IN26 ;
				"01110111111" : OUT = IN27 ;
				"11111111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS6B3X11H1(
IN4, IN5, IN0, IN1, IN2, IN3, OUT, _1
);
		input IN4, IN5, IN0, IN1, IN2, IN3, _1;
		output reg OUT;
		parameter CONF = "111";

		always @ (IN4 or IN5 or IN0 or IN1 or IN2 or IN3 or _1)
			case (CONF) 
				"000" : OUT = IN0 ;
				"001" : OUT = IN1 ;
				"010" : OUT = IN2 ;
				"011" : OUT = IN3 ;
				"100" : OUT = IN4 ;
				"101" : OUT = IN5 ;
				"111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS2B1X1H1(
A, Y, B, _1
);
		input A, B, _1;
		output reg Y;
		parameter CONF = "0";

		always @ (A or B or _1)
			case (CONF) 
				"0" : Y = A ;
				"1" : Y = B ;
				"0" : Y = 1'bz ;
				default : Y = 1'bx ;
			endcase
endmodule

module TRIBUF1T0X10H1(
OUT, ENn, IN, _1
);
		input ENn, IN, _1;
		output  OUT;

		assign	OUT = ENn? IN : 1'bz ;
				
endmodule

module SPS13B6X6H1(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN11, IN12, IN10, OUT, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN11, IN12, IN10, _1;
		output reg OUT;
		parameter CONF = "111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN11 or IN12 or IN10 or _1)
			case (CONF) 
				"000111" : OUT = IN0 ;
				"001011" : OUT = IN1 ;
				"001101" : OUT = IN2 ;
				"001110" : OUT = IN3 ;
				"010111" : OUT = IN4 ;
				"011011" : OUT = IN5 ;
				"011101" : OUT = IN6 ;
				"011110" : OUT = IN7 ;
				"100111" : OUT = IN8 ;
				"101011" : OUT = IN9 ;
				"101101" : OUT = IN10 ;
				"101110" : OUT = IN11 ;
				"111111" : OUT = IN12 ;
				"111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS6T4X11H1(
IN4, IN5, IN0, IN1, IN2, IN3, OUT, _1
);
		input IN4, IN5, IN0, IN1, IN2, IN3, _1;
		output reg OUT;
		parameter CONF = "1111";

		always @ (IN4 or IN5 or IN0 or IN1 or IN2 or IN3 or _1)
			case (CONF) 
				"0000" : OUT = IN0 ;
				"0001" : OUT = IN1 ;
				"0010" : OUT = IN2 ;
				"0011" : OUT = IN3 ;
				"0100" : OUT = IN4 ;
				"0101" : OUT = IN5 ;
				"1111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module BUF1B0X4H1(
A, Y
);
		input A;
		output Y;

		assign	Y = A ;
endmodule

module BUF1B0X4H2(
OUT, IN
);
		input IN;
		output OUT;

		assign	OUT = IN ;
endmodule

/*wrong
module DMUX16N0X0H1(
O15, O14, O13, O12, O11, O10, I, A1, A3, A2, A4, O9, O8, O7, O6, O5, O4, O3, O2, O1, O0, _1
);
		input I, A1, A3, A2, A4, _1;
		output reg O15, O14, O13, O12, O11, O10, O9, O8, O7, O6, O5, O4, O3, O2, O1, O0;

		assign	O15 = I ;
				odd : O15 = A4 ;
				odd : O15 = A3 ;
				odd : O15 = A2 ;
				odd : O15 = A1 ;
		assign	O14 = I ;
				odd : O14 = A4 ;
				odd : O14 = A3 ;
				odd : O14 = A2 ;
				odd : O14 = A1 ;
		assign	O13 = I ;
				odd : O13 = A4 ;
				odd : O13 = A3 ;
				odd : O13 = A2 ;
				odd : O13 = A1 ;
		assign	O12 = I ;
				odd : O12 = A4 ;
				odd : O12 = A3 ;
				odd : O12 = A2 ;
				odd : O12 = A1 ;
		assign	O11 = I ;
				odd : O11 = A4 ;
				odd : O11 = A3 ;
				odd : O11 = A2 ;
				odd : O11 = A1 ;
		assign	O10 = I ;
				odd : O10 = A4 ;
				odd : O10 = A3 ;
				odd : O10 = A2 ;
				odd : O10 = A1 ;
		assign	O9 = I ;
				odd : O9 = A4 ;
				odd : O9 = A3 ;
				odd : O9 = A2 ;
				odd : O9 = A1 ;
		assign	O8 = I ;
				odd : O8 = A4 ;
				odd : O8 = A3 ;
				odd : O8 = A2 ;
				odd : O8 = A1 ;
		assign	O7 = I ;
				odd : O7 = A4 ;
				odd : O7 = A3 ;
				odd : O7 = A2 ;
				odd : O7 = A1 ;
		assign	O6 = I ;
				odd : O6 = A4 ;
				odd : O6 = A3 ;
				odd : O6 = A2 ;
				odd : O6 = A1 ;
		assign	O5 = I ;
				odd : O5 = A4 ;
				odd : O5 = A3 ;
				odd : O5 = A2 ;
				odd : O5 = A1 ;
		assign	O4 = I ;
				odd : O4 = A4 ;
				odd : O4 = A3 ;
				odd : O4 = A2 ;
				odd : O4 = A1 ;
		assign	O3 = I ;
				odd : O3 = A4 ;
				odd : O3 = A3 ;
				odd : O3 = A2 ;
				odd : O3 = A1 ;
		assign	O2 = I ;
				odd : O2 = A4 ;
				odd : O2 = A3 ;
				odd : O2 = A2 ;
				odd : O2 = A1 ;
		assign	O1 = I ;
				odd : O1 = A4 ;
				odd : O1 = A3 ;
				odd : O1 = A2 ;
				odd : O1 = A1 ;
		assign	O0 = I ;
				odd : O0 = A4 ;
				odd : O0 = A3 ;
				odd : O0 = A2 ;
				odd : O0 = A1 ;
endmodule
*/

module TRIBUF1PBU8W0X1H1(
OUT, EN, IN, _1
);
		input EN, IN, _1;
		output OUT;

		assign	OUT = EN ? IN : 1'bz ;
endmodule

module AND2B0X2H1(
A, Y, B, _1
);
		input A, B, _1;
		output Y;

		assign	Y = A & B;
endmodule

module SPS12N4X0H1(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN11, IN10, OUT, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN11, IN10, _1;
		output reg OUT;
		parameter CONF = "1111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN11 or IN10 or _1)
			case (CONF) 
				"0000" : OUT = IN0 ;
				"0001" : OUT = IN1 ;
				"0010" : OUT = IN2 ;
				"0011" : OUT = IN3 ;
				"0100" : OUT = IN4 ;
				"0101" : OUT = IN5 ;
				"0110" : OUT = IN6 ;
				"0111" : OUT = IN7 ;
				"1000" : OUT = IN8 ;
				"1001" : OUT = IN9 ;
				"1010" : OUT = IN10 ;
				"1011" : OUT = IN11 ;
				"1111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS1N1X0H1(
OUT, IN , _1
);
		input IN, _1;
		output reg OUT;
		parameter CONF = "1";

		always @ (IN or _1)
			case (CONF) 
				"0" : OUT = IN ;
				"1" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS28N6X0H1(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, OUT, IN23, IN22, IN21, IN20, IN27, IN26, IN25, IN24, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, IN23, IN22, IN21, IN20, IN27, IN26, IN25, IN24, _1;
		output reg OUT;
		parameter CONF = "111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN18 or IN19 or IN16 or IN17 or IN14 or IN15 or IN12 or IN13 or IN10 or IN11 or IN23 or IN22 or IN21 or IN20 or IN27 or IN26 or IN25 or IN24 or _1)
			case (CONF) 
				"000111" : OUT = IN0 ;
				"001000" : OUT = IN1 ;
				"001011" : OUT = IN2 ;
				"001101" : OUT = IN3 ;
				"001111" : OUT = IN4 ;
				"001010" : OUT = IN5 ;
				"001100" : OUT = IN6 ;
				"010000" : OUT = IN7 ;
				"010011" : OUT = IN8 ;
				"010101" : OUT = IN9 ;
				"010111" : OUT = IN10 ;
				"010010" : OUT = IN11 ;
				"010100" : OUT = IN12 ;
				"011000" : OUT = IN13 ;
				"011011" : OUT = IN14 ;
				"011101" : OUT = IN15 ;
				"011111" : OUT = IN16 ;
				"011010" : OUT = IN17 ;
				"011100" : OUT = IN18 ;
				"100000" : OUT = IN19 ;
				"100011" : OUT = IN20 ;
				"100101" : OUT = IN21 ;
				"100111" : OUT = IN22 ;
				"100010" : OUT = IN23 ;
				"100100" : OUT = IN24 ;
				"101111" : OUT = IN25 ;
				"110111" : OUT = IN26 ;
				"111111" : OUT = IN27 ;
				"111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS2T2X7H2(
IN0, IN1, OUT, _1
);
		input IN0, IN1, _1;
		output reg OUT;
		parameter CONF = "11";

		always @ (IN0 or IN1 or _1)
			case (CONF) 
				"01" : OUT = IN0 ;
				"00" : OUT = IN1 ;
				"11" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS2N1X0H1(
IN0, IN1, OUT, _1
);
		input IN0, IN1, _1;
		output reg OUT;
		parameter CONF = "1";

		always @ (IN0 or IN1 or _1)
			case (CONF) 
				"0" : OUT = IN0 ;
				"1" : OUT = IN1 ;
				"1" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

/*wrong
module JTAG2B0X1H1(
TDO1, RESET, TDI, TDO2, SHIFT, UPDATE, DRCK1, DRCK2, SEL1, SEL2, _1
);

endmodule
*/

module BUF1B0X2H2(
OUT, IN
);
		input IN;
		output OUT;

		assign	OUT = IN ;
endmodule

module BUF1B0X2H3(
A, Y
);
		input A;
		output Y;

		assign	Y = A ;
endmodule

module BUF1B0X2H1(
OUT, IN
);
		input IN;
		output OUT;

		assign	OUT = IN ;
endmodule

module BUF1B0X2H4(
OUT, IN
);
		input IN;
		output OUT;

		assign	OUT = IN ;
endmodule

module BUF1B0X2H5(
A, Y
);
		input A;
		output Y;

		assign	Y = A ;
endmodule

module SPS22N7X0H1(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, OUT, IN21, IN20, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, IN21, IN20, _1;
		output reg OUT;
		parameter CONF = "111111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN18 or IN19 or IN16 or IN17 or IN14 or IN15 or IN12 or IN13 or IN10 or IN11 or IN21 or IN20 or _1)
			case (CONF) 
				"110001110" : OUT = IN0 ;
				"110001101" : OUT = IN1 ;
				"110001011" : OUT = IN2 ;
				"110000111" : OUT = IN3 ;
				"110011110" : OUT = IN4 ;
				"110011101" : OUT = IN5 ;
				"110011011" : OUT = IN6 ;
				"110010111" : OUT = IN7 ;
				"110101110" : OUT = IN8 ;
				"110101101" : OUT = IN9 ;
				"110101011" : OUT = IN10 ;
				"110100111" : OUT = IN11 ;
				"110111110" : OUT = IN12 ;
				"110111101" : OUT = IN13 ;
				"110111011" : OUT = IN14 ;
				"110110111" : OUT = IN15 ;
				"111111110" : OUT = IN16 ;
				"111111101" : OUT = IN17 ;
				"111111011" : OUT = IN18 ;
				"111110111" : OUT = IN19 ;
				"101111111" : OUT = IN20 ;
				"011111111" : OUT = IN21 ;
				"111111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

/*wrong
module RAM4096B28X1H1(
DIA8, DIA9, DIA6, DIA7, DIA4, DIA5, DIA2, DIA3, DIA0, DIA1, DIB6, WEB, WEA, ADDRA6, DOB1, CLKA, CLKB, ENA, ENB, DOB2, DOA8, DOA9, ADDRA0, ADDRA1, DIB1, DOB7, DOB6, RSTA, RSTB, DIB7, ADDRA5, ADDRB11, ADDRB10, DOB3, DIB4, DIA14, DIA15, DIA10, DIA11, DIA12, DIA13, DOA4, DOA5, DOA6, DOA7, DOA0, DOA1, DOA2, DOA3, DIB15, DIB14, DIB13, DIB12, DIB11, DIB10, DOB15, DOB14, DOB11, DOB10, DOB13, DOB12, ADDRA10, ADDRA11, ADDRB1, DOA14, DOA15, DOA12, DOA13, DOA10, DOA11, ADDRB5, ADDRB4, ADDRB7, ADDRB6, DIB3, ADDRB0, ADDRB3, ADDRB2, ADDRB9, ADDRB8, DIB2, DOB5, DOB4, ADDRA2, ADDRA3, ADDRA4, DOB0, DIB5, ADDRA7, ADDRA8, ADDRA9, DIB9, DIB8, DOB9, DOB8, DIB0, _1
);
		parameter CONF = "1111111110101111011110111111";

		always @ ()
			case (CONF) 
				"1111111110101111011110111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule
*/

/*wrong
module MUX1B1X4H1(
A, Y, CE, _1
);
		input A, CE, _1;
		output reg Y;
		parameter CONF = "1";

		always @ (A or CE or _1)
			case (CONF) 
				undefined : Y = A ;
				undefined : Y = CE ;
				"1" : Y = 1'bz ;
				default : Y = 1'bx ;
			endcase
endmodule
*/

module SPS2T2X11H1(
IN0, IN1, OUT, _1
);
		input IN0, IN1, _1;
		output reg OUT;
		parameter CONF = "11";

		always @ (IN0 or IN1 or _1)
			case (CONF) 
				"00" : OUT = IN0 ;
				"01" : OUT = IN1 ;
				"11" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS2T2X11H3(
IN0, IN1, OUT, _1
);
		input IN0, IN1, _1;
		output reg OUT;
		parameter CONF = "11";

		always @ (IN0 or IN1 or _1)
			case (CONF) 
				"00" : OUT = IN0 ;
				"01" : OUT = IN1 ;
				"11" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS2T2X11H2(
IN0, IN1, OUT, _1
);
		input IN0, IN1, _1;
		output reg OUT;
		parameter CONF = "11";

		always @ (IN0 or IN1 or _1)
			case (CONF) 
				"01" : OUT = IN0 ;
				"00" : OUT = IN1 ;
				"11" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module INV1B0X1H2(
A, Y
);
		input A;
		output Y;

		assign	Y = A ;
endmodule

module SPS2N2X0H1(
IN0, IN1, OUT, _1
);
		input IN0, IN1, _1;
		output reg OUT;
		parameter CONF = "11";

		always @ (IN0 or IN1 or _1)
			case (CONF) 
				"01" : OUT = IN0 ;
				"10" : OUT = IN1 ;
				"11" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS2N2X0H2(
IN0, IN1, OUT, _1
);
		input IN0, IN1, _1;
		output reg OUT;
		parameter CONF = "11";

		always @ (IN0 or IN1 or _1)
			case (CONF) 
				"10" : OUT = IN0 ;
				"01" : OUT = IN1 ;
				"11" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS24B10X11H1(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, OUT, IN23, IN22, IN21, IN20, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, IN23, IN22, IN21, IN20, _1;
		output reg OUT;
		parameter CONF = "1111111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN18 or IN19 or IN16 or IN17 or IN14 or IN15 or IN12 or IN13 or IN10 or IN11 or IN23 or IN22 or IN21 or IN20 or _1)
			case (CONF) 
				"1110111110" : OUT = IN0 ;
				"1110111101" : OUT = IN1 ;
				"1110111011" : OUT = IN2 ;
				"1110110111" : OUT = IN3 ;
				"1110101111" : OUT = IN4 ;
				"1110011111" : OUT = IN5 ;
				"1101111110" : OUT = IN6 ;
				"1101111101" : OUT = IN7 ;
				"1101111011" : OUT = IN8 ;
				"1101110111" : OUT = IN9 ;
				"1101101111" : OUT = IN10 ;
				"1101011111" : OUT = IN11 ;
				"1011111110" : OUT = IN12 ;
				"1011111101" : OUT = IN13 ;
				"1011111011" : OUT = IN14 ;
				"1011110111" : OUT = IN15 ;
				"1011101111" : OUT = IN16 ;
				"1011011111" : OUT = IN17 ;
				"0111111110" : OUT = IN18 ;
				"0111111101" : OUT = IN19 ;
				"0111111011" : OUT = IN20 ;
				"0111110111" : OUT = IN21 ;
				"0111101111" : OUT = IN22 ;
				"0111011111" : OUT = IN23 ;
				"1111111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS12B8X11H1(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN11, IN10, OUT, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN11, IN10, _1;
		output reg OUT;
		parameter CONF = "11111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN11 or IN10 or _1)
			case (CONF) 
				"10111110" : OUT = IN0 ;
				"10111101" : OUT = IN1 ;
				"10111011" : OUT = IN2 ;
				"10110111" : OUT = IN3 ;
				"10101111" : OUT = IN4 ;
				"10011111" : OUT = IN5 ;
				"01111110" : OUT = IN6 ;
				"01111101" : OUT = IN7 ;
				"01111011" : OUT = IN8 ;
				"01110111" : OUT = IN9 ;
				"01101111" : OUT = IN10 ;
				"01011111" : OUT = IN11 ;
				"11111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module BUF1PBU8W0X1H1(
OUT, IN
);
		input IN;
		output OUT;

		assign	OUT = IN ;
endmodule

module SPBU1OR2BB1X1H1(
OUT, IN
);
		input IN;
		output reg OUT;
		parameter CONF = "1";

		always @ (IN)
			case (CONF) 
				"0" : OUT = IN ;
				"1" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module INV1B0X2H1(
OUT, IN
);
		input IN;
		output OUT;

		assign	OUT = ~IN ;
endmodule

module INV1B0X2H2(
OUT, IN
);
		input IN;
		output OUT;

		assign	OUT = ~IN ;
endmodule

module TRIBUF1T1X7H1(
OUT, IN
);
		input IN;
		output reg OUT;
		parameter CONF = "1";

		always @ (IN)
			case (CONF) 
				"0" : OUT = IN ;
				"1" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS4T5X11H1(
IN3, IN0, IN1, IN2, OUT, _1
);
		input IN3, IN0, IN1, IN2, _1;
		output reg OUT;
		parameter CONF = "11111";

		always @ (IN3 or IN0 or IN1 or IN2 or _1)
			case (CONF) 
				"01110" : OUT = IN0 ;
				"01101" : OUT = IN1 ;
				"01011" : OUT = IN2 ;
				"00111" : OUT = IN3 ;
				"11111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS2B1X1H2(
IN0, IN1, OUT, _1
);
		input IN0, IN1, _1;
		output reg OUT;
		parameter CONF = "0";

		always @ (IN0 or IN1 or _1)
			case (CONF) 
				"0" : OUT = IN0 ;
				"1" : OUT = IN1 ;
				"0" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

/*wrong
module REG5B5X1H1(
CK, GSR, E, D, SR, Q, _1
);
		parameter CONF = "11100";

		always @ ()
			case (CONF) 
				"11100" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule
*/

module SPS8T6X11H1(
IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, OUT, _1
);
		input IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, _1;
		output reg OUT;
		parameter CONF = "111111";

		always @ (IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or _1)
			case (CONF) 
				"011110" : OUT = IN0 ;
				"011101" : OUT = IN1 ;
				"011011" : OUT = IN2 ;
				"010111" : OUT = IN3 ;
				"001110" : OUT = IN4 ;
				"001101" : OUT = IN5 ;
				"001011" : OUT = IN6 ;
				"000111" : OUT = IN7 ;
				"111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS3N3X0H1(
IN0, IN1, IN2, OUT, _1
);
		input IN0, IN1, IN2, _1;
		output reg OUT;
		parameter CONF = "111";

		always @ (IN0 or IN1 or IN2 or _1)
			case (CONF) 
				"110" : OUT = IN0 ;
				"101" : OUT = IN1 ;
				"011" : OUT = IN2 ;
				"111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS28B11X11H2(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, OUT, IN23, IN22, IN21, IN20, IN27, IN26, IN25, IN24, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, IN23, IN22, IN21, IN20, IN27, IN26, IN25, IN24, _1;
		output reg OUT;
		parameter CONF = "11111111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN18 or IN19 or IN16 or IN17 or IN14 or IN15 or IN12 or IN13 or IN10 or IN11 or IN23 or IN22 or IN21 or IN20 or IN27 or IN26 or IN25 or IN24 or _1)
			case (CONF) 
				"11101111110" : OUT = IN0 ;
				"11101111101" : OUT = IN1 ;
				"11101111011" : OUT = IN2 ;
				"11101110111" : OUT = IN3 ;
				"11101101111" : OUT = IN4 ;
				"11101011111" : OUT = IN5 ;
				"11100111111" : OUT = IN6 ;
				"11011111110" : OUT = IN7 ;
				"11011111101" : OUT = IN8 ;
				"11011111011" : OUT = IN9 ;
				"11011110111" : OUT = IN10 ;
				"11011101111" : OUT = IN11 ;
				"11011011111" : OUT = IN12 ;
				"11010111111" : OUT = IN13 ;
				"10111111110" : OUT = IN14 ;
				"10111111101" : OUT = IN15 ;
				"10111111011" : OUT = IN16 ;
				"10111110111" : OUT = IN17 ;
				"10111101111" : OUT = IN18 ;
				"10111011111" : OUT = IN19 ;
				"10110111111" : OUT = IN20 ;
				"01111111110" : OUT = IN21 ;
				"01111111101" : OUT = IN22 ;
				"01111111011" : OUT = IN23 ;
				"01111110111" : OUT = IN24 ;
				"01111101111" : OUT = IN25 ;
				"01111011111" : OUT = IN26 ;
				"01110111111" : OUT = IN27 ;
				"11111111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPBU1OR1X1H1(
OUT, IN
);
		input IN;
		output reg OUT;
		parameter CONF = "1";

		always @ (IN)
			case (CONF) 
				"0" : OUT = IN ;
				"1" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS28N9X0H1(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, OUT, IN23, IN22, IN21, IN20, IN27, IN26, IN25, IN24, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, IN23, IN22, IN21, IN20, IN27, IN26, IN25, IN24, _1;
		output reg OUT;
		parameter CONF = "111111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN18 or IN19 or IN16 or IN17 or IN14 or IN15 or IN12 or IN13 or IN10 or IN11 or IN23 or IN22 or IN21 or IN20 or IN27 or IN26 or IN25 or IN24 or _1)
			case (CONF) 
				"000111111" : OUT = IN0 ;
				"001111110" : OUT = IN1 ;
				"001111101" : OUT = IN2 ;
				"001111011" : OUT = IN3 ;
				"001110111" : OUT = IN4 ;
				"001101111" : OUT = IN5 ;
				"001011111" : OUT = IN6 ;
				"010111110" : OUT = IN7 ;
				"010111101" : OUT = IN8 ;
				"010111011" : OUT = IN9 ;
				"010110111" : OUT = IN10 ;
				"010101111" : OUT = IN11 ;
				"010011111" : OUT = IN12 ;
				"011111110" : OUT = IN13 ;
				"011111101" : OUT = IN14 ;
				"011111011" : OUT = IN15 ;
				"011110111" : OUT = IN16 ;
				"011101111" : OUT = IN17 ;
				"011011111" : OUT = IN18 ;
				"100111110" : OUT = IN19 ;
				"100111101" : OUT = IN20 ;
				"100111011" : OUT = IN21 ;
				"100110111" : OUT = IN22 ;
				"100101111" : OUT = IN23 ;
				"100011111" : OUT = IN24 ;
				"101111111" : OUT = IN25 ;
				"110111111" : OUT = IN26 ;
				"111111111" : OUT = IN27 ;
				"111111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS3N2X0H1(
IN0, IN1, IN2, OUT, _1
);
		input IN0, IN1, IN2, _1;
		output reg OUT;
		parameter CONF = "00";

		always @ (IN0 or IN1 or IN2 or _1)
			case (CONF) 
				"00" : OUT = IN0 ;
				"01" : OUT = IN1 ;
				"10" : OUT = IN2 ;
				"00" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS20N8X0H1(
IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN11, IN12, IN13, IN10, OUT, _1
);
		input IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN11, IN12, IN13, IN10, _1;
		output reg OUT;
		parameter CONF = "11111111";

		always @ (IN15 or IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN18 or IN19 or IN16 or IN17 or IN14 or IN11 or IN12 or IN13 or IN10 or _1)
			case (CONF) 
				"11011110" : OUT = IN0 ;
				"11011101" : OUT = IN1 ;
				"11011011" : OUT = IN2 ;
				"11010111" : OUT = IN3 ;
				"11001110" : OUT = IN4 ;
				"11001101" : OUT = IN5 ;
				"11001011" : OUT = IN6 ;
				"11000111" : OUT = IN7 ;
				"10111110" : OUT = IN8 ;
				"10111101" : OUT = IN9 ;
				"10111011" : OUT = IN10 ;
				"10110111" : OUT = IN11 ;
				"10101110" : OUT = IN12 ;
				"10101101" : OUT = IN13 ;
				"10101011" : OUT = IN14 ;
				"10100111" : OUT = IN15 ;
				"01111110" : OUT = IN16 ;
				"01111101" : OUT = IN17 ;
				"01111011" : OUT = IN18 ;
				"01110111" : OUT = IN19 ;
				"11111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS4B2X3H1(
IN3, IN0, IN1, IN2, OUT, _1
);
		input IN3, IN0, IN1, IN2, _1;
		output reg OUT;
		parameter CONF = "00";

		always @ (IN3 or IN0 or IN1 or IN2 or _1)
			case (CONF) 
				"00" : OUT = IN0 ;
				"01" : OUT = IN1 ;
				"10" : OUT = IN2 ;
				"11" : OUT = IN3 ;
				"00" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS12N7X0H2(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN11, IN10, OUT, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN11, IN10, _1;
		output reg OUT;
		parameter CONF = "1111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN11 or IN10 or _1)
			case (CONF) 
				"1101110" : OUT = IN0 ;
				"1101101" : OUT = IN1 ;
				"1101011" : OUT = IN2 ;
				"1100111" : OUT = IN3 ;
				"1011110" : OUT = IN4 ;
				"1011101" : OUT = IN5 ;
				"1011011" : OUT = IN6 ;
				"1010111" : OUT = IN7 ;
				"0110111" : OUT = IN8 ;
				"0111011" : OUT = IN9 ;
				"0111101" : OUT = IN10 ;
				"0111110" : OUT = IN11 ;
				"1111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS12N7X0H1(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN11, IN10, OUT, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN11, IN10, _1;
		output reg OUT;
		parameter CONF = "1111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN11 or IN10 or _1)
			case (CONF) 
				"1101110" : OUT = IN0 ;
				"1101101" : OUT = IN1 ;
				"1101011" : OUT = IN2 ;
				"1100111" : OUT = IN3 ;
				"1011110" : OUT = IN4 ;
				"1011101" : OUT = IN5 ;
				"1011011" : OUT = IN6 ;
				"1010111" : OUT = IN7 ;
				"0111110" : OUT = IN8 ;
				"0111101" : OUT = IN9 ;
				"0111011" : OUT = IN10 ;
				"0110111" : OUT = IN11 ;
				"1111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module INV1B0X35H1(
OUT, IN
);
		input IN;
		output OUT;

		assign	OUT = ~IN ;
endmodule

module AND2B0X1H1(
A, Y, B, _1
);
		input A, B, _1;
		output Y;

		assign	Y = A & B;

endmodule

/*wrong
module START1B0X1H1(
USERCLK
);

endmodule
*/

module XOR2B0X2H1(
A, Y, B, _1
);
		input A, B, _1;
		output Y;

		assign	Y = A | B ;
endmodule


module STUBX10H1(
INOUTB, INOUTA
);
		inout INOUTA;
		inout INOUTB;
		parameter CONF = "1";

		case (CONF) 
			"0" : assign INOUTB = INOUTA ;
			"1" : begin
				assign INOUTA = 1'bz ;
				assign INOUTB = 1'bz ;
			      end
			default : begin
					assign INOUTA = 1'bx ;	
					assign INOUTB = 1'bx ;
				  end
		endcase
endmodule


module SPS4N4X0H1(
IN3, IN0, IN1, IN2, OUT, _1
);
		input IN3, IN0, IN1, IN2, _1;
		output reg OUT;
		parameter CONF = "1111";

		always @ (IN3 or IN0 or IN1 or IN2 or _1)
			case (CONF) 
				"1110" : OUT = IN0 ;
				"1101" : OUT = IN1 ;
				"1011" : OUT = IN2 ;
				"0111" : OUT = IN3 ;
				"1111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module BUF1B0X5H1(
OUT, IN
);
		input IN;
		output OUT;

		assign	OUT = IN ;
endmodule

/*wrong
module REG3N1X0H1(
Q, CK, E, D, _1
);
		parameter CONF = "1";

		always @ ()
			case (CONF) 
				"1" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule
*/


module SWITCH2N1X0H1(
SOURCE, DRAIN
);
		inout SOURCE;
		inout DRAIN;
		parameter CONF = "11";

		case (CONF) 
			"00" : assign SOURCE = DRAIN ;
			"01" : assign DRAIN = SOURCE ;	
			"11" : begin
					assign DRAIN = 1'bz ;
					assign SOURCE = 1'bz ;
			       end
			default : begin
					assign DRAIN = 1'bx ;
					assign SOURCE = 1'bx ;
				  end
		endcase
endmodule



module SWITCH2N1X0H2(
SOURCE, DRAIN
);
		inout SOURCE;
		inout DRAIN;
		parameter CONF = "11";

		case (CONF) 
			"00" : assign SOURCE = DRAIN ;
			"01" : assign DRAIN = SOURCE ;	
			"11" : begin
					assign DRAIN = 1'bz ;
					assign SOURCE = 1'bz ;
			       end
			default : begin
					assign DRAIN = 1'bx ;
					assign SOURCE = 1'bx ;
				  end
		endcase
endmodule


module SPBU1OR2B1X1H1(
OUT, IN
);
		input IN;
		output reg OUT;
		parameter CONF = "1";

		always @ (IN)
			case (CONF) 
				"0" : OUT = IN ;
				"1" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS6B6X2H1(
IN4, IN5, IN0, IN1, IN2, IN3, OUT, _1
);
		input IN4, IN5, IN0, IN1, IN2, IN3, _1;
		output reg OUT;
		parameter CONF = "111111";

		always @ (IN4 or IN5 or IN0 or IN1 or IN2 or IN3 or _1)
			case (CONF) 
				"111110" : OUT = IN0 ;
				"111101" : OUT = IN1 ;
				"111011" : OUT = IN2 ;
				"110111" : OUT = IN3 ;
				"101111" : OUT = IN4 ;
				"011111" : OUT = IN5 ;
				"111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPBB2T2X7H1(
A, B
);
		inout  A;
		inout  B;
		parameter CONF = "11";
	
		case (CONF)
			"10" : assign A = B ;
			"01" : assign B = A ;
			"11" : begin
					assign B = 1'bz ;
					assign A = 1'bz ;
			       end
			default :  begin
						assign A = 1'bx;
						assign B = 1'bx;
					   end
			endcase
endmodule

/*wrong
module MUX16B0X4H1(
I9, I8, A1, I13, I10, I1, I0, I3, I2, I5, I4, O, I6, I11, I15, A3, A2, I7, I14, I12, A4, _1
);
		input I9, I8, A1, I13, I10, I1, I0, I3, I2, I5, I4, I6, I11, I15, A3, A2, I7, I14, I12, A4, _1;
		output reg O;

		assign	O = I0 ;
				odd : O = I1 ;
				odd : O = I2 ;
				odd : O = I3 ;
				odd : O = I4 ;
				odd : O = I5 ;
				odd : O = I6 ;
				odd : O = I7 ;
				odd : O = I8 ;
				odd : O = I9 ;
				odd : O = I10 ;
				odd : O = I11 ;
				odd : O = I12 ;
				odd : O = I13 ;
				odd : O = I14 ;
				odd : O = I15 ;
				odd : O = A4 ;
				odd : O = A3 ;
				odd : O = A2 ;
				odd : O = A1 ;
endmodule
*/

module BUFDUMMY(
OUT, IN
);
		input IN;
		output OUT;

		assign	OUT = IN ;
endmodule

module BUF1PIW0X1H1(
OUT, IN
);
		input IN;
		output OUT;

		assign	OUT = IN ;
endmodule


/*wrong
module DELAY1B4X1H1(
A, Y
);
		input A;
		output reg Y;
		parameter CONF = "1111";

		always @ (A)
			case (CONF) 
				undefined : Y = A ;
				"1111" : Y = 1'bz ;
				default : Y = 1'bx ;
			endcase
endmodule
*/

module SPS8T6X11H2(
IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, OUT, _1
);
		input IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, _1;
		output reg OUT;
		parameter CONF = "111111";

		always @ (IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or _1)
			case (CONF) 
				"001110" : OUT = IN0 ;
				"001101" : OUT = IN1 ;
				"001011" : OUT = IN2 ;
				"000111" : OUT = IN3 ;
				"011110" : OUT = IN4 ;
				"011101" : OUT = IN5 ;
				"011011" : OUT = IN6 ;
				"010111" : OUT = IN7 ;
				"111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS24B7X11H1(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, OUT, IN23, IN22, IN21, IN20, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, IN23, IN22, IN21, IN20, _1;
		output reg OUT;
		parameter CONF = "1111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN18 or IN19 or IN16 or IN17 or IN14 or IN15 or IN12 or IN13 or IN10 or IN11 or IN23 or IN22 or IN21 or IN20 or _1)
			case (CONF) 
				"1111110" : OUT = IN0 ;
				"1111101" : OUT = IN1 ;
				"1111011" : OUT = IN2 ;
				"1110111" : OUT = IN3 ;
				"1101110" : OUT = IN4 ;
				"1101101" : OUT = IN5 ;
				"1101011" : OUT = IN6 ;
				"1100111" : OUT = IN7 ;
				"0011110" : OUT = IN8 ;
				"0011101" : OUT = IN9 ;
				"0011011" : OUT = IN10 ;
				"0010111" : OUT = IN11 ;
				"0001110" : OUT = IN12 ;
				"0001101" : OUT = IN13 ;
				"0001011" : OUT = IN14 ;
				"0000111" : OUT = IN15 ;
				"1011110" : OUT = IN16 ;
				"1011101" : OUT = IN17 ;
				"1011011" : OUT = IN18 ;
				"1010111" : OUT = IN19 ;
				"1001110" : OUT = IN20 ;
				"1001101" : OUT = IN21 ;
				"1001011" : OUT = IN22 ;
				"1000111" : OUT = IN23 ;
				"1111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS8N4X0H1(
IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, OUT, _1
);
		input IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, _1;
		output reg OUT;
		parameter CONF = "1111";

		always @ (IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or _1)
			case (CONF) 
				"0010" : OUT = IN0 ;
				"0001" : OUT = IN1 ;
				"0110" : OUT = IN2 ;
				"0101" : OUT = IN3 ;
				"1010" : OUT = IN4 ;
				"1001" : OUT = IN5 ;
				"1110" : OUT = IN6 ;
				"1101" : OUT = IN7 ;
				"1111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS5B3X4H1(
IN4, IN0, IN1, IN2, IN3, OUT, _1
);
		input IN4, IN0, IN1, IN2, IN3, _1;
		output reg OUT;
		parameter CONF = "011";

		always @ (IN4 or IN0 or IN1 or IN2 or IN3 or _1)
			case (CONF) 
				"111" : OUT = IN0 ;
				"110" : OUT = IN1 ;
				"101" : OUT = IN2 ;
				"100" : OUT = IN3 ;
				"011" : OUT = IN4 ;
				"011" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS16N6X0H2(
IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN14, IN11, IN12, IN13, IN10, OUT, _1
);
		input IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN14, IN11, IN12, IN13, IN10, _1;
		output reg OUT;
		parameter CONF = "111111";

		always @ (IN15 or IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN14 or IN11 or IN12 or IN13 or IN10 or _1)
			case (CONF) 
				"111110" : OUT = IN0 ;
				"111101" : OUT = IN1 ;
				"111011" : OUT = IN2 ;
				"110111" : OUT = IN3 ;
				"101110" : OUT = IN4 ;
				"101101" : OUT = IN5 ;
				"101011" : OUT = IN6 ;
				"100111" : OUT = IN7 ;
				"011110" : OUT = IN8 ;
				"011101" : OUT = IN9 ;
				"011011" : OUT = IN10 ;
				"010111" : OUT = IN11 ;
				"001110" : OUT = IN12 ;
				"001101" : OUT = IN13 ;
				"001011" : OUT = IN14 ;
				"000111" : OUT = IN15 ;
				"111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS16N6X0H3(
IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN14, IN11, IN12, IN13, IN10, OUT, _1
);
		input IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN14, IN11, IN12, IN13, IN10, _1;
		output reg OUT;
		parameter CONF = "111111";

		always @ (IN15 or IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN14 or IN11 or IN12 or IN13 or IN10 or _1)
			case (CONF) 
				"001110" : OUT = IN0 ;
				"001101" : OUT = IN1 ;
				"001011" : OUT = IN2 ;
				"000111" : OUT = IN3 ;
				"011110" : OUT = IN4 ;
				"011101" : OUT = IN5 ;
				"011011" : OUT = IN6 ;
				"010111" : OUT = IN7 ;
				"101110" : OUT = IN8 ;
				"101101" : OUT = IN9 ;
				"101011" : OUT = IN10 ;
				"100111" : OUT = IN11 ;
				"111110" : OUT = IN12 ;
				"111101" : OUT = IN13 ;
				"111011" : OUT = IN14 ;
				"110111" : OUT = IN15 ;
				"111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS16N6X0H1(
IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN14, IN11, IN12, IN13, IN10, OUT, _1
);
		input IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN14, IN11, IN12, IN13, IN10, _1;
		output reg OUT;
		parameter CONF = "111111";

		always @ (IN15 or IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN14 or IN11 or IN12 or IN13 or IN10 or _1)
			case (CONF) 
				"001110" : OUT = IN0 ;
				"001101" : OUT = IN1 ;
				"001011" : OUT = IN2 ;
				"000111" : OUT = IN3 ;
				"011110" : OUT = IN4 ;
				"011101" : OUT = IN5 ;
				"011011" : OUT = IN6 ;
				"010111" : OUT = IN7 ;
				"101110" : OUT = IN8 ;
				"101101" : OUT = IN9 ;
				"101011" : OUT = IN10 ;
				"100111" : OUT = IN11 ;
				"111110" : OUT = IN12 ;
				"111101" : OUT = IN13 ;
				"111011" : OUT = IN14 ;
				"110111" : OUT = IN15 ;
				"111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS16N8X0H1(
IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN14, IN11, IN12, IN13, IN10, OUT, _1
);
		input IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN14, IN11, IN12, IN13, IN10, _1;
		output reg OUT;
		parameter CONF = "11111111";

		always @ (IN15 or IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN14 or IN11 or IN12 or IN13 or IN10 or _1)
			case (CONF) 
				"11101110" : OUT = IN0 ;
				"11101101" : OUT = IN1 ;
				"11101011" : OUT = IN2 ;
				"11100111" : OUT = IN3 ;
				"11011110" : OUT = IN4 ;
				"11011101" : OUT = IN5 ;
				"11011011" : OUT = IN6 ;
				"11010111" : OUT = IN7 ;
				"10111110" : OUT = IN8 ;
				"10111101" : OUT = IN9 ;
				"01111110" : OUT = IN10 ;
				"01111101" : OUT = IN11 ;
				"01111011" : OUT = IN12 ;
				"01110111" : OUT = IN13 ;
				"10111011" : OUT = IN14 ;
				"10110111" : OUT = IN15 ;
				"11111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS6T7X11H1(
IN4, IN5, IN0, IN1, IN2, IN3, OUT, _1
);
		input IN4, IN5, IN0, IN1, IN2, IN3, _1;
		output reg OUT;
		parameter CONF = "1111111";

		always @ (IN4 or IN5 or IN0 or IN1 or IN2 or IN3 or _1)
			case (CONF) 
				"0111110" : OUT = IN0 ;
				"0111101" : OUT = IN1 ;
				"0111011" : OUT = IN2 ;
				"0110111" : OUT = IN3 ;
				"0101111" : OUT = IN4 ;
				"0011111" : OUT = IN5 ;
				"1111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

/*wrong
module MUX2N0X0H1(
P, IN0, IN1, OUT, _1
);
		input P, IN0, IN1, _1;
		output reg OUT;

		assign	OUT = IN0 ;
				odd : OUT = IN1 ;
				odd : OUT = P ;
endmodule
*/

/*wrong
module MUX2N0X0H2(
P, IN0, IN1, OUT, _1
);
		input P, IN0, IN1, _1;
		output reg OUT;

		assign	OUT = IN0 ;
				odd : OUT = IN1 ;
				odd : OUT = P ;
endmodule
*/

module SPS4B2X2H1(
IN3, IN0, IN1, IN2, OUT, _1
);
		input IN3, IN0, IN1, IN2, _1;
		output reg OUT;
		parameter CONF = "00";

		always @ (IN3 or IN0 or IN1 or IN2 or _1)
			case (CONF) 
				"00" : OUT = IN0 ;
				"01" : OUT = IN1 ;
				"10" : OUT = IN2 ;
				"11" : OUT = IN3 ;
				"00" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS20T6X11H1(
IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN11, IN12, IN13, IN10, OUT, _1
);
		input IN15, IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN11, IN12, IN13, IN10, _1;
		output reg OUT;
		parameter CONF = "111111";

		always @ (IN15 or IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN18 or IN19 or IN16 or IN17 or IN14 or IN11 or IN12 or IN13 or IN10 or _1)
			case (CONF) 
				"000000" : OUT = IN0 ;
				"000001" : OUT = IN1 ;
				"000010" : OUT = IN2 ;
				"000011" : OUT = IN3 ;
				"000100" : OUT = IN4 ;
				"000101" : OUT = IN5 ;
				"000110" : OUT = IN6 ;
				"000111" : OUT = IN7 ;
				"001000" : OUT = IN8 ;
				"001001" : OUT = IN9 ;
				"001010" : OUT = IN10 ;
				"001011" : OUT = IN11 ;
				"001100" : OUT = IN12 ;
				"001101" : OUT = IN13 ;
				"001110" : OUT = IN14 ;
				"001111" : OUT = IN15 ;
				"010000" : OUT = IN16 ;
				"010001" : OUT = IN17 ;
				"010010" : OUT = IN18 ;
				"010011" : OUT = IN19 ;
				"111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS4B2X1H1(
A, Y, C, B, D, _1
);
		input A, C, B, D, _1;
		output reg Y;
		parameter CONF = "11";

		always @ (A or C or B or D or _1)
			case (CONF) 
				"00" : Y = A ;
				"01" : Y = B ;
				"10" : Y = C ;
				"11" : Y = D ;
				"11" : Y = 1'bz ;
				default : Y = 1'bx ;
			endcase
endmodule

module SPS3T3X7H1(
IN3, IN1, IN2, OUT, _1
);
		input IN3, IN1, IN2, _1;
		output reg OUT;
		parameter CONF = "111";

		always @ (IN3 or IN1 or IN2 or _1)
			case (CONF) 
				"001" : OUT = IN1 ;
				"010" : OUT = IN2 ;
				"011" : OUT = IN3 ;
				"111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS4T3X11H2(
IN3, IN0, IN1, IN2, OUT, _1
);
		input IN3, IN0, IN1, IN2, _1;
		output reg OUT;
		parameter CONF = "111";

		always @ (IN3 or IN0 or IN1 or IN2 or _1)
			case (CONF) 
				"000" : OUT = IN0 ;
				"001" : OUT = IN1 ;
				"010" : OUT = IN2 ;
				"011" : OUT = IN3 ;
				"111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS12T8X11H1(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN11, IN10, OUT, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN11, IN10, _1;
		output reg OUT;
		parameter CONF = "11111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN11 or IN10 or _1)
			case (CONF) 
				"01101110" : OUT = IN0 ;
				"01101101" : OUT = IN1 ;
				"01101011" : OUT = IN2 ;
				"01100111" : OUT = IN3 ;
				"01011110" : OUT = IN4 ;
				"01011101" : OUT = IN5 ;
				"01011011" : OUT = IN6 ;
				"01010111" : OUT = IN7 ;
				"00110111" : OUT = IN8 ;
				"00111011" : OUT = IN9 ;
				"00111101" : OUT = IN10 ;
				"00111110" : OUT = IN11 ;
				"11111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS12T8X11H2(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN11, IN10, OUT, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN11, IN10, _1;
		output reg OUT;
		parameter CONF = "11111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN11 or IN10 or _1)
			case (CONF) 
				"01110110" : OUT = IN0 ;
				"01110101" : OUT = IN1 ;
				"01110011" : OUT = IN2 ;
				"01101101" : OUT = IN3 ;
				"01101011" : OUT = IN4 ;
				"01011101" : OUT = IN5 ;
				"01011011" : OUT = IN6 ;
				"00111101" : OUT = IN7 ;
				"00111011" : OUT = IN8 ;
				"01101110" : OUT = IN9 ;
				"01011110" : OUT = IN10 ;
				"00111110" : OUT = IN11 ;
				"11111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPBU1AND1X2H1(
OUT, IN
);
		input IN;
		output reg OUT;
		parameter CONF = "0";

		always @ (IN)
			case (CONF) 
				"1" : OUT = IN ;
				"0" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS1T1X7H1(
OUT, IN
);
		input IN;
		output reg OUT;
		parameter CONF = "1";

		always @ (IN)
			case (CONF) 
				"0" : OUT = IN ;
				"1" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS8T5X11H1(
IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, OUT, _1
);
		input IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, _1;
		output reg OUT;
		parameter CONF = "11111";

		always @ (IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or _1)
			case (CONF) 
				"00010" : OUT = IN0 ;
				"00001" : OUT = IN1 ;
				"00110" : OUT = IN2 ;
				"00101" : OUT = IN3 ;
				"01010" : OUT = IN4 ;
				"01001" : OUT = IN5 ;
				"01110" : OUT = IN6 ;
				"01101" : OUT = IN7 ;
				"11111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS4N2X0H2(
IN3, IN0, IN1, IN2, OUT, _1
);
		input IN3, IN0, IN1, IN2, _1;
		output reg OUT;
		parameter CONF = "00";

		always @ (IN3 or IN0 or IN1 or IN2 or _1)
			case (CONF) 
				"00" : OUT = IN0 ;
				"01" : OUT = IN1 ;
				"10" : OUT = IN2 ;
				"11" : OUT = IN3 ;
				"00" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS4N2X0H3(
IN3, IN0, IN1, IN2, OUT, _1
);
		input IN3, IN0, IN1, IN2, _1;
		output reg OUT;
		parameter CONF = "11";

		always @ (IN3 or IN0 or IN1 or IN2 or _1)
			case (CONF) 
				"00" : OUT = IN0 ;
				"01" : OUT = IN1 ;
				"10" : OUT = IN2 ;
				"11" : OUT = IN3 ;
				"11" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS4N2X0H1(
IN3, IN0, IN1, IN2, OUT, _1
);
		input IN3, IN0, IN1, IN2, _1;
		output reg OUT;
		parameter CONF = "11";

		always @ (IN3 or IN0 or IN1 or IN2 or _1)
			case (CONF) 
				"11" : OUT = IN0 ;
				"10" : OUT = IN1 ;
				"01" : OUT = IN2 ;
				"00" : OUT = IN3 ;
				"11" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

module SPS28B6X2H1(
IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, OUT, IN23, IN22, IN21, IN20, IN27, IN26, IN25, IN24, _1
);
		input IN8, IN9, IN4, IN5, IN6, IN7, IN0, IN1, IN2, IN3, IN18, IN19, IN16, IN17, IN14, IN15, IN12, IN13, IN10, IN11, IN23, IN22, IN21, IN20, IN27, IN26, IN25, IN24, _1;
		output reg OUT;
		parameter CONF = "111111";

		always @ (IN8 or IN9 or IN4 or IN5 or IN6 or IN7 or IN0 or IN1 or IN2 or IN3 or IN18 or IN19 or IN16 or IN17 or IN14 or IN15 or IN12 or IN13 or IN10 or IN11 or IN23 or IN22 or IN21 or IN20 or IN27 or IN26 or IN25 or IN24 or _1)
			case (CONF) 
				"000000" : OUT = IN0 ;
				"000011" : OUT = IN1 ;
				"000100" : OUT = IN2 ;
				"000111" : OUT = IN3 ;
				"001000" : OUT = IN4 ;
				"001011" : OUT = IN5 ;
				"001100" : OUT = IN6 ;
				"001111" : OUT = IN7 ;
				"010000" : OUT = IN8 ;
				"010011" : OUT = IN9 ;
				"010100" : OUT = IN10 ;
				"010111" : OUT = IN11 ;
				"011000" : OUT = IN12 ;
				"011011" : OUT = IN13 ;
				"011100" : OUT = IN14 ;
				"011111" : OUT = IN15 ;
				"100000" : OUT = IN16 ;
				"100011" : OUT = IN17 ;
				"100100" : OUT = IN18 ;
				"100111" : OUT = IN19 ;
				"101000" : OUT = IN20 ;
				"101011" : OUT = IN21 ;
				"101100" : OUT = IN22 ;
				"101111" : OUT = IN23 ;
				"110000" : OUT = IN24 ;
				"110011" : OUT = IN25 ;
				"110100" : OUT = IN26 ;
				"110111" : OUT = IN27 ;
				"111111" : OUT = 1'bz ;
				default : OUT = 1'bx ;
			endcase
endmodule

 `timescale 1 ns/1 ns

module GSB_RBRAMA(
BRAM_EA0, BRAM_EA1, BRAM_EA2, BRAM_EA3, BRAM_EA4, BRAM_EA5, BRAM_EA6, BRAM_EA7, BRAM_EA8, BRAM_EA9, BRAM_EA10, BRAM_EA11, BRAM_EA12, BRAM_EA13, BRAM_EA14, BRAM_EA15, BRAM_EA16, BRAM_EA17, BRAM_EA18, BRAM_EA19, BRAM_EA20, BRAM_EA21, BRAM_EA22, BRAM_EA23, BRAM_H6EA0, BRAM_H6EA1, BRAM_H6EA2, BRAM_H6EA3, BRAM_H6BA0, BRAM_H6BA1, BRAM_H6BA2, BRAM_H6BA3, BRAM_H6MA0, BRAM_H6MA1, BRAM_H6MA2, BRAM_H6MA3, BRAM_H6DA0, BRAM_H6DA1, BRAM_H6DA2, BRAM_H6DA3, BRAM_LHA0, BRAM_LHA3, BRAM_LHA6, BRAM_LHA9, BRAM_LLV3, BRAM_LLV7, BRAM_LLV11, BRAM_GCLKIN0, BRAM_GCLKIN1, BRAM_GCLKIN2, BRAM_GCLKIN3, BRAM_GCLK_IOBA0, BRAM_GCLK_IOBA1, BRAM_GCLK_IOBA2, BRAM_GCLK_IOBA3, BRAM_GCLK_CLBA0, BRAM_GCLK_CLBA1, BRAM_GCLK_CLBA2, BRAM_GCLK_CLBA3, BRAM_RADDRS0, BRAM_RADDRS1, BRAM_RADDRS2, BRAM_RADDRS3, BRAM_RADDRS4, BRAM_RADDRS5, BRAM_RADDRS6, BRAM_RADDRS7, BRAM_RADDRS8, BRAM_RADDRS9, BRAM_RADDRS10, BRAM_RADDRS11, BRAM_RADDRS12, BRAM_RADDRS13, BRAM_RADDRS14, BRAM_RADDRS15, BRAM_RADDRS16, BRAM_RADDRS17, BRAM_RADDRS18, BRAM_RADDRS19, BRAM_RADDRS20, BRAM_RADDRS21, BRAM_RADDRS22, BRAM_RADDRS23, BRAM_RADDRS24, BRAM_RADDRS25, BRAM_RADDRS26, BRAM_RADDRS27, BRAM_RADDRS28, BRAM_RADDRS29, BRAM_RADDRS30, BRAM_RADDRS31, BRAM_RDINS0, BRAM_RDINS1, BRAM_RDINS2, BRAM_RDINS3, BRAM_RDINS4, BRAM_RDINS5, BRAM_RDINS6, BRAM_RDINS7, BRAM_RDINS8, BRAM_RDINS9, BRAM_RDINS10, BRAM_RDINS11, BRAM_RDINS12, BRAM_RDINS13, BRAM_RDINS14, BRAM_RDINS15, BRAM_RDINS16, BRAM_RDINS17, BRAM_RDINS18, BRAM_RDINS19, BRAM_RDINS20, BRAM_RDINS21, BRAM_RDINS22, BRAM_RDINS23, BRAM_RDINS24, BRAM_RDINS25, BRAM_RDINS26, BRAM_RDINS27, BRAM_RDINS28, BRAM_RDINS29, BRAM_RDINS30, BRAM_RDINS31, BRAM_RDOUTS0, BRAM_RDOUTS1, BRAM_RDOUTS2, BRAM_RDOUTS3, BRAM_RDOUTS4, BRAM_RDOUTS5, BRAM_RDOUTS6, BRAM_RDOUTS7, BRAM_RDOUTS8, BRAM_RDOUTS9, BRAM_RDOUTS10, BRAM_RDOUTS11, BRAM_RDOUTS12, BRAM_RDOUTS13, BRAM_RDOUTS14, BRAM_RDOUTS15, BRAM_RDOUTS16, BRAM_RDOUTS17, BRAM_RDOUTS18, BRAM_RDOUTS19, BRAM_RDOUTS20, BRAM_RDOUTS21, BRAM_RDOUTS22, BRAM_RDOUTS23, BRAM_RDOUTS24, BRAM_RDOUTS25, BRAM_RDOUTS26, BRAM_RDOUTS27, BRAM_RDOUTS28, BRAM_RDOUTS29, BRAM_RDOUTS30, BRAM_RDOUTS31, BRAM_RADDRN0, BRAM_RADDRN1, BRAM_RADDRN2, BRAM_RADDRN3, BRAM_RADDRN4, BRAM_RADDRN5, BRAM_RADDRN6, BRAM_RADDRN7, BRAM_RADDRN8, BRAM_RADDRN9, BRAM_RADDRN10, BRAM_RADDRN11, BRAM_RADDRN12, BRAM_RADDRN13, BRAM_RADDRN14, BRAM_RADDRN15, BRAM_RADDRN16, BRAM_RADDRN17, BRAM_RADDRN18, BRAM_RADDRN19, BRAM_RADDRN20, BRAM_RADDRN21, BRAM_RADDRN22, BRAM_RADDRN23, BRAM_RADDRN24, BRAM_RADDRN25, BRAM_RADDRN26, BRAM_RADDRN27, BRAM_RADDRN28, BRAM_RADDRN29, BRAM_RADDRN30, BRAM_RADDRN31, BRAM_RDINN0, BRAM_RDINN1, BRAM_RDINN2, BRAM_RDINN3, BRAM_RDINN4, BRAM_RDINN5, BRAM_RDINN6, BRAM_RDINN7, BRAM_RDINN8, BRAM_RDINN9, BRAM_RDINN10, BRAM_RDINN11, BRAM_RDINN12, BRAM_RDINN13, BRAM_RDINN14, BRAM_RDINN15, BRAM_RDINN16, BRAM_RDINN17, BRAM_RDINN18, BRAM_RDINN19, BRAM_RDINN20, BRAM_RDINN21, BRAM_RDINN22, BRAM_RDINN23, BRAM_RDINN24, BRAM_RDINN25, BRAM_RDINN26, BRAM_RDINN27, BRAM_RDINN28, BRAM_RDINN29, BRAM_RDINN30, BRAM_RDINN31, BRAM_RDOUTN0, BRAM_RDOUTN1, BRAM_RDOUTN2, BRAM_RDOUTN3, BRAM_RDOUTN4, BRAM_RDOUTN5, BRAM_RDOUTN6, BRAM_RDOUTN7, BRAM_RDOUTN8, BRAM_RDOUTN9, BRAM_RDOUTN10, BRAM_RDOUTN11, BRAM_RDOUTN12, BRAM_RDOUTN13, BRAM_RDOUTN14, BRAM_RDOUTN15, BRAM_RDOUTN16, BRAM_RDOUTN17, BRAM_RDOUTN18, BRAM_RDOUTN19, BRAM_RDOUTN20, BRAM_RDOUTN21, BRAM_RDOUTN22, BRAM_RDOUTN23, BRAM_RDOUTN24, BRAM_RDOUTN25, BRAM_RDOUTN26, BRAM_RDOUTN27, BRAM_RDOUTN28, BRAM_RDOUTN29, BRAM_RDOUTN30, BRAM_RDOUTN31, BRAM_DIA0, BRAM_DIA2, BRAM_DIA8, BRAM_DIA10, BRAM_DIB0, BRAM_DIB2, BRAM_DIB8, BRAM_DIB10, BRAM_DOA0, BRAM_DOA4, BRAM_DOA8, BRAM_DOA12, BRAM_DOB0, BRAM_DOB4, BRAM_DOB8, BRAM_DOB12, _1
);
inout	BRAM_EA0;
inout	BRAM_EA1;
inout	BRAM_EA2;
inout	BRAM_EA3;
inout	BRAM_EA4;
inout	BRAM_EA5;
inout	BRAM_EA6;
inout	BRAM_EA7;
inout	BRAM_EA8;
inout	BRAM_EA9;
inout	BRAM_EA10;
inout	BRAM_EA11;
inout	BRAM_EA12;
inout	BRAM_EA13;
inout	BRAM_EA14;
inout	BRAM_EA15;
inout	BRAM_EA16;
inout	BRAM_EA17;
inout	BRAM_EA18;
inout	BRAM_EA19;
inout	BRAM_EA20;
inout	BRAM_EA21;
inout	BRAM_EA22;
inout	BRAM_EA23;
inout	BRAM_H6EA0;
inout	BRAM_H6EA1;
inout	BRAM_H6EA2;
inout	BRAM_H6EA3;
inout	BRAM_H6BA0;
inout	BRAM_H6BA1;
inout	BRAM_H6BA2;
inout	BRAM_H6BA3;
inout	BRAM_H6MA0;
inout	BRAM_H6MA1;
inout	BRAM_H6MA2;
inout	BRAM_H6MA3;
inout	BRAM_H6DA0;
inout	BRAM_H6DA1;
inout	BRAM_H6DA2;
inout	BRAM_H6DA3;
inout	BRAM_LHA0;
inout	BRAM_LHA3;
inout	BRAM_LHA6;
inout	BRAM_LHA9;
inout	BRAM_LLV3;
inout	BRAM_LLV7;
inout	BRAM_LLV11;
inout	BRAM_GCLKIN0;
inout	BRAM_GCLKIN1;
inout	BRAM_GCLKIN2;
inout	BRAM_GCLKIN3;
inout	BRAM_GCLK_IOBA0;
inout	BRAM_GCLK_IOBA1;
inout	BRAM_GCLK_IOBA2;
inout	BRAM_GCLK_IOBA3;
inout	BRAM_GCLK_CLBA0;
inout	BRAM_GCLK_CLBA1;
inout	BRAM_GCLK_CLBA2;
inout	BRAM_GCLK_CLBA3;
inout	BRAM_RADDRS0;
inout	BRAM_RADDRS1;
inout	BRAM_RADDRS2;
inout	BRAM_RADDRS3;
inout	BRAM_RADDRS4;
inout	BRAM_RADDRS5;
inout	BRAM_RADDRS6;
inout	BRAM_RADDRS7;
inout	BRAM_RADDRS8;
inout	BRAM_RADDRS9;
inout	BRAM_RADDRS10;
inout	BRAM_RADDRS11;
inout	BRAM_RADDRS12;
inout	BRAM_RADDRS13;
inout	BRAM_RADDRS14;
inout	BRAM_RADDRS15;
inout	BRAM_RADDRS16;
inout	BRAM_RADDRS17;
inout	BRAM_RADDRS18;
inout	BRAM_RADDRS19;
inout	BRAM_RADDRS20;
inout	BRAM_RADDRS21;
inout	BRAM_RADDRS22;
inout	BRAM_RADDRS23;
inout	BRAM_RADDRS24;
inout	BRAM_RADDRS25;
inout	BRAM_RADDRS26;
inout	BRAM_RADDRS27;
inout	BRAM_RADDRS28;
inout	BRAM_RADDRS29;
inout	BRAM_RADDRS30;
inout	BRAM_RADDRS31;
inout	BRAM_RDINS0;
inout	BRAM_RDINS1;
inout	BRAM_RDINS2;
inout	BRAM_RDINS3;
inout	BRAM_RDINS4;
inout	BRAM_RDINS5;
inout	BRAM_RDINS6;
inout	BRAM_RDINS7;
inout	BRAM_RDINS8;
inout	BRAM_RDINS9;
inout	BRAM_RDINS10;
inout	BRAM_RDINS11;
inout	BRAM_RDINS12;
inout	BRAM_RDINS13;
inout	BRAM_RDINS14;
inout	BRAM_RDINS15;
inout	BRAM_RDINS16;
inout	BRAM_RDINS17;
inout	BRAM_RDINS18;
inout	BRAM_RDINS19;
inout	BRAM_RDINS20;
inout	BRAM_RDINS21;
inout	BRAM_RDINS22;
inout	BRAM_RDINS23;
inout	BRAM_RDINS24;
inout	BRAM_RDINS25;
inout	BRAM_RDINS26;
inout	BRAM_RDINS27;
inout	BRAM_RDINS28;
inout	BRAM_RDINS29;
inout	BRAM_RDINS30;
inout	BRAM_RDINS31;
inout	BRAM_RDOUTS0;
inout	BRAM_RDOUTS1;
inout	BRAM_RDOUTS2;
inout	BRAM_RDOUTS3;
inout	BRAM_RDOUTS4;
inout	BRAM_RDOUTS5;
inout	BRAM_RDOUTS6;
inout	BRAM_RDOUTS7;
inout	BRAM_RDOUTS8;
inout	BRAM_RDOUTS9;
inout	BRAM_RDOUTS10;
inout	BRAM_RDOUTS11;
inout	BRAM_RDOUTS12;
inout	BRAM_RDOUTS13;
inout	BRAM_RDOUTS14;
inout	BRAM_RDOUTS15;
inout	BRAM_RDOUTS16;
inout	BRAM_RDOUTS17;
inout	BRAM_RDOUTS18;
inout	BRAM_RDOUTS19;
inout	BRAM_RDOUTS20;
inout	BRAM_RDOUTS21;
inout	BRAM_RDOUTS22;
inout	BRAM_RDOUTS23;
inout	BRAM_RDOUTS24;
inout	BRAM_RDOUTS25;
inout	BRAM_RDOUTS26;
inout	BRAM_RDOUTS27;
inout	BRAM_RDOUTS28;
inout	BRAM_RDOUTS29;
inout	BRAM_RDOUTS30;
inout	BRAM_RDOUTS31;
inout	BRAM_RADDRN0;
inout	BRAM_RADDRN1;
inout	BRAM_RADDRN2;
inout	BRAM_RADDRN3;
inout	BRAM_RADDRN4;
inout	BRAM_RADDRN5;
inout	BRAM_RADDRN6;
inout	BRAM_RADDRN7;
inout	BRAM_RADDRN8;
inout	BRAM_RADDRN9;
inout	BRAM_RADDRN10;
inout	BRAM_RADDRN11;
inout	BRAM_RADDRN12;
inout	BRAM_RADDRN13;
inout	BRAM_RADDRN14;
inout	BRAM_RADDRN15;
inout	BRAM_RADDRN16;
inout	BRAM_RADDRN17;
inout	BRAM_RADDRN18;
inout	BRAM_RADDRN19;
inout	BRAM_RADDRN20;
inout	BRAM_RADDRN21;
inout	BRAM_RADDRN22;
inout	BRAM_RADDRN23;
inout	BRAM_RADDRN24;
inout	BRAM_RADDRN25;
inout	BRAM_RADDRN26;
inout	BRAM_RADDRN27;
inout	BRAM_RADDRN28;
inout	BRAM_RADDRN29;
inout	BRAM_RADDRN30;
inout	BRAM_RADDRN31;
inout	BRAM_RDINN0;
inout	BRAM_RDINN1;
inout	BRAM_RDINN2;
inout	BRAM_RDINN3;
inout	BRAM_RDINN4;
inout	BRAM_RDINN5;
inout	BRAM_RDINN6;
inout	BRAM_RDINN7;
inout	BRAM_RDINN8;
inout	BRAM_RDINN9;
inout	BRAM_RDINN10;
inout	BRAM_RDINN11;
inout	BRAM_RDINN12;
inout	BRAM_RDINN13;
inout	BRAM_RDINN14;
inout	BRAM_RDINN15;
inout	BRAM_RDINN16;
inout	BRAM_RDINN17;
inout	BRAM_RDINN18;
inout	BRAM_RDINN19;
inout	BRAM_RDINN20;
inout	BRAM_RDINN21;
inout	BRAM_RDINN22;
inout	BRAM_RDINN23;
inout	BRAM_RDINN24;
inout	BRAM_RDINN25;
inout	BRAM_RDINN26;
inout	BRAM_RDINN27;
inout	BRAM_RDINN28;
inout	BRAM_RDINN29;
inout	BRAM_RDINN30;
inout	BRAM_RDINN31;
inout	BRAM_RDOUTN0;
inout	BRAM_RDOUTN1;
inout	BRAM_RDOUTN2;
inout	BRAM_RDOUTN3;
inout	BRAM_RDOUTN4;
inout	BRAM_RDOUTN5;
inout	BRAM_RDOUTN6;
inout	BRAM_RDOUTN7;
inout	BRAM_RDOUTN8;
inout	BRAM_RDOUTN9;
inout	BRAM_RDOUTN10;
inout	BRAM_RDOUTN11;
inout	BRAM_RDOUTN12;
inout	BRAM_RDOUTN13;
inout	BRAM_RDOUTN14;
inout	BRAM_RDOUTN15;
inout	BRAM_RDOUTN16;
inout	BRAM_RDOUTN17;
inout	BRAM_RDOUTN18;
inout	BRAM_RDOUTN19;
inout	BRAM_RDOUTN20;
inout	BRAM_RDOUTN21;
inout	BRAM_RDOUTN22;
inout	BRAM_RDOUTN23;
inout	BRAM_RDOUTN24;
inout	BRAM_RDOUTN25;
inout	BRAM_RDOUTN26;
inout	BRAM_RDOUTN27;
inout	BRAM_RDOUTN28;
inout	BRAM_RDOUTN29;
inout	BRAM_RDOUTN30;
inout	BRAM_RDOUTN31;
inout	BRAM_DIA0;
inout	BRAM_DIA2;
inout	BRAM_DIA8;
inout	BRAM_DIA10;
inout	BRAM_DIB0;
inout	BRAM_DIB2;
inout	BRAM_DIB8;
inout	BRAM_DIB10;
inout	BRAM_DOA0;
inout	BRAM_DOA4;
inout	BRAM_DOA8;
inout	BRAM_DOA12;
inout	BRAM_DOB0;
inout	BRAM_DOB4;
inout	BRAM_DOB8;
inout	BRAM_DOB12;
inout	_1;

		SPBU1NAND1X35H1 spbu_gclk_clba0(
											.OUT(BRAM_GCLK_CLBA0),
											.IN(BRAM_GCLKIN0)
		);

		SPBU1NAND1X35H1 spbu_gclk_clba1(
											.OUT(BRAM_GCLK_CLBA1),
											.IN(BRAM_GCLKIN1)
		);

		SPBB2T2X7H1 spbb_raddrs12_raddrn12(
											.A(BRAM_RADDRS12),
											.B(BRAM_RADDRN12)
		);

		SPBB2T2X7H1 spbb_rdins2_rdinn3(
											.A(BRAM_RDINS2),
											.B(BRAM_RDINN3)
		);

		SPS8T6X11H2 sps_rdins7(
											.IN4(BRAM_EA5),
											.IN5(BRAM_EA1),
											.IN6(BRAM_H6DA1),
											.IN7(BRAM_H6EA1),
											.IN0(BRAM_EA21),
											.IN1(BRAM_EA17),
											.IN2(BRAM_EA13),
											.IN3(BRAM_EA9),
											.OUT(BRAM_RDINS7),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob4_rdouts22(
											.IN(BRAM_DOB4),
											.OUT(BRAM_RDOUTS22)
		);

		SPBU1NAND1X35H1 spbu_gclk_clba2(
											.OUT(BRAM_GCLK_CLBA2),
											.IN(BRAM_GCLKIN2)
		);

		SPBB2T2X7H1 spbb_rdins29_rdinn30(
											.A(BRAM_RDINS29),
											.B(BRAM_RDINN30)
		);

		SPBU1NAND1X35H1 spbu_gclk_clba3(
											.OUT(BRAM_GCLK_CLBA3),
											.IN(BRAM_GCLKIN3)
		);

		SPBB2T2X7H1 spbb_raddrs13_raddrn13(
											.A(BRAM_RADDRS13),
											.B(BRAM_RADDRN13)
		);

		SPS8T6X11H1 sps_llv7(
											.IN4(BRAM_EA5),
											.IN5(BRAM_EA1),
											.IN6(BRAM_H6DA1),
											.IN7(BRAM_H6EA1),
											.IN0(BRAM_EA21),
											.IN1(BRAM_EA17),
											.IN2(BRAM_EA13),
											.IN3(BRAM_EA9),
											.OUT(BRAM_LLV7),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins31_rdinn16(
											.A(BRAM_RDINS31),
											.B(BRAM_RDINN16)
		);

		SPBB2T2X7H1 spbb_rdouts28_rdoutn29(
											.A(BRAM_RDOUTS28),
											.B(BRAM_RDOUTN29)
		);

		SPBB2T2X7H1 spbb_raddrs15_raddrn15(
											.A(BRAM_RADDRS15),
											.B(BRAM_RADDRN15)
		);

		TRIBUF1T1X7H1 tribuf_dob4_rdouts4(
											.IN(BRAM_DOB4),
											.OUT(BRAM_RDOUTS4)
		);

		TRIBUF1T1X7H1 tribuf_doa8_rdouts14(
											.OUT(BRAM_RDOUTS14),
											.IN(BRAM_DOA8)
		);

		SPS8T6X11H2 sps_rdins11(
											.IN4(BRAM_EA6),
											.IN5(BRAM_EA2),
											.IN6(BRAM_H6DA2),
											.IN7(BRAM_H6EA2),
											.IN0(BRAM_EA22),
											.IN1(BRAM_EA18),
											.IN2(BRAM_EA14),
											.IN3(BRAM_EA10),
											.OUT(BRAM_RDINS11),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins15_rdinn0(
											.A(BRAM_RDINS15),
											.B(BRAM_RDINN0)
		);

		SPS8T6X11H2 sps_rdins15(
											.IN4(BRAM_EA7),
											.IN5(BRAM_EA3),
											.IN6(BRAM_H6DA3),
											.IN7(BRAM_H6EA3),
											.IN0(BRAM_EA23),
											.IN1(BRAM_EA19),
											.IN2(BRAM_EA15),
											.IN3(BRAM_EA11),
											.OUT(BRAM_RDINS15),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins5_rdinn6(
											.A(BRAM_RDINS5),
											.B(BRAM_RDINN6)
		);

		SPS8T6X11H1 sps_rdins19(
											.IN4(BRAM_EA4),
											.IN5(BRAM_EA0),
											.IN6(BRAM_H6DA0),
											.IN7(BRAM_H6EA0),
											.IN0(BRAM_EA20),
											.IN1(BRAM_EA16),
											.IN2(BRAM_EA12),
											.IN3(BRAM_EA8),
											.OUT(BRAM_RDINS19),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs31(
											.IN4(BRAM_EA7),
											.IN5(BRAM_EA3),
											.IN6(BRAM_H6DA3),
											.IN7(BRAM_H6EA3),
											.IN0(BRAM_EA23),
											.IN1(BRAM_EA19),
											.IN2(BRAM_EA15),
											.IN3(BRAM_EA11),
											.OUT(BRAM_RADDRS31),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins26_rdinn27(
											.A(BRAM_RDINS26),
											.B(BRAM_RDINN27)
		);

		SPBB2T2X7H1 spbb_raddrs9_raddrn9(
											.A(BRAM_RADDRS9),
											.B(BRAM_RADDRN9)
		);

		SPS2T2X7H2 sps_ea23(
											.IN0(BRAM_RDOUTS31),
											.IN1(BRAM_RDOUTS15),
											.OUT(BRAM_EA23),
											._1(1)
		);

		SPS2T2X7H2 sps_ea22(
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS11),
											.OUT(BRAM_EA22),
											._1(1)
		);

		SPS2T2X7H2 sps_ea21(
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS7),
											.OUT(BRAM_EA21),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins17_rdinn18(
											.A(BRAM_RDINS17),
											.B(BRAM_RDINN18)
		);

		SPS4T3X11H2 sps_h6ba3(
											.OUT(BRAM_H6BA3),
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS31),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											._1(1)
		);

		SPS4T3X11H2 sps_h6ba2(
											.OUT(BRAM_H6BA2),
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS19),
											.IN2(BRAM_RDOUTS7),
											.IN3(BRAM_RDOUTS3),
											._1(1)
		);

		SPS4T3X11H2 sps_h6ba1(
											.OUT(BRAM_H6BA1),
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS31),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											._1(1)
		);

		SPS4T3X11H2 sps_h6ba0(
											.OUT(BRAM_H6BA0),
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS19),
											.IN2(BRAM_RDOUTS7),
											.IN3(BRAM_RDOUTS3),
											._1(1)
		);

		SPS8T6X11H1 sps_lha0(
											.IN4(BRAM_RDOUTS19),
											.IN5(BRAM_RDOUTS23),
											.IN6(BRAM_RDOUTS27),
											.IN7(BRAM_RDOUTS31),
											.IN0(BRAM_RDOUTS3),
											.IN1(BRAM_RDOUTS7),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											.OUT(BRAM_LHA0),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins13_rdinn14(
											.A(BRAM_RDINS13),
											.B(BRAM_RDINN14)
		);

		SPBB2T2X7H1 spbb_raddrs26_raddrn26(
											.A(BRAM_RADDRS26),
											.B(BRAM_RADDRN26)
		);

		SPS8T6X11H1 sps_lha6(
											.IN4(BRAM_RDOUTS19),
											.IN5(BRAM_RDOUTS23),
											.IN6(BRAM_RDOUTS27),
											.IN7(BRAM_RDOUTS31),
											.IN0(BRAM_RDOUTS3),
											.IN1(BRAM_RDOUTS7),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											.OUT(BRAM_LHA6),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts23_rdoutn24(
											.A(BRAM_RDOUTS23),
											.B(BRAM_RDOUTN24)
		);

		SPS8T6X11H1 sps_lha9(
											.IN4(BRAM_RDOUTS19),
											.IN5(BRAM_RDOUTS23),
											.IN6(BRAM_RDOUTS27),
											.IN7(BRAM_RDOUTS31),
											.IN0(BRAM_RDOUTS3),
											.IN1(BRAM_RDOUTS7),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											.OUT(BRAM_LHA9),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins21_rdinn22(
											.A(BRAM_RDINS21),
											.B(BRAM_RDINN22)
		);

		SPBB2T2X7H1 spbb_rdins27_rdinn28(
											.A(BRAM_RDINS27),
											.B(BRAM_RDINN28)
		);

		SPBB2T2X7H1 spbb_rdins10_rdinn11(
											.A(BRAM_RDINS10),
											.B(BRAM_RDINN11)
		);

		SPBB2T2X7H1 spbb_rdouts9_rdoutn10(
											.A(BRAM_RDOUTS9),
											.B(BRAM_RDOUTN10)
		);

		TRIBUF1T1X7H1 tribuf_doa12_rdouts21(
											.OUT(BRAM_RDOUTS21),
											.IN(BRAM_DOA12)
		);

		SPBB2T2X7H1 spbb_rdouts24_rdoutn25(
											.A(BRAM_RDOUTS24),
											.B(BRAM_RDOUTN25)
		);

		SPBB2T2X7H1 spbb_rdins19_rdinn20(
											.A(BRAM_RDINS19),
											.B(BRAM_RDINN20)
		);

		SPBB2T2X7H1 spbb_rdins28_rdinn29(
											.A(BRAM_RDINS28),
											.B(BRAM_RDINN29)
		);

		SPS8T6X11H1 sps_llv3(
											.IN4(BRAM_EA4),
											.IN5(BRAM_EA0),
											.IN6(BRAM_H6DA0),
											.IN7(BRAM_H6EA0),
											.IN0(BRAM_EA20),
											.IN1(BRAM_EA16),
											.IN2(BRAM_EA12),
											.IN3(BRAM_EA8),
											.OUT(BRAM_LLV3),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs10_raddrn10(
											.A(BRAM_RADDRS10),
											.B(BRAM_RADDRN10)
		);

		SPBB2T2X7H1 spbb_rdins30_rdinn31(
											.A(BRAM_RDINS30),
											.B(BRAM_RDINN31)
		);

		SPS8T6X11H1 sps_llv11(
											.IN4(BRAM_EA6),
											.IN5(BRAM_EA2),
											.IN6(BRAM_H6DA2),
											.IN7(BRAM_H6EA2),
											.IN0(BRAM_EA22),
											.IN1(BRAM_EA18),
											.IN2(BRAM_EA14),
											.IN3(BRAM_EA10),
											.OUT(BRAM_LLV11),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs22_raddrn22(
											.A(BRAM_RADDRS22),
											.B(BRAM_RADDRN22)
		);

		SPS2T2X7H2 sps_ea18(
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS11),
											.OUT(BRAM_EA18),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins25_rdinn26(
											.A(BRAM_RDINS25),
											.B(BRAM_RDINN26)
		);

		SPS2T2X7H2 sps_ea16(
											.IN0(BRAM_RDOUTS19),
											.IN1(BRAM_RDOUTS3),
											.OUT(BRAM_EA16),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts17_rdoutn18(
											.A(BRAM_RDOUTS17),
											.B(BRAM_RDOUTN18)
		);

		SPS2T2X7H2 sps_ea14(
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS11),
											.OUT(BRAM_EA14),
											._1(1)
		);

		SPS2T2X7H2 sps_ea15(
											.IN0(BRAM_RDOUTS31),
											.IN1(BRAM_RDOUTS15),
											.OUT(BRAM_EA15),
											._1(1)
		);

		SPS2T2X7H2 sps_ea12(
											.IN0(BRAM_RDOUTS19),
											.IN1(BRAM_RDOUTS3),
											.OUT(BRAM_EA12),
											._1(1)
		);

		SPS2T2X7H2 sps_ea13(
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS7),
											.OUT(BRAM_EA13),
											._1(1)
		);

		SPS2T2X7H2 sps_ea10(
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS11),
											.OUT(BRAM_EA10),
											._1(1)
		);

		SPS2T2X7H2 sps_ea11(
											.IN0(BRAM_RDOUTS31),
											.IN1(BRAM_RDOUTS15),
											.OUT(BRAM_EA11),
											._1(1)
		);

		SPS8T6X11H2 sps_dib10(
											.IN4(BRAM_RDINS5),
											.IN5(BRAM_RDINS4),
											.IN6(BRAM_RDINS1),
											.IN7(BRAM_RDINS0),
											.IN0(BRAM_RDINS23),
											.IN1(BRAM_RDINS22),
											.IN2(BRAM_RDINS19),
											.IN3(BRAM_RDINS18),
											.OUT(BRAM_DIB10),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa8_rdouts31(
											.IN(BRAM_DOA8),
											.OUT(BRAM_RDOUTS31)
		);

		SPS4T3X11H2 sps_h6ma3(
											.OUT(BRAM_H6MA3),
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS31),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											._1(1)
		);

		SPS8T6X11H1 sps_dia0(
											.IN4(BRAM_RDINS4),
											.IN5(BRAM_RDINS3),
											.IN6(BRAM_RDINS0),
											.IN7(BRAM_RDINS15),
											.IN0(BRAM_RDINS22),
											.IN1(BRAM_RDINS21),
											.IN2(BRAM_RDINS18),
											.IN3(BRAM_RDINS17),
											.OUT(BRAM_DIA0),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs6_raddrn6(
											.A(BRAM_RADDRS6),
											.B(BRAM_RADDRN6)
		);

		SPS8T6X11H2 sps_dia2(
											.IN4(BRAM_RDINS4),
											.IN5(BRAM_RDINS3),
											.IN6(BRAM_RDINS0),
											.IN7(BRAM_RDINS15),
											.IN0(BRAM_RDINS22),
											.IN1(BRAM_RDINS21),
											.IN2(BRAM_RDINS18),
											.IN3(BRAM_RDINS17),
											.OUT(BRAM_DIA2),
											._1(1)
		);

		SPS8T6X11H1 sps_dia8(
											.IN4(BRAM_RDINS4),
											.IN5(BRAM_RDINS3),
											.IN6(BRAM_RDINS0),
											.IN7(BRAM_RDINS15),
											.IN0(BRAM_RDINS22),
											.IN1(BRAM_RDINS21),
											.IN2(BRAM_RDINS18),
											.IN3(BRAM_RDINS17),
											.OUT(BRAM_DIA8),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs21_raddrn21(
											.A(BRAM_RADDRS21),
											.B(BRAM_RADDRN21)
		);

		SPBB2T2X7H1 spbb_rdouts8_rdoutn9(
											.A(BRAM_RDOUTS8),
											.B(BRAM_RDOUTN9)
		);

		SPS8T6X11H1 sps_rdins31(
											.IN4(BRAM_EA7),
											.IN5(BRAM_EA3),
											.IN6(BRAM_H6DA3),
											.IN7(BRAM_H6EA3),
											.IN0(BRAM_EA23),
											.IN1(BRAM_EA19),
											.IN2(BRAM_EA15),
											.IN3(BRAM_EA11),
											.OUT(BRAM_RDINS31),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins20_rdinn21(
											.A(BRAM_RDINS20),
											.B(BRAM_RDINN21)
		);

		SPBB2T2X7H1 spbb_raddrs7_raddrn7(
											.A(BRAM_RADDRS7),
											.B(BRAM_RADDRN7)
		);

		SPBB2T2X7H1 spbb_rdouts14_rdoutn15(
											.A(BRAM_RDOUTS14),
											.B(BRAM_RDOUTN15)
		);

		SPBB2T2X7H1 spbb_rdins8_rdinn9(
											.A(BRAM_RDINS8),
											.B(BRAM_RDINN9)
		);

		SPBB2T2X7H1 spbb_raddrs14_raddrn14(
											.A(BRAM_RADDRS14),
											.B(BRAM_RADDRN14)
		);

		SPBB2T2X7H1 spbb_rdouts5_rdoutn6(
											.A(BRAM_RDOUTS5),
											.B(BRAM_RDOUTN6)
		);

		TRIBUF1T1X7H1 tribuf_dob8_rdouts16(
											.IN(BRAM_DOB8),
											.OUT(BRAM_RDOUTS16)
		);

		SPBB2T2X7H1 spbb_rdins24_rdinn25(
											.A(BRAM_RDINS24),
											.B(BRAM_RDINN25)
		);

		SPBB2T2X7H1 spbb_rdouts27_rdoutn28(
											.A(BRAM_RDOUTS27),
											.B(BRAM_RDOUTN28)
		);

		TRIBUF1T1X7H1 tribuf_doa12_rdouts4(
											.OUT(BRAM_RDOUTS4),
											.IN(BRAM_DOA12)
		);

		SPBB2T2X7H1 spbb_raddrs0_raddrn0(
											.A(BRAM_RADDRS0),
											.B(BRAM_RADDRN0)
		);

		SPBB2T2X7H1 spbb_rdouts25_rdoutn26(
											.A(BRAM_RDOUTS25),
											.B(BRAM_RDOUTN26)
		);

		SPBB2T2X7H1 spbb_raddrs24_raddrn24(
											.A(BRAM_RADDRS24),
											.B(BRAM_RADDRN24)
		);

		SPBB2T2X7H1 spbb_rdouts6_rdoutn7(
											.A(BRAM_RDOUTS6),
											.B(BRAM_RDOUTN7)
		);

		SPBB2T2X7H1 spbb_raddrs30_raddrn30(
											.A(BRAM_RADDRS30),
											.B(BRAM_RADDRN30)
		);

		SPBB2T2X7H1 spbb_raddrs2_raddrn2(
											.A(BRAM_RADDRS2),
											.B(BRAM_RADDRN2)
		);

		SPS2T2X7H2 sps_ea17(
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS7),
											.OUT(BRAM_EA17),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins23(
											.IN4(BRAM_EA5),
											.IN5(BRAM_EA1),
											.IN6(BRAM_H6DA1),
											.IN7(BRAM_H6EA1),
											.IN0(BRAM_EA21),
											.IN1(BRAM_EA17),
											.IN2(BRAM_EA13),
											.IN3(BRAM_EA9),
											.OUT(BRAM_RDINS23),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins27(
											.IN4(BRAM_EA6),
											.IN5(BRAM_EA2),
											.IN6(BRAM_H6DA2),
											.IN7(BRAM_H6EA2),
											.IN0(BRAM_EA22),
											.IN1(BRAM_EA18),
											.IN2(BRAM_EA14),
											.IN3(BRAM_EA10),
											.OUT(BRAM_RDINS27),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs25_raddrn25(
											.A(BRAM_RADDRS25),
											.B(BRAM_RADDRN25)
		);

		SPBB2T2X7H1 spbb_rdins6_rdinn7(
											.A(BRAM_RDINS6),
											.B(BRAM_RDINN7)
		);

		SPBB2T2X7H1 spbb_raddrs19_raddrn19(
											.A(BRAM_RADDRS19),
											.B(BRAM_RADDRN19)
		);

		SPS8T6X11H2 sps_dia10(
											.IN4(BRAM_RDINS4),
											.IN5(BRAM_RDINS3),
											.IN6(BRAM_RDINS0),
											.IN7(BRAM_RDINS15),
											.IN0(BRAM_RDINS22),
											.IN1(BRAM_RDINS21),
											.IN2(BRAM_RDINS18),
											.IN3(BRAM_RDINS17),
											.OUT(BRAM_DIA10),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts21_rdoutn22(
											.A(BRAM_RDOUTS21),
											.B(BRAM_RDOUTN22)
		);

		SPBB2T2X7H1 spbb_rdins4_rdinn5(
											.A(BRAM_RDINS4),
											.B(BRAM_RDINN5)
		);

		SPBB2T2X7H1 spbb_rdins9_rdinn10(
											.A(BRAM_RDINS9),
											.B(BRAM_RDINN10)
		);

		SPBB2T2X7H1 spbb_rdouts31_rdoutn16(
											.A(BRAM_RDOUTS31),
											.B(BRAM_RDOUTN16)
		);

		SPBB2T2X7H1 spbb_rdins16_rdinn17(
											.A(BRAM_RDINS16),
											.B(BRAM_RDINN17)
		);

		SPBB2T2X7H1 spbb_rdins7_rdinn8(
											.A(BRAM_RDINS7),
											.B(BRAM_RDINN8)
		);

		SPBB2T2X7H1 spbb_raddrs28_raddrn28(
											.A(BRAM_RADDRS28),
											.B(BRAM_RADDRN28)
		);

		SPBB2T2X7H1 spbb_rdouts2_rdoutn3(
											.A(BRAM_RDOUTS2),
											.B(BRAM_RDOUTN3)
		);

		SPBB2T2X7H1 spbb_rdouts19_rdoutn20(
											.A(BRAM_RDOUTS19),
											.B(BRAM_RDOUTN20)
		);

		SPBB2T2X7H1 spbb_rdins22_rdinn23(
											.A(BRAM_RDINS22),
											.B(BRAM_RDINN23)
		);

		SPBB2T2X7H1 spbb_rdouts15_rdoutn0(
											.A(BRAM_RDOUTS15),
											.B(BRAM_RDOUTN0)
		);

		SPBB2T2X7H1 spbb_raddrs3_raddrn3(
											.A(BRAM_RADDRS3),
											.B(BRAM_RADDRN3)
		);

		SPS8T6X11H2 sps_raddrs11(
											.IN4(BRAM_EA6),
											.IN5(BRAM_EA2),
											.IN6(BRAM_H6DA2),
											.IN7(BRAM_H6EA2),
											.IN0(BRAM_EA22),
											.IN1(BRAM_EA18),
											.IN2(BRAM_EA14),
											.IN3(BRAM_EA10),
											.OUT(BRAM_RADDRS11),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs3(
											.IN4(BRAM_EA4),
											.IN5(BRAM_EA0),
											.IN6(BRAM_H6DA0),
											.IN7(BRAM_H6EA0),
											.IN0(BRAM_EA20),
											.IN1(BRAM_EA16),
											.IN2(BRAM_EA12),
											.IN3(BRAM_EA8),
											.OUT(BRAM_RADDRS3),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob8_rdouts15(
											.IN(BRAM_DOB8),
											.OUT(BRAM_RDOUTS15)
		);

		SPBB2T2X7H1 spbb_raddrs27_raddrn27(
											.A(BRAM_RADDRS27),
											.B(BRAM_RADDRN27)
		);

		SPS8T6X11H2 sps_raddrs7(
											.IN4(BRAM_EA5),
											.IN5(BRAM_EA1),
											.IN6(BRAM_H6DA1),
											.IN7(BRAM_H6EA1),
											.IN0(BRAM_EA21),
											.IN1(BRAM_EA17),
											.IN2(BRAM_EA13),
											.IN3(BRAM_EA9),
											.OUT(BRAM_RADDRS7),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa0_rdouts13(
											.OUT(BRAM_RDOUTS13),
											.IN(BRAM_DOA0)
		);

		TRIBUF1T1X7H1 tribuf_dob12_rdouts5(
											.IN(BRAM_DOB12),
											.OUT(BRAM_RDOUTS5)
		);

		TRIBUF1T1X7H1 tribuf_doa0_rdouts16(
											.OUT(BRAM_RDOUTS16),
											.IN(BRAM_DOA0)
		);

		TRIBUF1T1X7H1 tribuf_doa0_rdouts14(
											.IN(BRAM_DOA0),
											.OUT(BRAM_RDOUTS14)
		);

		SPBB2T2X7H1 spbb_rdouts18_rdoutn19(
											.A(BRAM_RDOUTS18),
											.B(BRAM_RDOUTN19)
		);

		TRIBUF1T1X7H1 tribuf_doa4_rdouts21(
											.IN(BRAM_DOA4),
											.OUT(BRAM_RDOUTS21)
		);

		SPS8T6X11H2 sps_raddrs15(
											.IN4(BRAM_EA7),
											.IN5(BRAM_EA3),
											.IN6(BRAM_H6DA3),
											.IN7(BRAM_H6EA3),
											.IN0(BRAM_EA23),
											.IN1(BRAM_EA19),
											.IN2(BRAM_EA15),
											.IN3(BRAM_EA11),
											.OUT(BRAM_RADDRS15),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins3_rdinn4(
											.A(BRAM_RDINS3),
											.B(BRAM_RDINN4)
		);

		SPBU1NAND1X35H1 spbu_gclk_ioba3(
											.OUT(BRAM_GCLK_IOBA3),
											.IN(BRAM_GCLKIN3)
		);

		SPBU1NAND1X35H1 spbu_gclk_ioba2(
											.OUT(BRAM_GCLK_IOBA2),
											.IN(BRAM_GCLKIN2)
		);

		SPBU1NAND1X35H1 spbu_gclk_ioba1(
											.OUT(BRAM_GCLK_IOBA1),
											.IN(BRAM_GCLKIN1)
		);

		SPBU1NAND1X35H1 spbu_gclk_ioba0(
											.OUT(BRAM_GCLK_IOBA0),
											.IN(BRAM_GCLKIN0)
		);

		SPBB2T2X7H1 spbb_raddrs17_raddrn17(
											.A(BRAM_RADDRS17),
											.B(BRAM_RADDRN17)
		);

		SPS2T2X7H2 sps_ea1(
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS7),
											.OUT(BRAM_EA1),
											._1(1)
		);

		SPS2T2X7H2 sps_ea2(
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS11),
											.OUT(BRAM_EA2),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts26_rdoutn27(
											.A(BRAM_RDOUTS26),
											.B(BRAM_RDOUTN27)
		);

		TRIBUF1T1X7H1 tribuf_dob4_rdouts23(
											.IN(BRAM_DOB4),
											.OUT(BRAM_RDOUTS23)
		);

		SPS2T2X7H2 sps_ea8(
											.IN0(BRAM_RDOUTS19),
											.IN1(BRAM_RDOUTS3),
											.OUT(BRAM_EA8),
											._1(1)
		);

		SPS2T2X7H2 sps_ea9(
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS7),
											.OUT(BRAM_EA9),
											._1(1)
		);

		SPS4T3X11H2 sps_h6ma0(
											.OUT(BRAM_H6MA0),
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS19),
											.IN2(BRAM_RDOUTS7),
											.IN3(BRAM_RDOUTS3),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins14_rdinn15(
											.A(BRAM_RDINS14),
											.B(BRAM_RDINN15)
		);

		SPS4T3X11H2 sps_h6ma1(
											.OUT(BRAM_H6MA1),
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS31),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											._1(1)
		);

		SPS4T3X11H2 sps_h6ma2(
											.OUT(BRAM_H6MA2),
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS19),
											.IN2(BRAM_RDOUTS7),
											.IN3(BRAM_RDOUTS3),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs20_raddrn20(
											.A(BRAM_RADDRS20),
											.B(BRAM_RADDRN20)
		);

		TRIBUF1T1X7H1 tribuf_doa0_rdouts31(
											.IN(BRAM_DOA0),
											.OUT(BRAM_RDOUTS31)
		);

		SPS2T2X7H2 sps_ea20(
											.IN0(BRAM_RDOUTS19),
											.IN1(BRAM_RDOUTS3),
											.OUT(BRAM_EA20),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts16_rdoutn17(
											.A(BRAM_RDOUTS16),
											.B(BRAM_RDOUTN17)
		);

		SPBB2T2X7H1 spbb_rdouts10_rdoutn11(
											.A(BRAM_RDOUTS10),
											.B(BRAM_RDOUTN11)
		);

		SPS2T2X7H2 sps_ea19(
											.IN0(BRAM_RDOUTS31),
											.IN1(BRAM_RDOUTS15),
											.OUT(BRAM_EA19),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs5_raddrn5(
											.A(BRAM_RADDRS5),
											.B(BRAM_RADDRN5)
		);

		SPBB2T2X7H1 spbb_rdins23_rdinn24(
											.A(BRAM_RDINS23),
											.B(BRAM_RDINN24)
		);

		TRIBUF1T1X7H1 tribuf_dob0_rdouts15(
											.IN(BRAM_DOB0),
											.OUT(BRAM_RDOUTS15)
		);

		TRIBUF1T1X7H1 tribuf_dob0_rdouts14(
											.IN(BRAM_DOB0),
											.OUT(BRAM_RDOUTS14)
		);

		TRIBUF1T1X7H1 tribuf_dob0_rdouts17(
											.OUT(BRAM_RDOUTS17),
											.IN(BRAM_DOB0)
		);

		TRIBUF1T1X7H1 tribuf_dob0_rdouts16(
											.IN(BRAM_DOB0),
											.OUT(BRAM_RDOUTS16)
		);

		SPBB2T2X7H1 spbb_rdouts0_rdoutn1(
											.A(BRAM_RDOUTS0),
											.B(BRAM_RDOUTN1)
		);

		TRIBUF1T1X7H1 tribuf_doa4_rdouts22(
											.OUT(BRAM_RDOUTS22),
											.IN(BRAM_DOA4)
		);

		SPBB2T2X7H1 spbb_raddrs29_raddrn29(
											.A(BRAM_RADDRS29),
											.B(BRAM_RADDRN29)
		);

		SPS2T2X7H2 sps_ea4(
											.IN0(BRAM_RDOUTS19),
											.IN1(BRAM_RDOUTS3),
											.OUT(BRAM_EA4),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob12_rdouts22(
											.IN(BRAM_DOB12),
											.OUT(BRAM_RDOUTS22)
		);

		SPBB2T2X7H1 spbb_rdouts4_rdoutn5(
											.A(BRAM_RDOUTS4),
											.B(BRAM_RDOUTN5)
		);

		SPS2T2X7H2 sps_ea5(
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS7),
											.OUT(BRAM_EA5),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts13_rdoutn14(
											.A(BRAM_RDOUTS13),
											.B(BRAM_RDOUTN14)
		);

		SPS2T2X7H2 sps_ea6(
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS11),
											.OUT(BRAM_EA6),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs27(
											.IN4(BRAM_EA6),
											.IN5(BRAM_EA2),
											.IN6(BRAM_H6DA2),
											.IN7(BRAM_H6EA2),
											.IN0(BRAM_EA22),
											.IN1(BRAM_EA18),
											.IN2(BRAM_EA14),
											.IN3(BRAM_EA10),
											.OUT(BRAM_RADDRS27),
											._1(1)
		);

		SPS2T2X7H2 sps_ea7(
											.IN0(BRAM_RDOUTS31),
											.IN1(BRAM_RDOUTS15),
											.OUT(BRAM_EA7),
											._1(1)
		);

		SPS2T2X7H2 sps_ea0(
											.IN0(BRAM_RDOUTS19),
											.IN1(BRAM_RDOUTS3),
											.OUT(BRAM_EA0),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts1_rdoutn2(
											.A(BRAM_RDOUTS1),
											.B(BRAM_RDOUTN2)
		);

		SPBB2T2X7H1 spbb_raddrs11_raddrn11(
											.A(BRAM_RADDRS11),
											.B(BRAM_RADDRN11)
		);

		SPBB2T2X7H1 spbb_rdins12_rdinn13(
											.A(BRAM_RDINS12),
											.B(BRAM_RDINN13)
		);

		SPBB2T2X7H1 spbb_raddrs18_raddrn18(
											.A(BRAM_RADDRS18),
											.B(BRAM_RADDRN18)
		);

		SPS8T6X11H1 sps_lha3(
											.IN4(BRAM_RDOUTS19),
											.IN5(BRAM_RDOUTS23),
											.IN6(BRAM_RDOUTS27),
											.IN7(BRAM_RDOUTS31),
											.IN0(BRAM_RDOUTS3),
											.IN1(BRAM_RDOUTS7),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											.OUT(BRAM_LHA3),
											._1(1)
		);

		SPS8T6X11H2 sps_rdins3(
											.IN4(BRAM_EA4),
											.IN5(BRAM_EA0),
											.IN6(BRAM_H6DA0),
											.IN7(BRAM_H6EA0),
											.IN0(BRAM_EA20),
											.IN1(BRAM_EA16),
											.IN2(BRAM_EA12),
											.IN3(BRAM_EA8),
											.OUT(BRAM_RDINS3),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs23(
											.IN4(BRAM_EA5),
											.IN5(BRAM_EA1),
											.IN6(BRAM_H6DA1),
											.IN7(BRAM_H6EA1),
											.IN0(BRAM_EA21),
											.IN1(BRAM_EA17),
											.IN2(BRAM_EA13),
											.IN3(BRAM_EA9),
											.OUT(BRAM_RADDRS23),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins0_rdinn1(
											.A(BRAM_RDINS0),
											.B(BRAM_RDINN1)
		);

		SPBB2T2X7H1 spbb_rdouts12_rdoutn13(
											.A(BRAM_RDOUTS12),
											.B(BRAM_RDOUTN13)
		);

		SPBB2T2X7H1 spbb_rdouts29_rdoutn30(
											.A(BRAM_RDOUTS29),
											.B(BRAM_RDOUTN30)
		);

		TRIBUF1T1X7H1 tribuf_dob4_rdouts5(
											.OUT(BRAM_RDOUTS5),
											.IN(BRAM_DOB4)
		);

		SPBB2T2X7H1 spbb_rdouts30_rdoutn31(
											.A(BRAM_RDOUTS30),
											.B(BRAM_RDOUTN31)
		);

		SPBB2T2X7H1 spbb_raddrs1_raddrn1(
											.A(BRAM_RADDRS1),
											.B(BRAM_RADDRN1)
		);

		SPBB2T2X7H1 spbb_raddrs16_raddrn16(
											.A(BRAM_RADDRS16),
											.B(BRAM_RADDRN16)
		);

		SPBB2T2X7H1 spbb_raddrs23_raddrn23(
											.A(BRAM_RADDRS23),
											.B(BRAM_RADDRN23)
		);

		SPBB2T2X7H1 spbb_rdins1_rdinn2(
											.A(BRAM_RDINS1),
											.B(BRAM_RDINN2)
		);

		SPS8T6X11H1 sps_raddrs19(
											.IN4(BRAM_EA4),
											.IN5(BRAM_EA0),
											.IN6(BRAM_H6DA0),
											.IN7(BRAM_H6EA0),
											.IN0(BRAM_EA20),
											.IN1(BRAM_EA16),
											.IN2(BRAM_EA12),
											.IN3(BRAM_EA8),
											.OUT(BRAM_RADDRS19),
											._1(1)
		);

		SPS8T6X11H1 sps_dib8(
											.IN4(BRAM_RDINS5),
											.IN5(BRAM_RDINS4),
											.IN6(BRAM_RDINS1),
											.IN7(BRAM_RDINS0),
											.IN0(BRAM_RDINS23),
											.IN1(BRAM_RDINS22),
											.IN2(BRAM_RDINS19),
											.IN3(BRAM_RDINS18),
											.OUT(BRAM_DIB8),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts7_rdoutn8(
											.A(BRAM_RDOUTS7),
											.B(BRAM_RDOUTN8)
		);

		SPBB2T2X7H1 spbb_rdouts22_rdoutn23(
											.A(BRAM_RDOUTS22),
											.B(BRAM_RDOUTN23)
		);

		SPBB2T2X7H1 spbb_rdouts20_rdoutn21(
											.A(BRAM_RDOUTS20),
											.B(BRAM_RDOUTN21)
		);

		SPS8T6X11H1 sps_dib0(
											.IN4(BRAM_RDINS5),
											.IN5(BRAM_RDINS4),
											.IN6(BRAM_RDINS1),
											.IN7(BRAM_RDINS0),
											.IN0(BRAM_RDINS23),
											.IN1(BRAM_RDINS22),
											.IN2(BRAM_RDINS19),
											.IN3(BRAM_RDINS18),
											.OUT(BRAM_DIB0),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts3_rdoutn4(
											.A(BRAM_RDOUTS3),
											.B(BRAM_RDOUTN4)
		);

		SPS8T6X11H2 sps_dib2(
											.IN4(BRAM_RDINS5),
											.IN5(BRAM_RDINS4),
											.IN6(BRAM_RDINS1),
											.IN7(BRAM_RDINS0),
											.IN0(BRAM_RDINS23),
											.IN1(BRAM_RDINS22),
											.IN2(BRAM_RDINS19),
											.IN3(BRAM_RDINS18),
											.OUT(BRAM_DIB2),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins18_rdinn19(
											.A(BRAM_RDINS18),
											.B(BRAM_RDINN19)
		);

		TRIBUF1T1X7H1 tribuf_doa4_rdouts4(
											.IN(BRAM_DOA4),
											.OUT(BRAM_RDOUTS4)
		);

		TRIBUF1T1X7H1 tribuf_doa4_rdouts3(
											.IN(BRAM_DOA4),
											.OUT(BRAM_RDOUTS3)
		);

		SPS2T2X7H2 sps_ea3(
											.IN0(BRAM_RDOUTS31),
											.IN1(BRAM_RDOUTS15),
											.OUT(BRAM_EA3),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs31_raddrn31(
											.A(BRAM_RADDRS31),
											.B(BRAM_RADDRN31)
		);

		SPBB2T2X7H1 spbb_rdouts11_rdoutn12(
											.A(BRAM_RDOUTS11),
											.B(BRAM_RDOUTN12)
		);

		SPBB2T2X7H1 spbb_raddrs4_raddrn4(
											.A(BRAM_RADDRS4),
											.B(BRAM_RADDRN4)
		);

		SPBB2T2X7H1 spbb_rdins11_rdinn12(
											.A(BRAM_RDINS11),
											.B(BRAM_RDINN12)
		);

		SPBB2T2X7H1 spbb_raddrs8_raddrn8(
											.A(BRAM_RADDRS8),
											.B(BRAM_RADDRN8)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_RBRAMC(
BRAM_EC0, BRAM_EC1, BRAM_EC2, BRAM_EC3, BRAM_EC4, BRAM_EC5, BRAM_EC6, BRAM_EC7, BRAM_EC8, BRAM_EC9, BRAM_EC10, BRAM_EC11, BRAM_EC12, BRAM_EC13, BRAM_EC14, BRAM_EC15, BRAM_EC16, BRAM_EC17, BRAM_EC18, BRAM_EC19, BRAM_EC20, BRAM_EC21, BRAM_EC22, BRAM_EC23, BRAM_H6EC0, BRAM_H6EC1, BRAM_H6EC2, BRAM_H6EC3, BRAM_H6BC0, BRAM_H6BC1, BRAM_H6BC2, BRAM_H6BC3, BRAM_H6MC0, BRAM_H6MC1, BRAM_H6MC2, BRAM_H6MC3, BRAM_H6DC0, BRAM_H6DC1, BRAM_H6DC2, BRAM_H6DC3, BRAM_LHC0, BRAM_LHC3, BRAM_LHC6, BRAM_LHC9, BRAM_LLV0, BRAM_LLV1, BRAM_LLV2, BRAM_LLV3, BRAM_LLV4, BRAM_LLV5, BRAM_LLV6, BRAM_LLV7, BRAM_LLV8, BRAM_LLV9, BRAM_LLV10, BRAM_LLV11, BRAM_RDOUTS1, BRAM_RDOUTS5, BRAM_RDOUTS9, BRAM_RDOUTS10, BRAM_RDOUTS11, BRAM_RDOUTS12, BRAM_RDOUTS13, BRAM_RDOUTS17, BRAM_RDOUTS21, BRAM_RDOUTS25, BRAM_RDOUTS27, BRAM_RDOUTS28, BRAM_RDOUTS29, BRAM_RDOUTS30, BRAM_RDOUTS31, BRAM_RDINS1, BRAM_RDINS2, BRAM_RDINS3, BRAM_RDINS5, BRAM_RDINS6, BRAM_RDINS7, BRAM_RDINS9, BRAM_RDINS13, BRAM_RDINS17, BRAM_RDINS19, BRAM_RDINS20, BRAM_RDINS21, BRAM_RDINS23, BRAM_RDINS24, BRAM_RDINS25, BRAM_RDINS29, BRAM_RADDRS0, BRAM_RADDRS1, BRAM_RADDRS2, BRAM_RADDRS3, BRAM_RADDRS5, BRAM_RADDRS8, BRAM_RADDRS9, BRAM_RADDRS10, BRAM_RADDRS11, BRAM_RADDRS12, BRAM_RADDRS13, BRAM_RADDRS14, BRAM_RADDRS15, BRAM_RADDRS16, BRAM_RADDRS17, BRAM_RADDRS18, BRAM_RADDRS19, BRAM_RADDRS21, BRAM_RADDRS24, BRAM_RADDRS25, BRAM_RADDRS26, BRAM_RADDRS27, BRAM_RADDRS28, BRAM_RADDRS29, BRAM_RADDRS30, BRAM_RADDRS31, BRAM_DIA4, BRAM_DIA5, BRAM_DIA12, BRAM_DIA13, BRAM_DIB4, BRAM_DIB5, BRAM_DIB12, BRAM_DIB13, BRAM_DOA2, BRAM_DOA6, BRAM_DOA10, BRAM_DOA14, BRAM_DOB2, BRAM_DOB6, BRAM_DOB10, BRAM_DOB14, BRAM_ADDRA4, BRAM_ADDRA5, BRAM_ADDRA6, BRAM_ADDRA7, BRAM_ADDRB4, BRAM_ADDRB5, BRAM_ADDRB6, BRAM_ADDRB7, BRAM_CLKB, BRAM_WEB, BRAM_SELB, BRAM_RSTB, BRAM_GCLKIN0, BRAM_GCLKIN1, BRAM_GCLKIN2, BRAM_GCLKIN3, BRAM_GCLK_IOBC0, BRAM_GCLK_IOBC1, BRAM_GCLK_IOBC2, BRAM_GCLK_IOBC3, BRAM_GCLK_CLBC0, BRAM_GCLK_CLBC1, BRAM_GCLK_CLBC2, BRAM_GCLK_CLBC3, _1
);
inout	BRAM_EC0;
inout	BRAM_EC1;
inout	BRAM_EC2;
inout	BRAM_EC3;
inout	BRAM_EC4;
inout	BRAM_EC5;
inout	BRAM_EC6;
inout	BRAM_EC7;
inout	BRAM_EC8;
inout	BRAM_EC9;
inout	BRAM_EC10;
inout	BRAM_EC11;
inout	BRAM_EC12;
inout	BRAM_EC13;
inout	BRAM_EC14;
inout	BRAM_EC15;
inout	BRAM_EC16;
inout	BRAM_EC17;
inout	BRAM_EC18;
inout	BRAM_EC19;
inout	BRAM_EC20;
inout	BRAM_EC21;
inout	BRAM_EC22;
inout	BRAM_EC23;
inout	BRAM_H6EC0;
inout	BRAM_H6EC1;
inout	BRAM_H6EC2;
inout	BRAM_H6EC3;
inout	BRAM_H6BC0;
inout	BRAM_H6BC1;
inout	BRAM_H6BC2;
inout	BRAM_H6BC3;
inout	BRAM_H6MC0;
inout	BRAM_H6MC1;
inout	BRAM_H6MC2;
inout	BRAM_H6MC3;
inout	BRAM_H6DC0;
inout	BRAM_H6DC1;
inout	BRAM_H6DC2;
inout	BRAM_H6DC3;
inout	BRAM_LHC0;
inout	BRAM_LHC3;
inout	BRAM_LHC6;
inout	BRAM_LHC9;
inout	BRAM_LLV0;
inout	BRAM_LLV1;
inout	BRAM_LLV2;
inout	BRAM_LLV3;
inout	BRAM_LLV4;
inout	BRAM_LLV5;
inout	BRAM_LLV6;
inout	BRAM_LLV7;
inout	BRAM_LLV8;
inout	BRAM_LLV9;
inout	BRAM_LLV10;
inout	BRAM_LLV11;
inout	BRAM_RDOUTS1;
inout	BRAM_RDOUTS5;
inout	BRAM_RDOUTS9;
inout	BRAM_RDOUTS10;
inout	BRAM_RDOUTS11;
inout	BRAM_RDOUTS12;
inout	BRAM_RDOUTS13;
inout	BRAM_RDOUTS17;
inout	BRAM_RDOUTS21;
inout	BRAM_RDOUTS25;
inout	BRAM_RDOUTS27;
inout	BRAM_RDOUTS28;
inout	BRAM_RDOUTS29;
inout	BRAM_RDOUTS30;
inout	BRAM_RDOUTS31;
inout	BRAM_RDINS1;
inout	BRAM_RDINS2;
inout	BRAM_RDINS3;
inout	BRAM_RDINS5;
inout	BRAM_RDINS6;
inout	BRAM_RDINS7;
inout	BRAM_RDINS9;
inout	BRAM_RDINS13;
inout	BRAM_RDINS17;
inout	BRAM_RDINS19;
inout	BRAM_RDINS20;
inout	BRAM_RDINS21;
inout	BRAM_RDINS23;
inout	BRAM_RDINS24;
inout	BRAM_RDINS25;
inout	BRAM_RDINS29;
inout	BRAM_RADDRS0;
inout	BRAM_RADDRS1;
inout	BRAM_RADDRS2;
inout	BRAM_RADDRS3;
inout	BRAM_RADDRS5;
inout	BRAM_RADDRS8;
inout	BRAM_RADDRS9;
inout	BRAM_RADDRS10;
inout	BRAM_RADDRS11;
inout	BRAM_RADDRS12;
inout	BRAM_RADDRS13;
inout	BRAM_RADDRS14;
inout	BRAM_RADDRS15;
inout	BRAM_RADDRS16;
inout	BRAM_RADDRS17;
inout	BRAM_RADDRS18;
inout	BRAM_RADDRS19;
inout	BRAM_RADDRS21;
inout	BRAM_RADDRS24;
inout	BRAM_RADDRS25;
inout	BRAM_RADDRS26;
inout	BRAM_RADDRS27;
inout	BRAM_RADDRS28;
inout	BRAM_RADDRS29;
inout	BRAM_RADDRS30;
inout	BRAM_RADDRS31;
inout	BRAM_DIA4;
inout	BRAM_DIA5;
inout	BRAM_DIA12;
inout	BRAM_DIA13;
inout	BRAM_DIB4;
inout	BRAM_DIB5;
inout	BRAM_DIB12;
inout	BRAM_DIB13;
inout	BRAM_DOA2;
inout	BRAM_DOA6;
inout	BRAM_DOA10;
inout	BRAM_DOA14;
inout	BRAM_DOB2;
inout	BRAM_DOB6;
inout	BRAM_DOB10;
inout	BRAM_DOB14;
inout	BRAM_ADDRA4;
inout	BRAM_ADDRA5;
inout	BRAM_ADDRA6;
inout	BRAM_ADDRA7;
inout	BRAM_ADDRB4;
inout	BRAM_ADDRB5;
inout	BRAM_ADDRB6;
inout	BRAM_ADDRB7;
inout	BRAM_CLKB;
inout	BRAM_WEB;
inout	BRAM_SELB;
inout	BRAM_RSTB;
inout	BRAM_GCLKIN0;
inout	BRAM_GCLKIN1;
inout	BRAM_GCLKIN2;
inout	BRAM_GCLKIN3;
inout	BRAM_GCLK_IOBC0;
inout	BRAM_GCLK_IOBC1;
inout	BRAM_GCLK_IOBC2;
inout	BRAM_GCLK_IOBC3;
inout	BRAM_GCLK_CLBC0;
inout	BRAM_GCLK_CLBC1;
inout	BRAM_GCLK_CLBC2;
inout	BRAM_GCLK_CLBC3;
inout	_1;
		wire		VDD ;

		TRIBUF1T1X7H1 tribuf_doa2_rdouts28(
											.OUT(BRAM_RDOUTS28),
											.IN(BRAM_DOA2)
		);

		SPS8T6X11H2 sps_rdins1(
											.IN4(BRAM_EC4),
											.IN5(BRAM_EC0),
											.IN6(BRAM_H6DC0),
											.IN7(BRAM_H6EC0),
											.IN0(BRAM_EC20),
											.IN1(BRAM_EC16),
											.IN2(BRAM_EC12),
											.IN3(BRAM_EC8),
											.OUT(BRAM_RDINS1),
											._1(1)
		);

		SPS8T6X11H2 sps_rdins5(
											.IN4(BRAM_EC5),
											.IN5(BRAM_EC1),
											.IN6(BRAM_H6DC1),
											.IN7(BRAM_H6EC1),
											.IN0(BRAM_EC21),
											.IN1(BRAM_EC17),
											.IN2(BRAM_EC13),
											.IN3(BRAM_EC9),
											.OUT(BRAM_RDINS5),
											._1(1)
		);

		SPS8T6X11H2 sps_rdins9(
											.IN4(BRAM_EC6),
											.IN5(BRAM_EC2),
											.IN6(BRAM_H6DC2),
											.IN7(BRAM_H6EC2),
											.IN0(BRAM_EC22),
											.IN1(BRAM_EC18),
											.IN2(BRAM_EC14),
											.IN3(BRAM_EC10),
											.OUT(BRAM_RDINS9),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa2_rdouts27(
											.IN(BRAM_DOA2),
											.OUT(BRAM_RDOUTS27)
		);

		SPS8T6X11H1 sps_llv1(
											.IN4(BRAM_EC4),
											.IN5(BRAM_EC0),
											.IN6(BRAM_H6DC0),
											.IN7(BRAM_H6EC0),
											.IN0(BRAM_EC20),
											.IN1(BRAM_EC16),
											.IN2(BRAM_EC12),
											.IN3(BRAM_EC8),
											.OUT(BRAM_LLV1),
											._1(1)
		);

		SPS8T6X11H1 sps_llv5(
											.IN4(BRAM_EC5),
											.IN5(BRAM_EC1),
											.IN6(BRAM_H6DC1),
											.IN7(BRAM_H6EC1),
											.IN0(BRAM_EC21),
											.IN1(BRAM_EC17),
											.IN2(BRAM_EC13),
											.IN3(BRAM_EC9),
											.OUT(BRAM_LLV5),
											._1(1)
		);

		SPS2T2X7H2 sps_ec21(
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS5),
											.OUT(BRAM_EC21),
											._1(1)
		);

		SPS2T2X7H2 sps_ec20(
											.IN0(BRAM_RDOUTS17),
											.IN1(BRAM_RDOUTS1),
											.OUT(BRAM_EC20),
											._1(1)
		);

		SPS2T2X7H2 sps_ec23(
											.IN0(BRAM_RDOUTS29),
											.IN1(BRAM_RDOUTS13),
											.OUT(BRAM_EC23),
											._1(1)
		);

		SPS2T2X7H2 sps_ec22(
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS9),
											.OUT(BRAM_EC22),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob14_rdouts13(
											.IN(BRAM_DOB14),
											.OUT(BRAM_RDOUTS13)
		);

		SPS8T6X11H2 sps_rdins13(
											.IN4(BRAM_EC7),
											.IN5(BRAM_EC3),
											.IN6(BRAM_H6DC3),
											.IN7(BRAM_H6EC3),
											.IN0(BRAM_EC23),
											.IN1(BRAM_EC19),
											.IN2(BRAM_EC15),
											.IN3(BRAM_EC11),
											.OUT(BRAM_RDINS13),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins17(
											.IN4(BRAM_EC4),
											.IN5(BRAM_EC0),
											.IN6(BRAM_H6DC0),
											.IN7(BRAM_H6EC0),
											.IN0(BRAM_EC20),
											.IN1(BRAM_EC16),
											.IN2(BRAM_EC12),
											.IN3(BRAM_EC8),
											.OUT(BRAM_RDINS17),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob6_rdouts31(
											.OUT(BRAM_RDOUTS31),
											.IN(BRAM_DOB6)
		);

		TRIBUF1T1X7H1 tribuf_dob6_rdouts30(
											.IN(BRAM_DOB6),
											.OUT(BRAM_RDOUTS30)
		);

		SPS24B7X11H1 sps_web(
											.IN8(VDD),
											.IN9(VDD),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS0),
											.IN1(BRAM_RADDRS1),
											.IN2(BRAM_RADDRS2),
											.IN3(BRAM_RADDRS3),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(VDD),
											.IN11(VDD),
											.OUT(BRAM_WEB),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobc1(
											.OUT(BRAM_GCLK_IOBC1),
											.IN(BRAM_GCLKIN1)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobc0(
											.OUT(BRAM_GCLK_IOBC0),
											.IN(BRAM_GCLKIN0)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobc3(
											.OUT(BRAM_GCLK_IOBC3),
											.IN(BRAM_GCLKIN3)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobc2(
											.OUT(BRAM_GCLK_IOBC2),
											.IN(BRAM_GCLKIN2)
		);

		TRIBUF1T1X7H1 tribuf_dob2_rdouts28(
											.IN(BRAM_DOB2),
											.OUT(BRAM_RDOUTS28)
		);

		TRIBUF1T1X7H1 tribuf_dob2_rdouts29(
											.IN(BRAM_DOB2),
											.OUT(BRAM_RDOUTS29)
		);

		TRIBUF1T1X7H1 tribuf_dob10_rdouts28(
											.IN(BRAM_DOB10),
											.OUT(BRAM_RDOUTS28)
		);

		TRIBUF1T1X7H1 tribuf_doa6_rdouts30(
											.OUT(BRAM_RDOUTS30),
											.IN(BRAM_DOA6)
		);

		TRIBUF1T1X7H1 tribuf_doa14_rdouts12(
											.OUT(BRAM_RDOUTS12),
											.IN(BRAM_DOA14)
		);

		SPS8T6X11H1 sps_dib12(
											.IN4(BRAM_RDINS7),
											.IN5(BRAM_RDINS6),
											.IN6(BRAM_RDINS3),
											.IN7(BRAM_RDINS2),
											.IN0(BRAM_RDINS25),
											.IN1(BRAM_RDINS24),
											.IN2(BRAM_RDINS21),
											.IN3(BRAM_RDINS20),
											.OUT(BRAM_DIB12),
											._1(1)
		);

		SPS8T6X11H2 sps_dib13(
											.IN4(BRAM_RDINS7),
											.IN5(BRAM_RDINS6),
											.IN6(BRAM_RDINS3),
											.IN7(BRAM_RDINS2),
											.IN0(BRAM_RDINS25),
											.IN1(BRAM_RDINS24),
											.IN2(BRAM_RDINS21),
											.IN3(BRAM_RDINS20),
											.OUT(BRAM_DIB13),
											._1(1)
		);

		SPS8T6X11H2 sps_dia5(
											.IN4(BRAM_RDINS6),
											.IN5(BRAM_RDINS5),
											.IN6(BRAM_RDINS2),
											.IN7(BRAM_RDINS1),
											.IN0(BRAM_RDINS24),
											.IN1(BRAM_RDINS23),
											.IN2(BRAM_RDINS20),
											.IN3(BRAM_RDINS19),
											.OUT(BRAM_DIA5),
											._1(1)
		);

		SPS8T6X11H1 sps_dia4(
											.IN4(BRAM_RDINS6),
											.IN5(BRAM_RDINS5),
											.IN6(BRAM_RDINS2),
											.IN7(BRAM_RDINS1),
											.IN0(BRAM_RDINS24),
											.IN1(BRAM_RDINS23),
											.IN2(BRAM_RDINS20),
											.IN3(BRAM_RDINS19),
											.OUT(BRAM_DIA4),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa10_rdouts10(
											.OUT(BRAM_RDOUTS10),
											.IN(BRAM_DOA10)
		);

		TRIBUF1T1X7H1 tribuf_doa6_rdouts29(
											.IN(BRAM_DOA6),
											.OUT(BRAM_RDOUTS29)
		);

		SPS24B7X11H1 sps_selb(
											.IN8(VDD),
											.IN9(VDD),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS24),
											.IN1(BRAM_RADDRS25),
											.IN2(BRAM_RADDRS26),
											.IN3(BRAM_RADDRS27),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(VDD),
											.IN11(VDD),
											.OUT(BRAM_SELB),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		SPS24B7X11H1 sps_clkb(
											.IN8(BRAM_GCLKIN0),
											.IN9(BRAM_GCLKIN1),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS0),
											.IN1(BRAM_RADDRS1),
											.IN2(BRAM_RADDRS2),
											.IN3(BRAM_RADDRS3),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(BRAM_GCLKIN2),
											.IN11(BRAM_GCLKIN3),
											.OUT(BRAM_CLKB),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		SPS24B7X11H1 sps_rstb(
											.IN8(VDD),
											.IN9(VDD),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS24),
											.IN1(BRAM_RADDRS25),
											.IN2(BRAM_RADDRS26),
											.IN3(BRAM_RADDRS27),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(VDD),
											.IN11(VDD),
											.OUT(BRAM_RSTB),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		SPS8T6X11H1 sps_lhc6(
											.IN4(BRAM_RDOUTS17),
											.IN5(BRAM_RDOUTS21),
											.IN6(BRAM_RDOUTS25),
											.IN7(BRAM_RDOUTS29),
											.IN0(BRAM_RDOUTS1),
											.IN1(BRAM_RDOUTS5),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											.OUT(BRAM_LHC6),
											._1(1)
		);

		SPS8T6X11H1 sps_lhc3(
											.IN4(BRAM_RDOUTS17),
											.IN5(BRAM_RDOUTS21),
											.IN6(BRAM_RDOUTS25),
											.IN7(BRAM_RDOUTS29),
											.IN0(BRAM_RDOUTS1),
											.IN1(BRAM_RDOUTS5),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											.OUT(BRAM_LHC3),
											._1(1)
		);

		SPS8T6X11H1 sps_lhc0(
											.IN4(BRAM_RDOUTS17),
											.IN5(BRAM_RDOUTS21),
											.IN6(BRAM_RDOUTS25),
											.IN7(BRAM_RDOUTS29),
											.IN0(BRAM_RDOUTS1),
											.IN1(BRAM_RDOUTS5),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											.OUT(BRAM_LHC0),
											._1(1)
		);

		SPS8T6X11H1 sps_lhc9(
											.IN4(BRAM_RDOUTS17),
											.IN5(BRAM_RDOUTS21),
											.IN6(BRAM_RDOUTS25),
											.IN7(BRAM_RDOUTS29),
											.IN0(BRAM_RDOUTS1),
											.IN1(BRAM_RDOUTS5),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											.OUT(BRAM_LHC9),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins29(
											.IN4(BRAM_EC7),
											.IN5(BRAM_EC3),
											.IN6(BRAM_H6DC3),
											.IN7(BRAM_H6EC3),
											.IN0(BRAM_EC23),
											.IN1(BRAM_EC19),
											.IN2(BRAM_EC15),
											.IN3(BRAM_EC11),
											.OUT(BRAM_RDINS29),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa2_rdouts9(
											.IN(BRAM_DOA2),
											.OUT(BRAM_RDOUTS9)
		);

		SPS8T6X11H1 sps_rdins21(
											.IN4(BRAM_EC5),
											.IN5(BRAM_EC1),
											.IN6(BRAM_H6DC1),
											.IN7(BRAM_H6EC1),
											.IN0(BRAM_EC21),
											.IN1(BRAM_EC17),
											.IN2(BRAM_EC13),
											.IN3(BRAM_EC9),
											.OUT(BRAM_RDINS21),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb6(
											.IN4(BRAM_RADDRS15),
											.IN5(BRAM_RADDRS14),
											.IN6(BRAM_RADDRS13),
											.IN7(BRAM_RADDRS12),
											.IN0(BRAM_RADDRS19),
											.IN1(BRAM_RADDRS18),
											.IN2(BRAM_RADDRS17),
											.IN3(BRAM_RADDRS16),
											.OUT(BRAM_ADDRB6),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb7(
											.IN4(BRAM_RADDRS15),
											.IN5(BRAM_RADDRS14),
											.IN6(BRAM_RADDRS13),
											.IN7(BRAM_RADDRS12),
											.IN0(BRAM_RADDRS19),
											.IN1(BRAM_RADDRS18),
											.IN2(BRAM_RADDRS17),
											.IN3(BRAM_RADDRS16),
											.OUT(BRAM_ADDRB7),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb4(
											.IN4(BRAM_RADDRS11),
											.IN5(BRAM_RADDRS10),
											.IN6(BRAM_RADDRS9),
											.IN7(BRAM_RADDRS8),
											.IN0(BRAM_RADDRS15),
											.IN1(BRAM_RADDRS14),
											.IN2(BRAM_RADDRS13),
											.IN3(BRAM_RADDRS12),
											.OUT(BRAM_ADDRB4),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb5(
											.IN4(BRAM_RADDRS11),
											.IN5(BRAM_RADDRS10),
											.IN6(BRAM_RADDRS9),
											.IN7(BRAM_RADDRS8),
											.IN0(BRAM_RADDRS15),
											.IN1(BRAM_RADDRS14),
											.IN2(BRAM_RADDRS13),
											.IN3(BRAM_RADDRS12),
											.OUT(BRAM_ADDRB5),
											._1(1)
		);

		SPS8T6X11H2 sps_dia13(
											.IN4(BRAM_RDINS6),
											.IN5(BRAM_RDINS5),
											.IN6(BRAM_RDINS2),
											.IN7(BRAM_RDINS1),
											.IN0(BRAM_RDINS24),
											.IN1(BRAM_RDINS23),
											.IN2(BRAM_RDINS20),
											.IN3(BRAM_RDINS19),
											.OUT(BRAM_DIA13),
											._1(1)
		);

		SPS8T6X11H1 sps_dia12(
											.IN4(BRAM_RDINS6),
											.IN5(BRAM_RDINS5),
											.IN6(BRAM_RDINS2),
											.IN7(BRAM_RDINS1),
											.IN0(BRAM_RDINS24),
											.IN1(BRAM_RDINS23),
											.IN2(BRAM_RDINS20),
											.IN3(BRAM_RDINS19),
											.OUT(BRAM_DIA12),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob14_rdouts30(
											.IN(BRAM_DOB14),
											.OUT(BRAM_RDOUTS30)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbc2(
											.OUT(BRAM_GCLK_CLBC2),
											.IN(BRAM_GCLKIN2)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbc3(
											.OUT(BRAM_GCLK_CLBC3),
											.IN(BRAM_GCLKIN3)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbc0(
											.OUT(BRAM_GCLK_CLBC0),
											.IN(BRAM_GCLKIN0)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbc1(
											.OUT(BRAM_GCLK_CLBC1),
											.IN(BRAM_GCLKIN1)
		);

		SPS8T6X11H1 sps_llv9(
											.IN4(BRAM_EC6),
											.IN5(BRAM_EC2),
											.IN6(BRAM_H6DC2),
											.IN7(BRAM_H6EC2),
											.IN0(BRAM_EC22),
											.IN1(BRAM_EC18),
											.IN2(BRAM_EC14),
											.IN3(BRAM_EC10),
											.OUT(BRAM_LLV9),
											._1(1)
		);

		SPS8T6X11H2 sps_dib5(
											.IN4(BRAM_RDINS7),
											.IN5(BRAM_RDINS6),
											.IN6(BRAM_RDINS3),
											.IN7(BRAM_RDINS2),
											.IN0(BRAM_RDINS25),
											.IN1(BRAM_RDINS24),
											.IN2(BRAM_RDINS21),
											.IN3(BRAM_RDINS20),
											.OUT(BRAM_DIB5),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs9(
											.IN4(BRAM_EC6),
											.IN5(BRAM_EC2),
											.IN6(BRAM_H6DC2),
											.IN7(BRAM_H6EC2),
											.IN0(BRAM_EC22),
											.IN1(BRAM_EC18),
											.IN2(BRAM_EC14),
											.IN3(BRAM_EC10),
											.OUT(BRAM_RADDRS9),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs1(
											.IN4(BRAM_EC4),
											.IN5(BRAM_EC0),
											.IN6(BRAM_H6DC0),
											.IN7(BRAM_H6EC0),
											.IN0(BRAM_EC20),
											.IN1(BRAM_EC16),
											.IN2(BRAM_EC12),
											.IN3(BRAM_EC8),
											.OUT(BRAM_RADDRS1),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs5(
											.IN4(BRAM_EC5),
											.IN5(BRAM_EC1),
											.IN6(BRAM_H6DC1),
											.IN7(BRAM_H6EC1),
											.IN0(BRAM_EC21),
											.IN1(BRAM_EC17),
											.IN2(BRAM_EC13),
											.IN3(BRAM_EC9),
											.OUT(BRAM_RADDRS5),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob2_rdouts11(
											.IN(BRAM_DOB2),
											.OUT(BRAM_RDOUTS11)
		);

		TRIBUF1T1X7H1 tribuf_dob2_rdouts10(
											.IN(BRAM_DOB2),
											.OUT(BRAM_RDOUTS10)
		);

		SPS8T6X11H1 sps_rdins25(
											.IN4(BRAM_EC6),
											.IN5(BRAM_EC2),
											.IN6(BRAM_H6DC2),
											.IN7(BRAM_H6EC2),
											.IN0(BRAM_EC22),
											.IN1(BRAM_EC18),
											.IN2(BRAM_EC14),
											.IN3(BRAM_EC10),
											.OUT(BRAM_RDINS25),
											._1(1)
		);

		SPS4T3X11H2 sps_h6mc2(
											.OUT(BRAM_H6MC2),
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS17),
											.IN2(BRAM_RDOUTS5),
											.IN3(BRAM_RDOUTS1),
											._1(1)
		);

		SPS4T3X11H2 sps_h6mc3(
											.OUT(BRAM_H6MC3),
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS29),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											._1(1)
		);

		SPS4T3X11H2 sps_h6mc0(
											.OUT(BRAM_H6MC0),
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS17),
											.IN2(BRAM_RDOUTS5),
											.IN3(BRAM_RDOUTS1),
											._1(1)
		);

		SPS4T3X11H2 sps_h6mc1(
											.OUT(BRAM_H6MC1),
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS29),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											._1(1)
		);

		SPS2T2X7H2 sps_ec10(
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS9),
											.OUT(BRAM_EC10),
											._1(1)
		);

		SPS2T2X7H2 sps_ec11(
											.IN0(BRAM_RDOUTS29),
											.IN1(BRAM_RDOUTS13),
											.OUT(BRAM_EC11),
											._1(1)
		);

		SPS2T2X7H2 sps_ec12(
											.IN0(BRAM_RDOUTS17),
											.IN1(BRAM_RDOUTS1),
											.OUT(BRAM_EC12),
											._1(1)
		);

		SPS2T2X7H2 sps_ec13(
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS5),
											.OUT(BRAM_EC13),
											._1(1)
		);

		SPS2T2X7H2 sps_ec14(
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS9),
											.OUT(BRAM_EC14),
											._1(1)
		);

		SPS2T2X7H2 sps_ec15(
											.IN0(BRAM_RDOUTS29),
											.IN1(BRAM_RDOUTS13),
											.OUT(BRAM_EC15),
											._1(1)
		);

		SPS2T2X7H2 sps_ec16(
											.IN0(BRAM_RDOUTS17),
											.IN1(BRAM_RDOUTS1),
											.OUT(BRAM_EC16),
											._1(1)
		);

		SPS2T2X7H2 sps_ec17(
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS5),
											.OUT(BRAM_EC17),
											._1(1)
		);

		SPS2T2X7H2 sps_ec18(
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS9),
											.OUT(BRAM_EC18),
											._1(1)
		);

		SPS2T2X7H2 sps_ec19(
											.IN0(BRAM_RDOUTS29),
											.IN1(BRAM_RDOUTS13),
											.OUT(BRAM_EC19),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa2_rdouts10(
											.IN(BRAM_DOA2),
											.OUT(BRAM_RDOUTS10)
		);

		SPS8T6X11H1 sps_raddrs29(
											.IN4(BRAM_EC7),
											.IN5(BRAM_EC3),
											.IN6(BRAM_H6DC3),
											.IN7(BRAM_H6EC3),
											.IN0(BRAM_EC23),
											.IN1(BRAM_EC19),
											.IN2(BRAM_EC15),
											.IN3(BRAM_EC11),
											.OUT(BRAM_RADDRS29),
											._1(1)
		);

		SPS8T6X11H1 sps_addra7(
											.IN4(BRAM_RADDRS15),
											.IN5(BRAM_RADDRS14),
											.IN6(BRAM_RADDRS13),
											.IN7(BRAM_RADDRS12),
											.IN0(BRAM_RADDRS19),
											.IN1(BRAM_RADDRS18),
											.IN2(BRAM_RADDRS17),
											.IN3(BRAM_RADDRS16),
											.OUT(BRAM_ADDRA7),
											._1(1)
		);

		SPS8T6X11H1 sps_addra6(
											.IN4(BRAM_RADDRS15),
											.IN5(BRAM_RADDRS14),
											.IN6(BRAM_RADDRS13),
											.IN7(BRAM_RADDRS12),
											.IN0(BRAM_RADDRS19),
											.IN1(BRAM_RADDRS18),
											.IN2(BRAM_RADDRS17),
											.IN3(BRAM_RADDRS16),
											.OUT(BRAM_ADDRA6),
											._1(1)
		);

		SPS8T6X11H1 sps_addra5(
											.IN4(BRAM_RADDRS11),
											.IN5(BRAM_RADDRS10),
											.IN6(BRAM_RADDRS9),
											.IN7(BRAM_RADDRS8),
											.IN0(BRAM_RADDRS15),
											.IN1(BRAM_RADDRS14),
											.IN2(BRAM_RADDRS13),
											.IN3(BRAM_RADDRS12),
											.OUT(BRAM_ADDRA5),
											._1(1)
		);

		SPS8T6X11H1 sps_addra4(
											.IN4(BRAM_RADDRS11),
											.IN5(BRAM_RADDRS10),
											.IN6(BRAM_RADDRS9),
											.IN7(BRAM_RADDRS8),
											.IN0(BRAM_RADDRS15),
											.IN1(BRAM_RADDRS14),
											.IN2(BRAM_RADDRS13),
											.IN3(BRAM_RADDRS12),
											.OUT(BRAM_ADDRA4),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs25(
											.IN4(BRAM_EC6),
											.IN5(BRAM_EC2),
											.IN6(BRAM_H6DC2),
											.IN7(BRAM_H6EC2),
											.IN0(BRAM_EC22),
											.IN1(BRAM_EC18),
											.IN2(BRAM_EC14),
											.IN3(BRAM_EC10),
											.OUT(BRAM_RADDRS25),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa10_rdouts27(
											.OUT(BRAM_RDOUTS27),
											.IN(BRAM_DOA10)
		);

		TRIBUF1T1X7H1 tribuf_dob6_rdouts13(
											.IN(BRAM_DOB6),
											.OUT(BRAM_RDOUTS13)
		);

		TRIBUF1T1X7H1 tribuf_dob6_rdouts12(
											.IN(BRAM_DOB6),
											.OUT(BRAM_RDOUTS12)
		);

		TRIBUF1T1X7H1 tribuf_doa14_rdouts29(
											.IN(BRAM_DOA14),
											.OUT(BRAM_RDOUTS29)
		);

		SPS8T6X11H1 sps_raddrs21(
											.IN4(BRAM_EC5),
											.IN5(BRAM_EC1),
											.IN6(BRAM_H6DC1),
											.IN7(BRAM_H6EC1),
											.IN0(BRAM_EC21),
											.IN1(BRAM_EC17),
											.IN2(BRAM_EC13),
											.IN3(BRAM_EC9),
											.OUT(BRAM_RADDRS21),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bc1(
											.OUT(BRAM_H6BC1),
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS29),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bc0(
											.OUT(BRAM_H6BC0),
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS17),
											.IN2(BRAM_RDOUTS5),
											.IN3(BRAM_RDOUTS1),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bc3(
											.OUT(BRAM_H6BC3),
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS29),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bc2(
											.OUT(BRAM_H6BC2),
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS17),
											.IN2(BRAM_RDOUTS5),
											.IN3(BRAM_RDOUTS1),
											._1(1)
		);

		SPS2T2X7H2 sps_ec8(
											.IN0(BRAM_RDOUTS17),
											.IN1(BRAM_RDOUTS1),
											.OUT(BRAM_EC8),
											._1(1)
		);

		SPS2T2X7H2 sps_ec9(
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS5),
											.OUT(BRAM_EC9),
											._1(1)
		);

		SPS2T2X7H2 sps_ec6(
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS9),
											.OUT(BRAM_EC6),
											._1(1)
		);

		SPS2T2X7H2 sps_ec7(
											.IN0(BRAM_RDOUTS29),
											.IN1(BRAM_RDOUTS13),
											.OUT(BRAM_EC7),
											._1(1)
		);

		SPS2T2X7H2 sps_ec4(
											.IN0(BRAM_RDOUTS17),
											.IN1(BRAM_RDOUTS1),
											.OUT(BRAM_EC4),
											._1(1)
		);

		SPS2T2X7H2 sps_ec5(
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS5),
											.OUT(BRAM_EC5),
											._1(1)
		);

		SPS2T2X7H2 sps_ec2(
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS9),
											.OUT(BRAM_EC2),
											._1(1)
		);

		SPS2T2X7H2 sps_ec3(
											.IN0(BRAM_RDOUTS29),
											.IN1(BRAM_RDOUTS13),
											.OUT(BRAM_EC3),
											._1(1)
		);

		SPS2T2X7H2 sps_ec0(
											.IN0(BRAM_RDOUTS17),
											.IN1(BRAM_RDOUTS1),
											.OUT(BRAM_EC0),
											._1(1)
		);

		SPS2T2X7H2 sps_ec1(
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS5),
											.OUT(BRAM_EC1),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob10_rdouts11(
											.IN(BRAM_DOB10),
											.OUT(BRAM_RDOUTS11)
		);

		SPS8T6X11H1 sps_dib4(
											.IN4(BRAM_RDINS7),
											.IN5(BRAM_RDINS6),
											.IN6(BRAM_RDINS3),
											.IN7(BRAM_RDINS2),
											.IN0(BRAM_RDINS25),
											.IN1(BRAM_RDINS24),
											.IN2(BRAM_RDINS21),
											.IN3(BRAM_RDINS20),
											.OUT(BRAM_DIB4),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs13(
											.IN4(BRAM_EC7),
											.IN5(BRAM_EC3),
											.IN6(BRAM_H6DC3),
											.IN7(BRAM_H6EC3),
											.IN0(BRAM_EC23),
											.IN1(BRAM_EC19),
											.IN2(BRAM_EC15),
											.IN3(BRAM_EC11),
											.OUT(BRAM_RADDRS13),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs17(
											.IN4(BRAM_EC4),
											.IN5(BRAM_EC0),
											.IN6(BRAM_H6DC0),
											.IN7(BRAM_H6EC0),
											.IN0(BRAM_EC20),
											.IN1(BRAM_EC16),
											.IN2(BRAM_EC12),
											.IN3(BRAM_EC8),
											.OUT(BRAM_RADDRS17),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa6_rdouts11(
											.OUT(BRAM_RDOUTS11),
											.IN(BRAM_DOA6)
		);

		TRIBUF1T1X7H1 tribuf_doa6_rdouts12(
											.IN(BRAM_DOA6),
											.OUT(BRAM_RDOUTS12)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_RBRAMB(
BRAM_EB0, BRAM_EB1, BRAM_EB2, BRAM_EB3, BRAM_EB4, BRAM_EB5, BRAM_EB6, BRAM_EB7, BRAM_EB8, BRAM_EB9, BRAM_EB10, BRAM_EB11, BRAM_EB12, BRAM_EB13, BRAM_EB14, BRAM_EB15, BRAM_EB16, BRAM_EB17, BRAM_EB18, BRAM_EB19, BRAM_EB20, BRAM_EB21, BRAM_EB22, BRAM_EB23, BRAM_H6EB0, BRAM_H6EB1, BRAM_H6EB2, BRAM_H6EB3, BRAM_H6BB0, BRAM_H6BB1, BRAM_H6BB2, BRAM_H6BB3, BRAM_H6MB0, BRAM_H6MB1, BRAM_H6MB2, BRAM_H6MB3, BRAM_H6DB0, BRAM_H6DB1, BRAM_H6DB2, BRAM_H6DB3, BRAM_LHB0, BRAM_LHB3, BRAM_LHB6, BRAM_LHB9, BRAM_LLV0, BRAM_LLV1, BRAM_LLV2, BRAM_LLV3, BRAM_LLV4, BRAM_LLV5, BRAM_LLV6, BRAM_LLV7, BRAM_LLV8, BRAM_LLV9, BRAM_LLV10, BRAM_LLV11, BRAM_GCLKIN0, BRAM_GCLKIN1, BRAM_GCLKIN2, BRAM_GCLKIN3, BRAM_GCLK_IOBB0, BRAM_GCLK_IOBB1, BRAM_GCLK_IOBB2, BRAM_GCLK_IOBB3, BRAM_GCLK_CLBB0, BRAM_GCLK_CLBB1, BRAM_GCLK_CLBB2, BRAM_GCLK_CLBB3, BRAM_RDOUTS0, BRAM_RDOUTS1, BRAM_RDOUTS2, BRAM_RDOUTS5, BRAM_RDOUTS6, BRAM_RDOUTS7, BRAM_RDOUTS10, BRAM_RDOUTS14, BRAM_RDOUTS15, BRAM_RDOUTS17, BRAM_RDOUTS18, BRAM_RDOUTS19, BRAM_RDOUTS22, BRAM_RDOUTS23, BRAM_RDOUTS24, BRAM_RDOUTS25, BRAM_RDOUTS26, BRAM_RDOUTS30, BRAM_RDINS2, BRAM_RDINS6, BRAM_RDINS7, BRAM_RDINS8, BRAM_RDINS9, BRAM_RDINS10, BRAM_RDINS11, BRAM_RDINS12, BRAM_RDINS13, BRAM_RDINS14, BRAM_RDINS18, BRAM_RDINS22, BRAM_RDINS25, BRAM_RDINS26, BRAM_RDINS27, BRAM_RDINS29, BRAM_RDINS30, BRAM_RDINS31, BRAM_RADDRS0, BRAM_RADDRS1, BRAM_RADDRS2, BRAM_RADDRS3, BRAM_RADDRS4, BRAM_RADDRS5, BRAM_RADDRS6, BRAM_RADDRS7, BRAM_RADDRS8, BRAM_RADDRS9, BRAM_RADDRS10, BRAM_RADDRS11, BRAM_RADDRS14, BRAM_RADDRS18, BRAM_RADDRS22, BRAM_RADDRS24, BRAM_RADDRS25, BRAM_RADDRS26, BRAM_RADDRS27, BRAM_RADDRS28, BRAM_RADDRS29, BRAM_RADDRS30, BRAM_RADDRS31, BRAM_DIA1, BRAM_DIA3, BRAM_DIA9, BRAM_DIA11, BRAM_DIB1, BRAM_DIB3, BRAM_DIB9, BRAM_DIB11, BRAM_DOA1, BRAM_DOA5, BRAM_DOA9, BRAM_DOA13, BRAM_DOB1, BRAM_DOB5, BRAM_DOB9, BRAM_DOB13, BRAM_ADDRA0, BRAM_ADDRA1, BRAM_ADDRA2, BRAM_ADDRA3, BRAM_ADDRB0, BRAM_ADDRB1, BRAM_ADDRB2, BRAM_ADDRB3, BRAM_CLKA, BRAM_WEA, BRAM_SELA, BRAM_RSTA, _1
);
inout	BRAM_EB0;
inout	BRAM_EB1;
inout	BRAM_EB2;
inout	BRAM_EB3;
inout	BRAM_EB4;
inout	BRAM_EB5;
inout	BRAM_EB6;
inout	BRAM_EB7;
inout	BRAM_EB8;
inout	BRAM_EB9;
inout	BRAM_EB10;
inout	BRAM_EB11;
inout	BRAM_EB12;
inout	BRAM_EB13;
inout	BRAM_EB14;
inout	BRAM_EB15;
inout	BRAM_EB16;
inout	BRAM_EB17;
inout	BRAM_EB18;
inout	BRAM_EB19;
inout	BRAM_EB20;
inout	BRAM_EB21;
inout	BRAM_EB22;
inout	BRAM_EB23;
inout	BRAM_H6EB0;
inout	BRAM_H6EB1;
inout	BRAM_H6EB2;
inout	BRAM_H6EB3;
inout	BRAM_H6BB0;
inout	BRAM_H6BB1;
inout	BRAM_H6BB2;
inout	BRAM_H6BB3;
inout	BRAM_H6MB0;
inout	BRAM_H6MB1;
inout	BRAM_H6MB2;
inout	BRAM_H6MB3;
inout	BRAM_H6DB0;
inout	BRAM_H6DB1;
inout	BRAM_H6DB2;
inout	BRAM_H6DB3;
inout	BRAM_LHB0;
inout	BRAM_LHB3;
inout	BRAM_LHB6;
inout	BRAM_LHB9;
inout	BRAM_LLV0;
inout	BRAM_LLV1;
inout	BRAM_LLV2;
inout	BRAM_LLV3;
inout	BRAM_LLV4;
inout	BRAM_LLV5;
inout	BRAM_LLV6;
inout	BRAM_LLV7;
inout	BRAM_LLV8;
inout	BRAM_LLV9;
inout	BRAM_LLV10;
inout	BRAM_LLV11;
inout	BRAM_GCLKIN0;
inout	BRAM_GCLKIN1;
inout	BRAM_GCLKIN2;
inout	BRAM_GCLKIN3;
inout	BRAM_GCLK_IOBB0;
inout	BRAM_GCLK_IOBB1;
inout	BRAM_GCLK_IOBB2;
inout	BRAM_GCLK_IOBB3;
inout	BRAM_GCLK_CLBB0;
inout	BRAM_GCLK_CLBB1;
inout	BRAM_GCLK_CLBB2;
inout	BRAM_GCLK_CLBB3;
inout	BRAM_RDOUTS0;
inout	BRAM_RDOUTS1;
inout	BRAM_RDOUTS2;
inout	BRAM_RDOUTS5;
inout	BRAM_RDOUTS6;
inout	BRAM_RDOUTS7;
inout	BRAM_RDOUTS10;
inout	BRAM_RDOUTS14;
inout	BRAM_RDOUTS15;
inout	BRAM_RDOUTS17;
inout	BRAM_RDOUTS18;
inout	BRAM_RDOUTS19;
inout	BRAM_RDOUTS22;
inout	BRAM_RDOUTS23;
inout	BRAM_RDOUTS24;
inout	BRAM_RDOUTS25;
inout	BRAM_RDOUTS26;
inout	BRAM_RDOUTS30;
inout	BRAM_RDINS2;
inout	BRAM_RDINS6;
inout	BRAM_RDINS7;
inout	BRAM_RDINS8;
inout	BRAM_RDINS9;
inout	BRAM_RDINS10;
inout	BRAM_RDINS11;
inout	BRAM_RDINS12;
inout	BRAM_RDINS13;
inout	BRAM_RDINS14;
inout	BRAM_RDINS18;
inout	BRAM_RDINS22;
inout	BRAM_RDINS25;
inout	BRAM_RDINS26;
inout	BRAM_RDINS27;
inout	BRAM_RDINS29;
inout	BRAM_RDINS30;
inout	BRAM_RDINS31;
inout	BRAM_RADDRS0;
inout	BRAM_RADDRS1;
inout	BRAM_RADDRS2;
inout	BRAM_RADDRS3;
inout	BRAM_RADDRS4;
inout	BRAM_RADDRS5;
inout	BRAM_RADDRS6;
inout	BRAM_RADDRS7;
inout	BRAM_RADDRS8;
inout	BRAM_RADDRS9;
inout	BRAM_RADDRS10;
inout	BRAM_RADDRS11;
inout	BRAM_RADDRS14;
inout	BRAM_RADDRS18;
inout	BRAM_RADDRS22;
inout	BRAM_RADDRS24;
inout	BRAM_RADDRS25;
inout	BRAM_RADDRS26;
inout	BRAM_RADDRS27;
inout	BRAM_RADDRS28;
inout	BRAM_RADDRS29;
inout	BRAM_RADDRS30;
inout	BRAM_RADDRS31;
inout	BRAM_DIA1;
inout	BRAM_DIA3;
inout	BRAM_DIA9;
inout	BRAM_DIA11;
inout	BRAM_DIB1;
inout	BRAM_DIB3;
inout	BRAM_DIB9;
inout	BRAM_DIB11;
inout	BRAM_DOA1;
inout	BRAM_DOA5;
inout	BRAM_DOA9;
inout	BRAM_DOA13;
inout	BRAM_DOB1;
inout	BRAM_DOB5;
inout	BRAM_DOB9;
inout	BRAM_DOB13;
inout	BRAM_ADDRA0;
inout	BRAM_ADDRA1;
inout	BRAM_ADDRA2;
inout	BRAM_ADDRA3;
inout	BRAM_ADDRB0;
inout	BRAM_ADDRB1;
inout	BRAM_ADDRB2;
inout	BRAM_ADDRB3;
inout	BRAM_CLKA;
inout	BRAM_WEA;
inout	BRAM_SELA;
inout	BRAM_RSTA;
inout	_1;
		wire		VDD ;

		SPS8T6X11H2 sps_rdins2(
											.IN4(BRAM_EB4),
											.IN5(BRAM_EB0),
											.IN6(BRAM_H6DB0),
											.IN7(BRAM_H6EB0),
											.IN0(BRAM_EB20),
											.IN1(BRAM_EB16),
											.IN2(BRAM_EB12),
											.IN3(BRAM_EB8),
											.OUT(BRAM_RDINS2),
											._1(1)
		);

		SPS8T6X11H2 sps_rdins6(
											.IN4(BRAM_EB5),
											.IN5(BRAM_EB1),
											.IN6(BRAM_H6DB1),
											.IN7(BRAM_H6EB1),
											.IN0(BRAM_EB21),
											.IN1(BRAM_EB17),
											.IN2(BRAM_EB13),
											.IN3(BRAM_EB9),
											.OUT(BRAM_RDINS6),
											._1(1)
		);

		SPS8T6X11H1 sps_llv2(
											.IN4(BRAM_EB4),
											.IN5(BRAM_EB0),
											.IN6(BRAM_H6DB0),
											.IN7(BRAM_H6EB0),
											.IN0(BRAM_EB20),
											.IN1(BRAM_EB16),
											.IN2(BRAM_EB12),
											.IN3(BRAM_EB8),
											.OUT(BRAM_LLV2),
											._1(1)
		);

		SPS8T6X11H1 sps_llv6(
											.IN4(BRAM_EB5),
											.IN5(BRAM_EB1),
											.IN6(BRAM_H6DB1),
											.IN7(BRAM_H6EB1),
											.IN0(BRAM_EB21),
											.IN1(BRAM_EB17),
											.IN2(BRAM_EB13),
											.IN3(BRAM_EB9),
											.OUT(BRAM_LLV6),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob1_rdouts25(
											.OUT(BRAM_RDOUTS25),
											.IN(BRAM_DOB1)
		);

		TRIBUF1T1X7H1 tribuf_dob1_rdouts24(
											.IN(BRAM_DOB1),
											.OUT(BRAM_RDOUTS24)
		);

		TRIBUF1T1X7H1 tribuf_doa13_rdouts0(
											.OUT(BRAM_RDOUTS0),
											.IN(BRAM_DOA13)
		);

		SPS8T6X11H2 sps_rdins10(
											.IN4(BRAM_EB6),
											.IN5(BRAM_EB2),
											.IN6(BRAM_H6DB2),
											.IN7(BRAM_H6EB2),
											.IN0(BRAM_EB22),
											.IN1(BRAM_EB18),
											.IN2(BRAM_EB14),
											.IN3(BRAM_EB10),
											.OUT(BRAM_RDINS10),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa1_rdouts24(
											.OUT(BRAM_RDOUTS24),
											.IN(BRAM_DOA1)
		);

		SPS8T6X11H2 sps_rdins14(
											.IN4(BRAM_EB7),
											.IN5(BRAM_EB3),
											.IN6(BRAM_H6DB3),
											.IN7(BRAM_H6EB3),
											.IN0(BRAM_EB23),
											.IN1(BRAM_EB19),
											.IN2(BRAM_EB15),
											.IN3(BRAM_EB11),
											.OUT(BRAM_RDINS14),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins18(
											.IN4(BRAM_EB4),
											.IN5(BRAM_EB0),
											.IN6(BRAM_H6DB0),
											.IN7(BRAM_H6EB0),
											.IN0(BRAM_EB20),
											.IN1(BRAM_EB16),
											.IN2(BRAM_EB12),
											.IN3(BRAM_EB8),
											.OUT(BRAM_RDINS18),
											._1(1)
		);

		SPS24B7X11H1 sps_wea(
											.IN8(VDD),
											.IN9(VDD),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS0),
											.IN1(BRAM_RADDRS1),
											.IN2(BRAM_RADDRS2),
											.IN3(BRAM_RADDRS3),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(VDD),
											.IN11(VDD),
											.OUT(BRAM_WEA),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob9_rdouts24(
											.IN(BRAM_DOB9),
											.OUT(BRAM_RDOUTS24)
		);

		SPS2T2X7H2 sps_eb19(
											.IN0(BRAM_RDOUTS30),
											.IN1(BRAM_RDOUTS14),
											.OUT(BRAM_EB19),
											._1(1)
		);

		SPS2T2X7H2 sps_eb18(
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS10),
											.OUT(BRAM_EB18),
											._1(1)
		);

		SPS2T2X7H2 sps_eb15(
											.IN0(BRAM_RDOUTS30),
											.IN1(BRAM_RDOUTS14),
											.OUT(BRAM_EB15),
											._1(1)
		);

		SPS2T2X7H2 sps_eb14(
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS10),
											.OUT(BRAM_EB14),
											._1(1)
		);

		SPS2T2X7H2 sps_eb17(
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS6),
											.OUT(BRAM_EB17),
											._1(1)
		);

		SPS2T2X7H2 sps_eb16(
											.IN0(BRAM_RDOUTS18),
											.IN1(BRAM_RDOUTS2),
											.OUT(BRAM_EB16),
											._1(1)
		);

		SPS2T2X7H2 sps_eb11(
											.IN0(BRAM_RDOUTS30),
											.IN1(BRAM_RDOUTS14),
											.OUT(BRAM_EB11),
											._1(1)
		);

		SPS2T2X7H2 sps_eb10(
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS10),
											.OUT(BRAM_EB10),
											._1(1)
		);

		SPS2T2X7H2 sps_eb13(
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS6),
											.OUT(BRAM_EB13),
											._1(1)
		);

		SPS2T2X7H2 sps_eb12(
											.IN0(BRAM_RDOUTS18),
											.IN1(BRAM_RDOUTS2),
											.OUT(BRAM_EB12),
											._1(1)
		);

		SPS8T6X11H1 sps_llv10(
											.IN4(BRAM_EB6),
											.IN5(BRAM_EB2),
											.IN6(BRAM_H6DB2),
											.IN7(BRAM_H6EB2),
											.IN0(BRAM_EB22),
											.IN1(BRAM_EB18),
											.IN2(BRAM_EB14),
											.IN3(BRAM_EB10),
											.OUT(BRAM_LLV10),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob1_rdouts6(
											.IN(BRAM_DOB1),
											.OUT(BRAM_RDOUTS6)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobb2(
											.OUT(BRAM_GCLK_IOBB2),
											.IN(BRAM_GCLKIN2)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobb3(
											.OUT(BRAM_GCLK_IOBB3),
											.IN(BRAM_GCLKIN3)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobb0(
											.OUT(BRAM_GCLK_IOBB0),
											.IN(BRAM_GCLKIN0)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobb1(
											.OUT(BRAM_GCLK_IOBB1),
											.IN(BRAM_GCLKIN1)
		);

		TRIBUF1T1X7H1 tribuf_dob5_rdouts18(
											.IN(BRAM_DOB5),
											.OUT(BRAM_RDOUTS18)
		);

		SPS8T6X11H2 sps_dib11(
											.IN4(BRAM_RDINS13),
											.IN5(BRAM_RDINS12),
											.IN6(BRAM_RDINS9),
											.IN7(BRAM_RDINS8),
											.IN0(BRAM_RDINS31),
											.IN1(BRAM_RDINS30),
											.IN2(BRAM_RDINS27),
											.IN3(BRAM_RDINS26),
											.OUT(BRAM_DIB11),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob13_rdouts1(
											.IN(BRAM_DOB13),
											.OUT(BRAM_RDOUTS1)
		);

		SPS8T6X11H1 sps_dia1(
											.IN4(BRAM_RDINS12),
											.IN5(BRAM_RDINS11),
											.IN6(BRAM_RDINS8),
											.IN7(BRAM_RDINS7),
											.IN0(BRAM_RDINS30),
											.IN1(BRAM_RDINS29),
											.IN2(BRAM_RDINS26),
											.IN3(BRAM_RDINS25),
											.OUT(BRAM_DIA1),
											._1(1)
		);

		SPS8T6X11H2 sps_dia3(
											.IN4(BRAM_RDINS12),
											.IN5(BRAM_RDINS11),
											.IN6(BRAM_RDINS8),
											.IN7(BRAM_RDINS7),
											.IN0(BRAM_RDINS30),
											.IN1(BRAM_RDINS29),
											.IN2(BRAM_RDINS26),
											.IN3(BRAM_RDINS25),
											.OUT(BRAM_DIA3),
											._1(1)
		);

		SPS8T6X11H1 sps_dia9(
											.IN4(BRAM_RDINS12),
											.IN5(BRAM_RDINS11),
											.IN6(BRAM_RDINS8),
											.IN7(BRAM_RDINS7),
											.IN0(BRAM_RDINS30),
											.IN1(BRAM_RDINS29),
											.IN2(BRAM_RDINS26),
											.IN3(BRAM_RDINS25),
											.OUT(BRAM_DIA9),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins30(
											.IN4(BRAM_EB7),
											.IN5(BRAM_EB3),
											.IN6(BRAM_H6DB3),
											.IN7(BRAM_H6EB3),
											.IN0(BRAM_EB23),
											.IN1(BRAM_EB19),
											.IN2(BRAM_EB15),
											.IN3(BRAM_EB11),
											.OUT(BRAM_RDINS30),
											._1(1)
		);

		SPS24B7X11H1 sps_sela(
											.IN8(VDD),
											.IN9(VDD),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS24),
											.IN1(BRAM_RADDRS25),
											.IN2(BRAM_RADDRS26),
											.IN3(BRAM_RADDRS27),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(VDD),
											.IN11(VDD),
											.OUT(BRAM_SELA),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		SPS24B7X11H1 sps_rsta(
											.IN8(VDD),
											.IN9(VDD),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS24),
											.IN1(BRAM_RADDRS25),
											.IN2(BRAM_RADDRS26),
											.IN3(BRAM_RADDRS27),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(VDD),
											.IN11(VDD),
											.OUT(BRAM_RSTA),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbb1(
											.OUT(BRAM_GCLK_CLBB1),
											.IN(BRAM_GCLKIN1)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbb0(
											.OUT(BRAM_GCLK_CLBB0),
											.IN(BRAM_GCLKIN0)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbb3(
											.OUT(BRAM_GCLK_CLBB3),
											.IN(BRAM_GCLKIN3)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbb2(
											.OUT(BRAM_GCLK_CLBB2),
											.IN(BRAM_GCLKIN2)
		);

		TRIBUF1T1X7H1 tribuf_doa1_rdouts23(
											.IN(BRAM_DOA1),
											.OUT(BRAM_RDOUTS23)
		);

		SPS8T6X11H2 sps_addrb2(
											.IN4(BRAM_RADDRS7),
											.IN5(BRAM_RADDRS6),
											.IN6(BRAM_RADDRS5),
											.IN7(BRAM_RADDRS4),
											.IN0(BRAM_RADDRS11),
											.IN1(BRAM_RADDRS10),
											.IN2(BRAM_RADDRS9),
											.IN3(BRAM_RADDRS8),
											.OUT(BRAM_ADDRB2),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb3(
											.IN4(BRAM_RADDRS7),
											.IN5(BRAM_RADDRS6),
											.IN6(BRAM_RADDRS5),
											.IN7(BRAM_RADDRS4),
											.IN0(BRAM_RADDRS11),
											.IN1(BRAM_RADDRS10),
											.IN2(BRAM_RADDRS9),
											.IN3(BRAM_RADDRS8),
											.OUT(BRAM_ADDRB3),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb0(
											.IN4(BRAM_RADDRS3),
											.IN5(BRAM_RADDRS2),
											.IN6(BRAM_RADDRS1),
											.IN7(BRAM_RADDRS0),
											.IN0(BRAM_RADDRS7),
											.IN1(BRAM_RADDRS6),
											.IN2(BRAM_RADDRS5),
											.IN3(BRAM_RADDRS4),
											.OUT(BRAM_ADDRB0),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb1(
											.IN4(BRAM_RADDRS3),
											.IN5(BRAM_RADDRS2),
											.IN6(BRAM_RADDRS1),
											.IN7(BRAM_RADDRS0),
											.IN0(BRAM_RADDRS7),
											.IN1(BRAM_RADDRS6),
											.IN2(BRAM_RADDRS5),
											.IN3(BRAM_RADDRS4),
											.OUT(BRAM_ADDRB1),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins26(
											.IN4(BRAM_EB6),
											.IN5(BRAM_EB2),
											.IN6(BRAM_H6DB2),
											.IN7(BRAM_H6EB2),
											.IN0(BRAM_EB22),
											.IN1(BRAM_EB18),
											.IN2(BRAM_EB14),
											.IN3(BRAM_EB10),
											.OUT(BRAM_RDINS26),
											._1(1)
		);

		SPS8T6X11H2 sps_dia11(
											.IN4(BRAM_RDINS12),
											.IN5(BRAM_RDINS11),
											.IN6(BRAM_RDINS8),
											.IN7(BRAM_RDINS7),
											.IN0(BRAM_RDINS30),
											.IN1(BRAM_RDINS29),
											.IN2(BRAM_RDINS26),
											.IN3(BRAM_RDINS25),
											.OUT(BRAM_DIA11),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa9_rdouts6(
											.IN(BRAM_DOA9),
											.OUT(BRAM_RDOUTS6)
		);

		SPS4T3X11H2 sps_h6mb1(
											.OUT(BRAM_H6MB1),
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS30),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											._1(1)
		);

		SPS4T3X11H2 sps_h6mb0(
											.OUT(BRAM_H6MB0),
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS18),
											.IN2(BRAM_RDOUTS6),
											.IN3(BRAM_RDOUTS2),
											._1(1)
		);

		SPS4T3X11H2 sps_h6mb3(
											.OUT(BRAM_H6MB3),
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS30),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											._1(1)
		);

		SPS4T3X11H2 sps_h6mb2(
											.OUT(BRAM_H6MB2),
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS18),
											.IN2(BRAM_RDOUTS6),
											.IN3(BRAM_RDOUTS2),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa5_rdouts0(
											.IN(BRAM_DOA5),
											.OUT(BRAM_RDOUTS0)
		);

		SPS8T6X11H1 sps_rdins22(
											.IN4(BRAM_EB5),
											.IN5(BRAM_EB1),
											.IN6(BRAM_H6DB1),
											.IN7(BRAM_H6EB1),
											.IN0(BRAM_EB21),
											.IN1(BRAM_EB17),
											.IN2(BRAM_EB13),
											.IN3(BRAM_EB9),
											.OUT(BRAM_RDINS22),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob5_rdouts0(
											.IN(BRAM_DOB5),
											.OUT(BRAM_RDOUTS0)
		);

		TRIBUF1T1X7H1 tribuf_dob5_rdouts1(
											.OUT(BRAM_RDOUTS1),
											.IN(BRAM_DOB5)
		);

		TRIBUF1T1X7H1 tribuf_dob1_rdouts7(
											.OUT(BRAM_RDOUTS7),
											.IN(BRAM_DOB1)
		);

		SPS8T6X11H2 sps_raddrs2(
											.IN4(BRAM_EB4),
											.IN5(BRAM_EB0),
											.IN6(BRAM_H6DB0),
											.IN7(BRAM_H6EB0),
											.IN0(BRAM_EB20),
											.IN1(BRAM_EB16),
											.IN2(BRAM_EB12),
											.IN3(BRAM_EB8),
											.OUT(BRAM_RADDRS2),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob5_rdouts19(
											.OUT(BRAM_RDOUTS19),
											.IN(BRAM_DOB5)
		);

		SPS8T6X11H2 sps_raddrs6(
											.IN4(BRAM_EB5),
											.IN5(BRAM_EB1),
											.IN6(BRAM_H6DB1),
											.IN7(BRAM_H6EB1),
											.IN0(BRAM_EB21),
											.IN1(BRAM_EB17),
											.IN2(BRAM_EB13),
											.IN3(BRAM_EB9),
											.OUT(BRAM_RADDRS6),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa5_rdouts18(
											.IN(BRAM_DOA5),
											.OUT(BRAM_RDOUTS18)
		);

		TRIBUF1T1X7H1 tribuf_doa5_rdouts15(
											.OUT(BRAM_RDOUTS15),
											.IN(BRAM_DOA5)
		);

		TRIBUF1T1X7H1 tribuf_doa5_rdouts17(
											.IN(BRAM_DOA5),
											.OUT(BRAM_RDOUTS17)
		);

		SPS8T6X11H1 sps_raddrs30(
											.IN4(BRAM_EB7),
											.IN5(BRAM_EB3),
											.IN6(BRAM_H6DB3),
											.IN7(BRAM_H6EB3),
											.IN0(BRAM_EB23),
											.IN1(BRAM_EB19),
											.IN2(BRAM_EB15),
											.IN3(BRAM_EB11),
											.OUT(BRAM_RADDRS30),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa9_rdouts23(
											.OUT(BRAM_RDOUTS23),
											.IN(BRAM_DOA9)
		);

		SPS8T6X11H1 sps_lhb9(
											.IN4(BRAM_RDOUTS18),
											.IN5(BRAM_RDOUTS22),
											.IN6(BRAM_RDOUTS26),
											.IN7(BRAM_RDOUTS30),
											.IN0(BRAM_RDOUTS2),
											.IN1(BRAM_RDOUTS6),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											.OUT(BRAM_LHB9),
											._1(1)
		);

		SPS8T6X11H1 sps_lhb0(
											.IN4(BRAM_RDOUTS18),
											.IN5(BRAM_RDOUTS22),
											.IN6(BRAM_RDOUTS26),
											.IN7(BRAM_RDOUTS30),
											.IN0(BRAM_RDOUTS2),
											.IN1(BRAM_RDOUTS6),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											.OUT(BRAM_LHB0),
											._1(1)
		);

		SPS8T6X11H1 sps_lhb3(
											.IN4(BRAM_RDOUTS18),
											.IN5(BRAM_RDOUTS22),
											.IN6(BRAM_RDOUTS26),
											.IN7(BRAM_RDOUTS30),
											.IN0(BRAM_RDOUTS2),
											.IN1(BRAM_RDOUTS6),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											.OUT(BRAM_LHB3),
											._1(1)
		);

		SPS8T6X11H1 sps_lhb6(
											.IN4(BRAM_RDOUTS18),
											.IN5(BRAM_RDOUTS22),
											.IN6(BRAM_RDOUTS26),
											.IN7(BRAM_RDOUTS30),
											.IN0(BRAM_RDOUTS2),
											.IN1(BRAM_RDOUTS6),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											.OUT(BRAM_LHB6),
											._1(1)
		);

		SPS2T2X7H2 sps_eb1(
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS6),
											.OUT(BRAM_EB1),
											._1(1)
		);

		SPS2T2X7H2 sps_eb0(
											.IN0(BRAM_RDOUTS18),
											.IN1(BRAM_RDOUTS2),
											.OUT(BRAM_EB0),
											._1(1)
		);

		SPS2T2X7H2 sps_eb3(
											.IN0(BRAM_RDOUTS30),
											.IN1(BRAM_RDOUTS14),
											.OUT(BRAM_EB3),
											._1(1)
		);

		SPS2T2X7H2 sps_eb2(
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS10),
											.OUT(BRAM_EB2),
											._1(1)
		);

		SPS2T2X7H2 sps_eb5(
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS6),
											.OUT(BRAM_EB5),
											._1(1)
		);

		SPS2T2X7H2 sps_eb4(
											.IN0(BRAM_RDOUTS18),
											.IN1(BRAM_RDOUTS2),
											.OUT(BRAM_EB4),
											._1(1)
		);

		SPS2T2X7H2 sps_eb7(
											.IN0(BRAM_RDOUTS30),
											.IN1(BRAM_RDOUTS14),
											.OUT(BRAM_EB7),
											._1(1)
		);

		SPS2T2X7H2 sps_eb6(
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS10),
											.OUT(BRAM_EB6),
											._1(1)
		);

		SPS2T2X7H2 sps_eb9(
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS6),
											.OUT(BRAM_EB9),
											._1(1)
		);

		SPS2T2X7H2 sps_eb8(
											.IN0(BRAM_RDOUTS18),
											.IN1(BRAM_RDOUTS2),
											.OUT(BRAM_EB8),
											._1(1)
		);

		SPS8T6X11H1 sps_addra3(
											.IN4(BRAM_RADDRS7),
											.IN5(BRAM_RADDRS6),
											.IN6(BRAM_RADDRS5),
											.IN7(BRAM_RADDRS4),
											.IN0(BRAM_RADDRS11),
											.IN1(BRAM_RADDRS10),
											.IN2(BRAM_RADDRS9),
											.IN3(BRAM_RADDRS8),
											.OUT(BRAM_ADDRA3),
											._1(1)
		);

		SPS8T6X11H1 sps_addra2(
											.IN4(BRAM_RADDRS7),
											.IN5(BRAM_RADDRS6),
											.IN6(BRAM_RADDRS5),
											.IN7(BRAM_RADDRS4),
											.IN0(BRAM_RADDRS11),
											.IN1(BRAM_RADDRS10),
											.IN2(BRAM_RADDRS9),
											.IN3(BRAM_RADDRS8),
											.OUT(BRAM_ADDRA2),
											._1(1)
		);

		SPS8T6X11H1 sps_addra1(
											.IN4(BRAM_RADDRS3),
											.IN5(BRAM_RADDRS2),
											.IN6(BRAM_RADDRS1),
											.IN7(BRAM_RADDRS0),
											.IN0(BRAM_RADDRS7),
											.IN1(BRAM_RADDRS6),
											.IN2(BRAM_RADDRS5),
											.IN3(BRAM_RADDRS4),
											.OUT(BRAM_ADDRA1),
											._1(1)
		);

		SPS8T6X11H1 sps_addra0(
											.IN4(BRAM_RADDRS3),
											.IN5(BRAM_RADDRS2),
											.IN6(BRAM_RADDRS1),
											.IN7(BRAM_RADDRS0),
											.IN0(BRAM_RADDRS7),
											.IN1(BRAM_RADDRS6),
											.IN2(BRAM_RADDRS5),
											.IN3(BRAM_RADDRS4),
											.OUT(BRAM_ADDRA0),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs26(
											.IN4(BRAM_EB6),
											.IN5(BRAM_EB2),
											.IN6(BRAM_H6DB2),
											.IN7(BRAM_H6EB2),
											.IN0(BRAM_EB22),
											.IN1(BRAM_EB18),
											.IN2(BRAM_EB14),
											.IN3(BRAM_EB10),
											.OUT(BRAM_RADDRS26),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs22(
											.IN4(BRAM_EB5),
											.IN5(BRAM_EB1),
											.IN6(BRAM_H6DB1),
											.IN7(BRAM_H6EB1),
											.IN0(BRAM_EB21),
											.IN1(BRAM_EB17),
											.IN2(BRAM_EB13),
											.IN3(BRAM_EB9),
											.OUT(BRAM_RADDRS22),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob13_rdouts18(
											.IN(BRAM_DOB13),
											.OUT(BRAM_RDOUTS18)
		);

		SPS2T2X7H2 sps_eb20(
											.IN0(BRAM_RDOUTS18),
											.IN1(BRAM_RDOUTS2),
											.OUT(BRAM_EB20),
											._1(1)
		);

		SPS2T2X7H2 sps_eb21(
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS6),
											.OUT(BRAM_EB21),
											._1(1)
		);

		SPS2T2X7H2 sps_eb22(
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS10),
											.OUT(BRAM_EB22),
											._1(1)
		);

		SPS2T2X7H2 sps_eb23(
											.IN0(BRAM_RDOUTS30),
											.IN1(BRAM_RDOUTS14),
											.OUT(BRAM_EB23),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa1_rdouts5(
											.OUT(BRAM_RDOUTS5),
											.IN(BRAM_DOA1)
		);

		TRIBUF1T1X7H1 tribuf_doa1_rdouts6(
											.IN(BRAM_DOA1),
											.OUT(BRAM_RDOUTS6)
		);

		TRIBUF1T1X7H1 tribuf_doa13_rdouts17(
											.OUT(BRAM_RDOUTS17),
											.IN(BRAM_DOA13)
		);

		SPS24B7X11H1 sps_clka(
											.IN8(BRAM_GCLKIN0),
											.IN9(BRAM_GCLKIN1),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS0),
											.IN1(BRAM_RADDRS1),
											.IN2(BRAM_RADDRS2),
											.IN3(BRAM_RADDRS3),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(BRAM_GCLKIN2),
											.IN11(BRAM_GCLKIN3),
											.OUT(BRAM_CLKA),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs18(
											.IN4(BRAM_EB4),
											.IN5(BRAM_EB0),
											.IN6(BRAM_H6DB0),
											.IN7(BRAM_H6EB0),
											.IN0(BRAM_EB20),
											.IN1(BRAM_EB16),
											.IN2(BRAM_EB12),
											.IN3(BRAM_EB8),
											.OUT(BRAM_RADDRS18),
											._1(1)
		);

		SPS8T6X11H1 sps_dib9(
											.IN4(BRAM_RDINS13),
											.IN5(BRAM_RDINS12),
											.IN6(BRAM_RDINS9),
											.IN7(BRAM_RDINS8),
											.IN0(BRAM_RDINS31),
											.IN1(BRAM_RDINS30),
											.IN2(BRAM_RDINS27),
											.IN3(BRAM_RDINS26),
											.OUT(BRAM_DIB9),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs10(
											.IN4(BRAM_EB6),
											.IN5(BRAM_EB2),
											.IN6(BRAM_H6DB2),
											.IN7(BRAM_H6EB2),
											.IN0(BRAM_EB22),
											.IN1(BRAM_EB18),
											.IN2(BRAM_EB14),
											.IN3(BRAM_EB10),
											.OUT(BRAM_RADDRS10),
											._1(1)
		);

		SPS8T6X11H1 sps_dib1(
											.IN4(BRAM_RDINS13),
											.IN5(BRAM_RDINS12),
											.IN6(BRAM_RDINS9),
											.IN7(BRAM_RDINS8),
											.IN0(BRAM_RDINS31),
											.IN1(BRAM_RDINS30),
											.IN2(BRAM_RDINS27),
											.IN3(BRAM_RDINS26),
											.OUT(BRAM_DIB1),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs14(
											.IN4(BRAM_EB7),
											.IN5(BRAM_EB3),
											.IN6(BRAM_H6DB3),
											.IN7(BRAM_H6EB3),
											.IN0(BRAM_EB23),
											.IN1(BRAM_EB19),
											.IN2(BRAM_EB15),
											.IN3(BRAM_EB11),
											.OUT(BRAM_RADDRS14),
											._1(1)
		);

		SPS8T6X11H2 sps_dib3(
											.IN4(BRAM_RDINS13),
											.IN5(BRAM_RDINS12),
											.IN6(BRAM_RDINS9),
											.IN7(BRAM_RDINS8),
											.IN0(BRAM_RDINS31),
											.IN1(BRAM_RDINS30),
											.IN2(BRAM_RDINS27),
											.IN3(BRAM_RDINS26),
											.OUT(BRAM_DIB3),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob9_rdouts7(
											.IN(BRAM_DOB9),
											.OUT(BRAM_RDOUTS7)
		);

		SPS4T3X11H2 sps_h6bb2(
											.OUT(BRAM_H6BB2),
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS18),
											.IN2(BRAM_RDOUTS6),
											.IN3(BRAM_RDOUTS2),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bb3(
											.OUT(BRAM_H6BB3),
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS30),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bb0(
											.OUT(BRAM_H6BB0),
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS18),
											.IN2(BRAM_RDOUTS6),
											.IN3(BRAM_RDOUTS2),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bb1(
											.OUT(BRAM_H6BB1),
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS30),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											._1(1)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_RBRAMD(
BRAM_ED0, BRAM_ED1, BRAM_ED2, BRAM_ED3, BRAM_ED4, BRAM_ED5, BRAM_ED6, BRAM_ED7, BRAM_ED8, BRAM_ED9, BRAM_ED10, BRAM_ED11, BRAM_ED12, BRAM_ED13, BRAM_ED14, BRAM_ED15, BRAM_ED16, BRAM_ED17, BRAM_ED18, BRAM_ED19, BRAM_ED20, BRAM_ED21, BRAM_ED22, BRAM_ED23, BRAM_H6ED0, BRAM_H6ED1, BRAM_H6ED2, BRAM_H6ED3, BRAM_H6BD0, BRAM_H6BD1, BRAM_H6BD2, BRAM_H6BD3, BRAM_H6MD0, BRAM_H6MD1, BRAM_H6MD2, BRAM_H6MD3, BRAM_H6DD0, BRAM_H6DD1, BRAM_H6DD2, BRAM_H6DD3, BRAM_LHD0, BRAM_LHD3, BRAM_LHD6, BRAM_LHD9, BRAM_LLV0, BRAM_LLV4, BRAM_LLV8, BRAM_RDOUTS0, BRAM_RDOUTS1, BRAM_RDOUTS2, BRAM_RDOUTS3, BRAM_RDOUTS4, BRAM_RDOUTS7, BRAM_RDOUTS8, BRAM_RDOUTS9, BRAM_RDOUTS12, BRAM_RDOUTS16, BRAM_RDOUTS19, BRAM_RDOUTS20, BRAM_RDOUTS21, BRAM_RDOUTS24, BRAM_RDOUTS25, BRAM_RDOUTS26, BRAM_RDOUTS27, BRAM_RDOUTS28, BRAM_RADDRS0, BRAM_RADDRS4, BRAM_RADDRS8, BRAM_RADDRS12, BRAM_RADDRS16, BRAM_RADDRS17, BRAM_RADDRS18, BRAM_RADDRS19, BRAM_RADDRS20, BRAM_RADDRS21, BRAM_RADDRS22, BRAM_RADDRS23, BRAM_RADDRS24, BRAM_RADDRS25, BRAM_RADDRS26, BRAM_RADDRS27, BRAM_RADDRS28, BRAM_RDINS0, BRAM_RDINS4, BRAM_RDINS8, BRAM_RDINS9, BRAM_RDINS10, BRAM_RDINS11, BRAM_RDINS12, BRAM_RDINS13, BRAM_RDINS14, BRAM_RDINS15, BRAM_RDINS16, BRAM_RDINS17, BRAM_RDINS20, BRAM_RDINS24, BRAM_RDINS27, BRAM_RDINS28, BRAM_RDINS29, BRAM_RDINS31, BRAM_GCLKIN0, BRAM_GCLKIN1, BRAM_GCLKIN2, BRAM_GCLKIN3, BRAM_GCLK_IOBD0, BRAM_GCLK_IOBD1, BRAM_GCLK_IOBD2, BRAM_GCLK_IOBD3, BRAM_GCLK_CLBD0, BRAM_GCLK_CLBD1, BRAM_GCLK_CLBD2, BRAM_GCLK_CLBD3, BRAM_DIA6, BRAM_DIA7, BRAM_DIA14, BRAM_DIA15, BRAM_DIB6, BRAM_DIB7, BRAM_DIB14, BRAM_DIB15, BRAM_DOA3, BRAM_DOA7, BRAM_DOA11, BRAM_DOA15, BRAM_DOB3, BRAM_DOB7, BRAM_DOB11, BRAM_DOB15, BRAM_ADDRB8, BRAM_ADDRB9, BRAM_ADDRB10, BRAM_ADDRB11, BRAM_ADDRA8, BRAM_ADDRA9, BRAM_ADDRA10, BRAM_ADDRA11, _1
);
inout	BRAM_ED0;
inout	BRAM_ED1;
inout	BRAM_ED2;
inout	BRAM_ED3;
inout	BRAM_ED4;
inout	BRAM_ED5;
inout	BRAM_ED6;
inout	BRAM_ED7;
inout	BRAM_ED8;
inout	BRAM_ED9;
inout	BRAM_ED10;
inout	BRAM_ED11;
inout	BRAM_ED12;
inout	BRAM_ED13;
inout	BRAM_ED14;
inout	BRAM_ED15;
inout	BRAM_ED16;
inout	BRAM_ED17;
inout	BRAM_ED18;
inout	BRAM_ED19;
inout	BRAM_ED20;
inout	BRAM_ED21;
inout	BRAM_ED22;
inout	BRAM_ED23;
inout	BRAM_H6ED0;
inout	BRAM_H6ED1;
inout	BRAM_H6ED2;
inout	BRAM_H6ED3;
inout	BRAM_H6BD0;
inout	BRAM_H6BD1;
inout	BRAM_H6BD2;
inout	BRAM_H6BD3;
inout	BRAM_H6MD0;
inout	BRAM_H6MD1;
inout	BRAM_H6MD2;
inout	BRAM_H6MD3;
inout	BRAM_H6DD0;
inout	BRAM_H6DD1;
inout	BRAM_H6DD2;
inout	BRAM_H6DD3;
inout	BRAM_LHD0;
inout	BRAM_LHD3;
inout	BRAM_LHD6;
inout	BRAM_LHD9;
inout	BRAM_LLV0;
inout	BRAM_LLV4;
inout	BRAM_LLV8;
inout	BRAM_RDOUTS0;
inout	BRAM_RDOUTS1;
inout	BRAM_RDOUTS2;
inout	BRAM_RDOUTS3;
inout	BRAM_RDOUTS4;
inout	BRAM_RDOUTS7;
inout	BRAM_RDOUTS8;
inout	BRAM_RDOUTS9;
inout	BRAM_RDOUTS12;
inout	BRAM_RDOUTS16;
inout	BRAM_RDOUTS19;
inout	BRAM_RDOUTS20;
inout	BRAM_RDOUTS21;
inout	BRAM_RDOUTS24;
inout	BRAM_RDOUTS25;
inout	BRAM_RDOUTS26;
inout	BRAM_RDOUTS27;
inout	BRAM_RDOUTS28;
inout	BRAM_RADDRS0;
inout	BRAM_RADDRS4;
inout	BRAM_RADDRS8;
inout	BRAM_RADDRS12;
inout	BRAM_RADDRS16;
inout	BRAM_RADDRS17;
inout	BRAM_RADDRS18;
inout	BRAM_RADDRS19;
inout	BRAM_RADDRS20;
inout	BRAM_RADDRS21;
inout	BRAM_RADDRS22;
inout	BRAM_RADDRS23;
inout	BRAM_RADDRS24;
inout	BRAM_RADDRS25;
inout	BRAM_RADDRS26;
inout	BRAM_RADDRS27;
inout	BRAM_RADDRS28;
inout	BRAM_RDINS0;
inout	BRAM_RDINS4;
inout	BRAM_RDINS8;
inout	BRAM_RDINS9;
inout	BRAM_RDINS10;
inout	BRAM_RDINS11;
inout	BRAM_RDINS12;
inout	BRAM_RDINS13;
inout	BRAM_RDINS14;
inout	BRAM_RDINS15;
inout	BRAM_RDINS16;
inout	BRAM_RDINS17;
inout	BRAM_RDINS20;
inout	BRAM_RDINS24;
inout	BRAM_RDINS27;
inout	BRAM_RDINS28;
inout	BRAM_RDINS29;
inout	BRAM_RDINS31;
inout	BRAM_GCLKIN0;
inout	BRAM_GCLKIN1;
inout	BRAM_GCLKIN2;
inout	BRAM_GCLKIN3;
inout	BRAM_GCLK_IOBD0;
inout	BRAM_GCLK_IOBD1;
inout	BRAM_GCLK_IOBD2;
inout	BRAM_GCLK_IOBD3;
inout	BRAM_GCLK_CLBD0;
inout	BRAM_GCLK_CLBD1;
inout	BRAM_GCLK_CLBD2;
inout	BRAM_GCLK_CLBD3;
inout	BRAM_DIA6;
inout	BRAM_DIA7;
inout	BRAM_DIA14;
inout	BRAM_DIA15;
inout	BRAM_DIB6;
inout	BRAM_DIB7;
inout	BRAM_DIB14;
inout	BRAM_DIB15;
inout	BRAM_DOA3;
inout	BRAM_DOA7;
inout	BRAM_DOA11;
inout	BRAM_DOA15;
inout	BRAM_DOB3;
inout	BRAM_DOB7;
inout	BRAM_DOB11;
inout	BRAM_DOB15;
inout	BRAM_ADDRB8;
inout	BRAM_ADDRB9;
inout	BRAM_ADDRB10;
inout	BRAM_ADDRB11;
inout	BRAM_ADDRA8;
inout	BRAM_ADDRA9;
inout	BRAM_ADDRA10;
inout	BRAM_ADDRA11;
inout	_1;

		SPS2T2X7H2 sps_ed9(
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS4),
											.OUT(BRAM_ED9),
											._1(1)
		);

		SPS8T6X11H2 sps_rdins0(
											.IN4(BRAM_ED4),
											.IN5(BRAM_ED0),
											.IN6(BRAM_H6DD0),
											.IN7(BRAM_H6ED0),
											.IN0(BRAM_ED20),
											.IN1(BRAM_ED16),
											.IN2(BRAM_ED12),
											.IN3(BRAM_ED8),
											.OUT(BRAM_RDINS0),
											._1(1)
		);

		SPS8T6X11H2 sps_rdins4(
											.IN4(BRAM_ED5),
											.IN5(BRAM_ED1),
											.IN6(BRAM_H6DD1),
											.IN7(BRAM_H6ED1),
											.IN0(BRAM_ED21),
											.IN1(BRAM_ED17),
											.IN2(BRAM_ED13),
											.IN3(BRAM_ED9),
											.OUT(BRAM_RDINS4),
											._1(1)
		);

		SPS2T2X7H2 sps_ed3(
											.IN0(BRAM_RDOUTS28),
											.IN1(BRAM_RDOUTS12),
											.OUT(BRAM_ED3),
											._1(1)
		);

		SPS2T2X7H2 sps_ed2(
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS8),
											.OUT(BRAM_ED2),
											._1(1)
		);

		SPS2T2X7H2 sps_ed1(
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS4),
											.OUT(BRAM_ED1),
											._1(1)
		);

		SPS2T2X7H2 sps_ed0(
											.IN0(BRAM_RDOUTS16),
											.IN1(BRAM_RDOUTS0),
											.OUT(BRAM_ED0),
											._1(1)
		);

		SPS2T2X7H2 sps_ed7(
											.IN0(BRAM_RDOUTS28),
											.IN1(BRAM_RDOUTS12),
											.OUT(BRAM_ED7),
											._1(1)
		);

		SPS2T2X7H2 sps_ed6(
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS8),
											.OUT(BRAM_ED6),
											._1(1)
		);

		SPS2T2X7H2 sps_ed5(
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS4),
											.OUT(BRAM_ED5),
											._1(1)
		);

		SPS2T2X7H2 sps_ed4(
											.IN0(BRAM_RDOUTS16),
											.IN1(BRAM_RDOUTS0),
											.OUT(BRAM_ED4),
											._1(1)
		);

		SPS8T6X11H1 sps_llv0(
											.IN4(BRAM_ED4),
											.IN5(BRAM_ED0),
											.IN6(BRAM_H6DD0),
											.IN7(BRAM_H6ED0),
											.IN0(BRAM_ED20),
											.IN1(BRAM_ED16),
											.IN2(BRAM_ED12),
											.IN3(BRAM_ED8),
											.OUT(BRAM_LLV0),
											._1(1)
		);

		SPS2T2X7H2 sps_ed8(
											.IN0(BRAM_RDOUTS16),
											.IN1(BRAM_RDOUTS0),
											.OUT(BRAM_ED8),
											._1(1)
		);

		SPS8T6X11H1 sps_llv4(
											.IN4(BRAM_ED5),
											.IN5(BRAM_ED1),
											.IN6(BRAM_H6DD1),
											.IN7(BRAM_H6ED1),
											.IN0(BRAM_ED21),
											.IN1(BRAM_ED17),
											.IN2(BRAM_ED13),
											.IN3(BRAM_ED9),
											.OUT(BRAM_LLV4),
											._1(1)
		);

		SPS8T6X11H1 sps_llv8(
											.IN4(BRAM_ED6),
											.IN5(BRAM_ED2),
											.IN6(BRAM_H6DD2),
											.IN7(BRAM_H6ED2),
											.IN0(BRAM_ED22),
											.IN1(BRAM_ED18),
											.IN2(BRAM_ED14),
											.IN3(BRAM_ED10),
											.OUT(BRAM_LLV8),
											._1(1)
		);

		SPS8T6X11H2 sps_rdins12(
											.IN4(BRAM_ED7),
											.IN5(BRAM_ED3),
											.IN6(BRAM_H6DD3),
											.IN7(BRAM_H6ED3),
											.IN0(BRAM_ED23),
											.IN1(BRAM_ED19),
											.IN2(BRAM_ED15),
											.IN3(BRAM_ED11),
											.OUT(BRAM_RDINS12),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins16(
											.IN4(BRAM_ED4),
											.IN5(BRAM_ED0),
											.IN6(BRAM_H6DD0),
											.IN7(BRAM_H6ED0),
											.IN0(BRAM_ED20),
											.IN1(BRAM_ED16),
											.IN2(BRAM_ED12),
											.IN3(BRAM_ED8),
											.OUT(BRAM_RDINS16),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob15_rdouts9(
											.IN(BRAM_DOB15),
											.OUT(BRAM_RDOUTS9)
		);

		SPS8T6X11H2 sps_rdins8(
											.IN4(BRAM_ED6),
											.IN5(BRAM_ED2),
											.IN6(BRAM_H6DD2),
											.IN7(BRAM_H6ED2),
											.IN0(BRAM_ED22),
											.IN1(BRAM_ED18),
											.IN2(BRAM_ED14),
											.IN3(BRAM_ED10),
											.OUT(BRAM_RDINS8),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa11_rdouts2(
											.OUT(BRAM_RDOUTS2),
											.IN(BRAM_DOA11)
		);

		TRIBUF1T1X7H1 tribuf_dob3_rdouts2(
											.IN(BRAM_DOB3),
											.OUT(BRAM_RDOUTS2)
		);

		TRIBUF1T1X7H1 tribuf_dob3_rdouts3(
											.OUT(BRAM_RDOUTS3),
											.IN(BRAM_DOB3)
		);

		SPS8T6X11H1 sps_dib14(
											.IN4(BRAM_RDINS15),
											.IN5(BRAM_RDINS14),
											.IN6(BRAM_RDINS11),
											.IN7(BRAM_RDINS10),
											.IN0(BRAM_RDINS29),
											.IN1(BRAM_RDINS28),
											.IN2(BRAM_RDINS17),
											.IN3(BRAM_RDINS16),
											.OUT(BRAM_DIB14),
											._1(1)
		);

		SPS8T6X11H2 sps_dib15(
											.IN4(BRAM_RDINS15),
											.IN5(BRAM_RDINS14),
											.IN6(BRAM_RDINS11),
											.IN7(BRAM_RDINS10),
											.IN0(BRAM_RDINS29),
											.IN1(BRAM_RDINS28),
											.IN2(BRAM_RDINS17),
											.IN3(BRAM_RDINS16),
											.OUT(BRAM_DIB15),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb10(
											.IN4(BRAM_RADDRS23),
											.IN5(BRAM_RADDRS22),
											.IN6(BRAM_RADDRS21),
											.IN7(BRAM_RADDRS20),
											.IN0(BRAM_RADDRS27),
											.IN1(BRAM_RADDRS26),
											.IN2(BRAM_RADDRS25),
											.IN3(BRAM_RADDRS24),
											.OUT(BRAM_ADDRB10),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb11(
											.IN4(BRAM_RADDRS23),
											.IN5(BRAM_RADDRS22),
											.IN6(BRAM_RADDRS21),
											.IN7(BRAM_RADDRS20),
											.IN0(BRAM_RADDRS27),
											.IN1(BRAM_RADDRS26),
											.IN2(BRAM_RADDRS25),
											.IN3(BRAM_RADDRS24),
											.OUT(BRAM_ADDRB11),
											._1(1)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobd0(
											.OUT(BRAM_GCLK_IOBD0),
											.IN(BRAM_GCLKIN0)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobd1(
											.OUT(BRAM_GCLK_IOBD1),
											.IN(BRAM_GCLKIN1)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobd2(
											.OUT(BRAM_GCLK_IOBD2),
											.IN(BRAM_GCLKIN2)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobd3(
											.OUT(BRAM_GCLK_IOBD3),
											.IN(BRAM_GCLKIN3)
		);

		SPS8T6X11H2 sps_dia7(
											.IN4(BRAM_RDINS14),
											.IN5(BRAM_RDINS13),
											.IN6(BRAM_RDINS10),
											.IN7(BRAM_RDINS9),
											.IN0(BRAM_RDINS28),
											.IN1(BRAM_RDINS27),
											.IN2(BRAM_RDINS16),
											.IN3(BRAM_RDINS31),
											.OUT(BRAM_DIA7),
											._1(1)
		);

		SPS8T6X11H1 sps_dia6(
											.IN4(BRAM_RDINS14),
											.IN5(BRAM_RDINS13),
											.IN6(BRAM_RDINS10),
											.IN7(BRAM_RDINS9),
											.IN0(BRAM_RDINS28),
											.IN1(BRAM_RDINS27),
											.IN2(BRAM_RDINS16),
											.IN3(BRAM_RDINS31),
											.OUT(BRAM_DIA6),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa7_rdouts7(
											.OUT(BRAM_RDOUTS7),
											.IN(BRAM_DOA7)
		);

		TRIBUF1T1X7H1 tribuf_doa7_rdouts8(
											.IN(BRAM_DOA7),
											.OUT(BRAM_RDOUTS8)
		);

		TRIBUF1T1X7H1 tribuf_dob7_rdouts27(
											.OUT(BRAM_RDOUTS27),
											.IN(BRAM_DOB7)
		);

		TRIBUF1T1X7H1 tribuf_dob7_rdouts26(
											.IN(BRAM_DOB7),
											.OUT(BRAM_RDOUTS26)
		);

		TRIBUF1T1X7H1 tribuf_doa15_rdouts25(
											.OUT(BRAM_RDOUTS25),
											.IN(BRAM_DOA15)
		);

		TRIBUF1T1X7H1 tribuf_doa11_rdouts19(
											.OUT(BRAM_RDOUTS19),
											.IN(BRAM_DOA11)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbd3(
											.OUT(BRAM_GCLK_CLBD3),
											.IN(BRAM_GCLKIN3)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbd2(
											.OUT(BRAM_GCLK_CLBD2),
											.IN(BRAM_GCLKIN2)
		);

		TRIBUF1T1X7H1 tribuf_doa3_rdouts19(
											.IN(BRAM_DOA3),
											.OUT(BRAM_RDOUTS19)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbd0(
											.OUT(BRAM_GCLK_CLBD0),
											.IN(BRAM_GCLKIN0)
		);

		TRIBUF1T1X7H1 tribuf_dob3_rdouts21(
											.OUT(BRAM_RDOUTS21),
											.IN(BRAM_DOB3)
		);

		TRIBUF1T1X7H1 tribuf_dob3_rdouts20(
											.IN(BRAM_DOB3),
											.OUT(BRAM_RDOUTS20)
		);

		SPS8T6X11H1 sps_rdins28(
											.IN4(BRAM_ED7),
											.IN5(BRAM_ED3),
											.IN6(BRAM_H6DD3),
											.IN7(BRAM_H6ED3),
											.IN0(BRAM_ED23),
											.IN1(BRAM_ED19),
											.IN2(BRAM_ED15),
											.IN3(BRAM_ED11),
											.OUT(BRAM_RDINS28),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb9(
											.IN4(BRAM_RADDRS19),
											.IN5(BRAM_RADDRS18),
											.IN6(BRAM_RADDRS17),
											.IN7(BRAM_RADDRS16),
											.IN0(BRAM_RADDRS23),
											.IN1(BRAM_RADDRS22),
											.IN2(BRAM_RADDRS21),
											.IN3(BRAM_RADDRS20),
											.OUT(BRAM_ADDRB9),
											._1(1)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbd1(
											.OUT(BRAM_GCLK_CLBD1),
											.IN(BRAM_GCLKIN1)
		);

		SPS8T6X11H1 sps_rdins20(
											.IN4(BRAM_ED5),
											.IN5(BRAM_ED1),
											.IN6(BRAM_H6DD1),
											.IN7(BRAM_H6ED1),
											.IN0(BRAM_ED21),
											.IN1(BRAM_ED17),
											.IN2(BRAM_ED13),
											.IN3(BRAM_ED9),
											.OUT(BRAM_RDINS20),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins24(
											.IN4(BRAM_ED6),
											.IN5(BRAM_ED2),
											.IN6(BRAM_H6DD2),
											.IN7(BRAM_H6ED2),
											.IN0(BRAM_ED22),
											.IN1(BRAM_ED18),
											.IN2(BRAM_ED14),
											.IN3(BRAM_ED10),
											.OUT(BRAM_RDINS24),
											._1(1)
		);

		SPS8T6X11H2 sps_dia15(
											.IN4(BRAM_RDINS14),
											.IN5(BRAM_RDINS13),
											.IN6(BRAM_RDINS10),
											.IN7(BRAM_RDINS9),
											.IN0(BRAM_RDINS28),
											.IN1(BRAM_RDINS27),
											.IN2(BRAM_RDINS16),
											.IN3(BRAM_RDINS31),
											.OUT(BRAM_DIA15),
											._1(1)
		);

		SPS8T6X11H1 sps_dia14(
											.IN4(BRAM_RDINS14),
											.IN5(BRAM_RDINS13),
											.IN6(BRAM_RDINS10),
											.IN7(BRAM_RDINS9),
											.IN0(BRAM_RDINS28),
											.IN1(BRAM_RDINS27),
											.IN2(BRAM_RDINS16),
											.IN3(BRAM_RDINS31),
											.OUT(BRAM_DIA14),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb8(
											.IN4(BRAM_RADDRS19),
											.IN5(BRAM_RADDRS18),
											.IN6(BRAM_RADDRS17),
											.IN7(BRAM_RADDRS16),
											.IN0(BRAM_RADDRS23),
											.IN1(BRAM_RADDRS22),
											.IN2(BRAM_RADDRS21),
											.IN3(BRAM_RADDRS20),
											.OUT(BRAM_ADDRB8),
											._1(1)
		);

		SPS4T3X11H2 sps_h6md3(
											.OUT(BRAM_H6MD3),
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS28),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa3_rdouts2(
											.IN(BRAM_DOA3),
											.OUT(BRAM_RDOUTS2)
		);

		TRIBUF1T1X7H1 tribuf_doa3_rdouts1(
											.OUT(BRAM_RDOUTS1),
											.IN(BRAM_DOA3)
		);

		SPS4T3X11H2 sps_h6md0(
											.OUT(BRAM_H6MD0),
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS16),
											.IN2(BRAM_RDOUTS4),
											.IN3(BRAM_RDOUTS0),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa3_rdouts20(
											.IN(BRAM_DOA3),
											.OUT(BRAM_RDOUTS20)
		);

		TRIBUF1T1X7H1 tribuf_doa15_rdouts8(
											.IN(BRAM_DOA15),
											.OUT(BRAM_RDOUTS8)
		);

		TRIBUF1T1X7H1 tribuf_dob7_rdouts8(
											.IN(BRAM_DOB7),
											.OUT(BRAM_RDOUTS8)
		);

		TRIBUF1T1X7H1 tribuf_dob7_rdouts9(
											.OUT(BRAM_RDOUTS9),
											.IN(BRAM_DOB7)
		);

		SPS8T6X11H2 sps_raddrs8(
											.IN4(BRAM_ED6),
											.IN5(BRAM_ED2),
											.IN6(BRAM_H6DD2),
											.IN7(BRAM_H6ED2),
											.IN0(BRAM_ED22),
											.IN1(BRAM_ED18),
											.IN2(BRAM_ED14),
											.IN3(BRAM_ED10),
											.OUT(BRAM_RADDRS8),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs0(
											.IN4(BRAM_ED4),
											.IN5(BRAM_ED0),
											.IN6(BRAM_H6DD0),
											.IN7(BRAM_H6ED0),
											.IN0(BRAM_ED20),
											.IN1(BRAM_ED16),
											.IN2(BRAM_ED12),
											.IN3(BRAM_ED8),
											.OUT(BRAM_RADDRS0),
											._1(1)
		);

		SPS8T6X11H1 sps_addra11(
											.IN4(BRAM_RADDRS23),
											.IN5(BRAM_RADDRS22),
											.IN6(BRAM_RADDRS21),
											.IN7(BRAM_RADDRS20),
											.IN0(BRAM_RADDRS27),
											.IN1(BRAM_RADDRS26),
											.IN2(BRAM_RADDRS25),
											.IN3(BRAM_RADDRS24),
											.OUT(BRAM_ADDRA11),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs4(
											.IN4(BRAM_ED5),
											.IN5(BRAM_ED1),
											.IN6(BRAM_H6DD1),
											.IN7(BRAM_H6ED1),
											.IN0(BRAM_ED21),
											.IN1(BRAM_ED17),
											.IN2(BRAM_ED13),
											.IN3(BRAM_ED9),
											.OUT(BRAM_RADDRS4),
											._1(1)
		);

		SPS2T2X7H2 sps_ed19(
											.IN0(BRAM_RDOUTS28),
											.IN1(BRAM_RDOUTS12),
											.OUT(BRAM_ED19),
											._1(1)
		);

		SPS2T2X7H2 sps_ed18(
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS8),
											.OUT(BRAM_ED18),
											._1(1)
		);

		SPS2T2X7H2 sps_ed17(
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS4),
											.OUT(BRAM_ED17),
											._1(1)
		);

		SPS2T2X7H2 sps_ed16(
											.IN0(BRAM_RDOUTS16),
											.IN1(BRAM_RDOUTS0),
											.OUT(BRAM_ED16),
											._1(1)
		);

		SPS2T2X7H2 sps_ed15(
											.IN0(BRAM_RDOUTS28),
											.IN1(BRAM_RDOUTS12),
											.OUT(BRAM_ED15),
											._1(1)
		);

		SPS2T2X7H2 sps_ed14(
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS8),
											.OUT(BRAM_ED14),
											._1(1)
		);

		SPS2T2X7H2 sps_ed13(
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS4),
											.OUT(BRAM_ED13),
											._1(1)
		);

		SPS2T2X7H2 sps_ed12(
											.IN0(BRAM_RDOUTS16),
											.IN1(BRAM_RDOUTS0),
											.OUT(BRAM_ED12),
											._1(1)
		);

		SPS2T2X7H2 sps_ed11(
											.IN0(BRAM_RDOUTS28),
											.IN1(BRAM_RDOUTS12),
											.OUT(BRAM_ED11),
											._1(1)
		);

		SPS2T2X7H2 sps_ed10(
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS8),
											.OUT(BRAM_ED10),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bd0(
											.OUT(BRAM_H6BD0),
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS16),
											.IN2(BRAM_RDOUTS4),
											.IN3(BRAM_RDOUTS0),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bd1(
											.OUT(BRAM_H6BD1),
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS28),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bd2(
											.OUT(BRAM_H6BD2),
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS16),
											.IN2(BRAM_RDOUTS4),
											.IN3(BRAM_RDOUTS0),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bd3(
											.OUT(BRAM_H6BD3),
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS28),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa7_rdouts26(
											.OUT(BRAM_RDOUTS26),
											.IN(BRAM_DOA7)
		);

		TRIBUF1T1X7H1 tribuf_doa7_rdouts25(
											.IN(BRAM_DOA7),
											.OUT(BRAM_RDOUTS25)
		);

		SPS2T2X7H2 sps_ed22(
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS8),
											.OUT(BRAM_ED22),
											._1(1)
		);

		SPS2T2X7H2 sps_ed23(
											.IN0(BRAM_RDOUTS28),
											.IN1(BRAM_RDOUTS12),
											.OUT(BRAM_ED23),
											._1(1)
		);

		SPS2T2X7H2 sps_ed20(
											.IN0(BRAM_RDOUTS16),
											.IN1(BRAM_RDOUTS0),
											.OUT(BRAM_ED20),
											._1(1)
		);

		SPS2T2X7H2 sps_ed21(
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS4),
											.OUT(BRAM_ED21),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs28(
											.IN4(BRAM_ED7),
											.IN5(BRAM_ED3),
											.IN6(BRAM_H6DD3),
											.IN7(BRAM_H6ED3),
											.IN0(BRAM_ED23),
											.IN1(BRAM_ED19),
											.IN2(BRAM_ED15),
											.IN3(BRAM_ED11),
											.OUT(BRAM_RADDRS28),
											._1(1)
		);

		SPS8T6X11H1 sps_addra9(
											.IN4(BRAM_RADDRS19),
											.IN5(BRAM_RADDRS18),
											.IN6(BRAM_RADDRS17),
											.IN7(BRAM_RADDRS16),
											.IN0(BRAM_RADDRS23),
											.IN1(BRAM_RADDRS22),
											.IN2(BRAM_RADDRS21),
											.IN3(BRAM_RADDRS20),
											.OUT(BRAM_ADDRA9),
											._1(1)
		);

		SPS8T6X11H1 sps_addra8(
											.IN4(BRAM_RADDRS19),
											.IN5(BRAM_RADDRS18),
											.IN6(BRAM_RADDRS17),
											.IN7(BRAM_RADDRS16),
											.IN0(BRAM_RADDRS23),
											.IN1(BRAM_RADDRS22),
											.IN2(BRAM_RADDRS21),
											.IN3(BRAM_RADDRS20),
											.OUT(BRAM_ADDRA8),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs20(
											.IN4(BRAM_ED5),
											.IN5(BRAM_ED1),
											.IN6(BRAM_H6DD1),
											.IN7(BRAM_H6ED1),
											.IN0(BRAM_ED21),
											.IN1(BRAM_ED17),
											.IN2(BRAM_ED13),
											.IN3(BRAM_ED9),
											.OUT(BRAM_RADDRS20),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs24(
											.IN4(BRAM_ED6),
											.IN5(BRAM_ED2),
											.IN6(BRAM_H6DD2),
											.IN7(BRAM_H6ED2),
											.IN0(BRAM_ED22),
											.IN1(BRAM_ED18),
											.IN2(BRAM_ED14),
											.IN3(BRAM_ED10),
											.OUT(BRAM_RADDRS24),
											._1(1)
		);

		SPS4T3X11H2 sps_h6md2(
											.OUT(BRAM_H6MD2),
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS16),
											.IN2(BRAM_RDOUTS4),
											.IN3(BRAM_RDOUTS0),
											._1(1)
		);

		SPS4T3X11H2 sps_h6md1(
											.OUT(BRAM_H6MD1),
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS28),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											._1(1)
		);

		SPS8T6X11H1 sps_addra10(
											.IN4(BRAM_RADDRS23),
											.IN5(BRAM_RADDRS22),
											.IN6(BRAM_RADDRS21),
											.IN7(BRAM_RADDRS20),
											.IN0(BRAM_RADDRS27),
											.IN1(BRAM_RADDRS26),
											.IN2(BRAM_RADDRS25),
											.IN3(BRAM_RADDRS24),
											.OUT(BRAM_ADDRA10),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob11_rdouts3(
											.IN(BRAM_DOB11),
											.OUT(BRAM_RDOUTS3)
		);

		TRIBUF1T1X7H1 tribuf_dob15_rdouts26(
											.IN(BRAM_DOB15),
											.OUT(BRAM_RDOUTS26)
		);

		TRIBUF1T1X7H1 tribuf_dob11_rdouts20(
											.IN(BRAM_DOB11),
											.OUT(BRAM_RDOUTS20)
		);

		SPS8T6X11H2 sps_raddrs12(
											.IN4(BRAM_ED7),
											.IN5(BRAM_ED3),
											.IN6(BRAM_H6DD3),
											.IN7(BRAM_H6ED3),
											.IN0(BRAM_ED23),
											.IN1(BRAM_ED19),
											.IN2(BRAM_ED15),
											.IN3(BRAM_ED11),
											.OUT(BRAM_RADDRS12),
											._1(1)
		);

		SPS8T6X11H1 sps_dib6(
											.IN4(BRAM_RDINS15),
											.IN5(BRAM_RDINS14),
											.IN6(BRAM_RDINS11),
											.IN7(BRAM_RDINS10),
											.IN0(BRAM_RDINS29),
											.IN1(BRAM_RDINS28),
											.IN2(BRAM_RDINS17),
											.IN3(BRAM_RDINS16),
											.OUT(BRAM_DIB6),
											._1(1)
		);

		SPS8T6X11H2 sps_dib7(
											.IN4(BRAM_RDINS15),
											.IN5(BRAM_RDINS14),
											.IN6(BRAM_RDINS11),
											.IN7(BRAM_RDINS10),
											.IN0(BRAM_RDINS29),
											.IN1(BRAM_RDINS28),
											.IN2(BRAM_RDINS17),
											.IN3(BRAM_RDINS16),
											.OUT(BRAM_DIB7),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs16(
											.IN4(BRAM_ED4),
											.IN5(BRAM_ED0),
											.IN6(BRAM_H6DD0),
											.IN7(BRAM_H6ED0),
											.IN0(BRAM_ED20),
											.IN1(BRAM_ED16),
											.IN2(BRAM_ED12),
											.IN3(BRAM_ED8),
											.OUT(BRAM_RADDRS16),
											._1(1)
		);

		SPS8T6X11H1 sps_lhd9(
											.IN4(BRAM_RDOUTS16),
											.IN5(BRAM_RDOUTS20),
											.IN6(BRAM_RDOUTS24),
											.IN7(BRAM_RDOUTS28),
											.IN0(BRAM_RDOUTS0),
											.IN1(BRAM_RDOUTS4),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											.OUT(BRAM_LHD9),
											._1(1)
		);

		SPS8T6X11H1 sps_lhd6(
											.IN4(BRAM_RDOUTS16),
											.IN5(BRAM_RDOUTS20),
											.IN6(BRAM_RDOUTS24),
											.IN7(BRAM_RDOUTS28),
											.IN0(BRAM_RDOUTS0),
											.IN1(BRAM_RDOUTS4),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											.OUT(BRAM_LHD6),
											._1(1)
		);

		SPS8T6X11H1 sps_lhd3(
											.IN4(BRAM_RDOUTS16),
											.IN5(BRAM_RDOUTS20),
											.IN6(BRAM_RDOUTS24),
											.IN7(BRAM_RDOUTS28),
											.IN0(BRAM_RDOUTS0),
											.IN1(BRAM_RDOUTS4),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											.OUT(BRAM_LHD3),
											._1(1)
		);

		SPS8T6X11H1 sps_lhd0(
											.IN4(BRAM_RDOUTS16),
											.IN5(BRAM_RDOUTS20),
											.IN6(BRAM_RDOUTS24),
											.IN7(BRAM_RDOUTS28),
											.IN0(BRAM_RDOUTS0),
											.IN1(BRAM_RDOUTS4),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											.OUT(BRAM_LHD0),
											._1(1)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_RCKT(
BRAM_TOP_H6E0, BRAM_TOP_H6A0, BRAM_TOP_H6B0, BRAM_TOP_H6M0, BRAM_TOP_H6C0, BRAM_TOP_H6D0, BRAM_TOP_H6E1, BRAM_TOP_H6A1, BRAM_TOP_H6B1, BRAM_TOP_H6M1, BRAM_TOP_H6C1, BRAM_TOP_H6D1, BRAM_TOP_H6E2, BRAM_TOP_H6A2, BRAM_TOP_H6B2, BRAM_TOP_H6M2, BRAM_TOP_H6C2, BRAM_TOP_H6D2, BRAM_TOP_H6E3, BRAM_TOP_H6A3, BRAM_TOP_H6B3, BRAM_TOP_H6M3, BRAM_TOP_H6C3, BRAM_TOP_H6D3, BRAM_TOP_H6E4, BRAM_TOP_H6A4, BRAM_TOP_H6B4, BRAM_TOP_H6M4, BRAM_TOP_H6C4, BRAM_TOP_H6D4, BRAM_TOP_H6E5, BRAM_TOP_H6A5, BRAM_TOP_H6B5, BRAM_TOP_H6M5, BRAM_TOP_H6C5, BRAM_TOP_H6D5, BRAM_TOP_VGCLK0, BRAM_TOP_VGCLK1, BRAM_TOP_VGCLK2, BRAM_TOP_VGCLK3, BRAM_TOP_GCLKE0, BRAM_TOP_GCLKE1, BRAM_TOP_GCLKE2, BRAM_TOP_GCLKE3, BRAM_TOP_GCLKW0, BRAM_TOP_GCLKW1, BRAM_TOP_GCLKW2, BRAM_TOP_GCLKW3, BRAM_TOP_RLLV0, BRAM_TOP_RLLV1, BRAM_TOP_RLLV2, BRAM_TOP_RLLV3, BRAM_TOP_RLLV4, BRAM_TOP_RLLV5, BRAM_TOP_RLLV6, BRAM_TOP_RLLV7, BRAM_TOP_RLLV8, BRAM_TOP_RLLV9, BRAM_TOP_RLLV10, BRAM_TOP_RLLV11, BRAM_TOPS_RST, BRAM_TOPS_CLKFB, BRAM_TOPS_CLKIN, _1
);
inout	BRAM_TOP_H6E0;
inout	BRAM_TOP_H6A0;
inout	BRAM_TOP_H6B0;
inout	BRAM_TOP_H6M0;
inout	BRAM_TOP_H6C0;
inout	BRAM_TOP_H6D0;
inout	BRAM_TOP_H6E1;
inout	BRAM_TOP_H6A1;
inout	BRAM_TOP_H6B1;
inout	BRAM_TOP_H6M1;
inout	BRAM_TOP_H6C1;
inout	BRAM_TOP_H6D1;
inout	BRAM_TOP_H6E2;
inout	BRAM_TOP_H6A2;
inout	BRAM_TOP_H6B2;
inout	BRAM_TOP_H6M2;
inout	BRAM_TOP_H6C2;
inout	BRAM_TOP_H6D2;
inout	BRAM_TOP_H6E3;
inout	BRAM_TOP_H6A3;
inout	BRAM_TOP_H6B3;
inout	BRAM_TOP_H6M3;
inout	BRAM_TOP_H6C3;
inout	BRAM_TOP_H6D3;
inout	BRAM_TOP_H6E4;
inout	BRAM_TOP_H6A4;
inout	BRAM_TOP_H6B4;
inout	BRAM_TOP_H6M4;
inout	BRAM_TOP_H6C4;
inout	BRAM_TOP_H6D4;
inout	BRAM_TOP_H6E5;
inout	BRAM_TOP_H6A5;
inout	BRAM_TOP_H6B5;
inout	BRAM_TOP_H6M5;
inout	BRAM_TOP_H6C5;
inout	BRAM_TOP_H6D5;
inout	BRAM_TOP_VGCLK0;
inout	BRAM_TOP_VGCLK1;
inout	BRAM_TOP_VGCLK2;
inout	BRAM_TOP_VGCLK3;
inout	BRAM_TOP_GCLKE0;
inout	BRAM_TOP_GCLKE1;
inout	BRAM_TOP_GCLKE2;
inout	BRAM_TOP_GCLKE3;
inout	BRAM_TOP_GCLKW0;
inout	BRAM_TOP_GCLKW1;
inout	BRAM_TOP_GCLKW2;
inout	BRAM_TOP_GCLKW3;
inout	BRAM_TOP_RLLV0;
inout	BRAM_TOP_RLLV1;
inout	BRAM_TOP_RLLV2;
inout	BRAM_TOP_RLLV3;
inout	BRAM_TOP_RLLV4;
inout	BRAM_TOP_RLLV5;
inout	BRAM_TOP_RLLV6;
inout	BRAM_TOP_RLLV7;
inout	BRAM_TOP_RLLV8;
inout	BRAM_TOP_RLLV9;
inout	BRAM_TOP_RLLV10;
inout	BRAM_TOP_RLLV11;
inout	BRAM_TOPS_RST;
inout	BRAM_TOPS_CLKFB;
inout	BRAM_TOPS_CLKIN;
inout	_1;

		SPS28B11X11H2 sps_clkin(
											.IN8(BRAM_TOP_RLLV3),
											.IN9(BRAM_TOP_RLLV1),
											.IN4(BRAM_TOP_H6C0),
											.IN5(BRAM_TOP_H6D0),
											.IN6(BRAM_TOP_GCLKE0),
											.IN7(BRAM_TOP_RLLV5),
											.IN0(BRAM_TOP_H6E0),
											.IN1(BRAM_TOP_H6A0),
											.IN2(BRAM_TOP_H6B0),
											.IN3(BRAM_TOP_H6M0),
											.IN18(BRAM_TOP_RLLV8),
											.IN19(BRAM_TOP_RLLV6),
											.IN16(BRAM_TOP_RLLV0),
											.IN17(BRAM_TOP_RLLV10),
											.IN14(BRAM_TOP_RLLV4),
											.IN15(BRAM_TOP_RLLV2),
											.IN12(BRAM_TOP_RLLV7),
											.IN13(BRAM_TOP_GCLKE1),
											.IN10(BRAM_TOP_RLLV11),
											.IN11(BRAM_TOP_RLLV9),
											.OUT(BRAM_TOPS_CLKIN),
											.IN23(BRAM_TOP_H6B1),
											.IN22(BRAM_TOP_H6A1),
											.IN21(BRAM_TOP_H6E1),
											.IN20(BRAM_TOP_GCLKE2),
											.IN27(BRAM_TOP_GCLKE3),
											.IN26(BRAM_TOP_H6D1),
											.IN25(BRAM_TOP_H6C1),
											.IN24(BRAM_TOP_H6M1),
											._1(1)
		);

		SPS12B8X11H1 sps_rst(
											.IN8(BRAM_TOP_H6B3),
											.IN9(BRAM_TOP_H6M3),
											.IN4(BRAM_TOP_H6C2),
											.IN5(BRAM_TOP_H6D2),
											.IN6(BRAM_TOP_H6E3),
											.IN7(BRAM_TOP_H6A3),
											.IN0(BRAM_TOP_H6E2),
											.IN1(BRAM_TOP_H6A2),
											.IN2(BRAM_TOP_H6B2),
											.IN3(BRAM_TOP_H6M2),
											.OUT(BRAM_TOPS_RST),
											.IN10(BRAM_TOP_H6C3),
											.IN11(BRAM_TOP_H6D3),
											._1(1)
		);

		SPBU1NAND1X35H1 spbu_gclke0(
											.IN(BRAM_TOP_VGCLK0),
											.OUT(BRAM_TOP_GCLKE0)
		);

		SPBU1NAND1X35H1 spbu_gclke1(
											.IN(BRAM_TOP_VGCLK1),
											.OUT(BRAM_TOP_GCLKE1)
		);

		SPBU1NAND1X35H1 spbu_gclke2(
											.IN(BRAM_TOP_VGCLK2),
											.OUT(BRAM_TOP_GCLKE2)
		);

		SPBU1NAND1X35H1 spbu_gclke3(
											.IN(BRAM_TOP_VGCLK3),
											.OUT(BRAM_TOP_GCLKE3)
		);

		SPS1T1X7H1 sps_rllv10(
											.OUT(BRAM_TOP_RLLV10),
											.IN(BRAM_TOP_H6A4)
		);

		SPS1T1X7H1 sps_rllv11(
											.OUT(BRAM_TOP_RLLV11),
											.IN(BRAM_TOP_H6E4)
		);

		SPS28B11X11H2 sps_clkfb(
											.IN8(BRAM_TOP_RLLV3),
											.IN9(BRAM_TOP_RLLV1),
											.IN4(BRAM_TOP_H6C0),
											.IN5(BRAM_TOP_H6D0),
											.IN6(BRAM_TOP_GCLKE0),
											.IN7(BRAM_TOP_RLLV5),
											.IN0(BRAM_TOP_H6E0),
											.IN1(BRAM_TOP_H6A0),
											.IN2(BRAM_TOP_H6B0),
											.IN3(BRAM_TOP_H6M0),
											.IN18(BRAM_TOP_RLLV8),
											.IN19(BRAM_TOP_RLLV6),
											.IN16(BRAM_TOP_RLLV0),
											.IN17(BRAM_TOP_RLLV10),
											.IN14(BRAM_TOP_RLLV4),
											.IN15(BRAM_TOP_RLLV2),
											.IN12(BRAM_TOP_RLLV7),
											.IN13(BRAM_TOP_GCLKE1),
											.IN10(BRAM_TOP_RLLV11),
											.IN11(BRAM_TOP_RLLV9),
											.OUT(BRAM_TOPS_CLKFB),
											.IN23(BRAM_TOP_H6B1),
											.IN22(BRAM_TOP_H6A1),
											.IN21(BRAM_TOP_H6E1),
											.IN20(BRAM_TOP_GCLKE2),
											.IN27(BRAM_TOP_GCLKE3),
											.IN26(BRAM_TOP_H6D1),
											.IN25(BRAM_TOP_H6C1),
											.IN24(BRAM_TOP_H6M1),
											._1(1)
		);

		SPS1T1X7H1 sps_rllv0(
											.OUT(BRAM_TOP_RLLV0),
											.IN(BRAM_TOP_H6D5)
		);

		SPS1T1X7H1 sps_rllv1(
											.OUT(BRAM_TOP_RLLV1),
											.IN(BRAM_TOP_H6C5)
		);

		SPS1T1X7H1 sps_rllv2(
											.OUT(BRAM_TOP_RLLV2),
											.IN(BRAM_TOP_H6M5)
		);

		SPBU1NAND1X35H1 spbu_gclkw1(
											.OUT(BRAM_TOP_GCLKW1),
											.IN(BRAM_TOP_VGCLK1)
		);

		SPS1T1X7H1 sps_rllv4(
											.OUT(BRAM_TOP_RLLV4),
											.IN(BRAM_TOP_H6A5)
		);

		SPS1T1X7H1 sps_rllv5(
											.OUT(BRAM_TOP_RLLV5),
											.IN(BRAM_TOP_H6E5)
		);

		SPS1T1X7H1 sps_rllv6(
											.OUT(BRAM_TOP_RLLV6),
											.IN(BRAM_TOP_H6D4)
		);

		SPS1T1X7H1 sps_rllv7(
											.OUT(BRAM_TOP_RLLV7),
											.IN(BRAM_TOP_H6C4)
		);

		SPS1T1X7H1 sps_rllv8(
											.OUT(BRAM_TOP_RLLV8),
											.IN(BRAM_TOP_H6M4)
		);

		SPS1T1X7H1 sps_rllv9(
											.OUT(BRAM_TOP_RLLV9),
											.IN(BRAM_TOP_H6B4)
		);

		SPBU1NAND1X35H1 spbu_gclkw2(
											.OUT(BRAM_TOP_GCLKW2),
											.IN(BRAM_TOP_VGCLK2)
		);

		SPBU1NAND1X35H1 spbu_gclkw3(
											.OUT(BRAM_TOP_GCLKW3),
											.IN(BRAM_TOP_VGCLK3)
		);

		SPBU1NAND1X35H1 spbu_gclkw0(
											.OUT(BRAM_TOP_GCLKW0),
											.IN(BRAM_TOP_VGCLK0)
		);

		SPS1T1X7H1 sps_rllv3(
											.OUT(BRAM_TOP_RLLV3),
											.IN(BRAM_TOP_H6B5)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_CLKC(
CLKC_GCLK0, CLKC_GCLK1, CLKC_GCLK2, CLKC_GCLK3, CLKC_HGCLK0, CLKC_HGCLK1, CLKC_HGCLK2, CLKC_HGCLK3, CLKC_VGCLK0, CLKC_VGCLK1, CLKC_VGCLK2, CLKC_VGCLK3, _1
);
inout	CLKC_GCLK0;
inout	CLKC_GCLK1;
inout	CLKC_GCLK2;
inout	CLKC_GCLK3;
inout	CLKC_HGCLK0;
inout	CLKC_HGCLK1;
inout	CLKC_HGCLK2;
inout	CLKC_HGCLK3;
inout	CLKC_VGCLK0;
inout	CLKC_VGCLK1;
inout	CLKC_VGCLK2;
inout	CLKC_VGCLK3;
inout	_1;

		INV1B0X35H1 inv_hgclk1(
											.OUT(CLKC_HGCLK1),
											.IN(CLKC_GCLK1)
		);

		INV1B0X35H1 inv_hgclk0(
											.OUT(CLKC_HGCLK0),
											.IN(CLKC_GCLK0)
		);

		INV1B0X35H1 inv_hgclk3(
											.OUT(CLKC_HGCLK3),
											.IN(CLKC_GCLK3)
		);

		INV1B0X35H1 inv_hgclk2(
											.OUT(CLKC_HGCLK2),
											.IN(CLKC_GCLK2)
		);

		INV1B0X35H1 inv_vgclk3(
											.OUT(CLKC_VGCLK3),
											.IN(CLKC_HGCLK3)
		);

		INV1B0X35H1 inv_vgclk2(
											.OUT(CLKC_VGCLK2),
											.IN(CLKC_HGCLK2)
		);

		INV1B0X35H1 inv_vgclk1(
											.OUT(CLKC_VGCLK1),
											.IN(CLKC_HGCLK1)
		);

		INV1B0X35H1 inv_vgclk0(
											.OUT(CLKC_VGCLK0),
											.IN(CLKC_HGCLK0)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_CLKB(
CLKB_H6E0, CLKB_H6E1, CLKB_H6E2, CLKB_H6E3, CLKB_H6A0, CLKB_H6A1, CLKB_H6A2, CLKB_H6A3, CLKB_H6B0, CLKB_H6B1, CLKB_H6B2, CLKB_H6B3, CLKB_H6M0, CLKB_H6M1, CLKB_H6M2, CLKB_H6M3, CLKB_H6C0, CLKB_H6C1, CLKB_H6C2, CLKB_H6C3, CLKB_H6D0, CLKB_H6D1, CLKB_H6D2, CLKB_H6D3, CLKB_LLH1, CLKB_LLH4, CLKB_LLH7, CLKB_LLH10, CLKB_GCLK0, CLKB_GCLK1, CLKB_VGCLK0, CLKB_VGCLK1, CLKB_VGCLK2, CLKB_VGCLK3, CLKB_HGCLK_E0, CLKB_HGCLK_E1, CLKB_HGCLK_E2, CLKB_HGCLK_E3, CLKB_HGCLK_W0, CLKB_HGCLK_W1, CLKB_HGCLK_W2, CLKB_HGCLK_W3, CLKB_CLKINL_1, CLKB_CLKFBL_1, CLKB_CLKDVL_1, CLKB_CLK0L_1, CLKB_CLK90L_1, CLKB_CLK180L_1, CLKB_CLK270L_1, CLKB_CLK2XL_1, CLKB_CLK2X90L_1, CLKB_LOCKEDL_1, CLKB_CLKINR_1, CLKB_CLKFBR_1, CLKB_CLKDVR_1, CLKB_CLK0R_1, CLKB_CLK90R_1, CLKB_CLK180R_1, CLKB_CLK270R_1, CLKB_CLK2XR_1, CLKB_CLK2X90R_1, CLKB_LOCKEDR_1, CLKB_CLKPAD0, CLKB_CLKPAD1, CLKB_GCLKBUF0_IN, CLKB_GCLK0_PW, CLKB_CE0, CLKB_GCLKBUF1_IN, CLKB_GCLK1_PW, CLKB_CE1, BOT_CLKINL, BOT_CLKFBL, BOT_CLKINR, BOT_CLKFBR, DLL1_RST_I, DLL1_RST_O, DLL0_RST_I, DLL0_RST_O, _1
);
inout	CLKB_H6E0;
inout	CLKB_H6E1;
inout	CLKB_H6E2;
inout	CLKB_H6E3;
inout	CLKB_H6A0;
inout	CLKB_H6A1;
inout	CLKB_H6A2;
inout	CLKB_H6A3;
inout	CLKB_H6B0;
inout	CLKB_H6B1;
inout	CLKB_H6B2;
inout	CLKB_H6B3;
inout	CLKB_H6M0;
inout	CLKB_H6M1;
inout	CLKB_H6M2;
inout	CLKB_H6M3;
inout	CLKB_H6C0;
inout	CLKB_H6C1;
inout	CLKB_H6C2;
inout	CLKB_H6C3;
inout	CLKB_H6D0;
inout	CLKB_H6D1;
inout	CLKB_H6D2;
inout	CLKB_H6D3;
inout	CLKB_LLH1;
inout	CLKB_LLH4;
inout	CLKB_LLH7;
inout	CLKB_LLH10;
inout	CLKB_GCLK0;
inout	CLKB_GCLK1;
inout	CLKB_VGCLK0;
inout	CLKB_VGCLK1;
inout	CLKB_VGCLK2;
inout	CLKB_VGCLK3;
inout	CLKB_HGCLK_E0;
inout	CLKB_HGCLK_E1;
inout	CLKB_HGCLK_E2;
inout	CLKB_HGCLK_E3;
inout	CLKB_HGCLK_W0;
inout	CLKB_HGCLK_W1;
inout	CLKB_HGCLK_W2;
inout	CLKB_HGCLK_W3;
inout	CLKB_CLKINL_1;
inout	CLKB_CLKFBL_1;
inout	CLKB_CLKDVL_1;
inout	CLKB_CLK0L_1;
inout	CLKB_CLK90L_1;
inout	CLKB_CLK180L_1;
inout	CLKB_CLK270L_1;
inout	CLKB_CLK2XL_1;
inout	CLKB_CLK2X90L_1;
inout	CLKB_LOCKEDL_1;
inout	CLKB_CLKINR_1;
inout	CLKB_CLKFBR_1;
inout	CLKB_CLKDVR_1;
inout	CLKB_CLK0R_1;
inout	CLKB_CLK90R_1;
inout	CLKB_CLK180R_1;
inout	CLKB_CLK270R_1;
inout	CLKB_CLK2XR_1;
inout	CLKB_CLK2X90R_1;
inout	CLKB_LOCKEDR_1;
inout	CLKB_CLKPAD0;
inout	CLKB_CLKPAD1;
inout	CLKB_GCLKBUF0_IN;
inout	CLKB_GCLK0_PW;
inout	CLKB_CE0;
inout	CLKB_GCLKBUF1_IN;
inout	CLKB_GCLK1_PW;
inout	CLKB_CE1;
inout	BOT_CLKINL;
inout	BOT_CLKFBL;
inout	BOT_CLKINR;
inout	BOT_CLKFBR;
inout	DLL1_RST_I;
inout	DLL1_RST_O;
inout	DLL0_RST_I;
inout	DLL0_RST_O;
inout	_1;
		wire		CLKB_IOFB0 ;
		wire		CLKB_IOFB1 ;

		SPS12N4X0H1 sps_ce0(
											.IN8(CLKB_H6E2),
											.IN9(CLKB_H6E3),
											.IN4(CLKB_H6C2),
											.IN5(CLKB_H6C3),
											.IN6(CLKB_H6D2),
											.IN7(CLKB_H6D3),
											.IN0(CLKB_H6A2),
											.IN1(CLKB_H6A3),
											.IN2(CLKB_H6B2),
											.IN3(CLKB_H6B3),
											.OUT(CLKB_CE0),
											.IN10(CLKB_H6M2),
											.IN11(CLKB_H6M3),
											._1(1)
		);

		SPS12N4X0H1 sps_ce1(
											.IN8(CLKB_H6E2),
											.IN9(CLKB_H6E3),
											.IN4(CLKB_H6C2),
											.IN5(CLKB_H6C3),
											.IN6(CLKB_H6D2),
											.IN7(CLKB_H6D3),
											.IN0(CLKB_H6A2),
											.IN1(CLKB_H6A3),
											.IN2(CLKB_H6B2),
											.IN3(CLKB_H6B3),
											.OUT(CLKB_CE1),
											.IN10(CLKB_H6M2),
											.IN11(CLKB_H6M3),
											._1(1)
		);

		SPBU1NAND1X35H1 spbu_hgclk_e3(
											.OUT(CLKB_HGCLK_E3),
											.IN(CLKB_VGCLK3)
		);

		SPBU1NAND1X35H1 spbu_hgclk_e2(
											.OUT(CLKB_HGCLK_E2),
											.IN(CLKB_VGCLK2)
		);

		SPBU1NAND1X35H1 spbu_hgclk_e1(
											.OUT(CLKB_HGCLK_E1),
											.IN(CLKB_VGCLK1)
		);

		SPBU1NAND1X35H1 spbu_hgclk_e0(
											.OUT(CLKB_HGCLK_E0),
											.IN(CLKB_VGCLK0)
		);

		SPBU1NAND1X35H1 spbu_gclk0(
											.OUT(CLKB_GCLK0),
											.IN(CLKB_GCLK0_PW)
		);

		SPBU1NAND1X35H1 spbu_gclk1(
											.OUT(CLKB_GCLK1),
											.IN(CLKB_GCLK1_PW)
		);

		SPS20T6X11H1 sps_h6e2(
											.IN8(CLKB_CLK270R_1),
											.IN9(CLKB_CLK270L_1),
											.IN4(CLKB_CLK90R_1),
											.IN5(CLKB_CLK90L_1),
											.IN6(CLKB_CLK180R_1),
											.IN7(CLKB_CLK180L_1),
											.IN0(CLKB_CLKDVR_1),
											.IN1(CLKB_CLKDVL_1),
											.IN2(CLKB_CLK0R_1),
											.IN3(CLKB_CLK0L_1),
											.IN11(CLKB_CLK2XL_1),
											.IN18(CLKB_LOCKEDR_1),
											.IN19(CLKB_LOCKEDL_1),
											.IN16(CLKB_GCLK0_PW),
											.IN17(CLKB_GCLK1_PW),
											.IN14(CLKB_CLKPAD0),
											.IN15(CLKB_CLKPAD1),
											.IN12(CLKB_CLK2X90R_1),
											.IN13(CLKB_CLK2X90L_1),
											.IN10(CLKB_CLK2XR_1),
											.OUT(CLKB_H6E2),
											._1(1)
		);

		SPS20T6X11H1 sps_h6e3(
											.IN8(CLKB_CLK270R_1),
											.IN9(CLKB_CLK270L_1),
											.IN4(CLKB_CLK90R_1),
											.IN5(CLKB_CLK90L_1),
											.IN6(CLKB_CLK180R_1),
											.IN7(CLKB_CLK180L_1),
											.IN0(CLKB_CLKDVR_1),
											.IN1(CLKB_CLKDVL_1),
											.IN2(CLKB_CLK0R_1),
											.IN3(CLKB_CLK0L_1),
											.IN11(CLKB_CLK2XL_1),
											.IN18(CLKB_LOCKEDR_1),
											.IN19(CLKB_LOCKEDL_1),
											.IN16(CLKB_GCLK0_PW),
											.IN17(CLKB_GCLK1_PW),
											.IN14(CLKB_CLKPAD0),
											.IN15(CLKB_CLKPAD1),
											.IN12(CLKB_CLK2X90R_1),
											.IN13(CLKB_CLK2X90L_1),
											.IN10(CLKB_CLK2XR_1),
											.OUT(CLKB_H6E3),
											._1(1)
		);

		SPS20T6X11H1 sps_h6e0(
											.IN8(CLKB_CLK270R_1),
											.IN9(CLKB_CLK270L_1),
											.IN4(CLKB_CLK90R_1),
											.IN5(CLKB_CLK90L_1),
											.IN6(CLKB_CLK180R_1),
											.IN7(CLKB_CLK180L_1),
											.IN0(CLKB_CLKDVR_1),
											.IN1(CLKB_CLKDVL_1),
											.IN2(CLKB_CLK0R_1),
											.IN3(CLKB_CLK0L_1),
											.OUT(CLKB_H6E0),
											.IN18(CLKB_LOCKEDR_1),
											.IN19(CLKB_LOCKEDL_1),
											.IN16(CLKB_GCLK0_PW),
											.IN17(CLKB_GCLK1_PW),
											.IN14(CLKB_CLKPAD0),
											.IN15(CLKB_CLKPAD1),
											.IN12(CLKB_CLK2X90R_1),
											.IN13(CLKB_CLK2X90L_1),
											.IN10(CLKB_CLK2XR_1),
											.IN11(CLKB_CLK2XL_1),
											._1(1)
		);

		SPS20T6X11H1 sps_h6e1(
											.IN8(CLKB_CLK270R_1),
											.IN9(CLKB_CLK270L_1),
											.IN4(CLKB_CLK90R_1),
											.IN5(CLKB_CLK90L_1),
											.IN6(CLKB_CLK180R_1),
											.IN7(CLKB_CLK180L_1),
											.IN0(CLKB_CLKDVR_1),
											.IN1(CLKB_CLKDVL_1),
											.IN2(CLKB_CLK0R_1),
											.IN3(CLKB_CLK0L_1),
											.OUT(CLKB_H6E1),
											.IN18(CLKB_LOCKEDR_1),
											.IN19(CLKB_LOCKEDL_1),
											.IN16(CLKB_GCLK0_PW),
											.IN17(CLKB_GCLK1_PW),
											.IN14(CLKB_CLKPAD0),
											.IN15(CLKB_CLKPAD1),
											.IN12(CLKB_CLK2X90R_1),
											.IN13(CLKB_CLK2X90L_1),
											.IN10(CLKB_CLK2XR_1),
											.IN11(CLKB_CLK2XL_1),
											._1(1)
		);

		SPBU1NAND1X35H1 spbu_hgclk_w1(
											.OUT(CLKB_HGCLK_W1),
											.IN(CLKB_VGCLK1)
		);

		SPBU1NAND1X35H1 spbu_hgclk_w0(
											.OUT(CLKB_HGCLK_W0),
											.IN(CLKB_VGCLK0)
		);

		SPBU1NAND1X35H1 spbu_hgclk_w3(
											.OUT(CLKB_HGCLK_W3),
											.IN(CLKB_VGCLK3)
		);

		SPBU1NAND1X35H1 spbu_hgclk_w2(
											.OUT(CLKB_HGCLK_W2),
											.IN(CLKB_VGCLK2)
		);

		SPS20T6X11H1 sps_llh10(
											.IN8(CLKB_CLK270R_1),
											.IN9(CLKB_CLK270L_1),
											.IN4(CLKB_CLK90R_1),
											.IN5(CLKB_CLK90L_1),
											.IN6(CLKB_CLK180R_1),
											.IN7(CLKB_CLK180L_1),
											.IN0(CLKB_CLKDVR_1),
											.IN1(CLKB_CLKDVL_1),
											.IN2(CLKB_CLK0R_1),
											.IN3(CLKB_CLK0L_1),
											.OUT(CLKB_LLH10),
											.IN18(CLKB_LOCKEDR_1),
											.IN19(CLKB_LOCKEDL_1),
											.IN16(CLKB_GCLK0_PW),
											.IN17(CLKB_GCLK1_PW),
											.IN14(CLKB_CLKPAD0),
											.IN15(CLKB_CLKPAD1),
											.IN12(CLKB_CLK2X90R_1),
											.IN13(CLKB_CLK2X90L_1),
											.IN10(CLKB_CLK2XR_1),
											.IN11(CLKB_CLK2XL_1),
											._1(1)
		);

		SPS20T6X11H1 sps_llh7(
											.IN8(CLKB_CLK270R_1),
											.IN9(CLKB_CLK270L_1),
											.IN4(CLKB_CLK90R_1),
											.IN5(CLKB_CLK90L_1),
											.IN6(CLKB_CLK180R_1),
											.IN7(CLKB_CLK180L_1),
											.IN0(CLKB_CLKDVR_1),
											.IN1(CLKB_CLKDVL_1),
											.IN2(CLKB_CLK0R_1),
											.IN3(CLKB_CLK0L_1),
											.OUT(CLKB_LLH7),
											.IN18(CLKB_LOCKEDR_1),
											.IN19(CLKB_LOCKEDL_1),
											.IN16(CLKB_GCLK0_PW),
											.IN17(CLKB_GCLK1_PW),
											.IN14(CLKB_CLKPAD0),
											.IN15(CLKB_CLKPAD1),
											.IN12(CLKB_CLK2X90R_1),
											.IN13(CLKB_CLK2X90L_1),
											.IN10(CLKB_CLK2XR_1),
											.IN11(CLKB_CLK2XL_1),
											._1(1)
		);

		SPS20T6X11H1 sps_llh4(
											.IN8(CLKB_CLK270R_1),
											.IN9(CLKB_CLK270L_1),
											.IN4(CLKB_CLK90R_1),
											.IN5(CLKB_CLK90L_1),
											.IN6(CLKB_CLK180R_1),
											.IN7(CLKB_CLK180L_1),
											.IN0(CLKB_CLKDVR_1),
											.IN1(CLKB_CLKDVL_1),
											.IN2(CLKB_CLK0R_1),
											.IN3(CLKB_CLK0L_1),
											.OUT(CLKB_LLH4),
											.IN18(CLKB_LOCKEDR_1),
											.IN19(CLKB_LOCKEDL_1),
											.IN16(CLKB_GCLK0_PW),
											.IN17(CLKB_GCLK1_PW),
											.IN14(CLKB_CLKPAD0),
											.IN15(CLKB_CLKPAD1),
											.IN12(CLKB_CLK2X90R_1),
											.IN13(CLKB_CLK2X90L_1),
											.IN10(CLKB_CLK2XR_1),
											.IN11(CLKB_CLK2XL_1),
											._1(1)
		);

		SPS20T6X11H1 sps_llh1(
											.IN8(CLKB_CLK270R_1),
											.IN9(CLKB_CLK270L_1),
											.IN4(CLKB_CLK90R_1),
											.IN5(CLKB_CLK90L_1),
											.IN6(CLKB_CLK180R_1),
											.IN7(CLKB_CLK180L_1),
											.IN0(CLKB_CLKDVR_1),
											.IN1(CLKB_CLKDVL_1),
											.IN2(CLKB_CLK0R_1),
											.IN3(CLKB_CLK0L_1),
											.OUT(CLKB_LLH1),
											.IN18(CLKB_LOCKEDR_1),
											.IN19(CLKB_LOCKEDL_1),
											.IN16(CLKB_GCLK0_PW),
											.IN17(CLKB_GCLK1_PW),
											.IN14(CLKB_CLKPAD0),
											.IN15(CLKB_CLKPAD1),
											.IN12(CLKB_CLK2X90R_1),
											.IN13(CLKB_CLK2X90L_1),
											.IN10(CLKB_CLK2XR_1),
											.IN11(CLKB_CLK2XL_1),
											._1(1)
		);

		SPS6B3X4H1 sps_clkfbl(
											.IN4(CLKB_CLK2XL_1),
											.IN5(BOT_CLKFBL),
											.IN0(CLKB_CLKPAD0),
											.IN1(CLKB_CLKPAD1),
											.IN2(CLKB_IOFB0),
											.IN3(CLKB_IOFB1),
											.OUT(CLKB_CLKFBL_1),
											._1(1)
		);

		SPS28B6X2H1 sps_gclkbuf0_in(
											.IN8(CLKB_CLK270R_1),
											.IN9(CLKB_CLK270L_1),
											.IN4(CLKB_CLK90R_1),
											.IN5(CLKB_CLK90L_1),
											.IN6(CLKB_CLK180R_1),
											.IN7(CLKB_CLK180L_1),
											.IN0(CLKB_CLKDVR_1),
											.IN1(CLKB_CLKDVL_1),
											.IN2(CLKB_CLK0R_1),
											.IN3(CLKB_CLK0L_1),
											.IN18(CLKB_H6B0),
											.IN19(CLKB_H6B1),
											.IN16(CLKB_H6A0),
											.IN17(CLKB_H6A1),
											.IN14(CLKB_CLKPAD0),
											.IN15(CLKB_CLKPAD1),
											.IN12(CLKB_CLK2X90R_1),
											.IN13(CLKB_CLK2X90L_1),
											.IN10(CLKB_CLK2XR_1),
											.IN11(CLKB_CLK2XL_1),
											.OUT(CLKB_GCLKBUF0_IN),
											.IN23(CLKB_H6D1),
											.IN22(CLKB_H6D0),
											.IN21(CLKB_H6C1),
											.IN20(CLKB_H6C0),
											.IN27(CLKB_H6M1),
											.IN26(CLKB_H6M0),
											.IN25(CLKB_H6E1),
											.IN24(CLKB_H6E0),
											._1(1)
		);

		SPS5B3X4H1 sps_clkinr(
											.IN4(BOT_CLKINR),
											.IN0(CLKB_CLKPAD0),
											.IN1(CLKB_CLKPAD1),
											.IN2(CLKB_IOFB0),
											.IN3(CLKB_IOFB1),
											.OUT(CLKB_CLKINR_1),
											._1(1)
		);

		SPS28B6X2H1 sps_gclkbuf1_in(
											.IN8(CLKB_CLK270R_1),
											.IN9(CLKB_CLK270L_1),
											.IN4(CLKB_CLK90R_1),
											.IN5(CLKB_CLK90L_1),
											.IN6(CLKB_CLK180R_1),
											.IN7(CLKB_CLK180L_1),
											.IN0(CLKB_CLKDVR_1),
											.IN1(CLKB_CLKDVL_1),
											.IN2(CLKB_CLK0R_1),
											.IN3(CLKB_CLK0L_1),
											.IN18(CLKB_H6B0),
											.IN19(CLKB_H6B1),
											.IN16(CLKB_H6A0),
											.IN17(CLKB_H6A1),
											.IN14(CLKB_CLKPAD0),
											.IN15(CLKB_CLKPAD1),
											.IN12(CLKB_CLK2X90R_1),
											.IN13(CLKB_CLK2X90L_1),
											.IN10(CLKB_CLK2XR_1),
											.IN11(CLKB_CLK2XL_1),
											.OUT(CLKB_GCLKBUF1_IN),
											.IN23(CLKB_H6D1),
											.IN22(CLKB_H6D0),
											.IN21(CLKB_H6C1),
											.IN20(CLKB_H6C0),
											.IN27(CLKB_H6M1),
											.IN26(CLKB_H6M0),
											.IN25(CLKB_H6E1),
											.IN24(CLKB_H6E0),
											._1(1)
		);

		SPS20T6X11H1 sps_h6d1(
											.IN8(CLKB_CLK270R_1),
											.IN9(CLKB_CLK270L_1),
											.IN4(CLKB_CLK90R_1),
											.IN5(CLKB_CLK90L_1),
											.IN6(CLKB_CLK180R_1),
											.IN7(CLKB_CLK180L_1),
											.IN0(CLKB_CLKDVR_1),
											.IN1(CLKB_CLKDVL_1),
											.IN2(CLKB_CLK0R_1),
											.IN3(CLKB_CLK0L_1),
											.OUT(CLKB_H6D1),
											.IN18(CLKB_LOCKEDR_1),
											.IN19(CLKB_LOCKEDL_1),
											.IN16(CLKB_GCLK0_PW),
											.IN17(CLKB_GCLK1_PW),
											.IN14(CLKB_CLKPAD0),
											.IN15(CLKB_CLKPAD1),
											.IN12(CLKB_CLK2X90R_1),
											.IN13(CLKB_CLK2X90L_1),
											.IN10(CLKB_CLK2XR_1),
											.IN11(CLKB_CLK2XL_1),
											._1(1)
		);

		SPS20T6X11H1 sps_h6d0(
											.IN8(CLKB_CLK270R_1),
											.IN9(CLKB_CLK270L_1),
											.IN4(CLKB_CLK90R_1),
											.IN5(CLKB_CLK90L_1),
											.IN6(CLKB_CLK180R_1),
											.IN7(CLKB_CLK180L_1),
											.IN0(CLKB_CLKDVR_1),
											.IN1(CLKB_CLKDVL_1),
											.IN2(CLKB_CLK0R_1),
											.IN3(CLKB_CLK0L_1),
											.OUT(CLKB_H6D0),
											.IN18(CLKB_LOCKEDR_1),
											.IN19(CLKB_LOCKEDL_1),
											.IN16(CLKB_GCLK0_PW),
											.IN17(CLKB_GCLK1_PW),
											.IN14(CLKB_CLKPAD0),
											.IN15(CLKB_CLKPAD1),
											.IN12(CLKB_CLK2X90R_1),
											.IN13(CLKB_CLK2X90L_1),
											.IN10(CLKB_CLK2XR_1),
											.IN11(CLKB_CLK2XL_1),
											._1(1)
		);

		SPS20T6X11H1 sps_h6d3(
											.IN8(CLKB_CLK270R_1),
											.IN9(CLKB_CLK270L_1),
											.IN4(CLKB_CLK90R_1),
											.IN5(CLKB_CLK90L_1),
											.IN6(CLKB_CLK180R_1),
											.IN7(CLKB_CLK180L_1),
											.IN0(CLKB_CLKDVR_1),
											.IN1(CLKB_CLKDVL_1),
											.IN2(CLKB_CLK0R_1),
											.IN3(CLKB_CLK0L_1),
											.IN11(CLKB_CLK2XL_1),
											.IN18(CLKB_LOCKEDR_1),
											.IN19(CLKB_LOCKEDL_1),
											.IN16(CLKB_GCLK0_PW),
											.IN17(CLKB_GCLK1_PW),
											.IN14(CLKB_CLKPAD0),
											.IN15(CLKB_CLKPAD1),
											.IN12(CLKB_CLK2X90R_1),
											.IN13(CLKB_CLK2X90L_1),
											.IN10(CLKB_CLK2XR_1),
											.OUT(CLKB_H6D3),
											._1(1)
		);

		SPS20T6X11H1 sps_h6d2(
											.IN8(CLKB_CLK270R_1),
											.IN9(CLKB_CLK270L_1),
											.IN4(CLKB_CLK90R_1),
											.IN5(CLKB_CLK90L_1),
											.IN6(CLKB_CLK180R_1),
											.IN7(CLKB_CLK180L_1),
											.IN0(CLKB_CLKDVR_1),
											.IN1(CLKB_CLKDVL_1),
											.IN2(CLKB_CLK0R_1),
											.IN3(CLKB_CLK0L_1),
											.IN11(CLKB_CLK2XL_1),
											.IN18(CLKB_LOCKEDR_1),
											.IN19(CLKB_LOCKEDL_1),
											.IN16(CLKB_GCLK0_PW),
											.IN17(CLKB_GCLK1_PW),
											.IN14(CLKB_CLKPAD0),
											.IN15(CLKB_CLKPAD1),
											.IN12(CLKB_CLK2X90R_1),
											.IN13(CLKB_CLK2X90L_1),
											.IN10(CLKB_CLK2XR_1),
											.OUT(CLKB_H6D2),
											._1(1)
		);

		SPS5B3X4H1 sps_clkinl(
											.IN4(BOT_CLKINL),
											.IN0(CLKB_CLKPAD0),
											.IN1(CLKB_CLKPAD1),
											.IN2(CLKB_IOFB0),
											.IN3(CLKB_IOFB1),
											.OUT(CLKB_CLKINL_1),
											._1(1)
		);

		SPS6B3X4H1 sps_clkfbr(
											.IN4(CLKB_CLK2XR_1),
											.IN5(BOT_CLKFBR),
											.IN0(CLKB_CLKPAD0),
											.IN1(CLKB_CLKPAD1),
											.IN2(CLKB_IOFB0),
											.IN3(CLKB_IOFB1),
											.OUT(CLKB_CLKFBR_1),
											._1(1)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_LFT(
LEFT_E23, LEFT_E22, LEFT_E21, LEFT_E20, LEFT_E19, LEFT_E18, LEFT_E17, LEFT_E16, LEFT_E15, LEFT_E14, LEFT_E13, LEFT_E12, LEFT_E11, LEFT_E10, LEFT_E9, LEFT_E8, LEFT_E7, LEFT_E6, LEFT_E5, LEFT_E4, LEFT_E3, LEFT_E2, LEFT_E1, LEFT_E0, LEFT_H6E0, LEFT_H6E1, LEFT_H6E2, LEFT_H6E3, LEFT_H6E4, LEFT_H6E5, LEFT_H6E6, LEFT_H6E7, LEFT_H6E8, LEFT_H6E9, LEFT_H6E10, LEFT_H6E11, LEFT_H6A0, LEFT_H6A1, LEFT_H6A2, LEFT_H6A3, LEFT_H6A4, LEFT_H6A5, LEFT_H6A6, LEFT_H6A7, LEFT_H6A8, LEFT_H6A9, LEFT_H6A10, LEFT_H6A11, LEFT_H6B0, LEFT_H6B1, LEFT_H6B2, LEFT_H6B3, LEFT_H6B4, LEFT_H6B5, LEFT_H6B6, LEFT_H6B7, LEFT_H6B8, LEFT_H6B9, LEFT_H6B10, LEFT_H6B11, LEFT_H6M0, LEFT_H6M1, LEFT_H6M2, LEFT_H6M3, LEFT_H6M4, LEFT_H6M5, LEFT_H6M6, LEFT_H6M7, LEFT_H6M8, LEFT_H6M9, LEFT_H6M10, LEFT_H6M11, LEFT_H6C0, LEFT_H6C1, LEFT_H6C2, LEFT_H6C3, LEFT_H6C4, LEFT_H6C5, LEFT_H6C6, LEFT_H6C7, LEFT_H6C8, LEFT_H6C9, LEFT_H6C10, LEFT_H6C11, LEFT_H6D0, LEFT_H6D1, LEFT_H6D2, LEFT_H6D3, LEFT_H6D4, LEFT_H6D5, LEFT_H6D6, LEFT_H6D7, LEFT_H6D8, LEFT_H6D9, LEFT_H6D10, LEFT_H6D11, LEFT_LLH0, LEFT_LLH1, LEFT_LLH2, LEFT_LLH3, LEFT_LLH4, LEFT_LLH5, LEFT_LLH6, LEFT_LLH7, LEFT_LLH8, LEFT_LLH9, LEFT_LLH10, LEFT_LLH11, LEFT_GCLK0, LEFT_GCLK1, LEFT_GCLK2, LEFT_GCLK3, LEFT_OUT0, LEFT_OUT1, LEFT_OUT_E6, LEFT_OUT_E7, LEFT_TBUF1_STUB, LEFT_TBUFO2, LEFT_TBUFO3, LEFT_TBUFO0, LEFT_V6N0, LEFT_V6N1, LEFT_V6N2, LEFT_V6N3, LEFT_V6A0, LEFT_V6A1, LEFT_V6A2, LEFT_V6A3, LEFT_V6B0, LEFT_V6B1, LEFT_V6B2, LEFT_V6B3, LEFT_V6M0, LEFT_V6M1, LEFT_V6M2, LEFT_V6M3, LEFT_V6C0, LEFT_V6C1, LEFT_V6C2, LEFT_V6C3, LEFT_V6D0, LEFT_V6D1, LEFT_V6D2, LEFT_V6D3, LEFT_V6S0, LEFT_V6S1, LEFT_V6S2, LEFT_V6S3, LEFT_LLV0, LEFT_LLV6, LEFT_PCI_CE, LEFT_I1, LEFT_I2, LEFT_I3, LEFT_IQ1, LEFT_IQ2, LEFT_IQ3, LEFT_ICE1, LEFT_ICE2, LEFT_ICE3, LEFT_O1, LEFT_O2, LEFT_O3, LEFT_OCE1, LEFT_OCE2, LEFT_OCE3, LEFT_T1, LEFT_T2, LEFT_T3, LEFT_TCE1, LEFT_TCE2, LEFT_TCE3, LEFT_CLK1, LEFT_CLK2, LEFT_CLK3, LEFT_SR_B1, LEFT_SR_B2, LEFT_SR_B3, LEFT_TS0_B, LEFT_TS1_B, LEFT_TO0, LEFT_TO1, LEFT_TI0_B, LEFT_TI1_B, _1
);
inout	LEFT_E23;
inout	LEFT_E22;
inout	LEFT_E21;
inout	LEFT_E20;
inout	LEFT_E19;
inout	LEFT_E18;
inout	LEFT_E17;
inout	LEFT_E16;
inout	LEFT_E15;
inout	LEFT_E14;
inout	LEFT_E13;
inout	LEFT_E12;
inout	LEFT_E11;
inout	LEFT_E10;
inout	LEFT_E9;
inout	LEFT_E8;
inout	LEFT_E7;
inout	LEFT_E6;
inout	LEFT_E5;
inout	LEFT_E4;
inout	LEFT_E3;
inout	LEFT_E2;
inout	LEFT_E1;
inout	LEFT_E0;
inout	LEFT_H6E0;
inout	LEFT_H6E1;
inout	LEFT_H6E2;
inout	LEFT_H6E3;
inout	LEFT_H6E4;
inout	LEFT_H6E5;
inout	LEFT_H6E6;
inout	LEFT_H6E7;
inout	LEFT_H6E8;
inout	LEFT_H6E9;
inout	LEFT_H6E10;
inout	LEFT_H6E11;
inout	LEFT_H6A0;
inout	LEFT_H6A1;
inout	LEFT_H6A2;
inout	LEFT_H6A3;
inout	LEFT_H6A4;
inout	LEFT_H6A5;
inout	LEFT_H6A6;
inout	LEFT_H6A7;
inout	LEFT_H6A8;
inout	LEFT_H6A9;
inout	LEFT_H6A10;
inout	LEFT_H6A11;
inout	LEFT_H6B0;
inout	LEFT_H6B1;
inout	LEFT_H6B2;
inout	LEFT_H6B3;
inout	LEFT_H6B4;
inout	LEFT_H6B5;
inout	LEFT_H6B6;
inout	LEFT_H6B7;
inout	LEFT_H6B8;
inout	LEFT_H6B9;
inout	LEFT_H6B10;
inout	LEFT_H6B11;
inout	LEFT_H6M0;
inout	LEFT_H6M1;
inout	LEFT_H6M2;
inout	LEFT_H6M3;
inout	LEFT_H6M4;
inout	LEFT_H6M5;
inout	LEFT_H6M6;
inout	LEFT_H6M7;
inout	LEFT_H6M8;
inout	LEFT_H6M9;
inout	LEFT_H6M10;
inout	LEFT_H6M11;
inout	LEFT_H6C0;
inout	LEFT_H6C1;
inout	LEFT_H6C2;
inout	LEFT_H6C3;
inout	LEFT_H6C4;
inout	LEFT_H6C5;
inout	LEFT_H6C6;
inout	LEFT_H6C7;
inout	LEFT_H6C8;
inout	LEFT_H6C9;
inout	LEFT_H6C10;
inout	LEFT_H6C11;
inout	LEFT_H6D0;
inout	LEFT_H6D1;
inout	LEFT_H6D2;
inout	LEFT_H6D3;
inout	LEFT_H6D4;
inout	LEFT_H6D5;
inout	LEFT_H6D6;
inout	LEFT_H6D7;
inout	LEFT_H6D8;
inout	LEFT_H6D9;
inout	LEFT_H6D10;
inout	LEFT_H6D11;
inout	LEFT_LLH0;
inout	LEFT_LLH1;
inout	LEFT_LLH2;
inout	LEFT_LLH3;
inout	LEFT_LLH4;
inout	LEFT_LLH5;
inout	LEFT_LLH6;
inout	LEFT_LLH7;
inout	LEFT_LLH8;
inout	LEFT_LLH9;
inout	LEFT_LLH10;
inout	LEFT_LLH11;
inout	LEFT_GCLK0;
inout	LEFT_GCLK1;
inout	LEFT_GCLK2;
inout	LEFT_GCLK3;
inout	LEFT_OUT0;
inout	LEFT_OUT1;
inout	LEFT_OUT_E6;
inout	LEFT_OUT_E7;
inout	LEFT_TBUF1_STUB;
inout	LEFT_TBUFO2;
inout	LEFT_TBUFO3;
inout	LEFT_TBUFO0;
inout	LEFT_V6N0;
inout	LEFT_V6N1;
inout	LEFT_V6N2;
inout	LEFT_V6N3;
inout	LEFT_V6A0;
inout	LEFT_V6A1;
inout	LEFT_V6A2;
inout	LEFT_V6A3;
inout	LEFT_V6B0;
inout	LEFT_V6B1;
inout	LEFT_V6B2;
inout	LEFT_V6B3;
inout	LEFT_V6M0;
inout	LEFT_V6M1;
inout	LEFT_V6M2;
inout	LEFT_V6M3;
inout	LEFT_V6C0;
inout	LEFT_V6C1;
inout	LEFT_V6C2;
inout	LEFT_V6C3;
inout	LEFT_V6D0;
inout	LEFT_V6D1;
inout	LEFT_V6D2;
inout	LEFT_V6D3;
inout	LEFT_V6S0;
inout	LEFT_V6S1;
inout	LEFT_V6S2;
inout	LEFT_V6S3;
inout	LEFT_LLV0;
inout	LEFT_LLV6;
inout	LEFT_PCI_CE;
inout	LEFT_I1;
inout	LEFT_I2;
inout	LEFT_I3;
inout	LEFT_IQ1;
inout	LEFT_IQ2;
inout	LEFT_IQ3;
inout	LEFT_ICE1;
inout	LEFT_ICE2;
inout	LEFT_ICE3;
inout	LEFT_O1;
inout	LEFT_O2;
inout	LEFT_O3;
inout	LEFT_OCE1;
inout	LEFT_OCE2;
inout	LEFT_OCE3;
inout	LEFT_T1;
inout	LEFT_T2;
inout	LEFT_T3;
inout	LEFT_TCE1;
inout	LEFT_TCE2;
inout	LEFT_TCE3;
inout	LEFT_CLK1;
inout	LEFT_CLK2;
inout	LEFT_CLK3;
inout	LEFT_SR_B1;
inout	LEFT_SR_B2;
inout	LEFT_SR_B3;
inout	LEFT_TS0_B;
inout	LEFT_TS1_B;
inout	LEFT_TO0;
inout	LEFT_TO1;
inout	LEFT_TI0_B;
inout	LEFT_TI1_B;
inout	_1;
		wire		LEFT_E_BUF23 ;
		wire		LEFT_E_BUF22 ;
		wire		LEFT_E_BUF21 ;
		wire		LEFT_E_BUF20 ;
		wire		LEFT_E_BUF19 ;
		wire		LEFT_E_BUF18 ;
		wire		LEFT_E_BUF17 ;
		wire		LEFT_E_BUF16 ;
		wire		LEFT_E_BUF15 ;
		wire		LEFT_E_BUF14 ;
		wire		LEFT_E_BUF13 ;
		wire		LEFT_E_BUF12 ;
		wire		LEFT_E_BUF11 ;
		wire		LEFT_E_BUF10 ;
		wire		LEFT_E_BUF9 ;
		wire		LEFT_E_BUF8 ;
		wire		LEFT_E_BUF7 ;
		wire		LEFT_E_BUF6 ;
		wire		LEFT_E_BUF5 ;
		wire		LEFT_E_BUF4 ;
		wire		LEFT_E_BUF3 ;
		wire		LEFT_E_BUF2 ;
		wire		LEFT_E_BUF1 ;
		wire		LEFT_E_BUF0 ;
		wire		LEFT_H6E_BUF1 ;
		wire		LEFT_H6E_BUF2 ;
		wire		LEFT_H6E_BUF3 ;
		wire		LEFT_H6A_BUF1 ;
		wire		LEFT_H6A_BUF2 ;
		wire		LEFT_H6A_BUF3 ;
		wire		LEFT_H6B_BUF1 ;
		wire		LEFT_H6B_BUF2 ;
		wire		LEFT_H6B_BUF3 ;
		wire		LEFT_H6M_BUF1 ;
		wire		LEFT_H6M_BUF2 ;
		wire		LEFT_H6M_BUF3 ;
		wire		LEFT_V6A_BUF0 ;
		wire		LEFT_V6A_BUF1 ;
		wire		LEFT_V6A_BUF2 ;
		wire		LEFT_V6A_BUF3 ;
		wire		LEFT_V6B_BUF0 ;
		wire		LEFT_V6B_BUF1 ;
		wire		LEFT_V6B_BUF2 ;
		wire		LEFT_V6B_BUF3 ;
		wire		LEFT_V6M_BUF0 ;
		wire		LEFT_V6M_BUF1 ;
		wire		LEFT_V6M_BUF2 ;
		wire		LEFT_V6M_BUF3 ;
		wire		LEFT_V6C_BUF0 ;
		wire		LEFT_V6C_BUF1 ;
		wire		LEFT_V6C_BUF2 ;
		wire		LEFT_V6C_BUF3 ;
		wire		LEFT_V6D_BUF0 ;
		wire		LEFT_V6D_BUF1 ;
		wire		LEFT_V6D_BUF2 ;
		wire		LEFT_V6D_BUF3 ;
		wire		LEFT_V6S_BUF0 ;
		wire		LEFT_V6S_BUF1 ;
		wire		LEFT_V6S_BUF2 ;
		wire		LEFT_V6S_BUF3 ;
		wire		LEFT_IQ0 ;
		wire		LEFT_I0 ;
		wire		LEFT_TBUFO1 ;
		wire		VDD ;

		SPS12T8X11H1 sps_v6s3(
											.IN8(LEFT_I0),
											.IN9(LEFT_LLV6),
											.IN4(LEFT_I2),
											.IN5(LEFT_IQ1),
											.IN6(LEFT_I1),
											.IN7(LEFT_IQ0),
											.IN0(LEFT_V6N3),
											.IN1(LEFT_IQ3),
											.IN2(LEFT_I3),
											.IN3(LEFT_IQ2),
											.IN11(LEFT_H6E3),
											.IN10(LEFT_H6M1),
											.OUT(LEFT_V6S3),
											._1(1)
		);

		BUF1B0X2H3 buf_h6m10_h6b11(
											.A(LEFT_H6M10),
											.Y(LEFT_H6B11)
		);

		SPS4T5X11H1 sps_h6m2(
											.IN3(LEFT_LLH3),
											.IN0(LEFT_I1),
											.IN1(LEFT_I2),
											.IN2(LEFT_I3),
											.OUT(LEFT_H6M2),
											._1(1)
		);

		SPS4T5X11H1 sps_h6m3(
											.IN3(LEFT_LLH3),
											.IN0(LEFT_IQ0),
											.IN1(LEFT_IQ1),
											.IN2(LEFT_I3),
											.OUT(LEFT_H6M3),
											._1(1)
		);

		SPS4T5X11H1 sps_h6m0(
											.OUT(LEFT_H6M0),
											.IN0(LEFT_IQ1),
											.IN1(LEFT_IQ2),
											.IN2(LEFT_IQ3),
											.IN3(LEFT_LLH9),
											._1(1)
		);

		SPS4T5X11H1 sps_h6m1(
											.IN3(LEFT_LLH9),
											.IN0(LEFT_I0),
											.IN1(LEFT_I1),
											.IN2(LEFT_IQ3),
											.OUT(LEFT_H6M1),
											._1(1)
		);

		BUF1B0X2H5 buf_e9(
											.A(LEFT_E9),
											.Y(LEFT_E_BUF9)
		);

		BUF1B0X2H5 buf_e8(
											.A(LEFT_E8),
											.Y(LEFT_E_BUF8)
		);

		BUF1B0X2H5 buf_e7(
											.A(LEFT_E7),
											.Y(LEFT_E_BUF7)
		);

		BUF1B0X2H5 buf_e6(
											.A(LEFT_E6),
											.Y(LEFT_E_BUF6)
		);

		BUF1B0X2H5 buf_e5(
											.A(LEFT_E5),
											.Y(LEFT_E_BUF5)
		);

		BUF1B0X2H5 buf_e4(
											.A(LEFT_E4),
											.Y(LEFT_E_BUF4)
		);

		BUF1B0X2H5 buf_e3(
											.A(LEFT_E3),
											.Y(LEFT_E_BUF3)
		);

		BUF1B0X2H5 buf_e2(
											.A(LEFT_E2),
											.Y(LEFT_E_BUF2)
		);

		BUF1B0X2H5 buf_e1(
											.A(LEFT_E1),
											.Y(LEFT_E_BUF1)
		);

		BUF1B0X2H5 buf_e0(
											.A(LEFT_E0),
											.Y(LEFT_E_BUF0)
		);

		SPS6B6X2H1 sps_h6e9(
											.IN4(LEFT_V6N0),
											.IN5(LEFT_H6D8),
											.IN0(LEFT_IQ2),
											.IN1(LEFT_I2),
											.IN2(LEFT_V6S2),
											.IN3(LEFT_V6M3),
											.OUT(LEFT_H6E9),
											._1(1)
		);

		BUF1B0X2H3 buf_h6a3(
											.A(LEFT_H6A3),
											.Y(LEFT_H6A_BUF3)
		);

		BUF1B0X2H3 buf_h6a2(
											.A(LEFT_H6A2),
											.Y(LEFT_H6A_BUF2)
		);

		BUF1B0X2H3 buf_h6a1(
											.A(LEFT_H6A1),
											.Y(LEFT_H6A_BUF1)
		);

		SPS6T7X11H1 sps_h6e2(
											.IN4(LEFT_V6M1),
											.IN5(LEFT_V6N3),
											.IN0(LEFT_IQ0),
											.IN1(LEFT_IQ1),
											.IN2(LEFT_LLH6),
											.IN3(LEFT_V6S2),
											.OUT(LEFT_H6E2),
											._1(1)
		);

		SPS6T7X11H1 sps_h6e3(
											.IN4(LEFT_V6M2),
											.IN5(LEFT_V6N0),
											.IN0(LEFT_IQ2),
											.IN1(LEFT_IQ3),
											.IN2(LEFT_LLH6),
											.IN3(LEFT_V6S3),
											.OUT(LEFT_H6E3),
											._1(1)
		);

		SPS6T7X11H1 sps_h6e0(
											.IN4(LEFT_V6M3),
											.IN5(LEFT_V6N1),
											.IN0(LEFT_I0),
											.IN1(LEFT_I1),
											.IN2(LEFT_LLH0),
											.IN3(LEFT_V6S0),
											.OUT(LEFT_H6E0),
											._1(1)
		);

		SPS6T7X11H1 sps_h6e1(
											.IN4(LEFT_V6M0),
											.IN5(LEFT_V6N2),
											.IN0(LEFT_I2),
											.IN1(LEFT_I3),
											.IN2(LEFT_LLH0),
											.IN3(LEFT_V6S1),
											.OUT(LEFT_H6E1),
											._1(1)
		);

		SPS6B6X2H1 sps_h6e7(
											.IN4(LEFT_V6S3),
											.IN5(LEFT_H6D6),
											.IN0(LEFT_IQ1),
											.IN1(LEFT_I1),
											.IN2(LEFT_V6N1),
											.IN3(LEFT_V6M0),
											.OUT(LEFT_H6E7),
											._1(1)
		);

		SPS6B6X2H1 sps_h6a11(
											.IN4(LEFT_V6N3),
											.IN5(LEFT_H6C10),
											.IN0(LEFT_IQ3),
											.IN1(LEFT_I3),
											.IN2(LEFT_V6S1),
											.IN3(LEFT_V6M2),
											.OUT(LEFT_H6A11),
											._1(1)
		);

		SPBU1AND1X10H1 spbu_tbufo0(
											.IN(LEFT_TO1),
											.OUT(LEFT_TBUFO0)
		);

		SPBU1AND1X10H1 spbu_tbufo1(
											.IN(LEFT_TO0),
											.OUT(LEFT_TBUFO1)
		);

		SPBU1AND1X10H1 spbu_tbufo2(
											.IN(LEFT_TO1),
											.OUT(LEFT_TBUFO2)
		);

		SPBU1AND1X10H1 spbu_tbufo3(
											.IN(LEFT_TO0),
											.OUT(LEFT_TBUFO3)
		);

		BUF1B0X2H3 buf_v6m1(
											.A(LEFT_V6M1),
											.Y(LEFT_V6M_BUF1)
		);

		BUF1B0X2H3 buf_v6m0(
											.A(LEFT_V6M0),
											.Y(LEFT_V6M_BUF0)
		);

		BUF1B0X2H3 buf_v6m3(
											.A(LEFT_V6M3),
											.Y(LEFT_V6M_BUF3)
		);

		BUF1B0X2H3 buf_v6m2(
											.A(LEFT_V6M2),
											.Y(LEFT_V6M_BUF2)
		);

		SPS12T8X11H1 sps_v6s2(
											.IN8(LEFT_I0),
											.IN9(LEFT_LLV6),
											.IN4(LEFT_I2),
											.IN5(LEFT_IQ1),
											.IN6(LEFT_I1),
											.IN7(LEFT_IQ0),
											.IN0(LEFT_V6N2),
											.IN1(LEFT_IQ3),
											.IN2(LEFT_I3),
											.IN3(LEFT_IQ2),
											.IN11(LEFT_H6E2),
											.IN10(LEFT_H6M0),
											.OUT(LEFT_V6S2),
											._1(1)
		);

		SPS2N2X0H2 sps_e4(
											.IN0(LEFT_IQ3),
											.IN1(LEFT_V6M0),
											.OUT(LEFT_E4),
											._1(1)
		);

		SPS2N2X0H2 sps_e14(
											.IN0(LEFT_IQ1),
											.IN1(LEFT_V6N2),
											.OUT(LEFT_E14),
											._1(1)
		);

		SPS3N3X0H1 sps_e15(
											.IN0(LEFT_IQ0),
											.IN1(LEFT_V6S2),
											.IN2(LEFT_TBUFO1),
											.OUT(LEFT_E15),
											._1(1)
		);

		SPS2N2X0H2 sps_e16(
											.IN0(LEFT_I3),
											.IN1(LEFT_V6M2),
											.OUT(LEFT_E16),
											._1(1)
		);

		SPS2N2X0H2 sps_e17(
											.IN0(LEFT_I2),
											.IN1(LEFT_V6N2),
											.OUT(LEFT_E17),
											._1(1)
		);

		SPS2N2X0H2 sps_e10(
											.IN0(LEFT_I1),
											.IN1(LEFT_V6M1),
											.OUT(LEFT_E10),
											._1(1)
		);

		SPS2N2X0H2 sps_e11(
											.IN0(LEFT_I0),
											.IN1(LEFT_V6N1),
											.OUT(LEFT_E11),
											._1(1)
		);

		SPS3N3X0H1 sps_e12(
											.IN0(LEFT_IQ3),
											.IN1(LEFT_V6S2),
											.IN2(LEFT_TBUFO1),
											.OUT(LEFT_E12),
											._1(1)
		);

		SPS2N2X0H2 sps_e13(
											.IN0(LEFT_IQ2),
											.IN1(LEFT_V6M2),
											.OUT(LEFT_E13),
											._1(1)
		);

		BUF1B0X2H3 buf_h6b2(
											.A(LEFT_H6B2),
											.Y(LEFT_H6B_BUF2)
		);

		BUF1B0X2H3 buf_h6b3(
											.A(LEFT_H6B3),
											.Y(LEFT_H6B_BUF3)
		);

		SPS12N7X0H2 sps_ice2(
											.IN8(LEFT_V6D_BUF3),
											.IN9(LEFT_V6S_BUF3),
											.IN4(LEFT_V6A_BUF3),
											.IN5(LEFT_V6B_BUF3),
											.IN6(LEFT_V6M_BUF3),
											.IN7(LEFT_V6C_BUF3),
											.IN0(LEFT_E_BUF23),
											.IN1(LEFT_E_BUF22),
											.IN2(LEFT_E_BUF21),
											.IN3(LEFT_E_BUF20),
											.OUT(LEFT_ICE2),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		BUF1B0X2H3 buf_h6b1(
											.A(LEFT_H6B1),
											.Y(LEFT_H6B_BUF1)
		);

		SPS3N3X0H1 sps_e18(
											.IN0(LEFT_I1),
											.IN1(LEFT_V6S3),
											.IN2(LEFT_TBUFO0),
											.OUT(LEFT_E18),
											._1(1)
		);

		SPS2N2X0H2 sps_e19(
											.IN0(LEFT_I0),
											.IN1(LEFT_V6M3),
											.OUT(LEFT_E19),
											._1(1)
		);

		BUF1B0X2H3 buf_h6m3(
											.A(LEFT_H6M3),
											.Y(LEFT_H6M_BUF3)
		);

		SPS6B6X2H1 sps_h6e11(
											.IN4(LEFT_V6N3),
											.IN5(LEFT_H6D10),
											.IN0(LEFT_IQ3),
											.IN1(LEFT_I3),
											.IN2(LEFT_V6S1),
											.IN3(LEFT_V6M2),
											.OUT(LEFT_H6E11),
											._1(1)
		);

		SPS4T5X11H1 sps_h6d1(
											.OUT(LEFT_H6D1),
											.IN0(LEFT_IQ0),
											.IN1(LEFT_IQ1),
											.IN2(LEFT_IQ2),
											.IN3(LEFT_LLH7),
											._1(1)
		);

		SPS4T5X11H1 sps_h6d0(
											.OUT(LEFT_H6D0),
											.IN0(LEFT_IQ0),
											.IN1(LEFT_I2),
											.IN2(LEFT_I3),
											.IN3(LEFT_LLH7),
											._1(1)
		);

		SPS4T5X11H1 sps_h6d3(
											.OUT(LEFT_H6D3),
											.IN0(LEFT_I0),
											.IN1(LEFT_I1),
											.IN2(LEFT_I2),
											.IN3(LEFT_LLH1),
											._1(1)
		);

		SPS4T5X11H1 sps_h6d2(
											.OUT(LEFT_H6D2),
											.IN0(LEFT_I0),
											.IN1(LEFT_IQ2),
											.IN2(LEFT_IQ3),
											.IN3(LEFT_LLH1),
											._1(1)
		);

		BUF1B0X2H5 buf_e19(
											.A(LEFT_E19),
											.Y(LEFT_E_BUF19)
		);

		BUF1B0X2H5 buf_e18(
											.A(LEFT_E18),
											.Y(LEFT_E_BUF18)
		);

		BUF1B0X2H5 buf_e17(
											.A(LEFT_E17),
											.Y(LEFT_E_BUF17)
		);

		BUF1B0X2H5 buf_e16(
											.A(LEFT_E16),
											.Y(LEFT_E_BUF16)
		);

		BUF1B0X2H3 buf_h6m4_h6b5(
											.A(LEFT_H6M4),
											.Y(LEFT_H6B5)
		);

		BUF1B0X2H5 buf_e14(
											.A(LEFT_E14),
											.Y(LEFT_E_BUF14)
		);

		BUF1B0X2H5 buf_e13(
											.A(LEFT_E13),
											.Y(LEFT_E_BUF13)
		);

		BUF1B0X2H5 buf_e12(
											.A(LEFT_E12),
											.Y(LEFT_E_BUF12)
		);

		BUF1B0X2H5 buf_e11(
											.A(LEFT_E11),
											.Y(LEFT_E_BUF11)
		);

		BUF1B0X2H5 buf_e10(
											.A(LEFT_E10),
											.Y(LEFT_E_BUF10)
		);

		SPS4N4X0H1 sps_out1(
											.OUT(LEFT_OUT1),
											.IN0(LEFT_I3),
											.IN1(LEFT_I2),
											.IN2(LEFT_I1),
											.IN3(LEFT_I0),
											._1(1)
		);

		SPS12N7X0H2 sps_sr_b2(
											.IN8(LEFT_V6D_BUF1),
											.IN9(LEFT_V6S_BUF1),
											.IN4(LEFT_V6A_BUF1),
											.IN5(LEFT_V6B_BUF1),
											.IN6(LEFT_V6M_BUF1),
											.IN7(LEFT_V6C_BUF1),
											.IN0(LEFT_E_BUF7),
											.IN1(LEFT_E_BUF6),
											.IN2(LEFT_E_BUF5),
											.IN3(LEFT_E_BUF4),
											.OUT(LEFT_SR_B2),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H1 sps_sr_b3(
											.IN8(LEFT_V6D_BUF1),
											.IN9(LEFT_V6S_BUF1),
											.IN4(LEFT_V6A_BUF1),
											.IN5(LEFT_V6B_BUF1),
											.IN6(LEFT_V6M_BUF1),
											.IN7(LEFT_V6C_BUF1),
											.IN0(LEFT_E_BUF7),
											.IN1(LEFT_E_BUF6),
											.IN2(LEFT_E_BUF5),
											.IN3(LEFT_E_BUF4),
											.OUT(LEFT_SR_B3),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS16T10X11H2 sps_llv6(
											.IN8(LEFT_E_BUF23),
											.IN9(LEFT_E_BUF22),
											.IN4(LEFT_IQ2),
											.IN5(LEFT_I2),
											.IN6(LEFT_IQ3),
											.IN7(LEFT_I3),
											.IN0(LEFT_IQ0),
											.IN1(LEFT_I0),
											.IN2(LEFT_IQ1),
											.IN3(LEFT_I1),
											.OUT(LEFT_LLV6),
											.IN14(LEFT_E_BUF6),
											.IN15(LEFT_E_BUF5),
											.IN12(LEFT_E_BUF11),
											.IN13(LEFT_E_BUF10),
											.IN10(LEFT_E_BUF18),
											.IN11(LEFT_E_BUF17),
											._1(1)
		);

		SPS3N3X0H1 sps_e21(
											.IN0(LEFT_IQ2),
											.IN1(LEFT_V6S3),
											.IN2(LEFT_TBUFO0),
											.OUT(LEFT_E21),
											._1(1)
		);

		BUF1B0X2H3 buf_v6d2(
											.A(LEFT_V6D2),
											.Y(LEFT_V6D_BUF2)
		);

		SPS2N2X0H2 sps_e23(
											.IN0(LEFT_IQ0),
											.IN1(LEFT_V6N3),
											.OUT(LEFT_E23),
											._1(1)
		);

		SPS2N2X0H2 sps_e22(
											.IN0(LEFT_IQ1),
											.IN1(LEFT_V6M3),
											.OUT(LEFT_E22),
											._1(1)
		);

		SPS12N7X0H2 sps_tce3(
											.IN8(LEFT_V6D_BUF3),
											.IN9(LEFT_V6S_BUF3),
											.IN4(LEFT_V6A_BUF3),
											.IN5(LEFT_V6B_BUF3),
											.IN6(LEFT_V6M_BUF3),
											.IN7(LEFT_V6C_BUF3),
											.IN0(LEFT_E_BUF13),
											.IN1(LEFT_E_BUF12),
											.IN2(LEFT_E_BUF11),
											.IN3(LEFT_E_BUF10),
											.OUT(LEFT_TCE3),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H2 sps_tce2(
											.IN8(LEFT_V6D_BUF3),
											.IN9(LEFT_V6S_BUF3),
											.IN4(LEFT_V6A_BUF3),
											.IN5(LEFT_V6B_BUF3),
											.IN6(LEFT_V6M_BUF3),
											.IN7(LEFT_V6C_BUF3),
											.IN0(LEFT_E_BUF13),
											.IN1(LEFT_E_BUF12),
											.IN2(LEFT_E_BUF11),
											.IN3(LEFT_E_BUF10),
											.OUT(LEFT_TCE2),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H1 sps_tce1(
											.IN8(LEFT_V6D_BUF3),
											.IN9(LEFT_V6S_BUF3),
											.IN4(LEFT_V6A_BUF3),
											.IN5(LEFT_V6B_BUF3),
											.IN6(LEFT_V6M_BUF3),
											.IN7(LEFT_V6C_BUF3),
											.IN0(LEFT_E_BUF13),
											.IN1(LEFT_E_BUF12),
											.IN2(LEFT_E_BUF11),
											.IN3(LEFT_E_BUF10),
											.OUT(LEFT_TCE1),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		BUF1B0X2H3 buf_v6d3(
											.A(LEFT_V6D3),
											.Y(LEFT_V6D_BUF3)
		);

		BUF1B0X2H3 buf_v6s3(
											.A(LEFT_V6S3),
											.Y(LEFT_V6S_BUF3)
		);

		BUF1B0X2H3 buf_v6s2(
											.A(LEFT_V6S2),
											.Y(LEFT_V6S_BUF2)
		);

		BUF1B0X2H3 buf_v6s1(
											.A(LEFT_V6S1),
											.Y(LEFT_V6S_BUF1)
		);

		BUF1B0X2H3 buf_v6s0(
											.A(LEFT_V6S0),
											.Y(LEFT_V6S_BUF0)
		);

		BUF1B0X2H3 buf_h6b4_h6m5(
											.A(LEFT_H6B4),
											.Y(LEFT_H6M5)
		);

		BUF1B0X2H3 buf_v6d0(
											.A(LEFT_V6D0),
											.Y(LEFT_V6D_BUF0)
		);

		SPS12N7X0H1 sps_ice3(
											.IN8(LEFT_V6D_BUF3),
											.IN9(LEFT_V6S_BUF3),
											.IN4(LEFT_V6A_BUF3),
											.IN5(LEFT_V6B_BUF3),
											.IN6(LEFT_V6M_BUF3),
											.IN7(LEFT_V6C_BUF3),
											.IN0(LEFT_E_BUF23),
											.IN1(LEFT_E_BUF22),
											.IN2(LEFT_E_BUF21),
											.IN3(LEFT_E_BUF20),
											.OUT(LEFT_ICE3),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		BUF1B0X2H3 buf_v6d1(
											.A(LEFT_V6D1),
											.Y(LEFT_V6D_BUF1)
		);

		BUF1B0X2H3 buf_v6b0(
											.A(LEFT_V6B0),
											.Y(LEFT_V6B_BUF0)
		);

		BUF1B0X2H3 buf_v6b1(
											.A(LEFT_V6B1),
											.Y(LEFT_V6B_BUF1)
		);

		BUF1B0X2H3 buf_v6b2(
											.A(LEFT_V6B2),
											.Y(LEFT_V6B_BUF2)
		);

		BUF1B0X2H3 buf_v6b3(
											.A(LEFT_V6B3),
											.Y(LEFT_V6B_BUF3)
		);

		SPS4T5X11H1 sps_h6c0(
											.OUT(LEFT_H6C0),
											.IN0(LEFT_IQ0),
											.IN1(LEFT_I2),
											.IN2(LEFT_I3),
											.IN3(LEFT_LLH8),
											._1(1)
		);

		SPS4T5X11H1 sps_h6c1(
											.OUT(LEFT_H6C1),
											.IN0(LEFT_IQ0),
											.IN1(LEFT_IQ1),
											.IN2(LEFT_IQ2),
											.IN3(LEFT_LLH8),
											._1(1)
		);

		SPS4T5X11H1 sps_h6c2(
											.OUT(LEFT_H6C2),
											.IN0(LEFT_I0),
											.IN1(LEFT_IQ2),
											.IN2(LEFT_IQ3),
											.IN3(LEFT_LLH2),
											._1(1)
		);

		SPS4T5X11H1 sps_h6c3(
											.OUT(LEFT_H6C3),
											.IN0(LEFT_I0),
											.IN1(LEFT_I1),
											.IN2(LEFT_I2),
											.IN3(LEFT_LLH2),
											._1(1)
		);

		SPS12N7X0H2 sps_oce2(
											.IN8(LEFT_V6D_BUF3),
											.IN9(LEFT_V6S_BUF3),
											.IN4(LEFT_V6A_BUF3),
											.IN5(LEFT_V6B_BUF3),
											.IN6(LEFT_V6M_BUF3),
											.IN7(LEFT_V6C_BUF3),
											.IN0(LEFT_E_BUF19),
											.IN1(LEFT_E_BUF18),
											.IN2(LEFT_E_BUF17),
											.IN3(LEFT_E_BUF16),
											.OUT(LEFT_OCE2),
											.IN10(LEFT_PCI_CE),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H2 sps_oce3(
											.IN8(LEFT_V6D_BUF3),
											.IN9(LEFT_V6S_BUF3),
											.IN4(LEFT_V6A_BUF3),
											.IN5(LEFT_V6B_BUF3),
											.IN6(LEFT_V6M_BUF3),
											.IN7(LEFT_V6C_BUF3),
											.IN0(LEFT_E_BUF19),
											.IN1(LEFT_E_BUF18),
											.IN2(LEFT_E_BUF17),
											.IN3(LEFT_E_BUF16),
											.OUT(LEFT_OCE3),
											.IN10(LEFT_PCI_CE),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H1 sps_oce1(
											.IN8(LEFT_V6D_BUF3),
											.IN9(LEFT_V6S_BUF3),
											.IN4(LEFT_V6A_BUF3),
											.IN5(LEFT_V6B_BUF3),
											.IN6(LEFT_V6M_BUF3),
											.IN7(LEFT_V6C_BUF3),
											.IN0(LEFT_E_BUF19),
											.IN1(LEFT_E_BUF18),
											.IN2(LEFT_E_BUF17),
											.IN3(LEFT_E_BUF16),
											.OUT(LEFT_OCE1),
											.IN10(LEFT_PCI_CE),
											.IN11(VDD),
											._1(1)
		);

		SPS3N3X0H1 sps_e6(
											.IN0(LEFT_IQ1),
											.IN1(LEFT_V6S1),
											.IN2(LEFT_TBUFO2),
											.OUT(LEFT_E6),
											._1(1)
		);

		SPS2T2X11H3 sps_llh9(
											.IN0(LEFT_IQ0),
											.IN1(LEFT_I2),
											.OUT(LEFT_LLH9),
											._1(1)
		);

		SPS2T2X11H3 sps_llh8(
											.IN0(LEFT_IQ0),
											.IN1(LEFT_I2),
											.OUT(LEFT_LLH8),
											._1(1)
		);

		SPS2T2X11H3 sps_llh7(
											.IN0(LEFT_I1),
											.IN1(LEFT_IQ2),
											.OUT(LEFT_LLH7),
											._1(1)
		);

		SPS2T2X11H3 sps_llh6(
											.IN0(LEFT_I0),
											.IN1(LEFT_IQ2),
											.OUT(LEFT_LLH6),
											._1(1)
		);

		SPS2T2X11H3 sps_llh5(
											.IN0(LEFT_I1),
											.IN1(LEFT_I2),
											.OUT(LEFT_LLH5),
											._1(1)
		);

		SPS2T2X11H3 sps_llh4(
											.IN0(LEFT_I1),
											.IN1(LEFT_IQ2),
											.OUT(LEFT_LLH4),
											._1(1)
		);

		SPS2T2X11H3 sps_llh3(
											.IN0(LEFT_IQ1),
											.IN1(LEFT_I3),
											.OUT(LEFT_LLH3),
											._1(1)
		);

		SPS2T2X11H3 sps_llh2(
											.IN0(LEFT_IQ1),
											.IN1(LEFT_I3),
											.OUT(LEFT_LLH2),
											._1(1)
		);

		SPS2T2X11H3 sps_llh1(
											.IN0(LEFT_I0),
											.IN1(LEFT_IQ3),
											.OUT(LEFT_LLH1),
											._1(1)
		);

		SPS2T2X11H3 sps_llh0(
											.IN0(LEFT_IQ3),
											.IN1(LEFT_IQ0),
											.OUT(LEFT_LLH0),
											._1(1)
		);

		BUF1B0X2H5 buf_e15(
											.A(LEFT_E15),
											.Y(LEFT_E_BUF15)
		);

		SPS2N2X0H2 sps_e7(
											.IN0(LEFT_IQ0),
											.IN1(LEFT_V6M1),
											.OUT(LEFT_E7),
											._1(1)
		);

		BUF1B0X2H3 buf_v6c3(
											.A(LEFT_V6C3),
											.Y(LEFT_V6C_BUF3)
		);

		BUF1B0X2H3 buf_v6c2(
											.A(LEFT_V6C2),
											.Y(LEFT_V6C_BUF2)
		);

		BUF1B0X2H3 buf_v6c1(
											.A(LEFT_V6C1),
											.Y(LEFT_V6C_BUF1)
		);

		BUF1B0X2H3 buf_v6c0(
											.A(LEFT_V6C0),
											.Y(LEFT_V6C_BUF0)
		);

		BUF1B0X2H3 buf_h6e8_h6d9(
											.A(LEFT_H6E8),
											.Y(LEFT_H6D9)
		);

		SPS4T5X11H1 sps_h6b2(
											.IN3(LEFT_LLH4),
											.IN0(LEFT_I1),
											.IN1(LEFT_I2),
											.IN2(LEFT_I3),
											.OUT(LEFT_H6B2),
											._1(1)
		);

		SPS4T5X11H1 sps_h6b1(
											.IN3(LEFT_LLH10),
											.IN0(LEFT_I0),
											.IN1(LEFT_I1),
											.IN2(LEFT_IQ3),
											.OUT(LEFT_H6B1),
											._1(1)
		);

		SPS4T5X11H1 sps_h6b0(
											.OUT(LEFT_H6B0),
											.IN0(LEFT_IQ1),
											.IN1(LEFT_IQ2),
											.IN2(LEFT_IQ3),
											.IN3(LEFT_LLH10),
											._1(1)
		);

		BUF1B0X2H3 buf_h6e6_h6d7(
											.A(LEFT_H6E6),
											.Y(LEFT_H6D7)
		);

		STUBX10H1 stub_tbuf1(
											.INOUTB(LEFT_TBUF1_STUB),
											.INOUTA(LEFT_TBUFO1)
		);

		BUF1B0X2H3 buf_h6e4_h6d5(
											.A(LEFT_H6E4),
											.Y(LEFT_H6D5)
		);

		BUF1B0X2H3 buf_h6m2(
											.A(LEFT_H6M2),
											.Y(LEFT_H6M_BUF2)
		);

		BUF1B0X2H3 buf_h6m1(
											.A(LEFT_H6M1),
											.Y(LEFT_H6M_BUF1)
		);

		SPS12N7X0H1 sps_ti0_b(
											.IN8(LEFT_E_BUF17),
											.IN9(LEFT_E_BUF18),
											.IN4(LEFT_IQ2),
											.IN5(LEFT_I2),
											.IN6(LEFT_IQ3),
											.IN7(LEFT_I3),
											.IN0(LEFT_IQ0),
											.IN1(LEFT_I0),
											.IN2(LEFT_IQ1),
											.IN3(LEFT_I1),
											.OUT(LEFT_TI0_B),
											.IN10(LEFT_E_BUF22),
											.IN11(LEFT_E_BUF23),
											._1(1)
		);

		SPS2N2X0H2 sps_e5(
											.IN0(LEFT_IQ2),
											.IN1(LEFT_V6N0),
											.OUT(LEFT_E5),
											._1(1)
		);

		SPS12N7X0H2 sps_sr_b1(
											.IN8(LEFT_V6D_BUF1),
											.IN9(LEFT_V6S_BUF1),
											.IN4(LEFT_V6A_BUF1),
											.IN5(LEFT_V6B_BUF1),
											.IN6(LEFT_V6M_BUF1),
											.IN7(LEFT_V6C_BUF1),
											.IN0(LEFT_E_BUF7),
											.IN1(LEFT_E_BUF6),
											.IN2(LEFT_E_BUF5),
											.IN3(LEFT_E_BUF4),
											.OUT(LEFT_SR_B1),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		BUF1B0X2H5 buf_e22(
											.A(LEFT_E22),
											.Y(LEFT_E_BUF22)
		);

		BUF1B0X2H5 buf_e23(
											.A(LEFT_E23),
											.Y(LEFT_E_BUF23)
		);

		BUF1B0X2H5 buf_e20(
											.A(LEFT_E20),
											.Y(LEFT_E_BUF20)
		);

		BUF1B0X2H5 buf_e21(
											.A(LEFT_E21),
											.Y(LEFT_E_BUF21)
		);

		BUF1B0X2H3 buf_h6e3(
											.A(LEFT_H6E3),
											.Y(LEFT_H6E_BUF3)
		);

		BUF1B0X2H3 buf_h6e2(
											.A(LEFT_H6E2),
											.Y(LEFT_H6E_BUF2)
		);

		BUF1B0X2H3 buf_h6e1(
											.A(LEFT_H6E1),
											.Y(LEFT_H6E_BUF1)
		);

		SPS6B6X2H1 sps_h6a9(
											.IN4(LEFT_V6N0),
											.IN5(LEFT_H6C8),
											.IN0(LEFT_IQ2),
											.IN1(LEFT_I2),
											.IN2(LEFT_V6S2),
											.IN3(LEFT_V6M3),
											.OUT(LEFT_H6A9),
											._1(1)
		);

		SPS6B6X2H1 sps_h6a7(
											.IN4(LEFT_V6S3),
											.IN5(LEFT_H6C6),
											.IN0(LEFT_IQ1),
											.IN1(LEFT_I1),
											.IN2(LEFT_V6N1),
											.IN3(LEFT_V6M0),
											.OUT(LEFT_H6A7),
											._1(1)
		);

		SPS6B6X2H1 sps_h6a5(
											.IN4(LEFT_V6N2),
											.IN5(LEFT_H6C4),
											.IN0(LEFT_IQ0),
											.IN1(LEFT_I0),
											.IN2(LEFT_V6S0),
											.IN3(LEFT_V6M1),
											.OUT(LEFT_H6A5),
											._1(1)
		);

		SPS4T5X11H1 sps_h6a2(
											.IN3(LEFT_LLH5),
											.IN0(LEFT_IQ0),
											.IN1(LEFT_IQ1),
											.IN2(LEFT_I3),
											.OUT(LEFT_H6A2),
											._1(1)
		);

		SPS4T5X11H1 sps_h6a3(
											.IN3(LEFT_LLH5),
											.IN0(LEFT_IQ2),
											.IN1(LEFT_IQ3),
											.IN2(LEFT_I2),
											.OUT(LEFT_H6A3),
											._1(1)
		);

		SPS4T5X11H1 sps_h6a0(
											.OUT(LEFT_H6A0),
											.IN0(LEFT_I0),
											.IN1(LEFT_I1),
											.IN2(LEFT_IQ1),
											.IN3(LEFT_LLH11),
											._1(1)
		);

		SPS4T5X11H1 sps_h6a1(
											.IN3(LEFT_LLH11),
											.IN0(LEFT_I2),
											.IN1(LEFT_I3),
											.IN2(LEFT_IQ0),
											.OUT(LEFT_H6A1),
											._1(1)
		);

		BUF1B0X2H3 buf_h6m6_h6b7(
											.A(LEFT_H6M6),
											.Y(LEFT_H6B7)
		);

		SPS12N7X0H2 sps_t1(
											.IN8(LEFT_V6D_BUF0),
											.IN9(LEFT_V6S_BUF0),
											.IN4(LEFT_V6A_BUF0),
											.IN5(LEFT_V6B_BUF0),
											.IN6(LEFT_V6M_BUF0),
											.IN7(LEFT_V6C_BUF0),
											.IN0(LEFT_E_BUF3),
											.IN1(LEFT_E_BUF2),
											.IN2(LEFT_E_BUF1),
											.IN3(LEFT_E_BUF0),
											.OUT(LEFT_T1),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H1 sps_t3(
											.IN8(LEFT_V6D_BUF0),
											.IN9(LEFT_V6S_BUF0),
											.IN4(LEFT_V6A_BUF0),
											.IN5(LEFT_V6B_BUF0),
											.IN6(LEFT_V6M_BUF0),
											.IN7(LEFT_V6C_BUF0),
											.IN0(LEFT_E_BUF3),
											.IN1(LEFT_E_BUF2),
											.IN2(LEFT_E_BUF1),
											.IN3(LEFT_E_BUF0),
											.OUT(LEFT_T3),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H2 sps_t2(
											.IN8(LEFT_V6D_BUF0),
											.IN9(LEFT_V6S_BUF0),
											.IN4(LEFT_V6A_BUF0),
											.IN5(LEFT_V6B_BUF0),
											.IN6(LEFT_V6M_BUF0),
											.IN7(LEFT_V6C_BUF0),
											.IN0(LEFT_E_BUF3),
											.IN1(LEFT_E_BUF2),
											.IN2(LEFT_E_BUF1),
											.IN3(LEFT_E_BUF0),
											.OUT(LEFT_T2),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS4N4X0H1 sps_out0(
											.OUT(LEFT_OUT0),
											.IN0(LEFT_I3),
											.IN1(LEFT_I2),
											.IN2(LEFT_I1),
											.IN3(LEFT_I0),
											._1(1)
		);

		BUF1B0X2H3 buf_h6a6_h6c7(
											.A(LEFT_H6A6),
											.Y(LEFT_H6C7)
		);

		BUF1B0X2H3 buf_v6a1(
											.A(LEFT_V6A1),
											.Y(LEFT_V6A_BUF1)
		);

		BUF1B0X2H3 buf_v6a0(
											.A(LEFT_V6A0),
											.Y(LEFT_V6A_BUF0)
		);

		BUF1B0X2H3 buf_v6a3(
											.A(LEFT_V6A3),
											.Y(LEFT_V6A_BUF3)
		);

		BUF1B0X2H3 buf_v6a2(
											.A(LEFT_V6A2),
											.Y(LEFT_V6A_BUF2)
		);

		SPS2N2X0H2 sps_e2(
											.IN0(LEFT_I1),
											.IN1(LEFT_V6N0),
											.OUT(LEFT_E2),
											._1(1)
		);

		SPS3N3X0H1 sps_e3(
											.IN0(LEFT_I0),
											.IN1(LEFT_V6S0),
											.IN2(LEFT_TBUFO3),
											.OUT(LEFT_E3),
											._1(1)
		);

		SPS3N3X0H1 sps_e0(
											.IN0(LEFT_I3),
											.IN1(LEFT_V6S0),
											.IN2(LEFT_TBUFO3),
											.OUT(LEFT_E0),
											._1(1)
		);

		SPS2N2X0H2 sps_e1(
											.IN0(LEFT_I2),
											.IN1(LEFT_V6M0),
											.OUT(LEFT_E1),
											._1(1)
		);

		BUF1B0X2H3 buf_h6b6_h6m7(
											.A(LEFT_H6B6),
											.Y(LEFT_H6M7)
		);

		SPS12T8X11H1 sps_v6s0(
											.IN8(LEFT_I0),
											.IN9(LEFT_LLV0),
											.IN4(LEFT_I2),
											.IN5(LEFT_IQ1),
											.IN6(LEFT_I1),
											.IN7(LEFT_IQ0),
											.IN0(LEFT_V6N0),
											.IN1(LEFT_IQ3),
											.IN2(LEFT_I3),
											.IN3(LEFT_IQ2),
											.IN11(LEFT_H6E0),
											.IN10(LEFT_H6M2),
											.OUT(LEFT_V6S0),
											._1(1)
		);

		SPS2N2X0H2 sps_e8(
											.IN0(LEFT_I3),
											.IN1(LEFT_V6N1),
											.OUT(LEFT_E8),
											._1(1)
		);

		SPS3N3X0H1 sps_e9(
											.IN0(LEFT_I2),
											.IN1(LEFT_V6S1),
											.IN2(LEFT_TBUFO2),
											.OUT(LEFT_E9),
											._1(1)
		);

		SPS12T8X11H1 sps_v6s1(
											.IN8(LEFT_I0),
											.IN9(LEFT_LLV0),
											.IN4(LEFT_I2),
											.IN5(LEFT_IQ1),
											.IN6(LEFT_I1),
											.IN7(LEFT_IQ0),
											.IN0(LEFT_V6N1),
											.IN1(LEFT_IQ3),
											.IN2(LEFT_I3),
											.IN3(LEFT_IQ2),
											.IN11(LEFT_H6E1),
											.IN10(LEFT_H6M3),
											.OUT(LEFT_V6S1),
											._1(1)
		);

		SPS12N7X0H2 sps_ice1(
											.IN8(LEFT_V6D_BUF3),
											.IN9(LEFT_V6S_BUF3),
											.IN4(LEFT_V6A_BUF3),
											.IN5(LEFT_V6B_BUF3),
											.IN6(LEFT_V6M_BUF3),
											.IN7(LEFT_V6C_BUF3),
											.IN0(LEFT_E_BUF23),
											.IN1(LEFT_E_BUF22),
											.IN2(LEFT_E_BUF21),
											.IN3(LEFT_E_BUF20),
											.OUT(LEFT_ICE1),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H2 sps_ts1_b(
											.IN8(LEFT_V6D_BUF1),
											.IN9(LEFT_V6S_BUF1),
											.IN4(LEFT_V6A_BUF1),
											.IN5(LEFT_V6B_BUF1),
											.IN6(LEFT_V6M_BUF1),
											.IN7(LEFT_V6C_BUF1),
											.IN0(LEFT_E_BUF0),
											.IN1(LEFT_E_BUF7),
											.IN2(LEFT_E_BUF12),
											.IN3(LEFT_E_BUF19),
											.OUT(LEFT_TS1_B),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		BUF1B0X2H3 buf_h6b8_h6m9(
											.A(LEFT_H6B8),
											.Y(LEFT_H6M9)
		);

		SPS2N2X0H2 sps_e20(
											.IN0(LEFT_IQ3),
											.IN1(LEFT_V6N3),
											.OUT(LEFT_E20),
											._1(1)
		);

		SPS6B6X2H1 sps_h6e5(
											.IN4(LEFT_V6N2),
											.IN5(LEFT_H6D4),
											.IN0(LEFT_IQ0),
											.IN1(LEFT_I0),
											.IN2(LEFT_V6S0),
											.IN3(LEFT_V6M1),
											.OUT(LEFT_H6E5),
											._1(1)
		);

		BUF1B0X2H3 buf_h6m8_h6b9(
											.A(LEFT_H6M8),
											.Y(LEFT_H6B9)
		);

		BUF1B0X2H3 buf_h6a10_h6c11(
											.A(LEFT_H6A10),
											.Y(LEFT_H6C11)
		);

		SPS12N7X0H1 sps_ti1_b(
											.IN8(LEFT_E_BUF5),
											.IN9(LEFT_E_BUF6),
											.IN4(LEFT_IQ2),
											.IN5(LEFT_I2),
											.IN6(LEFT_IQ3),
											.IN7(LEFT_I3),
											.IN0(LEFT_IQ0),
											.IN1(LEFT_I0),
											.IN2(LEFT_IQ1),
											.IN3(LEFT_I1),
											.OUT(LEFT_TI1_B),
											.IN10(LEFT_E_BUF10),
											.IN11(LEFT_E_BUF11),
											._1(1)
		);

		BUF1B0X2H3 buf_h6a4_h6c5(
											.A(LEFT_H6A4),
											.Y(LEFT_H6C5)
		);

		SPS12N7X0H2 sps_ts0_b(
											.IN8(LEFT_V6D_BUF1),
											.IN9(LEFT_V6S_BUF1),
											.IN4(LEFT_V6A_BUF1),
											.IN5(LEFT_V6B_BUF1),
											.IN6(LEFT_V6M_BUF1),
											.IN7(LEFT_V6C_BUF1),
											.IN0(LEFT_E_BUF0),
											.IN1(LEFT_E_BUF7),
											.IN2(LEFT_E_BUF12),
											.IN3(LEFT_E_BUF19),
											.OUT(LEFT_TS0_B),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS16N8X0H1 sps_clk3(
											.IN8(LEFT_V6D_BUF2),
											.IN9(LEFT_V6S_BUF2),
											.IN4(LEFT_V6A_BUF2),
											.IN5(LEFT_V6B_BUF2),
											.IN6(LEFT_V6M_BUF2),
											.IN7(LEFT_V6C_BUF2),
											.IN0(LEFT_E_BUF15),
											.IN1(LEFT_E_BUF14),
											.IN2(LEFT_E_BUF9),
											.IN3(LEFT_E_BUF8),
											.OUT(LEFT_CLK3),
											.IN14(VDD),
											.IN15(VDD),
											.IN12(LEFT_GCLK2),
											.IN13(LEFT_GCLK3),
											.IN10(LEFT_GCLK0),
											.IN11(LEFT_GCLK1),
											._1(1)
		);

		SPS16N8X0H1 sps_clk2(
											.IN8(LEFT_V6D_BUF2),
											.IN9(LEFT_V6S_BUF2),
											.IN4(LEFT_V6A_BUF2),
											.IN5(LEFT_V6B_BUF2),
											.IN6(LEFT_V6M_BUF2),
											.IN7(LEFT_V6C_BUF2),
											.IN0(LEFT_E_BUF15),
											.IN1(LEFT_E_BUF14),
											.IN2(LEFT_E_BUF9),
											.IN3(LEFT_E_BUF8),
											.OUT(LEFT_CLK2),
											.IN14(VDD),
											.IN15(VDD),
											.IN12(LEFT_GCLK2),
											.IN13(LEFT_GCLK3),
											.IN10(LEFT_GCLK0),
											.IN11(LEFT_GCLK1),
											._1(1)
		);

		SPS16N8X0H1 sps_clk1(
											.IN8(LEFT_V6D_BUF2),
											.IN9(LEFT_V6S_BUF2),
											.IN4(LEFT_V6A_BUF2),
											.IN5(LEFT_V6B_BUF2),
											.IN6(LEFT_V6M_BUF2),
											.IN7(LEFT_V6C_BUF2),
											.IN0(LEFT_E_BUF15),
											.IN1(LEFT_E_BUF14),
											.IN2(LEFT_E_BUF9),
											.IN3(LEFT_E_BUF8),
											.OUT(LEFT_CLK1),
											.IN14(VDD),
											.IN15(VDD),
											.IN12(LEFT_GCLK2),
											.IN13(LEFT_GCLK3),
											.IN10(LEFT_GCLK0),
											.IN11(LEFT_GCLK1),
											._1(1)
		);

		SPS12T8X11H1 sps_v6n1(
											.IN8(LEFT_I0),
											.IN9(LEFT_LLV0),
											.IN4(LEFT_I2),
											.IN5(LEFT_IQ1),
											.IN6(LEFT_I1),
											.IN7(LEFT_IQ0),
											.IN0(LEFT_V6S1),
											.IN1(LEFT_IQ3),
											.IN2(LEFT_I3),
											.IN3(LEFT_IQ2),
											.IN11(LEFT_H6E0),
											.IN10(LEFT_H6M3),
											.OUT(LEFT_V6N1),
											._1(1)
		);

		SPS12T8X11H1 sps_v6n0(
											.IN8(LEFT_I0),
											.IN9(LEFT_LLV0),
											.IN4(LEFT_I2),
											.IN5(LEFT_IQ1),
											.IN6(LEFT_I1),
											.IN7(LEFT_IQ0),
											.IN0(LEFT_V6S0),
											.IN1(LEFT_IQ3),
											.IN2(LEFT_I3),
											.IN3(LEFT_IQ2),
											.IN11(LEFT_H6E3),
											.IN10(LEFT_H6M2),
											.OUT(LEFT_V6N0),
											._1(1)
		);

		SPS12T8X11H1 sps_v6n3(
											.IN8(LEFT_I0),
											.IN9(LEFT_LLV6),
											.IN4(LEFT_I2),
											.IN5(LEFT_IQ1),
											.IN6(LEFT_I1),
											.IN7(LEFT_IQ0),
											.IN0(LEFT_V6S3),
											.IN1(LEFT_IQ3),
											.IN2(LEFT_I3),
											.IN3(LEFT_IQ2),
											.OUT(LEFT_V6N3),
											.IN10(LEFT_H6M1),
											.IN11(LEFT_H6E2),
											._1(1)
		);

		SPS12T8X11H1 sps_v6n2(
											.IN8(LEFT_I0),
											.IN9(LEFT_LLV6),
											.IN4(LEFT_I2),
											.IN5(LEFT_IQ1),
											.IN6(LEFT_I1),
											.IN7(LEFT_IQ0),
											.IN0(LEFT_V6S2),
											.IN1(LEFT_IQ3),
											.IN2(LEFT_I3),
											.IN3(LEFT_IQ2),
											.OUT(LEFT_V6N2),
											.IN10(LEFT_H6M0),
											.IN11(LEFT_H6E1),
											._1(1)
		);

		BUF1B0X2H3 buf_h6e10_h6d11(
											.A(LEFT_H6E10),
											.Y(LEFT_H6D11)
		);

		BUF1B0X2H3 buf_h6a8_h6c9(
											.A(LEFT_H6A8),
											.Y(LEFT_H6C9)
		);

		SPS4T5X11H1 sps_h6b3(
											.IN3(LEFT_LLH4),
											.IN0(LEFT_IQ0),
											.IN1(LEFT_IQ1),
											.IN2(LEFT_I3),
											.OUT(LEFT_H6B3),
											._1(1)
		);

		SPS22N7X0H1 sps_o1(
											.IN8(LEFT_E_BUF3),
											.IN9(LEFT_E_BUF2),
											.IN4(LEFT_E_BUF7),
											.IN5(LEFT_E_BUF6),
											.IN6(LEFT_E_BUF5),
											.IN7(LEFT_E_BUF4),
											.IN0(LEFT_E_BUF11),
											.IN1(LEFT_E_BUF10),
											.IN2(LEFT_E_BUF9),
											.IN3(LEFT_E_BUF8),
											.IN18(LEFT_TBUFO2),
											.IN19(LEFT_TBUFO3),
											.IN16(LEFT_TBUFO0),
											.IN17(LEFT_TBUFO1),
											.IN14(LEFT_H6B_BUF1),
											.IN15(LEFT_H6M_BUF1),
											.IN12(LEFT_H6E_BUF1),
											.IN13(LEFT_H6A_BUF1),
											.IN10(LEFT_E_BUF1),
											.IN11(LEFT_E_BUF0),
											.OUT(LEFT_O1),
											.IN21(LEFT_OUT_E7),
											.IN20(LEFT_OUT_E6),
											._1(1)
		);

		SPS22N7X0H1 sps_o2(
											.IN8(LEFT_E_BUF15),
											.IN9(LEFT_E_BUF14),
											.IN4(LEFT_E_BUF19),
											.IN5(LEFT_E_BUF18),
											.IN6(LEFT_E_BUF17),
											.IN7(LEFT_E_BUF16),
											.IN0(LEFT_E_BUF23),
											.IN1(LEFT_E_BUF22),
											.IN2(LEFT_E_BUF21),
											.IN3(LEFT_E_BUF20),
											.IN18(LEFT_TBUFO2),
											.IN19(LEFT_TBUFO3),
											.IN16(LEFT_TBUFO0),
											.IN17(LEFT_TBUFO1),
											.IN14(LEFT_H6B_BUF2),
											.IN15(LEFT_H6M_BUF2),
											.IN12(LEFT_H6E_BUF2),
											.IN13(LEFT_H6A_BUF2),
											.IN10(LEFT_E_BUF13),
											.IN11(LEFT_E_BUF12),
											.OUT(LEFT_O2),
											.IN21(LEFT_OUT_E7),
											.IN20(LEFT_OUT_E6),
											._1(1)
		);

		SPS22N7X0H1 sps_o3(
											.IN8(LEFT_E_BUF15),
											.IN9(LEFT_E_BUF14),
											.IN4(LEFT_E_BUF19),
											.IN5(LEFT_E_BUF18),
											.IN6(LEFT_E_BUF17),
											.IN7(LEFT_E_BUF16),
											.IN0(LEFT_E_BUF23),
											.IN1(LEFT_E_BUF22),
											.IN2(LEFT_E_BUF21),
											.IN3(LEFT_E_BUF20),
											.IN18(LEFT_TBUFO2),
											.IN19(LEFT_TBUFO3),
											.IN16(LEFT_TBUFO0),
											.IN17(LEFT_TBUFO1),
											.IN14(LEFT_H6B_BUF3),
											.IN15(LEFT_H6M_BUF3),
											.IN12(LEFT_H6E_BUF3),
											.IN13(LEFT_H6A_BUF3),
											.IN10(LEFT_E_BUF13),
											.IN11(LEFT_E_BUF12),
											.OUT(LEFT_O3),
											.IN21(LEFT_OUT_E7),
											.IN20(LEFT_OUT_E6),
											._1(1)
		);

		SPS16T10X11H2 sps_llv0(
											.IN8(LEFT_E_BUF23),
											.IN9(LEFT_E_BUF22),
											.IN4(LEFT_IQ2),
											.IN5(LEFT_I2),
											.IN6(LEFT_IQ3),
											.IN7(LEFT_I3),
											.IN0(LEFT_IQ0),
											.IN1(LEFT_I0),
											.IN2(LEFT_IQ1),
											.IN3(LEFT_I1),
											.OUT(LEFT_LLV0),
											.IN14(LEFT_E_BUF6),
											.IN15(LEFT_E_BUF5),
											.IN12(LEFT_E_BUF11),
											.IN13(LEFT_E_BUF10),
											.IN10(LEFT_E_BUF18),
											.IN11(LEFT_E_BUF17),
											._1(1)
		);

		SPS2T2X11H3 sps_llh11(
											.IN0(LEFT_IQ1),
											.IN1(LEFT_I3),
											.OUT(LEFT_LLH11),
											._1(1)
		);

		SPS2T2X11H3 sps_llh10(
											.IN0(LEFT_I0),
											.IN1(LEFT_IQ3),
											.OUT(LEFT_LLH10),
											._1(1)
		);

		BUF1B0X2H3 buf_h6b10_h6m11(
											.A(LEFT_H6B10),
											.Y(LEFT_H6M11)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_RHT(
RIGHT_W23, RIGHT_W22, RIGHT_W21, RIGHT_W20, RIGHT_W19, RIGHT_W18, RIGHT_W17, RIGHT_W16, RIGHT_W15, RIGHT_W14, RIGHT_W13, RIGHT_W12, RIGHT_W11, RIGHT_W10, RIGHT_W9, RIGHT_W8, RIGHT_W7, RIGHT_W6, RIGHT_W5, RIGHT_W4, RIGHT_W3, RIGHT_W2, RIGHT_W1, RIGHT_W0, RIGHT_H6A0, RIGHT_H6A1, RIGHT_H6A2, RIGHT_H6A3, RIGHT_H6A4, RIGHT_H6A5, RIGHT_H6A6, RIGHT_H6A7, RIGHT_H6A8, RIGHT_H6A9, RIGHT_H6A10, RIGHT_H6A11, RIGHT_H6B0, RIGHT_H6B1, RIGHT_H6B2, RIGHT_H6B3, RIGHT_H6B4, RIGHT_H6B5, RIGHT_H6B6, RIGHT_H6B7, RIGHT_H6B8, RIGHT_H6B9, RIGHT_H6B10, RIGHT_H6B11, RIGHT_H6M0, RIGHT_H6M1, RIGHT_H6M2, RIGHT_H6M3, RIGHT_H6M4, RIGHT_H6M5, RIGHT_H6M6, RIGHT_H6M7, RIGHT_H6M8, RIGHT_H6M9, RIGHT_H6M10, RIGHT_H6M11, RIGHT_H6C0, RIGHT_H6C1, RIGHT_H6C2, RIGHT_H6C3, RIGHT_H6C4, RIGHT_H6C5, RIGHT_H6C6, RIGHT_H6C7, RIGHT_H6C8, RIGHT_H6C9, RIGHT_H6C10, RIGHT_H6C11, RIGHT_H6D0, RIGHT_H6D1, RIGHT_H6D2, RIGHT_H6D3, RIGHT_H6D4, RIGHT_H6D5, RIGHT_H6D6, RIGHT_H6D7, RIGHT_H6D8, RIGHT_H6D9, RIGHT_H6D10, RIGHT_H6D11, RIGHT_H6W0, RIGHT_H6W1, RIGHT_H6W2, RIGHT_H6W3, RIGHT_H6W4, RIGHT_H6W5, RIGHT_H6W6, RIGHT_H6W7, RIGHT_H6W8, RIGHT_H6W9, RIGHT_H6W10, RIGHT_H6W11, RIGHT_LLH0, RIGHT_LLH1, RIGHT_LLH2, RIGHT_LLH3, RIGHT_LLH4, RIGHT_LLH5, RIGHT_LLH6, RIGHT_LLH7, RIGHT_LLH8, RIGHT_LLH9, RIGHT_LLH10, RIGHT_LLH11, RIGHT_GCLK0, RIGHT_GCLK1, RIGHT_GCLK2, RIGHT_GCLK3, RIGHT_OUT_W0, RIGHT_OUT_W1, RIGHT_OUT6, RIGHT_OUT7, RIGHT_TBUFO2, RIGHT_TBUFO3, RIGHT_TBUFO0, RIGHT_TBUFO1, RIGHT_V6N0, RIGHT_V6N1, RIGHT_V6N2, RIGHT_V6N3, RIGHT_V6A0, RIGHT_V6A1, RIGHT_V6A2, RIGHT_V6A3, RIGHT_V6B0, RIGHT_V6B1, RIGHT_V6B2, RIGHT_V6B3, RIGHT_V6M0, RIGHT_V6M1, RIGHT_V6M2, RIGHT_V6M3, RIGHT_V6C0, RIGHT_V6C1, RIGHT_V6C2, RIGHT_V6C3, RIGHT_V6D0, RIGHT_V6D1, RIGHT_V6D2, RIGHT_V6D3, RIGHT_V6S0, RIGHT_V6S1, RIGHT_V6S2, RIGHT_V6S3, RIGHT_LLV0, RIGHT_LLV6, RIGHT_PCI_CE, RIGHT_I1, RIGHT_I2, RIGHT_I3, RIGHT_IQ1, RIGHT_IQ2, RIGHT_IQ3, RIGHT_ICE1, RIGHT_ICE2, RIGHT_ICE3, RIGHT_O1, RIGHT_O2, RIGHT_O3, RIGHT_OCE1, RIGHT_OCE2, RIGHT_OCE3, RIGHT_T1, RIGHT_T2, RIGHT_T3, RIGHT_TCE1, RIGHT_TCE2, RIGHT_TCE3, RIGHT_CLK1, RIGHT_CLK2, RIGHT_CLK3, RIGHT_SR_B1, RIGHT_SR_B2, RIGHT_SR_B3, RIGHT_TO0, RIGHT_TO1, RIGHT_TI0_B, RIGHT_TI1_B, RIGHT_TS0_B, RIGHT_TS1_B, _1
);
inout	RIGHT_W23;
inout	RIGHT_W22;
inout	RIGHT_W21;
inout	RIGHT_W20;
inout	RIGHT_W19;
inout	RIGHT_W18;
inout	RIGHT_W17;
inout	RIGHT_W16;
inout	RIGHT_W15;
inout	RIGHT_W14;
inout	RIGHT_W13;
inout	RIGHT_W12;
inout	RIGHT_W11;
inout	RIGHT_W10;
inout	RIGHT_W9;
inout	RIGHT_W8;
inout	RIGHT_W7;
inout	RIGHT_W6;
inout	RIGHT_W5;
inout	RIGHT_W4;
inout	RIGHT_W3;
inout	RIGHT_W2;
inout	RIGHT_W1;
inout	RIGHT_W0;
inout	RIGHT_H6A0;
inout	RIGHT_H6A1;
inout	RIGHT_H6A2;
inout	RIGHT_H6A3;
inout	RIGHT_H6A4;
inout	RIGHT_H6A5;
inout	RIGHT_H6A6;
inout	RIGHT_H6A7;
inout	RIGHT_H6A8;
inout	RIGHT_H6A9;
inout	RIGHT_H6A10;
inout	RIGHT_H6A11;
inout	RIGHT_H6B0;
inout	RIGHT_H6B1;
inout	RIGHT_H6B2;
inout	RIGHT_H6B3;
inout	RIGHT_H6B4;
inout	RIGHT_H6B5;
inout	RIGHT_H6B6;
inout	RIGHT_H6B7;
inout	RIGHT_H6B8;
inout	RIGHT_H6B9;
inout	RIGHT_H6B10;
inout	RIGHT_H6B11;
inout	RIGHT_H6M0;
inout	RIGHT_H6M1;
inout	RIGHT_H6M2;
inout	RIGHT_H6M3;
inout	RIGHT_H6M4;
inout	RIGHT_H6M5;
inout	RIGHT_H6M6;
inout	RIGHT_H6M7;
inout	RIGHT_H6M8;
inout	RIGHT_H6M9;
inout	RIGHT_H6M10;
inout	RIGHT_H6M11;
inout	RIGHT_H6C0;
inout	RIGHT_H6C1;
inout	RIGHT_H6C2;
inout	RIGHT_H6C3;
inout	RIGHT_H6C4;
inout	RIGHT_H6C5;
inout	RIGHT_H6C6;
inout	RIGHT_H6C7;
inout	RIGHT_H6C8;
inout	RIGHT_H6C9;
inout	RIGHT_H6C10;
inout	RIGHT_H6C11;
inout	RIGHT_H6D0;
inout	RIGHT_H6D1;
inout	RIGHT_H6D2;
inout	RIGHT_H6D3;
inout	RIGHT_H6D4;
inout	RIGHT_H6D5;
inout	RIGHT_H6D6;
inout	RIGHT_H6D7;
inout	RIGHT_H6D8;
inout	RIGHT_H6D9;
inout	RIGHT_H6D10;
inout	RIGHT_H6D11;
inout	RIGHT_H6W0;
inout	RIGHT_H6W1;
inout	RIGHT_H6W2;
inout	RIGHT_H6W3;
inout	RIGHT_H6W4;
inout	RIGHT_H6W5;
inout	RIGHT_H6W6;
inout	RIGHT_H6W7;
inout	RIGHT_H6W8;
inout	RIGHT_H6W9;
inout	RIGHT_H6W10;
inout	RIGHT_H6W11;
inout	RIGHT_LLH0;
inout	RIGHT_LLH1;
inout	RIGHT_LLH2;
inout	RIGHT_LLH3;
inout	RIGHT_LLH4;
inout	RIGHT_LLH5;
inout	RIGHT_LLH6;
inout	RIGHT_LLH7;
inout	RIGHT_LLH8;
inout	RIGHT_LLH9;
inout	RIGHT_LLH10;
inout	RIGHT_LLH11;
inout	RIGHT_GCLK0;
inout	RIGHT_GCLK1;
inout	RIGHT_GCLK2;
inout	RIGHT_GCLK3;
inout	RIGHT_OUT_W0;
inout	RIGHT_OUT_W1;
inout	RIGHT_OUT6;
inout	RIGHT_OUT7;
inout	RIGHT_TBUFO2;
inout	RIGHT_TBUFO3;
inout	RIGHT_TBUFO0;
inout	RIGHT_TBUFO1;
inout	RIGHT_V6N0;
inout	RIGHT_V6N1;
inout	RIGHT_V6N2;
inout	RIGHT_V6N3;
inout	RIGHT_V6A0;
inout	RIGHT_V6A1;
inout	RIGHT_V6A2;
inout	RIGHT_V6A3;
inout	RIGHT_V6B0;
inout	RIGHT_V6B1;
inout	RIGHT_V6B2;
inout	RIGHT_V6B3;
inout	RIGHT_V6M0;
inout	RIGHT_V6M1;
inout	RIGHT_V6M2;
inout	RIGHT_V6M3;
inout	RIGHT_V6C0;
inout	RIGHT_V6C1;
inout	RIGHT_V6C2;
inout	RIGHT_V6C3;
inout	RIGHT_V6D0;
inout	RIGHT_V6D1;
inout	RIGHT_V6D2;
inout	RIGHT_V6D3;
inout	RIGHT_V6S0;
inout	RIGHT_V6S1;
inout	RIGHT_V6S2;
inout	RIGHT_V6S3;
inout	RIGHT_LLV0;
inout	RIGHT_LLV6;
inout	RIGHT_PCI_CE;
inout	RIGHT_I1;
inout	RIGHT_I2;
inout	RIGHT_I3;
inout	RIGHT_IQ1;
inout	RIGHT_IQ2;
inout	RIGHT_IQ3;
inout	RIGHT_ICE1;
inout	RIGHT_ICE2;
inout	RIGHT_ICE3;
inout	RIGHT_O1;
inout	RIGHT_O2;
inout	RIGHT_O3;
inout	RIGHT_OCE1;
inout	RIGHT_OCE2;
inout	RIGHT_OCE3;
inout	RIGHT_T1;
inout	RIGHT_T2;
inout	RIGHT_T3;
inout	RIGHT_TCE1;
inout	RIGHT_TCE2;
inout	RIGHT_TCE3;
inout	RIGHT_CLK1;
inout	RIGHT_CLK2;
inout	RIGHT_CLK3;
inout	RIGHT_SR_B1;
inout	RIGHT_SR_B2;
inout	RIGHT_SR_B3;
inout	RIGHT_TO0;
inout	RIGHT_TO1;
inout	RIGHT_TI0_B;
inout	RIGHT_TI1_B;
inout	RIGHT_TS0_B;
inout	RIGHT_TS1_B;
inout	_1;
		wire		RIGHT_W_BUF23 ;
		wire		RIGHT_W_BUF22 ;
		wire		RIGHT_W_BUF21 ;
		wire		RIGHT_W_BUF20 ;
		wire		RIGHT_W_BUF19 ;
		wire		RIGHT_W_BUF18 ;
		wire		RIGHT_W_BUF17 ;
		wire		RIGHT_W_BUF16 ;
		wire		RIGHT_W_BUF15 ;
		wire		RIGHT_W_BUF14 ;
		wire		RIGHT_W_BUF13 ;
		wire		RIGHT_W_BUF12 ;
		wire		RIGHT_W_BUF11 ;
		wire		RIGHT_W_BUF10 ;
		wire		RIGHT_W_BUF9 ;
		wire		RIGHT_W_BUF8 ;
		wire		RIGHT_W_BUF7 ;
		wire		RIGHT_W_BUF6 ;
		wire		RIGHT_W_BUF5 ;
		wire		RIGHT_W_BUF4 ;
		wire		RIGHT_W_BUF3 ;
		wire		RIGHT_W_BUF2 ;
		wire		RIGHT_W_BUF1 ;
		wire		RIGHT_W_BUF0 ;
		wire		RIGHT_H6M_BUF1 ;
		wire		RIGHT_H6M_BUF2 ;
		wire		RIGHT_H6M_BUF3 ;
		wire		RIGHT_H6C_BUF1 ;
		wire		RIGHT_H6C_BUF2 ;
		wire		RIGHT_H6C_BUF3 ;
		wire		RIGHT_H6D_BUF1 ;
		wire		RIGHT_H6D_BUF2 ;
		wire		RIGHT_H6D_BUF3 ;
		wire		RIGHT_H6W_BUF1 ;
		wire		RIGHT_H6W_BUF2 ;
		wire		RIGHT_H6W_BUF3 ;
		wire		RIGHT_V6A_BUF0 ;
		wire		RIGHT_V6A_BUF1 ;
		wire		RIGHT_V6A_BUF2 ;
		wire		RIGHT_V6A_BUF3 ;
		wire		RIGHT_V6B_BUF0 ;
		wire		RIGHT_V6B_BUF1 ;
		wire		RIGHT_V6B_BUF2 ;
		wire		RIGHT_V6B_BUF3 ;
		wire		RIGHT_V6M_BUF0 ;
		wire		RIGHT_V6M_BUF1 ;
		wire		RIGHT_V6M_BUF2 ;
		wire		RIGHT_V6M_BUF3 ;
		wire		RIGHT_V6C_BUF0 ;
		wire		RIGHT_V6C_BUF1 ;
		wire		RIGHT_V6C_BUF2 ;
		wire		RIGHT_V6C_BUF3 ;
		wire		RIGHT_V6D_BUF0 ;
		wire		RIGHT_V6D_BUF1 ;
		wire		RIGHT_V6D_BUF2 ;
		wire		RIGHT_V6D_BUF3 ;
		wire		RIGHT_V6S_BUF0 ;
		wire		RIGHT_V6S_BUF1 ;
		wire		RIGHT_V6S_BUF2 ;
		wire		RIGHT_V6S_BUF3 ;
		wire		RIGHT_IQ0 ;
		wire		RIGHT_I0 ;
		wire		VDD ;

		BUF1B0X2H3 buf_h6w7_h6a6(
											.A(RIGHT_H6W7),
											.Y(RIGHT_H6A6)
		);

		BUF1B0X2H5 buf_w11(
											.A(RIGHT_W11),
											.Y(RIGHT_W_BUF11)
		);

		BUF1B0X2H5 buf_w10(
											.A(RIGHT_W10),
											.Y(RIGHT_W_BUF10)
		);

		BUF1B0X2H5 buf_w13(
											.A(RIGHT_W13),
											.Y(RIGHT_W_BUF13)
		);

		BUF1B0X2H5 buf_w12(
											.A(RIGHT_W12),
											.Y(RIGHT_W_BUF12)
		);

		BUF1B0X2H5 buf_w15(
											.A(RIGHT_W15),
											.Y(RIGHT_W_BUF15)
		);

		BUF1B0X2H5 buf_w14(
											.A(RIGHT_W14),
											.Y(RIGHT_W_BUF14)
		);

		BUF1B0X2H5 buf_w17(
											.A(RIGHT_W17),
											.Y(RIGHT_W_BUF17)
		);

		BUF1B0X2H5 buf_w16(
											.A(RIGHT_W16),
											.Y(RIGHT_W_BUF16)
		);

		BUF1B0X2H3 buf_v6d2(
											.A(RIGHT_V6D2),
											.Y(RIGHT_V6D_BUF2)
		);

		BUF1B0X2H3 buf_v6d3(
											.A(RIGHT_V6D3),
											.Y(RIGHT_V6D_BUF3)
		);

		BUF1B0X2H3 buf_v6d0(
											.A(RIGHT_V6D0),
											.Y(RIGHT_V6D_BUF0)
		);

		BUF1B0X2H3 buf_v6d1(
											.A(RIGHT_V6D1),
											.Y(RIGHT_V6D_BUF1)
		);

		BUF1B0X2H3 buf_h6w11_h6a10(
											.A(RIGHT_H6W11),
											.Y(RIGHT_H6A10)
		);

		SPBU1AND1X10H1 spbu_tbufo0(
											.IN(RIGHT_TO0),
											.OUT(RIGHT_TBUFO0)
		);

		SPBU1AND1X10H1 spbu_tbufo1(
											.IN(RIGHT_TO1),
											.OUT(RIGHT_TBUFO1)
		);

		SPBU1AND1X10H1 spbu_tbufo2(
											.IN(RIGHT_TO0),
											.OUT(RIGHT_TBUFO2)
		);

		SPBU1AND1X10H1 spbu_tbufo3(
											.IN(RIGHT_TO1),
											.OUT(RIGHT_TBUFO3)
		);

		BUF1B0X2H3 buf_v6m1(
											.A(RIGHT_V6M1),
											.Y(RIGHT_V6M_BUF1)
		);

		BUF1B0X2H3 buf_v6m0(
											.A(RIGHT_V6M0),
											.Y(RIGHT_V6M_BUF0)
		);

		BUF1B0X2H3 buf_v6m3(
											.A(RIGHT_V6M3),
											.Y(RIGHT_V6M_BUF3)
		);

		BUF1B0X2H3 buf_h6m5_h6c4(
											.A(RIGHT_H6M5),
											.Y(RIGHT_H6C4)
		);

		BUF1B0X2H3 buf_h6c9_h6m8(
											.A(RIGHT_H6C9),
											.Y(RIGHT_H6M8)
		);

		SPS12N7X0H2 sps_sr_b2(
											.IN8(RIGHT_V6D_BUF1),
											.IN9(RIGHT_V6S_BUF1),
											.IN4(RIGHT_V6A_BUF1),
											.IN5(RIGHT_V6B_BUF1),
											.IN6(RIGHT_V6M_BUF1),
											.IN7(RIGHT_V6C_BUF1),
											.IN0(RIGHT_W_BUF7),
											.IN1(RIGHT_W_BUF6),
											.IN2(RIGHT_W_BUF5),
											.IN3(RIGHT_W_BUF4),
											.OUT(RIGHT_SR_B2),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS2N2X0H2 sps_w8(
											.IN0(RIGHT_I3),
											.IN1(RIGHT_V6N1),
											.OUT(RIGHT_W8),
											._1(1)
		);

		BUF1B0X2H3 buf_h6m7_h6c6(
											.A(RIGHT_H6M7),
											.Y(RIGHT_H6C6)
		);

		SPS12N7X0H2 sps_ice1(
											.IN8(RIGHT_V6D_BUF3),
											.IN9(RIGHT_V6S_BUF3),
											.IN4(RIGHT_V6A_BUF3),
											.IN5(RIGHT_V6B_BUF3),
											.IN6(RIGHT_V6M_BUF3),
											.IN7(RIGHT_V6C_BUF3),
											.IN0(RIGHT_W_BUF23),
											.IN1(RIGHT_W_BUF22),
											.IN2(RIGHT_W_BUF21),
											.IN3(RIGHT_W_BUF20),
											.OUT(RIGHT_ICE1),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H2 sps_ice2(
											.IN8(RIGHT_V6D_BUF3),
											.IN9(RIGHT_V6S_BUF3),
											.IN4(RIGHT_V6A_BUF3),
											.IN5(RIGHT_V6B_BUF3),
											.IN6(RIGHT_V6M_BUF3),
											.IN7(RIGHT_V6C_BUF3),
											.IN0(RIGHT_W_BUF23),
											.IN1(RIGHT_W_BUF22),
											.IN2(RIGHT_W_BUF21),
											.IN3(RIGHT_W_BUF20),
											.OUT(RIGHT_ICE2),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H1 sps_ice3(
											.IN8(RIGHT_V6D_BUF3),
											.IN9(RIGHT_V6S_BUF3),
											.IN4(RIGHT_V6A_BUF3),
											.IN5(RIGHT_V6B_BUF3),
											.IN6(RIGHT_V6M_BUF3),
											.IN7(RIGHT_V6C_BUF3),
											.IN0(RIGHT_W_BUF23),
											.IN1(RIGHT_W_BUF22),
											.IN2(RIGHT_W_BUF21),
											.IN3(RIGHT_W_BUF20),
											.OUT(RIGHT_ICE3),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS3N3X0H1 sps_w18(
											.IN0(RIGHT_I1),
											.IN1(RIGHT_V6S3),
											.IN2(RIGHT_TBUFO0),
											.OUT(RIGHT_W18),
											._1(1)
		);

		SPS4T5X11H1 sps_h6m2(
											.IN3(RIGHT_LLH9),
											.IN0(RIGHT_I1),
											.IN1(RIGHT_I2),
											.IN2(RIGHT_I3),
											.OUT(RIGHT_H6M2),
											._1(1)
		);

		SPS2N2X0H2 sps_w19(
											.IN0(RIGHT_I0),
											.IN1(RIGHT_V6M3),
											.OUT(RIGHT_W19),
											._1(1)
		);

		SPS6B6X2H1 sps_h6d8(
											.IN4(RIGHT_V6N0),
											.IN5(RIGHT_H6B9),
											.IN0(RIGHT_IQ2),
											.IN1(RIGHT_I2),
											.IN2(RIGHT_V6S2),
											.IN3(RIGHT_V6M3),
											.OUT(RIGHT_H6D8),
											._1(1)
		);

		SPS4T5X11H1 sps_h6m3(
											.IN3(RIGHT_LLH9),
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_IQ1),
											.IN2(RIGHT_I3),
											.OUT(RIGHT_H6M3),
											._1(1)
		);

		SPS6B6X2H1 sps_h6d4(
											.IN4(RIGHT_V6N2),
											.IN5(RIGHT_H6B5),
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_I0),
											.IN2(RIGHT_V6S0),
											.IN3(RIGHT_V6M1),
											.OUT(RIGHT_H6D4),
											._1(1)
		);

		SPS6B6X2H1 sps_h6d6(
											.IN4(RIGHT_V6S3),
											.IN5(RIGHT_H6B7),
											.IN0(RIGHT_IQ1),
											.IN1(RIGHT_I1),
											.IN2(RIGHT_V6N1),
											.IN3(RIGHT_V6M0),
											.OUT(RIGHT_H6D6),
											._1(1)
		);

		SPS4T5X11H1 sps_h6d1(
											.IN3(RIGHT_LLH1),
											.IN0(RIGHT_I2),
											.IN1(RIGHT_I3),
											.IN2(RIGHT_IQ0),
											.OUT(RIGHT_H6D1),
											._1(1)
		);

		SPS4T5X11H1 sps_h6d0(
											.OUT(RIGHT_H6D0),
											.IN0(RIGHT_I0),
											.IN1(RIGHT_I1),
											.IN2(RIGHT_IQ1),
											.IN3(RIGHT_LLH1),
											._1(1)
		);

		SPS4T5X11H1 sps_h6d3(
											.IN3(RIGHT_LLH7),
											.IN0(RIGHT_IQ2),
											.IN1(RIGHT_IQ3),
											.IN2(RIGHT_I2),
											.OUT(RIGHT_H6D3),
											._1(1)
		);

		SPS4T5X11H1 sps_h6d2(
											.IN3(RIGHT_LLH7),
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_IQ1),
											.IN2(RIGHT_I3),
											.OUT(RIGHT_H6D2),
											._1(1)
		);

		SPS4T5X11H1 sps_h6m1(
											.IN3(RIGHT_LLH3),
											.IN0(RIGHT_I0),
											.IN1(RIGHT_I1),
											.IN2(RIGHT_IQ3),
											.OUT(RIGHT_H6M1),
											._1(1)
		);

		SPS6B6X2H1 sps_h6d10(
											.IN4(RIGHT_V6N3),
											.IN5(RIGHT_H6B11),
											.IN0(RIGHT_IQ3),
											.IN1(RIGHT_I3),
											.IN2(RIGHT_V6S1),
											.IN3(RIGHT_V6M2),
											.OUT(RIGHT_H6D10),
											._1(1)
		);

		SPS12N7X0H2 sps_sr_b1(
											.IN8(RIGHT_V6D_BUF1),
											.IN9(RIGHT_V6S_BUF1),
											.IN4(RIGHT_V6A_BUF1),
											.IN5(RIGHT_V6B_BUF1),
											.IN6(RIGHT_V6M_BUF1),
											.IN7(RIGHT_V6C_BUF1),
											.IN0(RIGHT_W_BUF7),
											.IN1(RIGHT_W_BUF6),
											.IN2(RIGHT_W_BUF5),
											.IN3(RIGHT_W_BUF4),
											.OUT(RIGHT_SR_B1),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS4N4X0H1 sps_out7(
											.OUT(RIGHT_OUT7),
											.IN0(RIGHT_I3),
											.IN1(RIGHT_I2),
											.IN2(RIGHT_I1),
											.IN3(RIGHT_I0),
											._1(1)
		);

		SPS12N7X0H1 sps_sr_b3(
											.IN8(RIGHT_V6D_BUF1),
											.IN9(RIGHT_V6S_BUF1),
											.IN4(RIGHT_V6A_BUF1),
											.IN5(RIGHT_V6B_BUF1),
											.IN6(RIGHT_V6M_BUF1),
											.IN7(RIGHT_V6C_BUF1),
											.IN0(RIGHT_W_BUF7),
											.IN1(RIGHT_W_BUF6),
											.IN2(RIGHT_W_BUF5),
											.IN3(RIGHT_W_BUF4),
											.OUT(RIGHT_SR_B3),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		BUF1B0X2H3 buf_h6w9_h6a8(
											.A(RIGHT_H6W9),
											.Y(RIGHT_H6A8)
		);

		SPS12T8X11H1 sps_v6s2(
											.IN8(RIGHT_I0),
											.IN9(RIGHT_LLV6),
											.IN4(RIGHT_I2),
											.IN5(RIGHT_IQ1),
											.IN6(RIGHT_I1),
											.IN7(RIGHT_IQ0),
											.IN0(RIGHT_V6N2),
											.IN1(RIGHT_IQ3),
											.IN2(RIGHT_I3),
											.IN3(RIGHT_IQ2),
											.IN11(RIGHT_H6W2),
											.IN10(RIGHT_H6M0),
											.OUT(RIGHT_V6S2),
											._1(1)
		);

		BUF1B0X2H5 buf_w19(
											.A(RIGHT_W19),
											.Y(RIGHT_W_BUF19)
		);

		SPS12T8X11H1 sps_v6s0(
											.IN8(RIGHT_I0),
											.IN9(RIGHT_LLV0),
											.IN4(RIGHT_I2),
											.IN5(RIGHT_IQ1),
											.IN6(RIGHT_I1),
											.IN7(RIGHT_IQ0),
											.IN0(RIGHT_V6N0),
											.IN1(RIGHT_IQ3),
											.IN2(RIGHT_I3),
											.IN3(RIGHT_IQ2),
											.IN11(RIGHT_H6W0),
											.IN10(RIGHT_H6M2),
											.OUT(RIGHT_V6S0),
											._1(1)
		);

		SPS12T8X11H1 sps_v6s1(
											.IN8(RIGHT_I0),
											.IN9(RIGHT_LLV0),
											.IN4(RIGHT_I2),
											.IN5(RIGHT_IQ1),
											.IN6(RIGHT_I1),
											.IN7(RIGHT_IQ0),
											.IN0(RIGHT_V6N1),
											.IN1(RIGHT_IQ3),
											.IN2(RIGHT_I3),
											.IN3(RIGHT_IQ2),
											.IN11(RIGHT_H6W1),
											.IN10(RIGHT_H6M3),
											.OUT(RIGHT_V6S1),
											._1(1)
		);

		SPS12N7X0H2 sps_tce3(
											.IN8(RIGHT_V6D_BUF3),
											.IN9(RIGHT_V6S_BUF3),
											.IN4(RIGHT_V6A_BUF3),
											.IN5(RIGHT_V6B_BUF3),
											.IN6(RIGHT_V6M_BUF3),
											.IN7(RIGHT_V6C_BUF3),
											.IN0(RIGHT_W_BUF13),
											.IN1(RIGHT_W_BUF12),
											.IN2(RIGHT_W_BUF11),
											.IN3(RIGHT_W_BUF10),
											.OUT(RIGHT_TCE3),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H2 sps_tce2(
											.IN8(RIGHT_V6D_BUF3),
											.IN9(RIGHT_V6S_BUF3),
											.IN4(RIGHT_V6A_BUF3),
											.IN5(RIGHT_V6B_BUF3),
											.IN6(RIGHT_V6M_BUF3),
											.IN7(RIGHT_V6C_BUF3),
											.IN0(RIGHT_W_BUF13),
											.IN1(RIGHT_W_BUF12),
											.IN2(RIGHT_W_BUF11),
											.IN3(RIGHT_W_BUF10),
											.OUT(RIGHT_TCE2),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H1 sps_tce1(
											.IN8(RIGHT_V6D_BUF3),
											.IN9(RIGHT_V6S_BUF3),
											.IN4(RIGHT_V6A_BUF3),
											.IN5(RIGHT_V6B_BUF3),
											.IN6(RIGHT_V6M_BUF3),
											.IN7(RIGHT_V6C_BUF3),
											.IN0(RIGHT_W_BUF13),
											.IN1(RIGHT_W_BUF12),
											.IN2(RIGHT_W_BUF11),
											.IN3(RIGHT_W_BUF10),
											.OUT(RIGHT_TCE1),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		BUF1B0X2H5 buf_w18(
											.A(RIGHT_W18),
											.Y(RIGHT_W_BUF18)
		);

		BUF1B0X2H3 buf_v6s3(
											.A(RIGHT_V6S3),
											.Y(RIGHT_V6S_BUF3)
		);

		BUF1B0X2H3 buf_v6s2(
											.A(RIGHT_V6S2),
											.Y(RIGHT_V6S_BUF2)
		);

		BUF1B0X2H3 buf_v6s1(
											.A(RIGHT_V6S1),
											.Y(RIGHT_V6S_BUF1)
		);

		BUF1B0X2H3 buf_v6s0(
											.A(RIGHT_V6S0),
											.Y(RIGHT_V6S_BUF0)
		);

		BUF1B0X2H3 buf_h6c1(
											.A(RIGHT_H6C1),
											.Y(RIGHT_H6C_BUF1)
		);

		SPS12N7X0H1 sps_ti1_b(
											.IN8(RIGHT_W_BUF5),
											.IN9(RIGHT_W_BUF6),
											.IN4(RIGHT_IQ2),
											.IN5(RIGHT_I2),
											.IN6(RIGHT_IQ3),
											.IN7(RIGHT_I3),
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_I0),
											.IN2(RIGHT_IQ1),
											.IN3(RIGHT_I1),
											.OUT(RIGHT_TI1_B),
											.IN10(RIGHT_W_BUF10),
											.IN11(RIGHT_W_BUF11),
											._1(1)
		);

		BUF1B0X2H3 buf_h6c3(
											.A(RIGHT_H6C3),
											.Y(RIGHT_H6C_BUF3)
		);

		BUF1B0X2H3 buf_h6c2(
											.A(RIGHT_H6C2),
											.Y(RIGHT_H6C_BUF2)
		);

		SPS4N4X0H1 sps_out6(
											.OUT(RIGHT_OUT6),
											.IN0(RIGHT_I3),
											.IN1(RIGHT_I2),
											.IN2(RIGHT_I1),
											.IN3(RIGHT_I0),
											._1(1)
		);

		BUF1B0X2H3 buf_v6b0(
											.A(RIGHT_V6B0),
											.Y(RIGHT_V6B_BUF0)
		);

		BUF1B0X2H3 buf_v6b1(
											.A(RIGHT_V6B1),
											.Y(RIGHT_V6B_BUF1)
		);

		BUF1B0X2H3 buf_v6b2(
											.A(RIGHT_V6B2),
											.Y(RIGHT_V6B_BUF2)
		);

		BUF1B0X2H3 buf_v6b3(
											.A(RIGHT_V6B3),
											.Y(RIGHT_V6B_BUF3)
		);

		SPS3N3X0H1 sps_w12(
											.IN0(RIGHT_IQ3),
											.IN1(RIGHT_V6S2),
											.IN2(RIGHT_TBUFO1),
											.OUT(RIGHT_W12),
											._1(1)
		);

		SPS2N2X0H2 sps_w13(
											.IN0(RIGHT_IQ2),
											.IN1(RIGHT_V6M2),
											.OUT(RIGHT_W13),
											._1(1)
		);

		SPS2N2X0H2 sps_w10(
											.IN0(RIGHT_I1),
											.IN1(RIGHT_V6M1),
											.OUT(RIGHT_W10),
											._1(1)
		);

		SPS2N2X0H2 sps_w11(
											.IN0(RIGHT_I0),
											.IN1(RIGHT_V6N1),
											.OUT(RIGHT_W11),
											._1(1)
		);

		SPS2N2X0H2 sps_w16(
											.IN0(RIGHT_I3),
											.IN1(RIGHT_V6M2),
											.OUT(RIGHT_W16),
											._1(1)
		);

		SPS2N2X0H2 sps_w17(
											.IN0(RIGHT_I2),
											.IN1(RIGHT_V6N2),
											.OUT(RIGHT_W17),
											._1(1)
		);

		SPS2N2X0H2 sps_w14(
											.IN0(RIGHT_IQ1),
											.IN1(RIGHT_V6N2),
											.OUT(RIGHT_W14),
											._1(1)
		);

		SPS3N3X0H1 sps_w15(
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_V6S2),
											.IN2(RIGHT_TBUFO1),
											.OUT(RIGHT_W15),
											._1(1)
		);

		SPS4T5X11H1 sps_h6c0(
											.OUT(RIGHT_H6C0),
											.IN0(RIGHT_IQ1),
											.IN1(RIGHT_IQ2),
											.IN2(RIGHT_IQ3),
											.IN3(RIGHT_LLH2),
											._1(1)
		);

		SPS4T5X11H1 sps_h6c1(
											.IN3(RIGHT_LLH2),
											.IN0(RIGHT_I0),
											.IN1(RIGHT_I1),
											.IN2(RIGHT_IQ3),
											.OUT(RIGHT_H6C1),
											._1(1)
		);

		SPS4T5X11H1 sps_h6c2(
											.IN3(RIGHT_LLH8),
											.IN0(RIGHT_I1),
											.IN1(RIGHT_I2),
											.IN2(RIGHT_I3),
											.OUT(RIGHT_H6C2),
											._1(1)
		);

		SPS4T5X11H1 sps_h6c3(
											.IN3(RIGHT_LLH8),
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_IQ1),
											.IN2(RIGHT_I3),
											.OUT(RIGHT_H6C3),
											._1(1)
		);

		SPS12N7X0H2 sps_oce2(
											.IN8(RIGHT_V6D_BUF3),
											.IN9(RIGHT_V6S_BUF3),
											.IN4(RIGHT_V6A_BUF3),
											.IN5(RIGHT_V6B_BUF3),
											.IN6(RIGHT_V6M_BUF3),
											.IN7(RIGHT_V6C_BUF3),
											.IN0(RIGHT_W_BUF19),
											.IN1(RIGHT_W_BUF18),
											.IN2(RIGHT_W_BUF17),
											.IN3(RIGHT_W_BUF16),
											.OUT(RIGHT_OCE2),
											.IN10(RIGHT_PCI_CE),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H2 sps_oce3(
											.IN8(RIGHT_V6D_BUF3),
											.IN9(RIGHT_V6S_BUF3),
											.IN4(RIGHT_V6A_BUF3),
											.IN5(RIGHT_V6B_BUF3),
											.IN6(RIGHT_V6M_BUF3),
											.IN7(RIGHT_V6C_BUF3),
											.IN0(RIGHT_W_BUF19),
											.IN1(RIGHT_W_BUF18),
											.IN2(RIGHT_W_BUF17),
											.IN3(RIGHT_W_BUF16),
											.OUT(RIGHT_OCE3),
											.IN10(RIGHT_PCI_CE),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H1 sps_oce1(
											.IN8(RIGHT_V6D_BUF3),
											.IN9(RIGHT_V6S_BUF3),
											.IN4(RIGHT_V6A_BUF3),
											.IN5(RIGHT_V6B_BUF3),
											.IN6(RIGHT_V6M_BUF3),
											.IN7(RIGHT_V6C_BUF3),
											.IN0(RIGHT_W_BUF19),
											.IN1(RIGHT_W_BUF18),
											.IN2(RIGHT_W_BUF17),
											.IN3(RIGHT_W_BUF16),
											.OUT(RIGHT_OCE1),
											.IN10(RIGHT_PCI_CE),
											.IN11(VDD),
											._1(1)
		);

		SPS2T2X11H3 sps_llh9(
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_I2),
											.OUT(RIGHT_LLH9),
											._1(1)
		);

		SPS2T2X11H3 sps_llh8(
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_I2),
											.OUT(RIGHT_LLH8),
											._1(1)
		);

		SPS2T2X11H3 sps_llh7(
											.IN0(RIGHT_I1),
											.IN1(RIGHT_IQ2),
											.OUT(RIGHT_LLH7),
											._1(1)
		);

		SPS2T2X11H3 sps_llh6(
											.IN0(RIGHT_I0),
											.IN1(RIGHT_IQ2),
											.OUT(RIGHT_LLH6),
											._1(1)
		);

		SPS2T2X11H3 sps_llh5(
											.IN0(RIGHT_I1),
											.IN1(RIGHT_I2),
											.OUT(RIGHT_LLH5),
											._1(1)
		);

		SPS2T2X11H3 sps_llh4(
											.IN0(RIGHT_I1),
											.IN1(RIGHT_IQ2),
											.OUT(RIGHT_LLH4),
											._1(1)
		);

		SPS2T2X11H3 sps_llh3(
											.IN0(RIGHT_IQ1),
											.IN1(RIGHT_I3),
											.OUT(RIGHT_LLH3),
											._1(1)
		);

		SPS2T2X11H3 sps_llh2(
											.IN0(RIGHT_IQ1),
											.IN1(RIGHT_I3),
											.OUT(RIGHT_LLH2),
											._1(1)
		);

		SPS2T2X11H3 sps_llh1(
											.IN0(RIGHT_I0),
											.IN1(RIGHT_IQ3),
											.OUT(RIGHT_LLH1),
											._1(1)
		);

		SPS2T2X11H3 sps_llh0(
											.IN0(RIGHT_IQ3),
											.IN1(RIGHT_IQ0),
											.OUT(RIGHT_LLH0),
											._1(1)
		);

		BUF1B0X2H3 buf_h6d9_h6b8(
											.A(RIGHT_H6D9),
											.Y(RIGHT_H6B8)
		);

		SPS4T5X11H1 sps_h6m0(
											.OUT(RIGHT_H6M0),
											.IN0(RIGHT_IQ1),
											.IN1(RIGHT_IQ2),
											.IN2(RIGHT_IQ3),
											.IN3(RIGHT_LLH3),
											._1(1)
		);

		BUF1B0X2H3 buf_h6m9_h6c8(
											.A(RIGHT_H6M9),
											.Y(RIGHT_H6C8)
		);

		BUF1B0X2H3 buf_v6c3(
											.A(RIGHT_V6C3),
											.Y(RIGHT_V6C_BUF3)
		);

		BUF1B0X2H3 buf_h6d1(
											.A(RIGHT_H6D1),
											.Y(RIGHT_H6D_BUF1)
		);

		BUF1B0X2H3 buf_h6d2(
											.A(RIGHT_H6D2),
											.Y(RIGHT_H6D_BUF2)
		);

		BUF1B0X2H3 buf_v6c0(
											.A(RIGHT_V6C0),
											.Y(RIGHT_V6C_BUF0)
		);

		SPS4T5X11H1 sps_h6b3(
											.OUT(RIGHT_H6B3),
											.IN0(RIGHT_I0),
											.IN1(RIGHT_I1),
											.IN2(RIGHT_I2),
											.IN3(RIGHT_LLH10),
											._1(1)
		);

		SPS4T5X11H1 sps_h6b2(
											.OUT(RIGHT_H6B2),
											.IN0(RIGHT_I0),
											.IN1(RIGHT_IQ2),
											.IN2(RIGHT_IQ3),
											.IN3(RIGHT_LLH10),
											._1(1)
		);

		SPS4T5X11H1 sps_h6b1(
											.OUT(RIGHT_H6B1),
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_IQ1),
											.IN2(RIGHT_IQ2),
											.IN3(RIGHT_LLH4),
											._1(1)
		);

		SPS4T5X11H1 sps_h6b0(
											.OUT(RIGHT_H6B0),
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_I2),
											.IN2(RIGHT_I3),
											.IN3(RIGHT_LLH4),
											._1(1)
		);

		BUF1B0X2H3 buf_h6w5_h6a4(
											.A(RIGHT_H6W5),
											.Y(RIGHT_H6A4)
		);

		BUF1B0X2H3 buf_h6m3(
											.A(RIGHT_H6M3),
											.Y(RIGHT_H6M_BUF3)
		);

		BUF1B0X2H3 buf_h6m2(
											.A(RIGHT_H6M2),
											.Y(RIGHT_H6M_BUF2)
		);

		BUF1B0X2H3 buf_h6m1(
											.A(RIGHT_H6M1),
											.Y(RIGHT_H6M_BUF1)
		);

		SPS12N7X0H1 sps_ti0_b(
											.IN8(RIGHT_W_BUF17),
											.IN9(RIGHT_W_BUF18),
											.IN4(RIGHT_IQ2),
											.IN5(RIGHT_I2),
											.IN6(RIGHT_IQ3),
											.IN7(RIGHT_I3),
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_I0),
											.IN2(RIGHT_IQ1),
											.IN3(RIGHT_I1),
											.OUT(RIGHT_TI0_B),
											.IN10(RIGHT_W_BUF22),
											.IN11(RIGHT_W_BUF23),
											._1(1)
		);

		BUF1B0X2H3 buf_h6d11_h6b10(
											.A(RIGHT_H6D11),
											.Y(RIGHT_H6B10)
		);

		BUF1B0X2H3 buf_h6c11_h6m10(
											.A(RIGHT_H6C11),
											.Y(RIGHT_H6M10)
		);

		SPS4T5X11H1 sps_h6a2(
											.OUT(RIGHT_H6A2),
											.IN0(RIGHT_I0),
											.IN1(RIGHT_IQ2),
											.IN2(RIGHT_IQ3),
											.IN3(RIGHT_LLH11),
											._1(1)
		);

		SPS4T5X11H1 sps_h6a3(
											.OUT(RIGHT_H6A3),
											.IN0(RIGHT_I0),
											.IN1(RIGHT_I1),
											.IN2(RIGHT_I2),
											.IN3(RIGHT_LLH11),
											._1(1)
		);

		SPS4T5X11H1 sps_h6a0(
											.OUT(RIGHT_H6A0),
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_I2),
											.IN2(RIGHT_I3),
											.IN3(RIGHT_LLH5),
											._1(1)
		);

		SPS4T5X11H1 sps_h6a1(
											.OUT(RIGHT_H6A1),
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_IQ1),
											.IN2(RIGHT_IQ2),
											.IN3(RIGHT_LLH5),
											._1(1)
		);

		BUF1B0X2H3 buf_h6d7_h6b6(
											.A(RIGHT_H6D7),
											.Y(RIGHT_H6B6)
		);

		BUF1B0X2H3 buf_h6m11_h6c10(
											.A(RIGHT_H6M11),
											.Y(RIGHT_H6C10)
		);

		BUF1B0X2H3 buf_h6w1(
											.A(RIGHT_H6W1),
											.Y(RIGHT_H6W_BUF1)
		);

		BUF1B0X2H3 buf_h6d5_h6b4(
											.A(RIGHT_H6D5),
											.Y(RIGHT_H6B4)
		);

		BUF1B0X2H3 buf_h6w3(
											.A(RIGHT_H6W3),
											.Y(RIGHT_H6W_BUF3)
		);

		BUF1B0X2H3 buf_h6w2(
											.A(RIGHT_H6W2),
											.Y(RIGHT_H6W_BUF2)
		);

		SPS12N7X0H2 sps_t1(
											.IN8(RIGHT_V6D_BUF0),
											.IN9(RIGHT_V6S_BUF0),
											.IN4(RIGHT_V6A_BUF0),
											.IN5(RIGHT_V6B_BUF0),
											.IN6(RIGHT_V6M_BUF0),
											.IN7(RIGHT_V6C_BUF0),
											.IN0(RIGHT_W_BUF3),
											.IN1(RIGHT_W_BUF2),
											.IN2(RIGHT_W_BUF1),
											.IN3(RIGHT_W_BUF0),
											.OUT(RIGHT_T1),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H1 sps_t3(
											.IN8(RIGHT_V6D_BUF0),
											.IN9(RIGHT_V6S_BUF0),
											.IN4(RIGHT_V6A_BUF0),
											.IN5(RIGHT_V6B_BUF0),
											.IN6(RIGHT_V6M_BUF0),
											.IN7(RIGHT_V6C_BUF0),
											.IN0(RIGHT_W_BUF3),
											.IN1(RIGHT_W_BUF2),
											.IN2(RIGHT_W_BUF1),
											.IN3(RIGHT_W_BUF0),
											.OUT(RIGHT_T3),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS12N7X0H2 sps_t2(
											.IN8(RIGHT_V6D_BUF0),
											.IN9(RIGHT_V6S_BUF0),
											.IN4(RIGHT_V6A_BUF0),
											.IN5(RIGHT_V6B_BUF0),
											.IN6(RIGHT_V6M_BUF0),
											.IN7(RIGHT_V6C_BUF0),
											.IN0(RIGHT_W_BUF3),
											.IN1(RIGHT_W_BUF2),
											.IN2(RIGHT_W_BUF1),
											.IN3(RIGHT_W_BUF0),
											.OUT(RIGHT_T2),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		BUF1B0X2H3 buf_v6a1(
											.A(RIGHT_V6A1),
											.Y(RIGHT_V6A_BUF1)
		);

		BUF1B0X2H3 buf_v6a0(
											.A(RIGHT_V6A0),
											.Y(RIGHT_V6A_BUF0)
		);

		BUF1B0X2H3 buf_v6a3(
											.A(RIGHT_V6A3),
											.Y(RIGHT_V6A_BUF3)
		);

		BUF1B0X2H3 buf_v6a2(
											.A(RIGHT_V6A2),
											.Y(RIGHT_V6A_BUF2)
		);

		SPS12T8X11H1 sps_v6s3(
											.IN8(RIGHT_I0),
											.IN9(RIGHT_LLV6),
											.IN4(RIGHT_I2),
											.IN5(RIGHT_IQ1),
											.IN6(RIGHT_I1),
											.IN7(RIGHT_IQ0),
											.IN0(RIGHT_V6N3),
											.IN1(RIGHT_IQ3),
											.IN2(RIGHT_I3),
											.IN3(RIGHT_IQ2),
											.IN11(RIGHT_H6W3),
											.IN10(RIGHT_H6M1),
											.OUT(RIGHT_V6S3),
											._1(1)
		);

		SPS16T10X11H2 sps_llv6(
											.IN8(RIGHT_W_BUF23),
											.IN9(RIGHT_W_BUF22),
											.IN4(RIGHT_IQ2),
											.IN5(RIGHT_I2),
											.IN6(RIGHT_IQ3),
											.IN7(RIGHT_I3),
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_I0),
											.IN2(RIGHT_IQ1),
											.IN3(RIGHT_I1),
											.OUT(RIGHT_LLV6),
											.IN14(RIGHT_W_BUF6),
											.IN15(RIGHT_W_BUF5),
											.IN12(RIGHT_W_BUF11),
											.IN13(RIGHT_W_BUF10),
											.IN10(RIGHT_W_BUF18),
											.IN11(RIGHT_W_BUF17),
											._1(1)
		);

		BUF1B0X2H3 buf_v6c2(
											.A(RIGHT_V6C2),
											.Y(RIGHT_V6C_BUF2)
		);

		SPS12N7X0H2 sps_ts1_b(
											.IN8(RIGHT_V6D_BUF1),
											.IN9(RIGHT_V6S_BUF1),
											.IN4(RIGHT_V6A_BUF1),
											.IN5(RIGHT_V6B_BUF1),
											.IN6(RIGHT_V6M_BUF1),
											.IN7(RIGHT_V6C_BUF1),
											.IN0(RIGHT_W_BUF0),
											.IN1(RIGHT_W_BUF7),
											.IN2(RIGHT_W_BUF12),
											.IN3(RIGHT_W_BUF19),
											.OUT(RIGHT_TS1_B),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		BUF1B0X2H3 buf_v6c1(
											.A(RIGHT_V6C1),
											.Y(RIGHT_V6C_BUF1)
		);

		SPS6B6X2H1 sps_h6w4(
											.IN4(RIGHT_V6N2),
											.IN5(RIGHT_H6A5),
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_I0),
											.IN2(RIGHT_V6S0),
											.IN3(RIGHT_V6M1),
											.OUT(RIGHT_H6W4),
											._1(1)
		);

		SPS6B6X2H1 sps_h6w6(
											.IN4(RIGHT_V6S3),
											.IN5(RIGHT_H6A7),
											.IN0(RIGHT_IQ1),
											.IN1(RIGHT_I1),
											.IN2(RIGHT_V6N1),
											.IN3(RIGHT_V6M0),
											.OUT(RIGHT_H6W6),
											._1(1)
		);

		BUF1B0X2H3 buf_h6d3(
											.A(RIGHT_H6D3),
											.Y(RIGHT_H6D_BUF3)
		);

		SPS6T7X11H1 sps_h6w0(
											.IN4(RIGHT_V6M3),
											.IN5(RIGHT_V6N1),
											.IN0(RIGHT_I0),
											.IN1(RIGHT_I1),
											.IN2(RIGHT_LLH0),
											.IN3(RIGHT_V6S0),
											.OUT(RIGHT_H6W0),
											._1(1)
		);

		SPS6T7X11H1 sps_h6w1(
											.IN4(RIGHT_V6M0),
											.IN5(RIGHT_V6N2),
											.IN0(RIGHT_I2),
											.IN1(RIGHT_I3),
											.IN2(RIGHT_LLH0),
											.IN3(RIGHT_V6S1),
											.OUT(RIGHT_H6W1),
											._1(1)
		);

		SPS6T7X11H1 sps_h6w2(
											.IN4(RIGHT_V6M1),
											.IN5(RIGHT_V6N3),
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_IQ1),
											.IN2(RIGHT_LLH6),
											.IN3(RIGHT_V6S2),
											.OUT(RIGHT_H6W2),
											._1(1)
		);

		SPS6T7X11H1 sps_h6w3(
											.IN4(RIGHT_V6M2),
											.IN5(RIGHT_V6N0),
											.IN0(RIGHT_IQ2),
											.IN1(RIGHT_IQ3),
											.IN2(RIGHT_LLH6),
											.IN3(RIGHT_V6S3),
											.OUT(RIGHT_H6W3),
											._1(1)
		);

		SPS2N2X0H2 sps_w23(
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_V6N3),
											.OUT(RIGHT_W23),
											._1(1)
		);

		SPS2N2X0H2 sps_w22(
											.IN0(RIGHT_IQ1),
											.IN1(RIGHT_V6M3),
											.OUT(RIGHT_W22),
											._1(1)
		);

		SPS3N3X0H1 sps_w21(
											.IN0(RIGHT_IQ2),
											.IN1(RIGHT_V6S3),
											.IN2(RIGHT_TBUFO0),
											.OUT(RIGHT_W21),
											._1(1)
		);

		SPS2N2X0H2 sps_w20(
											.IN0(RIGHT_IQ3),
											.IN1(RIGHT_V6N3),
											.OUT(RIGHT_W20),
											._1(1)
		);

		SPS6B6X2H1 sps_h6w8(
											.IN4(RIGHT_V6N0),
											.IN5(RIGHT_H6A9),
											.IN0(RIGHT_IQ2),
											.IN1(RIGHT_I2),
											.IN2(RIGHT_V6S2),
											.IN3(RIGHT_V6M3),
											.OUT(RIGHT_H6W8),
											._1(1)
		);

		SPS3N3X0H1 sps_w0(
											.IN0(RIGHT_I3),
											.IN1(RIGHT_V6S0),
											.IN2(RIGHT_TBUFO3),
											.OUT(RIGHT_W0),
											._1(1)
		);

		SPS2N2X0H2 sps_w1(
											.IN0(RIGHT_I2),
											.IN1(RIGHT_V6M0),
											.OUT(RIGHT_W1),
											._1(1)
		);

		SPS2N2X0H2 sps_w2(
											.IN0(RIGHT_I1),
											.IN1(RIGHT_V6N0),
											.OUT(RIGHT_W2),
											._1(1)
		);

		SPS3N3X0H1 sps_w3(
											.IN0(RIGHT_I0),
											.IN1(RIGHT_V6S0),
											.IN2(RIGHT_TBUFO3),
											.OUT(RIGHT_W3),
											._1(1)
		);

		SPS2N2X0H2 sps_w4(
											.IN0(RIGHT_IQ3),
											.IN1(RIGHT_V6M0),
											.OUT(RIGHT_W4),
											._1(1)
		);

		SPS2N2X0H2 sps_w5(
											.IN0(RIGHT_IQ2),
											.IN1(RIGHT_V6N0),
											.OUT(RIGHT_W5),
											._1(1)
		);

		SPS3N3X0H1 sps_w6(
											.IN0(RIGHT_IQ1),
											.IN1(RIGHT_V6S1),
											.IN2(RIGHT_TBUFO2),
											.OUT(RIGHT_W6),
											._1(1)
		);

		SPS2N2X0H2 sps_w7(
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_V6M1),
											.OUT(RIGHT_W7),
											._1(1)
		);

		SPS16T10X11H2 sps_llv0(
											.IN8(RIGHT_W_BUF23),
											.IN9(RIGHT_W_BUF22),
											.IN4(RIGHT_IQ2),
											.IN5(RIGHT_I2),
											.IN6(RIGHT_IQ3),
											.IN7(RIGHT_I3),
											.IN0(RIGHT_IQ0),
											.IN1(RIGHT_I0),
											.IN2(RIGHT_IQ1),
											.IN3(RIGHT_I1),
											.OUT(RIGHT_LLV0),
											.IN14(RIGHT_W_BUF6),
											.IN15(RIGHT_W_BUF5),
											.IN12(RIGHT_W_BUF11),
											.IN13(RIGHT_W_BUF10),
											.IN10(RIGHT_W_BUF18),
											.IN11(RIGHT_W_BUF17),
											._1(1)
		);

		SPS3N3X0H1 sps_w9(
											.IN0(RIGHT_I2),
											.IN1(RIGHT_V6S1),
											.IN2(RIGHT_TBUFO2),
											.OUT(RIGHT_W9),
											._1(1)
		);

		BUF1B0X2H3 buf_v6m2(
											.A(RIGHT_V6M2),
											.Y(RIGHT_V6M_BUF2)
		);

		SPS12N7X0H2 sps_ts0_b(
											.IN8(RIGHT_V6D_BUF1),
											.IN9(RIGHT_V6S_BUF1),
											.IN4(RIGHT_V6A_BUF1),
											.IN5(RIGHT_V6B_BUF1),
											.IN6(RIGHT_V6M_BUF1),
											.IN7(RIGHT_V6C_BUF1),
											.IN0(RIGHT_W_BUF0),
											.IN1(RIGHT_W_BUF7),
											.IN2(RIGHT_W_BUF12),
											.IN3(RIGHT_W_BUF19),
											.OUT(RIGHT_TS0_B),
											.IN10(VDD),
											.IN11(VDD),
											._1(1)
		);

		SPS16N8X0H1 sps_clk3(
											.IN8(RIGHT_V6D_BUF2),
											.IN9(RIGHT_V6S_BUF2),
											.IN4(RIGHT_V6A_BUF2),
											.IN5(RIGHT_V6B_BUF2),
											.IN6(RIGHT_V6M_BUF2),
											.IN7(RIGHT_V6C_BUF2),
											.IN0(RIGHT_W_BUF15),
											.IN1(RIGHT_W_BUF14),
											.IN2(RIGHT_W_BUF9),
											.IN3(RIGHT_W_BUF8),
											.OUT(RIGHT_CLK3),
											.IN14(VDD),
											.IN15(VDD),
											.IN12(RIGHT_GCLK2),
											.IN13(RIGHT_GCLK3),
											.IN10(RIGHT_GCLK0),
											.IN11(RIGHT_GCLK1),
											._1(1)
		);

		SPS16N8X0H1 sps_clk2(
											.IN8(RIGHT_V6D_BUF2),
											.IN9(RIGHT_V6S_BUF2),
											.IN4(RIGHT_V6A_BUF2),
											.IN5(RIGHT_V6B_BUF2),
											.IN6(RIGHT_V6M_BUF2),
											.IN7(RIGHT_V6C_BUF2),
											.IN0(RIGHT_W_BUF15),
											.IN1(RIGHT_W_BUF14),
											.IN2(RIGHT_W_BUF9),
											.IN3(RIGHT_W_BUF8),
											.OUT(RIGHT_CLK2),
											.IN14(VDD),
											.IN15(VDD),
											.IN12(RIGHT_GCLK2),
											.IN13(RIGHT_GCLK3),
											.IN10(RIGHT_GCLK0),
											.IN11(RIGHT_GCLK1),
											._1(1)
		);

		SPS16N8X0H1 sps_clk1(
											.IN8(RIGHT_V6D_BUF2),
											.IN9(RIGHT_V6S_BUF2),
											.IN4(RIGHT_V6A_BUF2),
											.IN5(RIGHT_V6B_BUF2),
											.IN6(RIGHT_V6M_BUF2),
											.IN7(RIGHT_V6C_BUF2),
											.IN0(RIGHT_W_BUF15),
											.IN1(RIGHT_W_BUF14),
											.IN2(RIGHT_W_BUF9),
											.IN3(RIGHT_W_BUF8),
											.OUT(RIGHT_CLK1),
											.IN14(VDD),
											.IN15(VDD),
											.IN12(RIGHT_GCLK2),
											.IN13(RIGHT_GCLK3),
											.IN10(RIGHT_GCLK0),
											.IN11(RIGHT_GCLK1),
											._1(1)
		);

		SPS12T8X11H1 sps_v6n1(
											.IN8(RIGHT_I0),
											.IN9(RIGHT_LLV0),
											.IN4(RIGHT_I2),
											.IN5(RIGHT_IQ1),
											.IN6(RIGHT_I1),
											.IN7(RIGHT_IQ0),
											.IN0(RIGHT_V6S1),
											.IN1(RIGHT_IQ3),
											.IN2(RIGHT_I3),
											.IN3(RIGHT_IQ2),
											.IN11(RIGHT_H6W0),
											.IN10(RIGHT_H6M3),
											.OUT(RIGHT_V6N1),
											._1(1)
		);

		SPS12T8X11H1 sps_v6n0(
											.IN8(RIGHT_I0),
											.IN9(RIGHT_LLV0),
											.IN4(RIGHT_I2),
											.IN5(RIGHT_IQ1),
											.IN6(RIGHT_I1),
											.IN7(RIGHT_IQ0),
											.IN0(RIGHT_V6S0),
											.IN1(RIGHT_IQ3),
											.IN2(RIGHT_I3),
											.IN3(RIGHT_IQ2),
											.IN11(RIGHT_H6W3),
											.IN10(RIGHT_H6M2),
											.OUT(RIGHT_V6N0),
											._1(1)
		);

		SPS12T8X11H1 sps_v6n3(
											.IN8(RIGHT_I0),
											.IN9(RIGHT_LLV6),
											.IN4(RIGHT_I2),
											.IN5(RIGHT_IQ1),
											.IN6(RIGHT_I1),
											.IN7(RIGHT_IQ0),
											.IN0(RIGHT_V6S3),
											.IN1(RIGHT_IQ3),
											.IN2(RIGHT_I3),
											.IN3(RIGHT_IQ2),
											.OUT(RIGHT_V6N3),
											.IN10(RIGHT_H6M1),
											.IN11(RIGHT_H6W2),
											._1(1)
		);

		SPS12T8X11H1 sps_v6n2(
											.IN8(RIGHT_I0),
											.IN9(RIGHT_LLV6),
											.IN4(RIGHT_I2),
											.IN5(RIGHT_IQ1),
											.IN6(RIGHT_I1),
											.IN7(RIGHT_IQ0),
											.IN0(RIGHT_V6S2),
											.IN1(RIGHT_IQ3),
											.IN2(RIGHT_I3),
											.IN3(RIGHT_IQ2),
											.OUT(RIGHT_V6N2),
											.IN10(RIGHT_H6M0),
											.IN11(RIGHT_H6W1),
											._1(1)
		);

		BUF1B0X2H3 buf_h6c5_h6m4(
											.A(RIGHT_H6C5),
											.Y(RIGHT_H6M4)
		);

		BUF1B0X2H5 buf_w20(
											.A(RIGHT_W20),
											.Y(RIGHT_W_BUF20)
		);

		BUF1B0X2H5 buf_w21(
											.A(RIGHT_W21),
											.Y(RIGHT_W_BUF21)
		);

		BUF1B0X2H5 buf_w22(
											.A(RIGHT_W22),
											.Y(RIGHT_W_BUF22)
		);

		BUF1B0X2H5 buf_w23(
											.A(RIGHT_W23),
											.Y(RIGHT_W_BUF23)
		);

		SPS22N7X0H1 sps_o1(
											.IN8(RIGHT_W_BUF3),
											.IN9(RIGHT_W_BUF2),
											.IN4(RIGHT_W_BUF7),
											.IN5(RIGHT_W_BUF6),
											.IN6(RIGHT_W_BUF5),
											.IN7(RIGHT_W_BUF4),
											.IN0(RIGHT_W_BUF11),
											.IN1(RIGHT_W_BUF10),
											.IN2(RIGHT_W_BUF9),
											.IN3(RIGHT_W_BUF8),
											.IN18(RIGHT_TBUFO2),
											.IN19(RIGHT_TBUFO3),
											.IN16(RIGHT_TBUFO0),
											.IN17(RIGHT_TBUFO1),
											.IN14(RIGHT_H6C_BUF1),
											.IN15(RIGHT_H6M_BUF1),
											.IN12(RIGHT_H6W_BUF1),
											.IN13(RIGHT_H6D_BUF1),
											.IN10(RIGHT_W_BUF1),
											.IN11(RIGHT_W_BUF0),
											.OUT(RIGHT_O1),
											.IN21(RIGHT_OUT_W1),
											.IN20(RIGHT_OUT_W0),
											._1(1)
		);

		SPS22N7X0H1 sps_o2(
											.IN8(RIGHT_W_BUF15),
											.IN9(RIGHT_W_BUF14),
											.IN4(RIGHT_W_BUF19),
											.IN5(RIGHT_W_BUF18),
											.IN6(RIGHT_W_BUF17),
											.IN7(RIGHT_W_BUF16),
											.IN0(RIGHT_W_BUF23),
											.IN1(RIGHT_W_BUF22),
											.IN2(RIGHT_W_BUF21),
											.IN3(RIGHT_W_BUF20),
											.IN18(RIGHT_TBUFO2),
											.IN19(RIGHT_TBUFO3),
											.IN16(RIGHT_TBUFO0),
											.IN17(RIGHT_TBUFO1),
											.IN14(RIGHT_H6C_BUF2),
											.IN15(RIGHT_H6M_BUF2),
											.IN12(RIGHT_H6W_BUF2),
											.IN13(RIGHT_H6D_BUF2),
											.IN10(RIGHT_W_BUF13),
											.IN11(RIGHT_W_BUF12),
											.OUT(RIGHT_O2),
											.IN21(RIGHT_OUT_W1),
											.IN20(RIGHT_OUT_W0),
											._1(1)
		);

		SPS22N7X0H1 sps_o3(
											.IN8(RIGHT_W_BUF15),
											.IN9(RIGHT_W_BUF14),
											.IN4(RIGHT_W_BUF19),
											.IN5(RIGHT_W_BUF18),
											.IN6(RIGHT_W_BUF17),
											.IN7(RIGHT_W_BUF16),
											.IN0(RIGHT_W_BUF23),
											.IN1(RIGHT_W_BUF22),
											.IN2(RIGHT_W_BUF21),
											.IN3(RIGHT_W_BUF20),
											.IN18(RIGHT_TBUFO2),
											.IN19(RIGHT_TBUFO3),
											.IN16(RIGHT_TBUFO0),
											.IN17(RIGHT_TBUFO1),
											.IN14(RIGHT_H6C_BUF3),
											.IN15(RIGHT_H6M_BUF3),
											.IN12(RIGHT_H6W_BUF3),
											.IN13(RIGHT_H6D_BUF3),
											.IN10(RIGHT_W_BUF13),
											.IN11(RIGHT_W_BUF12),
											.OUT(RIGHT_O3),
											.IN21(RIGHT_OUT_W1),
											.IN20(RIGHT_OUT_W0),
											._1(1)
		);

		SPS6B6X2H1 sps_h6w10(
											.IN4(RIGHT_V6N3),
											.IN5(RIGHT_H6A11),
											.IN0(RIGHT_IQ3),
											.IN1(RIGHT_I3),
											.IN2(RIGHT_V6S1),
											.IN3(RIGHT_V6M2),
											.OUT(RIGHT_H6W10),
											._1(1)
		);

		BUF1B0X2H5 buf_w5(
											.A(RIGHT_W5),
											.Y(RIGHT_W_BUF5)
		);

		BUF1B0X2H5 buf_w4(
											.A(RIGHT_W4),
											.Y(RIGHT_W_BUF4)
		);

		BUF1B0X2H5 buf_w7(
											.A(RIGHT_W7),
											.Y(RIGHT_W_BUF7)
		);

		BUF1B0X2H5 buf_w6(
											.A(RIGHT_W6),
											.Y(RIGHT_W_BUF6)
		);

		BUF1B0X2H5 buf_w1(
											.A(RIGHT_W1),
											.Y(RIGHT_W_BUF1)
		);

		BUF1B0X2H5 buf_w0(
											.A(RIGHT_W0),
											.Y(RIGHT_W_BUF0)
		);

		BUF1B0X2H5 buf_w3(
											.A(RIGHT_W3),
											.Y(RIGHT_W_BUF3)
		);

		BUF1B0X2H5 buf_w2(
											.A(RIGHT_W2),
											.Y(RIGHT_W_BUF2)
		);

		SPS2T2X11H3 sps_llh11(
											.IN0(RIGHT_IQ1),
											.IN1(RIGHT_I3),
											.OUT(RIGHT_LLH11),
											._1(1)
		);

		SPS2T2X11H3 sps_llh10(
											.IN0(RIGHT_I0),
											.IN1(RIGHT_IQ3),
											.OUT(RIGHT_LLH10),
											._1(1)
		);

		BUF1B0X2H5 buf_w9(
											.A(RIGHT_W9),
											.Y(RIGHT_W_BUF9)
		);

		BUF1B0X2H5 buf_w8(
											.A(RIGHT_W8),
											.Y(RIGHT_W_BUF8)
		);

		BUF1B0X2H3 buf_h6c7_h6m6(
											.A(RIGHT_H6C7),
											.Y(RIGHT_H6M6)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_CLKL(
BRAM_CLKH_GCLK0, BRAM_CLKH_GCLK1, BRAM_CLKH_GCLK2, BRAM_CLKH_GCLK3, BRAM_CLKH_VGCLK0, BRAM_CLKH_VGCLK1, BRAM_CLKH_VGCLK2, BRAM_CLKH_VGCLK3, _1
);
inout	BRAM_CLKH_GCLK0;
inout	BRAM_CLKH_GCLK1;
inout	BRAM_CLKH_GCLK2;
inout	BRAM_CLKH_GCLK3;
inout	BRAM_CLKH_VGCLK0;
inout	BRAM_CLKH_VGCLK1;
inout	BRAM_CLKH_VGCLK2;
inout	BRAM_CLKH_VGCLK3;
inout	_1;

		INV1B0X35H1 inv_vgclk3(
											.OUT(BRAM_CLKH_VGCLK3),
											.IN(BRAM_CLKH_GCLK3)
		);

		INV1B0X35H1 inv_vgclk2(
											.OUT(BRAM_CLKH_VGCLK2),
											.IN(BRAM_CLKH_GCLK2)
		);

		INV1B0X35H1 inv_vgclk1(
											.OUT(BRAM_CLKH_VGCLK1),
											.IN(BRAM_CLKH_GCLK1)
		);

		INV1B0X35H1 inv_vgclk0(
											.OUT(BRAM_CLKH_VGCLK0),
											.IN(BRAM_CLKH_GCLK0)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_CLKR(
BRAM_CLKH_GCLK0, BRAM_CLKH_GCLK1, BRAM_CLKH_GCLK2, BRAM_CLKH_GCLK3, BRAM_CLKH_VGCLK0, BRAM_CLKH_VGCLK1, BRAM_CLKH_VGCLK2, BRAM_CLKH_VGCLK3, _1
);
inout	BRAM_CLKH_GCLK0;
inout	BRAM_CLKH_GCLK1;
inout	BRAM_CLKH_GCLK2;
inout	BRAM_CLKH_GCLK3;
inout	BRAM_CLKH_VGCLK0;
inout	BRAM_CLKH_VGCLK1;
inout	BRAM_CLKH_VGCLK2;
inout	BRAM_CLKH_VGCLK3;
inout	_1;

		INV1B0X35H1 inv_vgclk3(
											.OUT(BRAM_CLKH_VGCLK3),
											.IN(BRAM_CLKH_GCLK3)
		);

		INV1B0X35H1 inv_vgclk2(
											.OUT(BRAM_CLKH_VGCLK2),
											.IN(BRAM_CLKH_GCLK2)
		);

		INV1B0X35H1 inv_vgclk1(
											.OUT(BRAM_CLKH_VGCLK1),
											.IN(BRAM_CLKH_GCLK1)
		);

		INV1B0X35H1 inv_vgclk0(
											.OUT(BRAM_CLKH_VGCLK0),
											.IN(BRAM_CLKH_GCLK0)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_CLKV(
CLKV_VGCLK0, CLKV_VGCLK1, CLKV_VGCLK2, CLKV_VGCLK3, CLKV_GCLK_BUFL0, CLKV_GCLK_BUFL1, CLKV_GCLK_BUFL2, CLKV_GCLK_BUFL3, CLKV_GCLK_BUFR0, CLKV_GCLK_BUFR1, CLKV_GCLK_BUFR2, CLKV_GCLK_BUFR3, _1
);
inout	CLKV_VGCLK0;
inout	CLKV_VGCLK1;
inout	CLKV_VGCLK2;
inout	CLKV_VGCLK3;
inout	CLKV_GCLK_BUFL0;
inout	CLKV_GCLK_BUFL1;
inout	CLKV_GCLK_BUFL2;
inout	CLKV_GCLK_BUFL3;
inout	CLKV_GCLK_BUFR0;
inout	CLKV_GCLK_BUFR1;
inout	CLKV_GCLK_BUFR2;
inout	CLKV_GCLK_BUFR3;
inout	_1;

		SPBU1NAND1X35H1 spbu_gclk_bufr3(
											.OUT(CLKV_GCLK_BUFR3),
											.IN(CLKV_VGCLK3)
		);

		SPBU1NAND1X35H1 spbu_gclk_bufr2(
											.OUT(CLKV_GCLK_BUFR2),
											.IN(CLKV_VGCLK2)
		);

		SPBU1NAND1X35H1 spbu_gclk_bufr1(
											.OUT(CLKV_GCLK_BUFR1),
											.IN(CLKV_VGCLK1)
		);

		SPBU1NAND1X35H1 spbu_gclk_bufl1(
											.OUT(CLKV_GCLK_BUFL1),
											.IN(CLKV_VGCLK1)
		);

		SPBU1NAND1X35H1 spbu_gclk_bufl0(
											.OUT(CLKV_GCLK_BUFL0),
											.IN(CLKV_VGCLK0)
		);

		SPBU1NAND1X35H1 spbu_gclk_bufl3(
											.OUT(CLKV_GCLK_BUFL3),
											.IN(CLKV_VGCLK3)
		);

		SPBU1NAND1X35H1 spbu_gclk_bufl2(
											.OUT(CLKV_GCLK_BUFL2),
											.IN(CLKV_VGCLK2)
		);

		SPBU1NAND1X35H1 spbu_gclk_bufr0(
											.OUT(CLKV_GCLK_BUFR0),
											.IN(CLKV_VGCLK0)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_CLKT(
CLKT_H6E0, CLKT_H6E1, CLKT_H6E2, CLKT_H6E3, CLKT_H6A0, CLKT_H6A1, CLKT_H6A2, CLKT_H6A3, CLKT_H6B0, CLKT_H6B1, CLKT_H6B2, CLKT_H6B3, CLKT_H6M0, CLKT_H6M1, CLKT_H6M2, CLKT_H6M3, CLKT_H6C0, CLKT_H6C1, CLKT_H6C2, CLKT_H6C3, CLKT_H6D0, CLKT_H6D1, CLKT_H6D2, CLKT_H6D3, CLKT_LLH1, CLKT_LLH4, CLKT_LLH7, CLKT_LLH10, CLKT_GCLK2, CLKT_GCLK3, CLKT_VGCLK0, CLKT_VGCLK1, CLKT_VGCLK2, CLKT_VGCLK3, CLKT_HGCLK_E0, CLKT_HGCLK_E1, CLKT_HGCLK_E2, CLKT_HGCLK_E3, CLKT_HGCLK_W0, CLKT_HGCLK_W1, CLKT_HGCLK_W2, CLKT_HGCLK_W3, CLKT_CE0, CLKT_CE1, CLKT_GCLKBUF2_IN, CLKT_GCLKBUF3_IN, CLKT_GCLK2_PW, CLKT_GCLK3_PW, CLKT_CLKPAD0, CLKT_CLKPAD1, CLKT_CLK0R_1, CLKT_CLK180R_1, CLKT_CLK270R_1, CLKT_CLK2XR_1, CLKT_CLK90R_1, CLKT_CLKDVR_1, CLKT_CLKFBR_1, CLKT_CLKINR_1, CLKT_LOCKEDR_1, CLKT_CLK2X90R_1, CLKT_CLK0L_1, CLKT_CLK180L_1, CLKT_CLK270L_1, CLKT_CLK2XL_1, CLKT_CLK90L_1, CLKT_CLKDVL_1, CLKT_CLKFBL_1, CLKT_CLKINL_1, CLKT_LOCK_TL_1, CLKT_CLK2X90L_1, TOP_CLKINL, TOP_CLKFBL, TOP_CLKINR, TOP_CLKFBR, DLL3_RST_I, DLL3_RST_O, DLL2_RST_I, DLL2_RST_O, _1
);
inout	CLKT_H6E0;
inout	CLKT_H6E1;
inout	CLKT_H6E2;
inout	CLKT_H6E3;
inout	CLKT_H6A0;
inout	CLKT_H6A1;
inout	CLKT_H6A2;
inout	CLKT_H6A3;
inout	CLKT_H6B0;
inout	CLKT_H6B1;
inout	CLKT_H6B2;
inout	CLKT_H6B3;
inout	CLKT_H6M0;
inout	CLKT_H6M1;
inout	CLKT_H6M2;
inout	CLKT_H6M3;
inout	CLKT_H6C0;
inout	CLKT_H6C1;
inout	CLKT_H6C2;
inout	CLKT_H6C3;
inout	CLKT_H6D0;
inout	CLKT_H6D1;
inout	CLKT_H6D2;
inout	CLKT_H6D3;
inout	CLKT_LLH1;
inout	CLKT_LLH4;
inout	CLKT_LLH7;
inout	CLKT_LLH10;
inout	CLKT_GCLK2;
inout	CLKT_GCLK3;
inout	CLKT_VGCLK0;
inout	CLKT_VGCLK1;
inout	CLKT_VGCLK2;
inout	CLKT_VGCLK3;
inout	CLKT_HGCLK_E0;
inout	CLKT_HGCLK_E1;
inout	CLKT_HGCLK_E2;
inout	CLKT_HGCLK_E3;
inout	CLKT_HGCLK_W0;
inout	CLKT_HGCLK_W1;
inout	CLKT_HGCLK_W2;
inout	CLKT_HGCLK_W3;
inout	CLKT_CE0;
inout	CLKT_CE1;
inout	CLKT_GCLKBUF2_IN;
inout	CLKT_GCLKBUF3_IN;
inout	CLKT_GCLK2_PW;
inout	CLKT_GCLK3_PW;
inout	CLKT_CLKPAD0;
inout	CLKT_CLKPAD1;
inout	CLKT_CLK0R_1;
inout	CLKT_CLK180R_1;
inout	CLKT_CLK270R_1;
inout	CLKT_CLK2XR_1;
inout	CLKT_CLK90R_1;
inout	CLKT_CLKDVR_1;
inout	CLKT_CLKFBR_1;
inout	CLKT_CLKINR_1;
inout	CLKT_LOCKEDR_1;
inout	CLKT_CLK2X90R_1;
inout	CLKT_CLK0L_1;
inout	CLKT_CLK180L_1;
inout	CLKT_CLK270L_1;
inout	CLKT_CLK2XL_1;
inout	CLKT_CLK90L_1;
inout	CLKT_CLKDVL_1;
inout	CLKT_CLKFBL_1;
inout	CLKT_CLKINL_1;
inout	CLKT_LOCK_TL_1;
inout	CLKT_CLK2X90L_1;
inout	TOP_CLKINL;
inout	TOP_CLKFBL;
inout	TOP_CLKINR;
inout	TOP_CLKFBR;
inout	DLL3_RST_I;
inout	DLL3_RST_O;
inout	DLL2_RST_I;
inout	DLL2_RST_O;
inout	_1;
		wire		CLKT_IOFB0 ;
		wire		CLKT_IOFB1 ;

		SPS12N4X0H1 sps_ce0(
											.IN8(CLKT_H6E2),
											.IN9(CLKT_H6E3),
											.IN4(CLKT_H6C2),
											.IN5(CLKT_H6C3),
											.IN6(CLKT_H6D2),
											.IN7(CLKT_H6D3),
											.IN0(CLKT_H6A2),
											.IN1(CLKT_H6A3),
											.IN2(CLKT_H6B2),
											.IN3(CLKT_H6B3),
											.OUT(CLKT_CE0),
											.IN10(CLKT_H6M2),
											.IN11(CLKT_H6M3),
											._1(1)
		);

		SPS12N4X0H1 sps_ce1(
											.IN8(CLKT_H6E2),
											.IN9(CLKT_H6E3),
											.IN4(CLKT_H6C2),
											.IN5(CLKT_H6C3),
											.IN6(CLKT_H6D2),
											.IN7(CLKT_H6D3),
											.IN0(CLKT_H6A2),
											.IN1(CLKT_H6A3),
											.IN2(CLKT_H6B2),
											.IN3(CLKT_H6B3),
											.OUT(CLKT_CE1),
											.IN10(CLKT_H6M2),
											.IN11(CLKT_H6M3),
											._1(1)
		);

		SPBU1NAND1X35H1 spbu_hgclk_e3(
											.OUT(CLKT_HGCLK_E3),
											.IN(CLKT_VGCLK3)
		);

		SPBU1NAND1X35H1 spbu_hgclk_e2(
											.OUT(CLKT_HGCLK_E2),
											.IN(CLKT_VGCLK2)
		);

		SPBU1NAND1X35H1 spbu_hgclk_e1(
											.OUT(CLKT_HGCLK_E1),
											.IN(CLKT_VGCLK1)
		);

		SPBU1NAND1X35H1 spbu_hgclk_e0(
											.OUT(CLKT_HGCLK_E0),
											.IN(CLKT_VGCLK0)
		);

		SPBU1NAND1X35H1 spbu_gclk2(
											.OUT(CLKT_GCLK2),
											.IN(CLKT_GCLK2_PW)
		);

		SPBU1NAND1X35H1 spbu_gclk3(
											.OUT(CLKT_GCLK3),
											.IN(CLKT_GCLK3_PW)
		);

		SPS20T6X11H1 sps_h6e2(
											.IN8(CLKT_CLK270R_1),
											.IN9(CLKT_CLK270L_1),
											.IN4(CLKT_CLK90R_1),
											.IN5(CLKT_CLK90L_1),
											.IN6(CLKT_CLK180R_1),
											.IN7(CLKT_CLK180L_1),
											.IN0(CLKT_CLKDVR_1),
											.IN1(CLKT_CLKDVL_1),
											.IN2(CLKT_CLK0R_1),
											.IN3(CLKT_CLK0L_1),
											.IN11(CLKT_CLK2XL_1),
											.IN18(CLKT_LOCKEDR_1),
											.IN19(CLKT_LOCK_TL_1),
											.IN16(CLKT_GCLK2_PW),
											.IN17(CLKT_GCLK3_PW),
											.IN14(CLKT_CLKPAD0),
											.IN15(CLKT_CLKPAD1),
											.IN12(CLKT_CLK2X90R_1),
											.IN13(CLKT_CLK2X90L_1),
											.IN10(CLKT_CLK2XR_1),
											.OUT(CLKT_H6E2),
											._1(1)
		);

		SPS20T6X11H1 sps_h6e3(
											.IN8(CLKT_CLK270R_1),
											.IN9(CLKT_CLK270L_1),
											.IN4(CLKT_CLK90R_1),
											.IN5(CLKT_CLK90L_1),
											.IN6(CLKT_CLK180R_1),
											.IN7(CLKT_CLK180L_1),
											.IN0(CLKT_CLKDVR_1),
											.IN1(CLKT_CLKDVL_1),
											.IN2(CLKT_CLK0R_1),
											.IN3(CLKT_CLK0L_1),
											.IN11(CLKT_CLK2XL_1),
											.IN18(CLKT_LOCKEDR_1),
											.IN19(CLKT_LOCK_TL_1),
											.IN16(CLKT_GCLK2_PW),
											.IN17(CLKT_GCLK3_PW),
											.IN14(CLKT_CLKPAD0),
											.IN15(CLKT_CLKPAD1),
											.IN12(CLKT_CLK2X90R_1),
											.IN13(CLKT_CLK2X90L_1),
											.IN10(CLKT_CLK2XR_1),
											.OUT(CLKT_H6E3),
											._1(1)
		);

		SPS20T6X11H1 sps_h6e0(
											.IN8(CLKT_CLK270R_1),
											.IN9(CLKT_CLK270L_1),
											.IN4(CLKT_CLK90R_1),
											.IN5(CLKT_CLK90L_1),
											.IN6(CLKT_CLK180R_1),
											.IN7(CLKT_CLK180L_1),
											.IN0(CLKT_CLKDVR_1),
											.IN1(CLKT_CLKDVL_1),
											.IN2(CLKT_CLK0R_1),
											.IN3(CLKT_CLK0L_1),
											.OUT(CLKT_H6E0),
											.IN18(CLKT_LOCKEDR_1),
											.IN19(CLKT_LOCK_TL_1),
											.IN16(CLKT_GCLK2_PW),
											.IN17(CLKT_GCLK3_PW),
											.IN14(CLKT_CLKPAD0),
											.IN15(CLKT_CLKPAD1),
											.IN12(CLKT_CLK2X90R_1),
											.IN13(CLKT_CLK2X90L_1),
											.IN10(CLKT_CLK2XR_1),
											.IN11(CLKT_CLK2XL_1),
											._1(1)
		);

		SPS20T6X11H1 sps_h6e1(
											.IN8(CLKT_CLK270R_1),
											.IN9(CLKT_CLK270L_1),
											.IN4(CLKT_CLK90R_1),
											.IN5(CLKT_CLK90L_1),
											.IN6(CLKT_CLK180R_1),
											.IN7(CLKT_CLK180L_1),
											.IN0(CLKT_CLKDVR_1),
											.IN1(CLKT_CLKDVL_1),
											.IN2(CLKT_CLK0R_1),
											.IN3(CLKT_CLK0L_1),
											.OUT(CLKT_H6E1),
											.IN18(CLKT_LOCKEDR_1),
											.IN19(CLKT_LOCK_TL_1),
											.IN16(CLKT_GCLK2_PW),
											.IN17(CLKT_GCLK3_PW),
											.IN14(CLKT_CLKPAD0),
											.IN15(CLKT_CLKPAD1),
											.IN12(CLKT_CLK2X90R_1),
											.IN13(CLKT_CLK2X90L_1),
											.IN10(CLKT_CLK2XR_1),
											.IN11(CLKT_CLK2XL_1),
											._1(1)
		);

		SPBU1NAND1X35H1 spbu_hgclk_w1(
											.OUT(CLKT_HGCLK_W1),
											.IN(CLKT_VGCLK1)
		);

		SPBU1NAND1X35H1 spbu_hgclk_w0(
											.OUT(CLKT_HGCLK_W0),
											.IN(CLKT_VGCLK0)
		);

		SPBU1NAND1X35H1 spbu_hgclk_w3(
											.OUT(CLKT_HGCLK_W3),
											.IN(CLKT_VGCLK3)
		);

		SPBU1NAND1X35H1 spbu_hgclk_w2(
											.OUT(CLKT_HGCLK_W2),
											.IN(CLKT_VGCLK2)
		);

		SPS20T6X11H1 sps_llh7(
											.IN8(CLKT_CLK270R_1),
											.IN9(CLKT_CLK270L_1),
											.IN4(CLKT_CLK90R_1),
											.IN5(CLKT_CLK90L_1),
											.IN6(CLKT_CLK180R_1),
											.IN7(CLKT_CLK180L_1),
											.IN0(CLKT_CLKDVR_1),
											.IN1(CLKT_CLKDVL_1),
											.IN2(CLKT_CLK0R_1),
											.IN3(CLKT_CLK0L_1),
											.OUT(CLKT_LLH7),
											.IN18(CLKT_LOCKEDR_1),
											.IN19(CLKT_LOCK_TL_1),
											.IN16(CLKT_GCLK2_PW),
											.IN17(CLKT_GCLK3_PW),
											.IN14(CLKT_CLKPAD0),
											.IN15(CLKT_CLKPAD1),
											.IN12(CLKT_CLK2X90R_1),
											.IN13(CLKT_CLK2X90L_1),
											.IN10(CLKT_CLK2XR_1),
											.IN11(CLKT_CLK2XL_1),
											._1(1)
		);

		SPS28B6X2H1 sps_gclkbuf2_in(
											.IN8(CLKT_CLK270R_1),
											.IN9(CLKT_CLK270L_1),
											.IN4(CLKT_CLK90R_1),
											.IN5(CLKT_CLK90L_1),
											.IN6(CLKT_CLK180R_1),
											.IN7(CLKT_CLK180L_1),
											.IN0(CLKT_CLKDVR_1),
											.IN1(CLKT_CLKDVL_1),
											.IN2(CLKT_CLK0R_1),
											.IN3(CLKT_CLK0L_1),
											.IN18(CLKT_H6B0),
											.IN19(CLKT_H6B1),
											.IN16(CLKT_H6A0),
											.IN17(CLKT_H6A1),
											.IN14(CLKT_CLKPAD0),
											.IN15(CLKT_CLKPAD1),
											.IN12(CLKT_CLK2X90R_1),
											.IN13(CLKT_CLK2X90L_1),
											.IN10(CLKT_CLK2XR_1),
											.IN11(CLKT_CLK2XL_1),
											.OUT(CLKT_GCLKBUF2_IN),
											.IN23(CLKT_H6D1),
											.IN22(CLKT_H6D0),
											.IN21(CLKT_H6C1),
											.IN20(CLKT_H6C0),
											.IN27(CLKT_H6M1),
											.IN26(CLKT_H6M0),
											.IN25(CLKT_H6E1),
											.IN24(CLKT_H6E0),
											._1(1)
		);

		SPS20T6X11H1 sps_llh4(
											.IN8(CLKT_CLK270R_1),
											.IN9(CLKT_CLK270L_1),
											.IN4(CLKT_CLK90R_1),
											.IN5(CLKT_CLK90L_1),
											.IN6(CLKT_CLK180R_1),
											.IN7(CLKT_CLK180L_1),
											.IN0(CLKT_CLKDVR_1),
											.IN1(CLKT_CLKDVL_1),
											.IN2(CLKT_CLK0R_1),
											.IN3(CLKT_CLK0L_1),
											.OUT(CLKT_LLH4),
											.IN18(CLKT_LOCKEDR_1),
											.IN19(CLKT_LOCK_TL_1),
											.IN16(CLKT_GCLK2_PW),
											.IN17(CLKT_GCLK3_PW),
											.IN14(CLKT_CLKPAD0),
											.IN15(CLKT_CLKPAD1),
											.IN12(CLKT_CLK2X90R_1),
											.IN13(CLKT_CLK2X90L_1),
											.IN10(CLKT_CLK2XR_1),
											.IN11(CLKT_CLK2XL_1),
											._1(1)
		);

		SPS20T6X11H1 sps_llh1(
											.IN8(CLKT_CLK270R_1),
											.IN9(CLKT_CLK270L_1),
											.IN4(CLKT_CLK90R_1),
											.IN5(CLKT_CLK90L_1),
											.IN6(CLKT_CLK180R_1),
											.IN7(CLKT_CLK180L_1),
											.IN0(CLKT_CLKDVR_1),
											.IN1(CLKT_CLKDVL_1),
											.IN2(CLKT_CLK0R_1),
											.IN3(CLKT_CLK0L_1),
											.OUT(CLKT_LLH1),
											.IN18(CLKT_LOCKEDR_1),
											.IN19(CLKT_LOCK_TL_1),
											.IN16(CLKT_GCLK2_PW),
											.IN17(CLKT_GCLK3_PW),
											.IN14(CLKT_CLKPAD0),
											.IN15(CLKT_CLKPAD1),
											.IN12(CLKT_CLK2X90R_1),
											.IN13(CLKT_CLK2X90L_1),
											.IN10(CLKT_CLK2XR_1),
											.IN11(CLKT_CLK2XL_1),
											._1(1)
		);

		SPS6B3X4H1 sps_clkfbl(
											.IN4(CLKT_CLK2XL_1),
											.IN5(TOP_CLKFBL),
											.IN0(CLKT_CLKPAD0),
											.IN1(CLKT_CLKPAD1),
											.IN2(CLKT_IOFB0),
											.IN3(CLKT_IOFB1),
											.OUT(CLKT_CLKFBL_1),
											._1(1)
		);

		SPS5B3X4H1 sps_clkinr(
											.IN4(TOP_CLKINR),
											.IN0(CLKT_CLKPAD0),
											.IN1(CLKT_CLKPAD1),
											.IN2(CLKT_IOFB0),
											.IN3(CLKT_IOFB1),
											.OUT(CLKT_CLKINR_1),
											._1(1)
		);

		SPS20T6X11H1 sps_llh10(
											.IN8(CLKT_CLK270R_1),
											.IN9(CLKT_CLK270L_1),
											.IN4(CLKT_CLK90R_1),
											.IN5(CLKT_CLK90L_1),
											.IN6(CLKT_CLK180R_1),
											.IN7(CLKT_CLK180L_1),
											.IN0(CLKT_CLKDVR_1),
											.IN1(CLKT_CLKDVL_1),
											.IN2(CLKT_CLK0R_1),
											.IN3(CLKT_CLK0L_1),
											.OUT(CLKT_LLH10),
											.IN18(CLKT_LOCKEDR_1),
											.IN19(CLKT_LOCK_TL_1),
											.IN16(CLKT_GCLK2_PW),
											.IN17(CLKT_GCLK3_PW),
											.IN14(CLKT_CLKPAD0),
											.IN15(CLKT_CLKPAD1),
											.IN12(CLKT_CLK2X90R_1),
											.IN13(CLKT_CLK2X90L_1),
											.IN10(CLKT_CLK2XR_1),
											.IN11(CLKT_CLK2XL_1),
											._1(1)
		);

		SPS20T6X11H1 sps_h6d1(
											.IN8(CLKT_CLK270R_1),
											.IN9(CLKT_CLK270L_1),
											.IN4(CLKT_CLK90R_1),
											.IN5(CLKT_CLK90L_1),
											.IN6(CLKT_CLK180R_1),
											.IN7(CLKT_CLK180L_1),
											.IN0(CLKT_CLKDVR_1),
											.IN1(CLKT_CLKDVL_1),
											.IN2(CLKT_CLK0R_1),
											.IN3(CLKT_CLK0L_1),
											.OUT(CLKT_H6D1),
											.IN18(CLKT_LOCKEDR_1),
											.IN19(CLKT_LOCK_TL_1),
											.IN16(CLKT_GCLK2_PW),
											.IN17(CLKT_GCLK3_PW),
											.IN14(CLKT_CLKPAD0),
											.IN15(CLKT_CLKPAD1),
											.IN12(CLKT_CLK2X90R_1),
											.IN13(CLKT_CLK2X90L_1),
											.IN10(CLKT_CLK2XR_1),
											.IN11(CLKT_CLK2XL_1),
											._1(1)
		);

		SPS20T6X11H1 sps_h6d0(
											.IN8(CLKT_CLK270R_1),
											.IN9(CLKT_CLK270L_1),
											.IN4(CLKT_CLK90R_1),
											.IN5(CLKT_CLK90L_1),
											.IN6(CLKT_CLK180R_1),
											.IN7(CLKT_CLK180L_1),
											.IN0(CLKT_CLKDVR_1),
											.IN1(CLKT_CLKDVL_1),
											.IN2(CLKT_CLK0R_1),
											.IN3(CLKT_CLK0L_1),
											.OUT(CLKT_H6D0),
											.IN18(CLKT_LOCKEDR_1),
											.IN19(CLKT_LOCK_TL_1),
											.IN16(CLKT_GCLK2_PW),
											.IN17(CLKT_GCLK3_PW),
											.IN14(CLKT_CLKPAD0),
											.IN15(CLKT_CLKPAD1),
											.IN12(CLKT_CLK2X90R_1),
											.IN13(CLKT_CLK2X90L_1),
											.IN10(CLKT_CLK2XR_1),
											.IN11(CLKT_CLK2XL_1),
											._1(1)
		);

		SPS20T6X11H1 sps_h6d3(
											.IN8(CLKT_CLK270R_1),
											.IN9(CLKT_CLK270L_1),
											.IN4(CLKT_CLK90R_1),
											.IN5(CLKT_CLK90L_1),
											.IN6(CLKT_CLK180R_1),
											.IN7(CLKT_CLK180L_1),
											.IN0(CLKT_CLKDVR_1),
											.IN1(CLKT_CLKDVL_1),
											.IN2(CLKT_CLK0R_1),
											.IN3(CLKT_CLK0L_1),
											.IN11(CLKT_CLK2XL_1),
											.IN18(CLKT_LOCKEDR_1),
											.IN19(CLKT_LOCK_TL_1),
											.IN16(CLKT_GCLK2_PW),
											.IN17(CLKT_GCLK3_PW),
											.IN14(CLKT_CLKPAD0),
											.IN15(CLKT_CLKPAD1),
											.IN12(CLKT_CLK2X90R_1),
											.IN13(CLKT_CLK2X90L_1),
											.IN10(CLKT_CLK2XR_1),
											.OUT(CLKT_H6D3),
											._1(1)
		);

		SPS20T6X11H1 sps_h6d2(
											.IN8(CLKT_CLK270R_1),
											.IN9(CLKT_CLK270L_1),
											.IN4(CLKT_CLK90R_1),
											.IN5(CLKT_CLK90L_1),
											.IN6(CLKT_CLK180R_1),
											.IN7(CLKT_CLK180L_1),
											.IN0(CLKT_CLKDVR_1),
											.IN1(CLKT_CLKDVL_1),
											.IN2(CLKT_CLK0R_1),
											.IN3(CLKT_CLK0L_1),
											.IN11(CLKT_CLK2XL_1),
											.IN18(CLKT_LOCKEDR_1),
											.IN19(CLKT_LOCK_TL_1),
											.IN16(CLKT_GCLK2_PW),
											.IN17(CLKT_GCLK3_PW),
											.IN14(CLKT_CLKPAD0),
											.IN15(CLKT_CLKPAD1),
											.IN12(CLKT_CLK2X90R_1),
											.IN13(CLKT_CLK2X90L_1),
											.IN10(CLKT_CLK2XR_1),
											.OUT(CLKT_H6D2),
											._1(1)
		);

		SPS28B6X2H1 sps_gclkbuf3_in(
											.IN8(CLKT_CLK270R_1),
											.IN9(CLKT_CLK270L_1),
											.IN4(CLKT_CLK90R_1),
											.IN5(CLKT_CLK90L_1),
											.IN6(CLKT_CLK180R_1),
											.IN7(CLKT_CLK180L_1),
											.IN0(CLKT_CLKDVR_1),
											.IN1(CLKT_CLKDVL_1),
											.IN2(CLKT_CLK0R_1),
											.IN3(CLKT_CLK0L_1),
											.IN18(CLKT_H6B0),
											.IN19(CLKT_H6B1),
											.IN16(CLKT_H6A0),
											.IN17(CLKT_H6A1),
											.IN14(CLKT_CLKPAD0),
											.IN15(CLKT_CLKPAD1),
											.IN12(CLKT_CLK2X90R_1),
											.IN13(CLKT_CLK2X90L_1),
											.IN10(CLKT_CLK2XR_1),
											.IN11(CLKT_CLK2XL_1),
											.OUT(CLKT_GCLKBUF3_IN),
											.IN23(CLKT_H6D1),
											.IN22(CLKT_H6D0),
											.IN21(CLKT_H6C1),
											.IN20(CLKT_H6C0),
											.IN27(CLKT_H6M1),
											.IN26(CLKT_H6M0),
											.IN25(CLKT_H6E1),
											.IN24(CLKT_H6E0),
											._1(1)
		);

		SPS5B3X4H1 sps_clkinl(
											.IN4(TOP_CLKINL),
											.IN0(CLKT_CLKPAD0),
											.IN1(CLKT_CLKPAD1),
											.IN2(CLKT_IOFB0),
											.IN3(CLKT_IOFB1),
											.OUT(CLKT_CLKINL_1),
											._1(1)
		);

		SPS6B3X4H1 sps_clkfbr(
											.IN4(CLKT_CLK2XR_1),
											.IN5(TOP_CLKFBR),
											.IN0(CLKT_CLKPAD0),
											.IN1(CLKT_CLKPAD1),
											.IN2(CLKT_IOFB0),
											.IN3(CLKT_IOFB1),
											.OUT(CLKT_CLKFBR_1),
											._1(1)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_RCKB(
BRAM_BOT_H6E0, BRAM_BOT_H6A0, BRAM_BOT_H6B0, BRAM_BOT_H6M0, BRAM_BOT_H6C0, BRAM_BOT_H6D0, BRAM_BOT_H6E1, BRAM_BOT_H6A1, BRAM_BOT_H6B1, BRAM_BOT_H6M1, BRAM_BOT_H6C1, BRAM_BOT_H6D1, BRAM_BOT_H6E2, BRAM_BOT_H6A2, BRAM_BOT_H6B2, BRAM_BOT_H6M2, BRAM_BOT_H6C2, BRAM_BOT_H6D2, BRAM_BOT_H6E3, BRAM_BOT_H6A3, BRAM_BOT_H6B3, BRAM_BOT_H6M3, BRAM_BOT_H6C3, BRAM_BOT_H6D3, BRAM_BOT_H6E4, BRAM_BOT_H6A4, BRAM_BOT_H6B4, BRAM_BOT_H6M4, BRAM_BOT_H6C4, BRAM_BOT_H6D4, BRAM_BOT_H6E5, BRAM_BOT_H6A5, BRAM_BOT_H6B5, BRAM_BOT_H6M5, BRAM_BOT_H6C5, BRAM_BOT_H6D5, BRAM_BOT_VGCLK0, BRAM_BOT_VGCLK1, BRAM_BOT_VGCLK2, BRAM_BOT_VGCLK3, BRAM_BOT_GCLKE0, BRAM_BOT_GCLKE1, BRAM_BOT_GCLKE2, BRAM_BOT_GCLKE3, BRAM_BOT_GCLKW0, BRAM_BOT_GCLKW1, BRAM_BOT_GCLKW2, BRAM_BOT_GCLKW3, BRAM_BOT_RLLV0, BRAM_BOT_RLLV1, BRAM_BOT_RLLV2, BRAM_BOT_RLLV3, BRAM_BOT_RLLV4, BRAM_BOT_RLLV5, BRAM_BOT_RLLV6, BRAM_BOT_RLLV7, BRAM_BOT_RLLV8, BRAM_BOT_RLLV9, BRAM_BOT_RLLV10, BRAM_BOT_RLLV11, BRAM_BOT_RST_1, BRAM_BOT_CLKFB_1, BRAM_BOT_CLKIN_1, _1
);
inout	BRAM_BOT_H6E0;
inout	BRAM_BOT_H6A0;
inout	BRAM_BOT_H6B0;
inout	BRAM_BOT_H6M0;
inout	BRAM_BOT_H6C0;
inout	BRAM_BOT_H6D0;
inout	BRAM_BOT_H6E1;
inout	BRAM_BOT_H6A1;
inout	BRAM_BOT_H6B1;
inout	BRAM_BOT_H6M1;
inout	BRAM_BOT_H6C1;
inout	BRAM_BOT_H6D1;
inout	BRAM_BOT_H6E2;
inout	BRAM_BOT_H6A2;
inout	BRAM_BOT_H6B2;
inout	BRAM_BOT_H6M2;
inout	BRAM_BOT_H6C2;
inout	BRAM_BOT_H6D2;
inout	BRAM_BOT_H6E3;
inout	BRAM_BOT_H6A3;
inout	BRAM_BOT_H6B3;
inout	BRAM_BOT_H6M3;
inout	BRAM_BOT_H6C3;
inout	BRAM_BOT_H6D3;
inout	BRAM_BOT_H6E4;
inout	BRAM_BOT_H6A4;
inout	BRAM_BOT_H6B4;
inout	BRAM_BOT_H6M4;
inout	BRAM_BOT_H6C4;
inout	BRAM_BOT_H6D4;
inout	BRAM_BOT_H6E5;
inout	BRAM_BOT_H6A5;
inout	BRAM_BOT_H6B5;
inout	BRAM_BOT_H6M5;
inout	BRAM_BOT_H6C5;
inout	BRAM_BOT_H6D5;
inout	BRAM_BOT_VGCLK0;
inout	BRAM_BOT_VGCLK1;
inout	BRAM_BOT_VGCLK2;
inout	BRAM_BOT_VGCLK3;
inout	BRAM_BOT_GCLKE0;
inout	BRAM_BOT_GCLKE1;
inout	BRAM_BOT_GCLKE2;
inout	BRAM_BOT_GCLKE3;
inout	BRAM_BOT_GCLKW0;
inout	BRAM_BOT_GCLKW1;
inout	BRAM_BOT_GCLKW2;
inout	BRAM_BOT_GCLKW3;
inout	BRAM_BOT_RLLV0;
inout	BRAM_BOT_RLLV1;
inout	BRAM_BOT_RLLV2;
inout	BRAM_BOT_RLLV3;
inout	BRAM_BOT_RLLV4;
inout	BRAM_BOT_RLLV5;
inout	BRAM_BOT_RLLV6;
inout	BRAM_BOT_RLLV7;
inout	BRAM_BOT_RLLV8;
inout	BRAM_BOT_RLLV9;
inout	BRAM_BOT_RLLV10;
inout	BRAM_BOT_RLLV11;
inout	BRAM_BOT_RST_1;
inout	BRAM_BOT_CLKFB_1;
inout	BRAM_BOT_CLKIN_1;
inout	_1;

		SPS28B11X11H2 sps_clkin(
											.IN8(BRAM_BOT_RLLV3),
											.IN9(BRAM_BOT_RLLV1),
											.IN4(BRAM_BOT_H6C0),
											.IN5(BRAM_BOT_H6D0),
											.IN6(BRAM_BOT_GCLKE0),
											.IN7(BRAM_BOT_RLLV5),
											.IN0(BRAM_BOT_H6E0),
											.IN1(BRAM_BOT_H6A0),
											.IN2(BRAM_BOT_H6B0),
											.IN3(BRAM_BOT_H6M0),
											.IN18(BRAM_BOT_RLLV8),
											.IN19(BRAM_BOT_RLLV6),
											.IN16(BRAM_BOT_RLLV0),
											.IN17(BRAM_BOT_RLLV10),
											.IN14(BRAM_BOT_RLLV4),
											.IN15(BRAM_BOT_RLLV2),
											.IN12(BRAM_BOT_RLLV7),
											.IN13(BRAM_BOT_GCLKE1),
											.IN10(BRAM_BOT_RLLV11),
											.IN11(BRAM_BOT_RLLV9),
											.OUT(BRAM_BOT_CLKIN_1),
											.IN23(BRAM_BOT_H6B1),
											.IN22(BRAM_BOT_H6A1),
											.IN21(BRAM_BOT_H6E1),
											.IN20(BRAM_BOT_GCLKE2),
											.IN27(BRAM_BOT_GCLKE3),
											.IN26(BRAM_BOT_H6D1),
											.IN25(BRAM_BOT_H6C1),
											.IN24(BRAM_BOT_H6M1),
											._1(1)
		);

		SPS12B8X11H1 sps_rst(
											.IN8(BRAM_BOT_H6B3),
											.IN9(BRAM_BOT_H6M3),
											.IN4(BRAM_BOT_H6C2),
											.IN5(BRAM_BOT_H6D2),
											.IN6(BRAM_BOT_H6E3),
											.IN7(BRAM_BOT_H6A3),
											.IN0(BRAM_BOT_H6E2),
											.IN1(BRAM_BOT_H6A2),
											.IN2(BRAM_BOT_H6B2),
											.IN3(BRAM_BOT_H6M2),
											.OUT(BRAM_BOT_RST_1),
											.IN10(BRAM_BOT_H6C3),
											.IN11(BRAM_BOT_H6D3),
											._1(1)
		);

		SPBU1NAND1X35H1 spbu_gclke0(
											.IN(BRAM_BOT_VGCLK0),
											.OUT(BRAM_BOT_GCLKE0)
		);

		SPBU1NAND1X35H1 spbu_gclke1(
											.IN(BRAM_BOT_VGCLK1),
											.OUT(BRAM_BOT_GCLKE1)
		);

		SPBU1NAND1X35H1 spbu_gclke2(
											.IN(BRAM_BOT_VGCLK2),
											.OUT(BRAM_BOT_GCLKE2)
		);

		SPBU1NAND1X35H1 spbu_gclke3(
											.IN(BRAM_BOT_VGCLK3),
											.OUT(BRAM_BOT_GCLKE3)
		);

		SPS1T1X7H1 sps_rllv10(
											.OUT(BRAM_BOT_RLLV10),
											.IN(BRAM_BOT_H6A4)
		);

		SPS1T1X7H1 sps_rllv11(
											.OUT(BRAM_BOT_RLLV11),
											.IN(BRAM_BOT_H6E4)
		);

		SPS28B11X11H2 sps_clkfb(
											.IN8(BRAM_BOT_RLLV3),
											.IN9(BRAM_BOT_RLLV1),
											.IN4(BRAM_BOT_H6C0),
											.IN5(BRAM_BOT_H6D0),
											.IN6(BRAM_BOT_GCLKE0),
											.IN7(BRAM_BOT_RLLV5),
											.IN0(BRAM_BOT_H6E0),
											.IN1(BRAM_BOT_H6A0),
											.IN2(BRAM_BOT_H6B0),
											.IN3(BRAM_BOT_H6M0),
											.IN18(BRAM_BOT_RLLV8),
											.IN19(BRAM_BOT_RLLV6),
											.IN16(BRAM_BOT_RLLV0),
											.IN17(BRAM_BOT_RLLV10),
											.IN14(BRAM_BOT_RLLV4),
											.IN15(BRAM_BOT_RLLV2),
											.IN12(BRAM_BOT_RLLV7),
											.IN13(BRAM_BOT_GCLKE1),
											.IN10(BRAM_BOT_RLLV11),
											.IN11(BRAM_BOT_RLLV9),
											.OUT(BRAM_BOT_CLKFB_1),
											.IN23(BRAM_BOT_H6B1),
											.IN22(BRAM_BOT_H6A1),
											.IN21(BRAM_BOT_H6E1),
											.IN20(BRAM_BOT_GCLKE2),
											.IN27(BRAM_BOT_GCLKE3),
											.IN26(BRAM_BOT_H6D1),
											.IN25(BRAM_BOT_H6C1),
											.IN24(BRAM_BOT_H6M1),
											._1(1)
		);

		SPS1T1X7H1 sps_rllv0(
											.OUT(BRAM_BOT_RLLV0),
											.IN(BRAM_BOT_H6D5)
		);

		SPS1T1X7H1 sps_rllv1(
											.OUT(BRAM_BOT_RLLV1),
											.IN(BRAM_BOT_H6C5)
		);

		SPS1T1X7H1 sps_rllv2(
											.OUT(BRAM_BOT_RLLV2),
											.IN(BRAM_BOT_H6M5)
		);

		SPBU1NAND1X35H1 spbu_gclkw1(
											.OUT(BRAM_BOT_GCLKW1),
											.IN(BRAM_BOT_VGCLK1)
		);

		SPS1T1X7H1 sps_rllv4(
											.OUT(BRAM_BOT_RLLV4),
											.IN(BRAM_BOT_H6A5)
		);

		SPS1T1X7H1 sps_rllv5(
											.OUT(BRAM_BOT_RLLV5),
											.IN(BRAM_BOT_H6E5)
		);

		SPS1T1X7H1 sps_rllv6(
											.OUT(BRAM_BOT_RLLV6),
											.IN(BRAM_BOT_H6D4)
		);

		SPS1T1X7H1 sps_rllv7(
											.OUT(BRAM_BOT_RLLV7),
											.IN(BRAM_BOT_H6C4)
		);

		SPS1T1X7H1 sps_rllv8(
											.OUT(BRAM_BOT_RLLV8),
											.IN(BRAM_BOT_H6M4)
		);

		SPS1T1X7H1 sps_rllv9(
											.OUT(BRAM_BOT_RLLV9),
											.IN(BRAM_BOT_H6B4)
		);

		SPBU1NAND1X35H1 spbu_gclkw2(
											.OUT(BRAM_BOT_GCLKW2),
											.IN(BRAM_BOT_VGCLK2)
		);

		SPBU1NAND1X35H1 spbu_gclkw3(
											.OUT(BRAM_BOT_GCLKW3),
											.IN(BRAM_BOT_VGCLK3)
		);

		SPBU1NAND1X35H1 spbu_gclkw0(
											.OUT(BRAM_BOT_GCLKW0),
											.IN(BRAM_BOT_VGCLK0)
		);

		SPS1T1X7H1 sps_rllv3(
											.OUT(BRAM_BOT_RLLV3),
											.IN(BRAM_BOT_H6B5)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_CNT(
E0, E1, E2, E3, E4, E5, E6, E7, E8, E9, E10, E11, E12, E13, E14, E15, E16, E17, E18, E19, E20, E21, E22, E23, N0, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17, N18, N19, N20, N21, N22, N23, W0, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13, W14, W15, W16, W17, W18, W19, W20, W21, W22, W23, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21, S22, S23, H6E0, H6E1, H6E2, H6E3, H6E4, H6E5, H6E6, H6E7, H6E8, H6E9, H6E10, H6E11, H6M0, H6M1, H6M2, H6M3, H6M4, H6M5, H6M6, H6M7, H6M8, H6M9, H6M10, H6M11, H6W0, H6W1, H6W2, H6W3, H6W4, H6W5, H6W6, H6W7, H6W8, H6W9, H6W10, H6W11, LLH0, LLH6, GCLK3, GCLK2, GCLK1, GCLK0, OUT0, OUT1, OUT6, OUT7, OUT_W0, OUT_W1, OUT_E6, OUT_E7, TBUF0, TBUF1, TBUF2, TBUF3, TBUF_STUB3, V6N0, V6N1, V6N2, V6N3, V6N4, V6N5, V6N6, V6N7, V6N8, V6N9, V6N10, V6N11, V6M0, V6M1, V6M2, V6M3, V6M4, V6M5, V6M6, V6M7, V6M8, V6M9, V6M10, V6M11, V6S0, V6S1, V6S2, V6S3, V6S4, V6S5, V6S6, V6S7, V6S8, V6S9, V6S10, V6S11, V6A0, V6A1, V6A2, V6A3, V6B0, V6B1, V6B2, V6B3, V6C0, V6C1, V6C2, V6C3, V6D0, V6D1, V6D2, V6D3, LLV0, LLV6, S0_F_B1, S0_F_B2, S0_F_B3, S0_F_B4, S0_G_B1, S0_G_B2, S0_G_B3, S0_G_B4, S0_BX_B, S0_BY_B, S0_CE_B, S0_CLK_B, S0_SR_B, S0_X, S0_XB, S0_Y, S0_YB, S0_XQ, S0_YQ, CO_0_LOCAL, CO_0, S0_F5, S0_F5IN, S1_F_B1, S1_F_B2, S1_F_B3, S1_F_B4, S1_G_B1, S1_G_B2, S1_G_B3, S1_G_B4, S1_BX_B, S1_BY_B, S1_CE_B, S1_CLK_B, S1_SR_B, S1_X, S1_XB, S1_Y, S1_YB, S1_XQ, S1_YQ, TS_B0, TS_B1, CO_1_LOCAL, CO_1, S1_F5, S1_F5IN, TBUF_OUT0, TBUF_OUT1, T_IN0, T_IN1, CIN_0_I, CIN_0_O, CIN_1_I, CIN_1_O, _1
);
inout	E0;
inout	E1;
inout	E2;
inout	E3;
inout	E4;
inout	E5;
inout	E6;
inout	E7;
inout	E8;
inout	E9;
inout	E10;
inout	E11;
inout	E12;
inout	E13;
inout	E14;
inout	E15;
inout	E16;
inout	E17;
inout	E18;
inout	E19;
inout	E20;
inout	E21;
inout	E22;
inout	E23;
inout	N0;
inout	N1;
inout	N2;
inout	N3;
inout	N4;
inout	N5;
inout	N6;
inout	N7;
inout	N8;
inout	N9;
inout	N10;
inout	N11;
inout	N12;
inout	N13;
inout	N14;
inout	N15;
inout	N16;
inout	N17;
inout	N18;
inout	N19;
inout	N20;
inout	N21;
inout	N22;
inout	N23;
inout	W0;
inout	W1;
inout	W2;
inout	W3;
inout	W4;
inout	W5;
inout	W6;
inout	W7;
inout	W8;
inout	W9;
inout	W10;
inout	W11;
inout	W12;
inout	W13;
inout	W14;
inout	W15;
inout	W16;
inout	W17;
inout	W18;
inout	W19;
inout	W20;
inout	W21;
inout	W22;
inout	W23;
inout	S0;
inout	S1;
inout	S2;
inout	S3;
inout	S4;
inout	S5;
inout	S6;
inout	S7;
inout	S8;
inout	S9;
inout	S10;
inout	S11;
inout	S12;
inout	S13;
inout	S14;
inout	S15;
inout	S16;
inout	S17;
inout	S18;
inout	S19;
inout	S20;
inout	S21;
inout	S22;
inout	S23;
inout	H6E0;
inout	H6E1;
inout	H6E2;
inout	H6E3;
inout	H6E4;
inout	H6E5;
inout	H6E6;
inout	H6E7;
inout	H6E8;
inout	H6E9;
inout	H6E10;
inout	H6E11;
inout	H6M0;
inout	H6M1;
inout	H6M2;
inout	H6M3;
inout	H6M4;
inout	H6M5;
inout	H6M6;
inout	H6M7;
inout	H6M8;
inout	H6M9;
inout	H6M10;
inout	H6M11;
inout	H6W0;
inout	H6W1;
inout	H6W2;
inout	H6W3;
inout	H6W4;
inout	H6W5;
inout	H6W6;
inout	H6W7;
inout	H6W8;
inout	H6W9;
inout	H6W10;
inout	H6W11;
inout	LLH0;
inout	LLH6;
inout	GCLK3;
inout	GCLK2;
inout	GCLK1;
inout	GCLK0;
inout	OUT0;
inout	OUT1;
inout	OUT6;
inout	OUT7;
inout	OUT_W0;
inout	OUT_W1;
inout	OUT_E6;
inout	OUT_E7;
inout	TBUF0;
inout	TBUF1;
inout	TBUF2;
inout	TBUF3;
inout	TBUF_STUB3;
inout	V6N0;
inout	V6N1;
inout	V6N2;
inout	V6N3;
inout	V6N4;
inout	V6N5;
inout	V6N6;
inout	V6N7;
inout	V6N8;
inout	V6N9;
inout	V6N10;
inout	V6N11;
inout	V6M0;
inout	V6M1;
inout	V6M2;
inout	V6M3;
inout	V6M4;
inout	V6M5;
inout	V6M6;
inout	V6M7;
inout	V6M8;
inout	V6M9;
inout	V6M10;
inout	V6M11;
inout	V6S0;
inout	V6S1;
inout	V6S2;
inout	V6S3;
inout	V6S4;
inout	V6S5;
inout	V6S6;
inout	V6S7;
inout	V6S8;
inout	V6S9;
inout	V6S10;
inout	V6S11;
inout	V6A0;
inout	V6A1;
inout	V6A2;
inout	V6A3;
inout	V6B0;
inout	V6B1;
inout	V6B2;
inout	V6B3;
inout	V6C0;
inout	V6C1;
inout	V6C2;
inout	V6C3;
inout	V6D0;
inout	V6D1;
inout	V6D2;
inout	V6D3;
inout	LLV0;
inout	LLV6;
inout	S0_F_B1;
inout	S0_F_B2;
inout	S0_F_B3;
inout	S0_F_B4;
inout	S0_G_B1;
inout	S0_G_B2;
inout	S0_G_B3;
inout	S0_G_B4;
inout	S0_BX_B;
inout	S0_BY_B;
inout	S0_CE_B;
inout	S0_CLK_B;
inout	S0_SR_B;
inout	S0_X;
inout	S0_XB;
inout	S0_Y;
inout	S0_YB;
inout	S0_XQ;
inout	S0_YQ;
inout	CO_0_LOCAL;
inout	CO_0;
inout	S0_F5;
inout	S0_F5IN;
inout	S1_F_B1;
inout	S1_F_B2;
inout	S1_F_B3;
inout	S1_F_B4;
inout	S1_G_B1;
inout	S1_G_B2;
inout	S1_G_B3;
inout	S1_G_B4;
inout	S1_BX_B;
inout	S1_BY_B;
inout	S1_CE_B;
inout	S1_CLK_B;
inout	S1_SR_B;
inout	S1_X;
inout	S1_XB;
inout	S1_Y;
inout	S1_YB;
inout	S1_XQ;
inout	S1_YQ;
inout	TS_B0;
inout	TS_B1;
inout	CO_1_LOCAL;
inout	CO_1;
inout	S1_F5;
inout	S1_F5IN;
inout	TBUF_OUT0;
inout	TBUF_OUT1;
inout	T_IN0;
inout	T_IN1;
inout	CIN_0_I;
inout	CIN_0_O;
inout	CIN_1_I;
inout	CIN_1_O;
inout	_1;
		wire		E_P0 ;
		wire		E_P1 ;
		wire		E_P2 ;
		wire		E_P3 ;
		wire		E_P4 ;
		wire		E_P5 ;
		wire		E_P6 ;
		wire		E_P7 ;
		wire		E_P8 ;
		wire		E_P9 ;
		wire		E_P10 ;
		wire		E_P11 ;
		wire		E_P12 ;
		wire		E_P13 ;
		wire		E_P14 ;
		wire		E_P15 ;
		wire		E_P16 ;
		wire		E_P17 ;
		wire		E_P18 ;
		wire		E_P19 ;
		wire		E_P20 ;
		wire		E_P21 ;
		wire		E_P22 ;
		wire		E_P23 ;
		wire		N_P0 ;
		wire		N_P1 ;
		wire		N_P2 ;
		wire		N_P3 ;
		wire		N_P4 ;
		wire		N_P5 ;
		wire		N_P6 ;
		wire		N_P7 ;
		wire		N_P8 ;
		wire		N_P9 ;
		wire		N_P10 ;
		wire		N_P11 ;
		wire		N_P12 ;
		wire		N_P13 ;
		wire		N_P14 ;
		wire		N_P15 ;
		wire		N_P16 ;
		wire		N_P17 ;
		wire		N_P18 ;
		wire		N_P19 ;
		wire		N_P20 ;
		wire		N_P21 ;
		wire		N_P22 ;
		wire		N_P23 ;
		wire		W_P0 ;
		wire		W_P1 ;
		wire		W_P2 ;
		wire		W_P3 ;
		wire		W_P4 ;
		wire		W_P5 ;
		wire		W_P6 ;
		wire		W_P7 ;
		wire		W_P8 ;
		wire		W_P9 ;
		wire		W_P10 ;
		wire		W_P11 ;
		wire		W_P12 ;
		wire		W_P13 ;
		wire		W_P14 ;
		wire		W_P15 ;
		wire		W_P16 ;
		wire		W_P17 ;
		wire		W_P18 ;
		wire		W_P19 ;
		wire		W_P20 ;
		wire		W_P21 ;
		wire		W_P22 ;
		wire		W_P23 ;
		wire		S_P0 ;
		wire		S_P1 ;
		wire		S_P2 ;
		wire		S_P3 ;
		wire		S_P4 ;
		wire		S_P5 ;
		wire		S_P6 ;
		wire		S_P7 ;
		wire		S_P8 ;
		wire		S_P9 ;
		wire		S_P10 ;
		wire		S_P11 ;
		wire		S_P12 ;
		wire		S_P13 ;
		wire		S_P14 ;
		wire		S_P15 ;
		wire		S_P16 ;
		wire		S_P17 ;
		wire		S_P18 ;
		wire		S_P19 ;
		wire		S_P20 ;
		wire		S_P21 ;
		wire		S_P22 ;
		wire		S_P23 ;
		wire		TBUFO ;
		wire		OUT2 ;
		wire		OUT3 ;
		wire		OUT5 ;
		wire		OUT4 ;
		wire		VDD ;
		wire		GND ;

		SPS2N2X0H1 sps_n7(
											.IN0(V6S1),
											.IN1(H6M8),
											.OUT(N7),
											._1(1)
		);

		SPS2N2X0H1 sps_n6(
											.IN0(H6E1),
											.IN1(OUT2),
											.OUT(N6),
											._1(1)
		);

		SPS1N1X0H1 sps_n5(
											.IN(H6M5),
											.OUT(N5),
											._1(1)
		);

		SPS2N2X0H1 sps_n4(
											.IN0(V6S5),
											.IN1(H6M0),
											.OUT(N4),
											._1(1)
		);

		SPS1N1X0H1 sps_n3(
											.IN(H6M4),
											.OUT(N3),
											._1(1)
		);

		SPS1N1X0H1 sps_n2(
											.IN(OUT1),
											.OUT(N2),
											._1(1)
		);

		SPS2N2X0H1 sps_n1(
											.IN0(V6S0),
											.IN1(OUT0),
											.OUT(N1),
											._1(1)
		);

		SPS2N2X0H1 sps_n0(
											.IN0(OUT0),
											.IN1(H6W0),
											.OUT(N0),
											._1(1)
		);

		SPS2N2X0H1 sps_n9(
											.IN0(H6E8),
											.IN1(OUT3),
											.OUT(N9),
											._1(1)
		);

		SPS2N2X0H1 sps_n8(
											.IN0(OUT2),
											.IN1(H6W9),
											.OUT(N8),
											._1(1)
		);

		BUF1B0X2H5 buf_w11(
											.A(W11),
											.Y(W_P11)
		);

		BUF1B0X2H5 buf_w10(
											.A(W10),
											.Y(W_P10)
		);

		BUF1B0X2H5 buf_w13(
											.A(W13),
											.Y(W_P13)
		);

		BUF1B0X2H5 buf_w12(
											.A(W12),
											.Y(W_P12)
		);

		BUF1B0X2H5 buf_w15(
											.A(W15),
											.Y(W_P15)
		);

		BUF1B0X2H5 buf_w14(
											.A(W14),
											.Y(W_P14)
		);

		BUF1B0X2H5 buf_w17(
											.A(W17),
											.Y(W_P17)
		);

		BUF1B0X2H5 buf_w16(
											.A(W16),
											.Y(W_P16)
		);

		BUF1B0X2H5 buf_w19(
											.A(W19),
											.Y(W_P19)
		);

		BUF1B0X2H5 buf_w18(
											.A(W18),
											.Y(W_P18)
		);

		SWITCH2N1X0H1 switch_n0_e20(
											.SOURCE(E20),
											.DRAIN(N0)
		);

		SWITCH2N1X0H1 switch_n7_e7(
											.SOURCE(E7),
											.DRAIN(N7)
		);

		SWITCH2N1X0H1 switch_n15_w16(
											.SOURCE(W16),
											.DRAIN(N15)
		);

		SPS1N1X0H1 sps_n17(
											.IN(H6M7),
											.OUT(N17),
											._1(1)
		);

		SPS2N2X0H1 sps_n16(
											.IN0(V6S7),
											.IN1(H6M2),
											.OUT(N16),
											._1(1)
		);

		SPS1N1X0H1 sps_n15(
											.IN(H6M6),
											.OUT(N15),
											._1(1)
		);

		SPS1N1X0H1 sps_n14(
											.IN(OUT5),
											.OUT(N14),
											._1(1)
		);

		SPS2N2X0H1 sps_n13(
											.IN0(V6S2),
											.IN1(OUT4),
											.OUT(N13),
											._1(1)
		);

		SPS2N2X0H1 sps_n12(
											.IN0(OUT4),
											.IN1(H6W2),
											.OUT(N12),
											._1(1)
		);

		SPS1N1X0H1 sps_n11(
											.IN(H6M9),
											.OUT(N11),
											._1(1)
		);

		SPS2N2X0H1 sps_n10(
											.IN0(V6S9),
											.IN1(H6M1),
											.OUT(N10),
											._1(1)
		);

		SPS2N2X0H1 sps_n19(
											.IN0(V6S3),
											.IN1(H6M10),
											.OUT(N19),
											._1(1)
		);

		SPS2N2X0H1 sps_n18(
											.IN0(H6E3),
											.IN1(OUT6),
											.OUT(N18),
											._1(1)
		);

		SWITCH2N1X0H2 switch_e18_w18(
											.SOURCE(W18),
											.DRAIN(E18)
		);

		SPS1N1X0H1 sps_e14(
											.IN(OUT4),
											.OUT(E14),
											._1(1)
		);

		SPS2N2X0H1 sps_e15(
											.IN0(OUT5),
											.IN1(H6W7),
											.OUT(E15),
											._1(1)
		);

		SPS1N1X0H1 sps_e16(
											.IN(V6M11),
											.OUT(E16),
											._1(1)
		);

		SPS2N2X0H1 sps_e17(
											.IN0(V6S7),
											.IN1(OUT5),
											.OUT(E17),
											._1(1)
		);

		SPS2N2X0H1 sps_e10(
											.IN0(V6M7),
											.IN1(H6W2),
											.OUT(E10),
											._1(1)
		);

		SPS2N2X0H1 sps_e11(
											.IN0(OUT3),
											.IN1(H6W1),
											.OUT(E11),
											._1(1)
		);

		SPS2N2X0H1 sps_e12(
											.IN0(V6S2),
											.IN1(V6M6),
											.OUT(E12),
											._1(1)
		);

		SPS2N2X0H1 sps_e13(
											.IN0(V6M2),
											.IN1(V6N6),
											.OUT(E13),
											._1(1)
		);

		SPS2N2X0H1 sps_e18(
											.IN0(OUT6),
											.IN1(H6W11),
											.OUT(E18),
											._1(1)
		);

		SPS1N1X0H1 sps_e19(
											.IN(V6M3),
											.OUT(E19),
											._1(1)
		);

		SWITCH2N1X0H2 switch_s20_n20(
											.SOURCE(N20),
											.DRAIN(S20)
		);

		SPS8T5X11H1 sps_llv0(
											.IN4(OUT2),
											.IN5(OUT1),
											.IN6(W_P6),
											.IN7(E_P5),
											.IN0(E_P22),
											.IN1(W_P11),
											.IN2(S_P2),
											.IN3(N_P4),
											.OUT(LLV0),
											._1(1)
		);

		SWITCH2N1X0H1 switch_n12_e8(
											.SOURCE(E8),
											.DRAIN(N12)
		);

		SWITCH2N1X0H2 switch_s5_n5(
											.SOURCE(N5),
											.DRAIN(S5)
		);

		SPS2N2X0H1 sps_s18(
											.IN0(H6W7),
											.IN1(H6M2),
											.OUT(S18),
											._1(1)
		);

		SPS1N1X0H1 sps_s19(
											.IN(OUT6),
											.OUT(S19),
											._1(1)
		);

		SPS2N2X0H1 sps_s16(
											.IN0(H6E2),
											.IN1(H6M7),
											.OUT(S16),
											._1(1)
		);

		SPS2N2X0H1 sps_s17(
											.IN0(V6N10),
											.IN1(OUT6),
											.OUT(S17),
											._1(1)
		);

		SPS2N2X0H1 sps_s14(
											.IN0(V6N2),
											.IN1(H6M6),
											.OUT(S14),
											._1(1)
		);

		SPS2N2X0H1 sps_s15(
											.IN0(H6E6),
											.IN1(OUT4),
											.OUT(S15),
											._1(1)
		);

		SPS1N1X0H1 sps_s12(
											.IN(OUT5),
											.OUT(S12),
											._1(1)
		);

		SPS2N2X0H1 sps_s13(
											.IN0(V6N6),
											.IN1(OUT4),
											.OUT(S13),
											._1(1)
		);

		SPS2N2X0H1 sps_s10(
											.IN0(V6N1),
											.IN1(OUT3),
											.OUT(S10),
											._1(1)
		);

		SPS1N1X0H1 sps_s11(
											.IN(H6M8),
											.OUT(S11),
											._1(1)
		);

		SPS2N2X0H1 sps_s4(
											.IN0(H6E0),
											.IN1(H6M5),
											.OUT(S4),
											._1(1)
		);

		SPS2N2X0H1 sps_s5(
											.IN0(V6N8),
											.IN1(OUT2),
											.OUT(S5),
											._1(1)
		);

		SPS2N2X0H1 sps_s6(
											.IN0(H6W5),
											.IN1(H6M0),
											.OUT(S6),
											._1(1)
		);

		SPS1N1X0H1 sps_s7(
											.IN(OUT2),
											.OUT(S7),
											._1(1)
		);

		SPS1N1X0H1 sps_s0(
											.IN(OUT1),
											.OUT(S0),
											._1(1)
		);

		SPS2N2X0H1 sps_s1(
											.IN0(V6N4),
											.IN1(OUT0),
											.OUT(S1),
											._1(1)
		);

		SPS2N2X0H1 sps_s2(
											.IN0(V6N0),
											.IN1(H6M4),
											.OUT(S2),
											._1(1)
		);

		SPS2N2X0H1 sps_s3(
											.IN0(H6E4),
											.IN1(OUT0),
											.OUT(S3),
											._1(1)
		);

		SPS8T5X11H1 sps_llv6(
											.IN4(W_P10),
											.IN5(E_P23),
											.IN6(S_P13),
											.IN7(W_P17),
											.IN0(N_P14),
											.IN1(OUT6),
											.IN2(OUT5),
											.IN3(E_P18),
											.OUT(LLV6),
											._1(1)
		);

		SPS2N2X0H1 sps_s8(
											.IN0(H6W1),
											.IN1(H6M9),
											.OUT(S8),
											._1(1)
		);

		SPS1N1X0H1 sps_s9(
											.IN(H6M1),
											.OUT(S9),
											._1(1)
		);

		SPS6T4X11H1 sps_v6s2(
											.IN4(H6E1),
											.IN5(V6N2),
											.IN0(OUT4),
											.IN1(LLV6),
											.IN2(H6W2),
											.IN3(H6M2),
											.OUT(V6S2),
											._1(1)
		);

		STUBX10H1 stub_tbuf3(
											.INOUTB(TBUF_STUB3),
											.INOUTA(TBUF3)
		);

		SPS6T4X11H1 sps_v6s0(
											.IN4(H6E3),
											.IN5(V6N0),
											.IN0(OUT0),
											.IN1(LLV0),
											.IN2(H6W0),
											.IN3(H6M0),
											.OUT(V6S0),
											._1(1)
		);

		SPS6T4X11H1 sps_v6s1(
											.IN4(H6E0),
											.IN5(V6N1),
											.IN0(OUT2),
											.IN1(LLV0),
											.IN2(H6W1),
											.IN3(H6M1),
											.OUT(V6S1),
											._1(1)
		);

		SPS6B3X11H1 sps_v6s6(
											.IN4(H6M6),
											.IN5(H6E6),
											.IN0(V6N6),
											.IN1(OUT5),
											.IN2(H6W11),
											.IN3(H6M7),
											.OUT(V6S6),
											._1(1)
		);

		SPS28N6X0H2 sps_s1_g_b3(
											.IN8(W_P20),
											.IN9(S_P10),
											.IN4(W_P12),
											.IN5(S_P19),
											.IN6(N_P16),
											.IN7(S_P3),
											.IN0(GND),
											.IN1(S_P4),
											.IN2(E_P6),
											.IN3(E_P23),
											.IN18(W_P16),
											.IN19(S_P1),
											.IN16(N_P18),
											.IN17(E_P18),
											.IN14(W_P10),
											.IN15(S_P23),
											.IN12(N_P17),
											.IN13(W_P2),
											.IN10(N_P21),
											.IN11(W_P19),
											.OUT(S1_G_B3),
											.IN23(E_P13),
											.IN22(N_P12),
											.IN21(S_P7),
											.IN20(E_P11),
											.IN27(VDD),
											.IN26(OUT_W0),
											.IN25(S1_Y),
											.IN24(E_P15),
											._1(1)
		);

		SPS6B3X11H1 sps_v6s4(
											.IN4(H6M4),
											.IN5(H6E4),
											.IN0(V6N4),
											.IN1(OUT1),
											.IN2(H6W9),
											.IN3(H6M5),
											.OUT(V6S4),
											._1(1)
		);

		SPS6B3X11H1 sps_v6s8(
											.IN4(H6M8),
											.IN5(H6E8),
											.IN0(V6N8),
											.IN1(OUT3),
											.IN2(H6W7),
											.IN3(H6M9),
											.OUT(V6S8),
											._1(1)
		);

		BUFDUMMY coupling_s1_x(
											.IN(S1_F5),
											.OUT(S1_X)
		);

		SWITCH2N1X0H2 switch_e17_w17(
											.SOURCE(W17),
											.DRAIN(E17)
		);

		SWITCH2N1X0H2 switch_s0_n0(
											.SOURCE(N0),
											.DRAIN(S0)
		);

		SWITCH2N1X0H1 switch_n12_w17(
											.SOURCE(W17),
											.DRAIN(N12)
		);

		SWITCH2N1X0H2 switch_e7_w7(
											.SOURCE(W7),
											.DRAIN(E7)
		);

		SWITCH2N1X0H1 switch_s8_e6(
											.SOURCE(E6),
											.DRAIN(S8)
		);

		SWITCH2N1X0H2 switch_e8_w8(
											.SOURCE(W8),
											.DRAIN(E8)
		);

		SPS16N6X0H3 sps_s1_by_b(
											.IN8(E_P6),
											.IN9(W_P12),
											.IN4(S_P12),
											.IN5(N_P20),
											.IN6(W_P21),
											.IN7(W_P18),
											.IN0(W_P2),
											.IN1(N_P21),
											.IN2(E_P13),
											.IN3(N_P15),
											.OUT(S1_BY_B),
											.IN14(E_P20),
											.IN15(S_P17),
											.IN12(S_P23),
											.IN13(N_P9),
											.IN10(W_P19),
											.IN11(S_P19),
											._1(1)
		);

		BUFDUMMY buf_s1_f5in(
											.OUT(S1_F5IN),
											.IN(S0_F5)
		);

		SWITCH2N1X0H1 switch_s15_e13(
											.SOURCE(E13),
											.DRAIN(S15)
		);

		SPS28N9X0H1 sps_s0_f_b4(
											.IN8(W_P14),
											.IN9(S_P11),
											.IN4(W_P11),
											.IN5(E_P0),
											.IN6(N_P3),
											.IN7(E_P17),
											.IN0(GND),
											.IN1(E_P16),
											.IN2(S_P16),
											.IN3(N_P5),
											.IN18(N_P1),
											.IN19(W_P9),
											.IN16(N_P7),
											.IN17(W_P3),
											.IN14(S_P18),
											.IN15(E_P22),
											.IN12(S_P2),
											.IN13(S_P9),
											.IN10(S_P8),
											.IN11(E_P4),
											.OUT(S0_F_B4),
											.IN23(N_P0),
											.IN22(E_P8),
											.IN21(N_P10),
											.IN20(E_P19),
											.IN27(VDD),
											.IN26(OUT_E6),
											.IN25(S0_X),
											.IN24(W_P1),
											._1(1)
		);

		SPS28N9X0H1 sps_s0_f_b1(
											.IN8(E_P14),
											.IN9(W_P18),
											.IN4(N_P19),
											.IN5(N_P22),
											.IN6(E_P20),
											.IN7(S_P12),
											.IN0(GND),
											.IN1(E_P2),
											.IN2(S_P17),
											.IN3(W_P7),
											.IN18(W_P22),
											.IN19(W_P5),
											.IN16(N_P15),
											.IN17(S_P21),
											.IN14(W_P13),
											.IN15(S_P6),
											.IN12(N_P23),
											.IN13(N_P9),
											.IN10(E_P12),
											.IN11(W_P21),
											.OUT(S0_F_B1),
											.IN23(W_P17),
											.IN22(S_P13),
											.IN21(N_P14),
											.IN20(S_P5),
											.IN27(VDD),
											.IN26(OUT_W1),
											.IN25(S1_X),
											.IN24(N_P20),
											._1(1)
		);

		SPS28N9X0H1 sps_s0_f_b3(
											.IN8(W_P0),
											.IN9(S_P15),
											.IN4(N_P11),
											.IN5(E_P10),
											.IN6(W_P8),
											.IN7(N_P4),
											.IN0(GND),
											.IN1(W_P23),
											.IN2(E_P3),
											.IN3(E_P1),
											.IN18(N_P8),
											.IN19(S_P0),
											.IN16(W_P4),
											.IN17(N_P6),
											.IN14(N_P13),
											.IN15(S_P22),
											.IN12(W_P6),
											.IN13(S_P20),
											.IN10(W_P15),
											.IN11(E_P9),
											.OUT(S0_F_B3),
											.IN23(E_P5),
											.IN22(N_P2),
											.IN21(S_P14),
											.IN20(E_P21),
											.IN27(VDD),
											.IN26(OUT_E7),
											.IN25(S0_Y),
											.IN24(E_P7),
											._1(1)
		);

		SPS28N9X0H1 sps_s0_f_b2(
											.IN8(W_P20),
											.IN9(S_P23),
											.IN4(W_P12),
											.IN5(S_P19),
											.IN6(E_P15),
											.IN7(S_P3),
											.IN0(GND),
											.IN1(S_P4),
											.IN2(E_P11),
											.IN3(S_P7),
											.IN18(E_P18),
											.IN19(S_P1),
											.IN16(N_P21),
											.IN17(N_P17),
											.IN14(W_P10),
											.IN15(E_P23),
											.IN12(W_P19),
											.IN13(W_P2),
											.IN10(N_P12),
											.IN11(N_P16),
											.OUT(S0_F_B2),
											.IN23(W_P16),
											.IN22(N_P18),
											.IN21(S_P10),
											.IN20(E_P6),
											.IN27(VDD),
											.IN26(OUT_W0),
											.IN25(S1_Y),
											.IN24(E_P13),
											._1(1)
		);

		SWITCH2N1X0H1 switch_n5_e5(
											.SOURCE(E5),
											.DRAIN(N5)
		);

		SWITCH2N1X0H1 switch_n9_w10(
											.SOURCE(W10),
											.DRAIN(N9)
		);

		SWITCH2N1X0H1 switch_s5_e7(
											.SOURCE(E7),
											.DRAIN(S5)
		);

		SWITCH2N1X0H1 switch_s17_w23(
											.SOURCE(W23),
											.DRAIN(S17)
		);

		BUF1B0X2H5 buf_e22(
											.A(E22),
											.Y(E_P22)
		);

		BUF1B0X2H5 buf_e23(
											.A(E23),
											.Y(E_P23)
		);

		BUF1B0X2H5 buf_e20(
											.A(E20),
											.Y(E_P20)
		);

		BUF1B0X2H5 buf_e21(
											.A(E21),
											.Y(E_P21)
		);

		SWITCH2N1X0H2 switch_e10_w10(
											.SOURCE(W10),
											.DRAIN(E10)
		);

		SWITCH2N1X0H1 switch_s18_w16(
											.SOURCE(W16),
											.DRAIN(S18)
		);

		SWITCH2N1X0H1 switch_n5_w6(
											.SOURCE(W6),
											.DRAIN(N5)
		);

		SWITCH2N1X0H1 switch_n20_w1(
											.SOURCE(W1),
											.DRAIN(N20)
		);

		SWITCH2N1X0H1 switch_n8_e4(
											.SOURCE(E4),
											.DRAIN(N8)
		);

		SWITCH2N1X0H1 switch_n18_w23(
											.SOURCE(W23),
											.DRAIN(N18)
		);

		SPS28N6X0H2 sps_s1_g_b4(
											.IN8(E_P14),
											.IN9(N_P14),
											.IN4(E_P12),
											.IN5(N_P23),
											.IN6(N_P22),
											.IN7(S_P12),
											.IN0(GND),
											.IN1(E_P2),
											.IN2(S_P5),
											.IN3(S_P6),
											.IN18(S_P21),
											.IN19(W_P5),
											.IN16(N_P19),
											.IN17(N_P20),
											.IN14(W_P13),
											.IN15(W_P18),
											.IN12(W_P21),
											.IN13(N_P9),
											.IN10(N_P15),
											.IN11(W_P22),
											.OUT(S1_G_B4),
											.IN23(W_P17),
											.IN22(S_P13),
											.IN21(W_P7),
											.IN20(S_P17),
											.IN27(VDD),
											.IN26(OUT_W1),
											.IN25(S1_X),
											.IN24(E_P20),
											._1(1)
		);

		SPS28N6X0H1 sps_s1_g_b1(
											.IN8(W_P14),
											.IN9(N_P10),
											.IN4(W_P11),
											.IN5(E_P0),
											.IN6(E_P4),
											.IN7(E_P17),
											.IN0(GND),
											.IN1(E_P16),
											.IN2(E_P19),
											.IN3(E_P22),
											.IN18(N_P0),
											.IN19(W_P9),
											.IN16(E_P8),
											.IN17(N_P1),
											.IN14(S_P18),
											.IN15(S_P11),
											.IN12(W_P3),
											.IN13(S_P9),
											.IN10(N_P7),
											.IN11(S_P2),
											.OUT(S1_G_B1),
											.IN23(W_P1),
											.IN22(S_P8),
											.IN21(N_P5),
											.IN20(S_P16),
											.IN27(VDD),
											.IN26(OUT_E6),
											.IN25(S0_X),
											.IN24(N_P3),
											._1(1)
		);

		SPS16N6X0H3 sps_s1_ce_b(
											.IN8(S_P5),
											.IN9(W_P7),
											.IN4(S_P6),
											.IN5(E_P12),
											.IN6(N_P19),
											.IN7(N_P22),
											.IN0(V6D3),
											.IN1(V6C3),
											.IN2(V6M3),
											.IN3(V6B3),
											.OUT(S1_CE_B),
											.IN14(V6N3),
											.IN15(N_P23),
											.IN12(E_P2),
											.IN13(V6A3),
											.IN10(S_P21),
											.IN11(W_P22),
											._1(1)
		);

		SPS28N6X0H1 sps_s1_g_b2(
											.IN8(W_P0),
											.IN9(S_P14),
											.IN4(W_P15),
											.IN5(W_P6),
											.IN6(E_P10),
											.IN7(N_P4),
											.IN0(GND),
											.IN1(W_P23),
											.IN2(E_P21),
											.IN3(S_P22),
											.IN18(N_P6),
											.IN19(S_P0),
											.IN16(N_P11),
											.IN17(E_P7),
											.IN14(N_P13),
											.IN15(S_P15),
											.IN12(E_P9),
											.IN13(S_P20),
											.IN10(W_P4),
											.IN11(N_P8),
											.OUT(S1_G_B2),
											.IN23(E_P5),
											.IN22(N_P2),
											.IN21(E_P1),
											.IN20(E_P3),
											.IN27(VDD),
											.IN26(OUT_E7),
											.IN25(S0_Y),
											.IN24(W_P8),
											._1(1)
		);

		SWITCH2N1X0H1 switch_s21_e23(
											.SOURCE(E23),
											.DRAIN(S21)
		);

		SWITCH2N1X0H1 switch_s13_w19(
											.SOURCE(W19),
											.DRAIN(S13)
		);

		SWITCH2N1X0H2 switch_e1_w1(
											.SOURCE(W1),
											.DRAIN(E1)
		);

		SWITCH2N1X0H2 switch_e21_w21(
											.SOURCE(W21),
											.DRAIN(E21)
		);

		SPS1N1X0H1 sps_s23(
											.IN(H6M10),
											.OUT(S23),
											._1(1)
		);

		SPS2N2X0H1 sps_s22(
											.IN0(V6N3),
											.IN1(OUT7),
											.OUT(S22),
											._1(1)
		);

		SPS1N1X0H1 sps_s21(
											.IN(H6M3),
											.OUT(S21),
											._1(1)
		);

		SPS2N2X0H1 sps_s20(
											.IN0(H6W3),
											.IN1(H6M11),
											.OUT(S20),
											._1(1)
		);

		SWITCH2N1X0H1 switch_n8_w13(
											.SOURCE(W13),
											.DRAIN(N8)
		);

		SWITCH2N1X0H1 switch_n19_w20(
											.SOURCE(W20),
											.DRAIN(N19)
		);

		SWITCH2N1X0H1 switch_s9_w15(
											.SOURCE(W15),
											.DRAIN(S9)
		);

		SWITCH2N1X0H2 switch_s15_n15(
											.SOURCE(N15),
											.DRAIN(S15)
		);

		SWITCH2N1X0H1 switch_n22_w3(
											.SOURCE(W3),
											.DRAIN(N22)
		);

		SPS16N6X0H3 sps_s0_clk_b(
											.IN8(V6D2),
											.IN9(V6C2),
											.IN4(S_P10),
											.IN5(N_P18),
											.IN6(W_P16),
											.IN7(E_P15),
											.IN0(N_P13),
											.IN1(S_P15),
											.IN2(V6A2),
											.IN3(V6N2),
											.OUT(S0_CLK_B),
											.IN14(GCLK1),
											.IN15(GCLK0),
											.IN12(GCLK3),
											.IN13(GCLK2),
											.IN10(V6M2),
											.IN11(V6B2),
											._1(1)
		);

		SWITCH2N1X0H1 switch_s1_e3(
											.SOURCE(E3),
											.DRAIN(S1)
		);

		SWITCH2N1X0H1 switch_n1_e1(
											.SOURCE(E1),
											.DRAIN(N1)
		);

		SWITCH2N1X0H1 switch_n14_e10(
											.SOURCE(E10),
											.DRAIN(N14)
		);

		SWITCH2N1X0H2 switch_e16_w16(
											.SOURCE(W16),
											.DRAIN(E16)
		);

		SWITCH2N1X0H1 switch_s20_w22(
											.SOURCE(W22),
											.DRAIN(S20)
		);

		SWITCH2N1X0H1 switch_n7_w8(
											.SOURCE(W8),
											.DRAIN(N7)
		);

		SPS28N9X0H1 sps_s1_f_b2(
											.IN8(W_P0),
											.IN9(S_P14),
											.IN4(W_P15),
											.IN5(W_P6),
											.IN6(E_P10),
											.IN7(N_P4),
											.IN0(GND),
											.IN1(W_P23),
											.IN2(E_P21),
											.IN3(S_P22),
											.IN18(N_P6),
											.IN19(S_P0),
											.IN16(N_P11),
											.IN17(E_P7),
											.IN14(N_P13),
											.IN15(S_P15),
											.IN12(E_P9),
											.IN13(S_P20),
											.IN10(W_P4),
											.IN11(N_P8),
											.OUT(S1_F_B2),
											.IN23(E_P5),
											.IN22(N_P2),
											.IN21(E_P1),
											.IN20(E_P3),
											.IN27(VDD),
											.IN26(OUT_E7),
											.IN25(S0_Y),
											.IN24(W_P8),
											._1(1)
		);

		SPS28N9X0H1 sps_s1_f_b3(
											.IN8(W_P20),
											.IN9(S_P10),
											.IN4(W_P12),
											.IN5(S_P19),
											.IN6(N_P16),
											.IN7(S_P3),
											.IN0(GND),
											.IN1(S_P4),
											.IN2(E_P6),
											.IN3(E_P23),
											.IN18(W_P16),
											.IN19(S_P1),
											.IN16(N_P18),
											.IN17(E_P18),
											.IN14(W_P10),
											.IN15(S_P23),
											.IN12(N_P17),
											.IN13(W_P2),
											.IN10(N_P21),
											.IN11(W_P19),
											.OUT(S1_F_B3),
											.IN23(E_P13),
											.IN22(N_P12),
											.IN21(S_P7),
											.IN20(E_P11),
											.IN27(VDD),
											.IN26(OUT_W0),
											.IN25(S1_Y),
											.IN24(E_P15),
											._1(1)
		);

		SPS16N6X0H3 sps_s0_bx_b(
											.IN8(S_P0),
											.IN9(W_P14),
											.IN4(E_P19),
											.IN5(E_P3),
											.IN6(S_P9),
											.IN7(N_P5),
											.IN0(S_P14),
											.IN1(N_P11),
											.IN2(W_P4),
											.IN3(E_P7),
											.OUT(S0_BX_B),
											.IN14(N_P2),
											.IN15(S_P8),
											.IN12(W_P0),
											.IN13(E_P1),
											.IN10(W_P8),
											.IN11(N_P6),
											._1(1)
		);

		SPS16N6X0H3 sps_s1_bx_b(
											.IN8(S_P23),
											.IN9(N_P9),
											.IN4(S_P12),
											.IN5(N_P20),
											.IN6(W_P21),
											.IN7(W_P18),
											.IN0(W_P2),
											.IN1(N_P21),
											.IN2(E_P13),
											.IN3(N_P15),
											.OUT(S1_BX_B),
											.IN14(W_P19),
											.IN15(S_P19),
											.IN12(E_P6),
											.IN13(W_P12),
											.IN10(E_P20),
											.IN11(S_P17),
											._1(1)
		);

		SWITCH2N1X0H1 switch_n11_e11(
											.SOURCE(E11),
											.DRAIN(N11)
		);

		SPS28N9X0H1 sps_s1_f_b4(
											.IN8(E_P14),
											.IN9(N_P14),
											.IN4(E_P12),
											.IN5(N_P23),
											.IN6(N_P22),
											.IN7(S_P12),
											.IN0(GND),
											.IN1(E_P2),
											.IN2(S_P5),
											.IN3(S_P6),
											.IN18(S_P21),
											.IN19(W_P5),
											.IN16(N_P19),
											.IN17(N_P20),
											.IN14(W_P13),
											.IN15(W_P18),
											.IN12(W_P21),
											.IN13(N_P9),
											.IN10(N_P15),
											.IN11(W_P22),
											.OUT(S1_F_B4),
											.IN23(W_P17),
											.IN22(S_P13),
											.IN21(W_P7),
											.IN20(S_P17),
											.IN27(VDD),
											.IN26(OUT_W1),
											.IN25(S1_X),
											.IN24(E_P20),
											._1(1)
		);

		SWITCH2N1X0H1 switch_n1_w2(
											.SOURCE(W2),
											.DRAIN(N1)
		);

		SWITCH2N1X0H1 switch_s17_e19(
											.SOURCE(E19),
											.DRAIN(S17)
		);

		SPS28N6X0H1 sps_s0_g_b2(
											.IN8(W_P20),
											.IN9(S_P23),
											.IN4(W_P12),
											.IN5(S_P19),
											.IN6(E_P15),
											.IN7(S_P3),
											.IN0(GND),
											.IN1(S_P4),
											.IN2(E_P11),
											.IN3(S_P7),
											.IN18(E_P18),
											.IN19(S_P1),
											.IN16(N_P21),
											.IN17(N_P17),
											.IN14(W_P10),
											.IN15(E_P23),
											.IN12(W_P19),
											.IN13(W_P2),
											.IN10(N_P12),
											.IN11(N_P16),
											.OUT(S0_G_B2),
											.IN23(W_P16),
											.IN22(N_P18),
											.IN21(S_P10),
											.IN20(E_P6),
											.IN27(VDD),
											.IN26(OUT_W0),
											.IN25(S1_Y),
											.IN24(E_P13),
											._1(1)
		);

		SPS28N6X0H2 sps_s0_g_b3(
											.IN8(W_P0),
											.IN9(S_P15),
											.IN4(N_P11),
											.IN5(E_P10),
											.IN6(W_P8),
											.IN7(N_P4),
											.IN0(GND),
											.IN1(W_P23),
											.IN2(E_P3),
											.IN3(E_P1),
											.IN18(N_P8),
											.IN19(S_P0),
											.IN16(W_P4),
											.IN17(N_P6),
											.IN14(N_P13),
											.IN15(S_P22),
											.IN12(W_P6),
											.IN13(S_P20),
											.IN10(W_P15),
											.IN11(E_P9),
											.OUT(S0_G_B3),
											.IN23(E_P5),
											.IN22(N_P2),
											.IN21(S_P14),
											.IN20(E_P21),
											.IN27(VDD),
											.IN26(OUT_E7),
											.IN25(S0_Y),
											.IN24(E_P7),
											._1(1)
		);

		SPS28N6X0H1 sps_s0_g_b1(
											.IN8(E_P14),
											.IN9(W_P18),
											.IN4(N_P19),
											.IN5(N_P22),
											.IN6(E_P20),
											.IN7(S_P12),
											.IN0(GND),
											.IN1(E_P2),
											.IN2(S_P17),
											.IN3(W_P7),
											.IN18(W_P22),
											.IN19(W_P5),
											.IN16(N_P15),
											.IN17(S_P21),
											.IN14(W_P13),
											.IN15(S_P6),
											.IN12(N_P23),
											.IN13(N_P9),
											.IN10(E_P12),
											.IN11(W_P21),
											.OUT(S0_G_B1),
											.IN23(W_P17),
											.IN22(S_P13),
											.IN21(N_P14),
											.IN20(S_P5),
											.IN27(VDD),
											.IN26(OUT_W1),
											.IN25(S1_X),
											.IN24(N_P20),
											._1(1)
		);

		BUF1B0X2H5 buf_n18(
											.A(N18),
											.Y(N_P18)
		);

		BUF1B0X2H5 buf_n19(
											.A(N19),
											.Y(N_P19)
		);

		SPS28N6X0H2 sps_s0_g_b4(
											.IN8(W_P14),
											.IN9(S_P11),
											.IN4(W_P11),
											.IN5(E_P0),
											.IN6(N_P3),
											.IN7(E_P17),
											.IN0(GND),
											.IN1(E_P16),
											.IN2(S_P16),
											.IN3(N_P5),
											.IN18(N_P1),
											.IN19(W_P9),
											.IN16(N_P7),
											.IN17(W_P3),
											.IN14(S_P18),
											.IN15(E_P22),
											.IN12(S_P2),
											.IN13(S_P9),
											.IN10(S_P8),
											.IN11(E_P4),
											.OUT(S0_G_B4),
											.IN23(N_P0),
											.IN22(E_P8),
											.IN21(N_P10),
											.IN20(E_P19),
											.IN27(VDD),
											.IN26(OUT_E6),
											.IN25(S0_X),
											.IN24(W_P1),
											._1(1)
		);

		BUF1B0X2H5 buf_n14(
											.A(N14),
											.Y(N_P14)
		);

		BUF1B0X2H5 buf_n15(
											.A(N15),
											.Y(N_P15)
		);

		BUF1B0X2H5 buf_n16(
											.A(N16),
											.Y(N_P16)
		);

		BUF1B0X2H5 buf_n17(
											.A(N17),
											.Y(N_P17)
		);

		BUF1B0X2H5 buf_n10(
											.A(N10),
											.Y(N_P10)
		);

		BUF1B0X2H5 buf_n11(
											.A(N11),
											.Y(N_P11)
		);

		BUF1B0X2H5 buf_n12(
											.A(N12),
											.Y(N_P12)
		);

		BUF1B0X2H5 buf_n13(
											.A(N13),
											.Y(N_P13)
		);

		SPS16N6X0H1 sps_ts_b0(
											.IN8(S_P16),
											.IN9(V6B0),
											.IN4(N_P10),
											.IN5(E_P8),
											.IN6(W_P3),
											.IN7(W_P1),
											.IN0(S_P11),
											.IN1(V6C0),
											.IN2(V6D0),
											.IN3(N_P0),
											.OUT(TS_B0),
											.IN14(V6A0),
											.IN15(N_P3),
											.IN12(S_P18),
											.IN13(V6N0),
											.IN10(V6M0),
											.IN11(E_P0),
											._1(1)
		);

		SPS16N6X0H1 sps_ts_b1(
											.IN8(S_P18),
											.IN9(V6N0),
											.IN4(N_P10),
											.IN5(E_P8),
											.IN6(W_P3),
											.IN7(W_P1),
											.IN0(S_P11),
											.IN1(V6C0),
											.IN2(V6D0),
											.IN3(N_P0),
											.OUT(TS_B1),
											.IN14(V6M0),
											.IN15(E_P0),
											.IN12(S_P16),
											.IN13(V6B0),
											.IN10(V6A0),
											.IN11(N_P3),
											._1(1)
		);

		SWITCH2N1X0H1 switch_s2_e20(
											.SOURCE(E20),
											.DRAIN(S2)
		);

		SWITCH2N1X0H1 switch_s8_w10(
											.SOURCE(W10),
											.DRAIN(S8)
		);

		SWITCH2N1X0H2 switch_e19_w19(
											.SOURCE(W19),
											.DRAIN(E19)
		);

		SWITCH2N1X0H1 switch_s23_e21(
											.SOURCE(E21),
											.DRAIN(S23)
		);

		SWITCH2N1X0H1 switch_s16_e14(
											.SOURCE(E14),
											.DRAIN(S16)
		);

		SWITCH2N1X0H2 switch_s21_n21(
											.SOURCE(N21),
											.DRAIN(S21)
		);

		SWITCH2N1X0H1 switch_n23_w0(
											.SOURCE(W0),
											.DRAIN(N23)
		);

		SWITCH2N1X0H1 switch_n11_w12(
											.SOURCE(W12),
											.DRAIN(N11)
		);

		BUF1B0X2H5 buf_e19(
											.A(E19),
											.Y(E_P19)
		);

		BUF1B0X2H5 buf_e18(
											.A(E18),
											.Y(E_P18)
		);

		BUF1B0X2H5 buf_e17(
											.A(E17),
											.Y(E_P17)
		);

		BUF1B0X2H5 buf_e16(
											.A(E16),
											.Y(E_P16)
		);

		BUF1B0X2H5 buf_e15(
											.A(E15),
											.Y(E_P15)
		);

		BUF1B0X2H5 buf_e14(
											.A(E14),
											.Y(E_P14)
		);

		BUF1B0X2H5 buf_e13(
											.A(E13),
											.Y(E_P13)
		);

		BUF1B0X2H5 buf_e12(
											.A(E12),
											.Y(E_P12)
		);

		BUF1B0X2H5 buf_e11(
											.A(E11),
											.Y(E_P11)
		);

		BUF1B0X2H5 buf_e10(
											.A(E10),
											.Y(E_P10)
		);

		SPS2N2X0H1 sps_e21(
											.IN0(V6M10),
											.IN1(V6N3),
											.OUT(E21),
											._1(1)
		);

		SPS1N1X0H1 sps_e20(
											.IN(OUT7),
											.OUT(E20),
											._1(1)
		);

		SPS2N2X0H1 sps_e23(
											.IN0(OUT7),
											.IN1(H6W3),
											.OUT(E23),
											._1(1)
		);

		SPS2N2X0H1 sps_e22(
											.IN0(V6M5),
											.IN1(H6W0),
											.OUT(E22),
											._1(1)
		);

		SWITCH2N1X0H1 switch_n13_e13(
											.SOURCE(E13),
											.DRAIN(N13)
		);

		BUFDUMMY buf_co1(
											.OUT(CO_1),
											.IN(CO_1_LOCAL)
		);

		BUFDUMMY buf_co0(
											.OUT(CO_0),
											.IN(CO_0_LOCAL)
		);

		SWITCH2N1X0H1 switch_s0_w2(
											.SOURCE(W2),
											.DRAIN(S0)
		);

		SWITCH2N1X0H1 switch_n17_w18(
											.SOURCE(W18),
											.DRAIN(N17)
		);

		SWITCH2N1X0H2 switch_e22_w22(
											.SOURCE(W22),
											.DRAIN(E22)
		);

		SPS1N1X0H1 sps_w12(
											.IN(V6M7),
											.OUT(W12),
											._1(1)
		);

		SPS1N1X0H1 sps_w13(
											.IN(V6M8),
											.OUT(W13),
											._1(1)
		);

		SPS2N2X0H1 sps_w10(
											.IN0(V6S9),
											.IN1(OUT3),
											.OUT(W10),
											._1(1)
		);

		SPS2N2X0H1 sps_w11(
											.IN0(H6E8),
											.IN1(OUT3),
											.OUT(W11),
											._1(1)
		);

		SPS2N2X0H1 sps_w16(
											.IN0(V6N2),
											.IN1(OUT5),
											.OUT(W16),
											._1(1)
		);

		SPS2N2X0H1 sps_w17(
											.IN0(H6E2),
											.IN1(OUT5),
											.OUT(W17),
											._1(1)
		);

		SPS1N1X0H1 sps_w14(
											.IN(V6M6),
											.OUT(W14),
											._1(1)
		);

		SPS2N2X0H1 sps_w15(
											.IN0(H6E6),
											.IN1(V6M2),
											.OUT(W15),
											._1(1)
		);

		BUFDUMMY routethrough_co1(
											.IN(CO_1_LOCAL),
											.OUT(S1_YB)
		);

		BUFDUMMY routethrough_co0(
											.IN(CO_0_LOCAL),
											.OUT(S0_YB)
		);

		SPS2N2X0H1 sps_w18(
											.IN0(V6M11),
											.IN1(H6E3),
											.OUT(W18),
											._1(1)
		);

		SPS1N1X0H1 sps_w19(
											.IN(OUT4),
											.OUT(W19),
											._1(1)
		);

		SWITCH2N1X0H1 switch_s19_e17(
											.SOURCE(E17),
											.DRAIN(S19)
		);

		SPS2T2X11H1 sps_llh6(
											.IN0(OUT4),
											.IN1(OUT5),
											.OUT(LLH6),
											._1(1)
		);

		SPS2T2X11H1 sps_llh0(
											.IN0(OUT2),
											.IN1(OUT3),
											.OUT(LLH0),
											._1(1)
		);

		SWITCH2N1X0H2 switch_e4_w4(
											.SOURCE(W4),
											.DRAIN(E4)
		);

		SWITCH2N1X0H2 switch_s16_n16(
											.SOURCE(N16),
											.DRAIN(S16)
		);

		SPS16N6X0H3 sps_s1_clk_b(
											.IN8(GCLK3),
											.IN9(GCLK2),
											.IN4(S_P10),
											.IN5(N_P18),
											.IN6(W_P16),
											.IN7(E_P15),
											.IN0(N_P13),
											.IN1(S_P15),
											.IN2(V6A2),
											.IN3(V6N2),
											.OUT(S1_CLK_B),
											.IN14(V6M2),
											.IN15(V6B2),
											.IN12(V6D2),
											.IN13(V6C2),
											.IN10(GCLK1),
											.IN11(GCLK0),
											._1(1)
		);

		SPS6B3X11H1 sps_h6e11(
											.IN4(V6N6),
											.IN5(V6S11),
											.IN0(H6W11),
											.IN1(OUT6),
											.IN2(V6M10),
											.IN3(V6M11),
											.OUT(H6E11),
											._1(1)
		);

		SWITCH2N1X0H1 switch_n22_e18(
											.SOURCE(E18),
											.DRAIN(N22)
		);

		SWITCH2N1X0H1 switch_n10_e6(
											.SOURCE(E6),
											.DRAIN(N10)
		);

		SWITCH2N1X0H1 switch_s23_w1(
											.SOURCE(W1),
											.DRAIN(S23)
		);

		SWITCH2N1X0H1 switch_s7_w9(
											.SOURCE(W9),
											.DRAIN(S7)
		);

		SWITCH2N1X0H1 switch_n20_e16(
											.SOURCE(E16),
											.DRAIN(N20)
		);

		SWITCH2N1X0H1 switch_s22_w20(
											.SOURCE(W20),
											.DRAIN(S22)
		);

		SPS13B6X6H1 sps_out1(
											.IN8(S1_XQ),
											.IN9(S1_YQ),
											.IN4(S0_XB),
											.IN5(S0_YB),
											.IN6(S1_X),
											.IN7(S1_Y),
											.IN0(S0_X),
											.IN1(S0_Y),
											.IN2(S0_XQ),
											.IN3(S0_YQ),
											.IN11(S1_YB),
											.IN12(VDD),
											.IN10(TBUFO),
											.OUT(OUT1),
											._1(1)
		);

		SWITCH2N1X0H2 switch_s14_n14(
											.SOURCE(N14),
											.DRAIN(S14)
		);

		SPS16N6X0H3 sps_s0_ce_b(
											.IN8(E_P2),
											.IN9(V6A3),
											.IN4(S_P6),
											.IN5(E_P12),
											.IN6(N_P19),
											.IN7(N_P22),
											.IN0(V6D3),
											.IN1(V6C3),
											.IN2(V6M3),
											.IN3(V6B3),
											.OUT(S0_CE_B),
											.IN14(S_P21),
											.IN15(W_P22),
											.IN12(S_P5),
											.IN13(W_P7),
											.IN10(V6N3),
											.IN11(N_P23),
											._1(1)
		);

		SPS13B6X6H1 sps_out0(
											.IN8(S1_XQ),
											.IN9(S1_YQ),
											.IN4(S0_XB),
											.IN5(S0_YB),
											.IN6(S1_X),
											.IN7(S1_Y),
											.IN0(S0_X),
											.IN1(S0_Y),
											.IN2(S0_XQ),
											.IN3(S0_YQ),
											.IN11(S1_YB),
											.IN12(VDD),
											.IN10(TBUFO),
											.OUT(OUT0),
											._1(1)
		);

		SPS6T4X11H1 sps_v6s3(
											.IN4(H6E2),
											.IN5(V6N3),
											.IN0(OUT6),
											.IN1(LLV6),
											.IN2(H6W3),
											.IN3(H6M3),
											.OUT(V6S3),
											._1(1)
		);

		SWITCH2N1X0H2 switch_s12_n12(
											.SOURCE(N12),
											.DRAIN(S12)
		);

		SPS6B3X11H1 sps_h6w4(
											.IN4(V6S5),
											.IN5(H6E4),
											.IN0(OUT0),
											.IN1(V6M4),
											.IN2(V6M5),
											.IN3(V6N10),
											.OUT(H6W4),
											._1(1)
		);

		SPS16N6X0H3 sps_s0_by_b(
											.IN8(W_P0),
											.IN9(E_P1),
											.IN4(E_P19),
											.IN5(E_P3),
											.IN6(S_P9),
											.IN7(N_P5),
											.IN0(S_P14),
											.IN1(N_P11),
											.IN2(W_P4),
											.IN3(E_P7),
											.OUT(S0_BY_B),
											.IN14(W_P8),
											.IN15(N_P6),
											.IN12(S_P0),
											.IN13(W_P14),
											.IN10(N_P2),
											.IN11(S_P8),
											._1(1)
		);

		SPS6T4X11H1 sps_h6w0(
											.IN4(V6N0),
											.IN5(V6S1),
											.IN0(H6E0),
											.IN1(LLH0),
											.IN2(OUT1),
											.IN3(V6M0),
											.OUT(H6W0),
											._1(1)
		);

		SPS6T4X11H1 sps_h6w1(
											.IN4(V6N1),
											.IN5(V6S2),
											.IN0(H6E1),
											.IN1(LLH0),
											.IN2(OUT3),
											.IN3(V6M1),
											.OUT(H6W1),
											._1(1)
		);

		SPS6T4X11H1 sps_h6w2(
											.IN4(V6N2),
											.IN5(V6S3),
											.IN0(H6E2),
											.IN1(LLH6),
											.IN2(OUT5),
											.IN3(V6M2),
											.OUT(H6W2),
											._1(1)
		);

		SPS6T4X11H1 sps_h6w3(
											.IN4(V6S0),
											.IN5(H6E3),
											.IN0(LLH6),
											.IN1(OUT7),
											.IN2(V6M3),
											.IN3(V6N3),
											.OUT(H6W3),
											._1(1)
		);

		SPS2N2X0H1 sps_w23(
											.IN0(H6E10),
											.IN1(OUT7),
											.OUT(W23),
											._1(1)
		);

		SPS2N2X0H1 sps_w22(
											.IN0(V6S11),
											.IN1(OUT7),
											.OUT(W22),
											._1(1)
		);

		SPS2N2X0H1 sps_w21(
											.IN0(V6S3),
											.IN1(OUT6),
											.OUT(W21),
											._1(1)
		);

		SPS2N2X0H1 sps_w20(
											.IN0(V6M3),
											.IN1(V6N10),
											.OUT(W20),
											._1(1)
		);

		SPS6B3X11H1 sps_h6w8(
											.IN4(V6S9),
											.IN5(H6E8),
											.IN0(OUT2),
											.IN1(V6M8),
											.IN2(V6M9),
											.IN3(V6N4),
											.OUT(H6W8),
											._1(1)
		);

		SPS8N4X0H1 sps_t_in0(
											.IN4(OUT2),
											.IN5(OUT1),
											.IN6(W_P6),
											.IN7(E_P5),
											.IN0(E_P22),
											.IN1(W_P11),
											.IN2(S_P2),
											.IN3(N_P4),
											.OUT(T_IN0),
											._1(1)
		);

		SPS8N4X0H1 sps_t_in1(
											.IN4(W_P10),
											.IN5(E_P23),
											.IN6(S_P13),
											.IN7(W_P17),
											.IN0(N_P14),
											.IN1(OUT6),
											.IN2(OUT5),
											.IN3(E_P18),
											.OUT(T_IN1),
											._1(1)
		);

		SWITCH2N1X0H2 switch_s22_n22(
											.SOURCE(N22),
											.DRAIN(S22)
		);

		SWITCH2N1X0H1 switch_s20_e18(
											.SOURCE(E18),
											.DRAIN(S20)
		);

		SPS6T4X11H1 sps_v6n1(
											.IN4(H6M1),
											.IN5(H6E0),
											.IN0(V6S1),
											.IN1(OUT2),
											.IN2(LLV0),
											.IN3(H6W1),
											.OUT(V6N1),
											._1(1)
		);

		SPS6T4X11H1 sps_v6n0(
											.IN4(H6M0),
											.IN5(H6E3),
											.IN0(V6S0),
											.IN1(OUT0),
											.IN2(LLV0),
											.IN3(H6W0),
											.OUT(V6N0),
											._1(1)
		);

		SPS6T4X11H1 sps_v6n3(
											.IN4(H6M3),
											.IN5(H6E2),
											.IN0(V6S3),
											.IN1(OUT6),
											.IN2(LLV6),
											.IN3(H6W3),
											.OUT(V6N3),
											._1(1)
		);

		SPS6T4X11H1 sps_v6n2(
											.IN4(H6M2),
											.IN5(H6E1),
											.IN0(V6S2),
											.IN1(OUT4),
											.IN2(LLV6),
											.IN3(H6W2),
											.OUT(V6N2),
											._1(1)
		);

		SPS6B3X11H1 sps_v6n5(
											.IN4(H6E4),
											.IN5(V6S5),
											.IN0(OUT1),
											.IN1(H6W9),
											.IN2(H6M5),
											.IN3(H6M4),
											.OUT(V6N5),
											._1(1)
		);

		SPS6B3X11H1 sps_v6n7(
											.IN4(H6E6),
											.IN5(V6S7),
											.IN0(OUT5),
											.IN1(H6W11),
											.IN2(H6M7),
											.IN3(H6M6),
											.OUT(V6N7),
											._1(1)
		);

		SPS6B3X11H1 sps_v6n9(
											.IN4(H6E8),
											.IN5(V6S9),
											.IN0(OUT3),
											.IN1(H6W7),
											.IN2(H6M9),
											.IN3(H6M8),
											.OUT(V6N9),
											._1(1)
		);

		SWITCH2N1X0H1 switch_s0_e22(
											.SOURCE(E22),
											.DRAIN(S0)
		);

		BUF1B0X2H5 buf_w5(
											.A(W5),
											.Y(W_P5)
		);

		BUF1B0X2H5 buf_w4(
											.A(W4),
											.Y(W_P4)
		);

		BUF1B0X2H5 buf_w7(
											.A(W7),
											.Y(W_P7)
		);

		BUF1B0X2H5 buf_w6(
											.A(W6),
											.Y(W_P6)
		);

		BUF1B0X2H5 buf_w1(
											.A(W1),
											.Y(W_P1)
		);

		BUF1B0X2H5 buf_w0(
											.A(W0),
											.Y(W_P0)
		);

		BUF1B0X2H5 buf_w3(
											.A(W3),
											.Y(W_P3)
		);

		BUF1B0X2H5 buf_w2(
											.A(W2),
											.Y(W_P2)
		);

		SWITCH2N1X0H1 switch_s1_w7(
											.SOURCE(W7),
											.DRAIN(S1)
		);

		BUF1B0X2H5 buf_w9(
											.A(W9),
											.Y(W_P9)
		);

		BUF1B0X2H5 buf_w8(
											.A(W8),
											.Y(W_P8)
		);

		BUF1B0X5H1 buf_tbufo(
											.OUT(TBUFO),
											.IN(TBUF2)
		);

		SPS13B6X6H1 sps_out7(
											.IN8(S1_XQ),
											.IN9(S1_YQ),
											.IN4(TBUFO),
											.IN5(S0_YB),
											.IN6(S1_X),
											.IN7(S1_Y),
											.IN0(S0_X),
											.IN1(S0_Y),
											.IN2(S0_XQ),
											.IN3(S0_YQ),
											.IN11(S1_YB),
											.IN12(VDD),
											.IN10(S1_XB),
											.OUT(OUT7),
											._1(1)
		);

		SPS13B6X6H1 sps_out6(
											.IN8(S1_XQ),
											.IN9(S1_YQ),
											.IN4(TBUFO),
											.IN5(S0_YB),
											.IN6(S1_X),
											.IN7(S1_Y),
											.IN0(S0_X),
											.IN1(S0_Y),
											.IN2(S0_XQ),
											.IN3(S0_YQ),
											.IN11(S1_YB),
											.IN12(VDD),
											.IN10(S1_XB),
											.OUT(OUT6),
											._1(1)
		);

		SPS13B6X6H1 sps_out5(
											.IN8(S1_XQ),
											.IN9(S1_YQ),
											.IN4(S0_XB),
											.IN5(TBUFO),
											.IN6(S1_X),
											.IN7(S1_Y),
											.IN0(S0_X),
											.IN1(S0_Y),
											.IN2(S0_XQ),
											.IN3(S0_YQ),
											.IN11(S1_YB),
											.IN12(VDD),
											.IN10(S1_XB),
											.OUT(OUT5),
											._1(1)
		);

		SPS13B6X6H1 sps_out4(
											.IN8(S1_XQ),
											.IN9(S1_YQ),
											.IN4(S0_XB),
											.IN5(TBUFO),
											.IN6(S1_X),
											.IN7(S1_Y),
											.IN0(S0_X),
											.IN1(S0_Y),
											.IN2(S0_XQ),
											.IN3(S0_YQ),
											.IN11(S1_YB),
											.IN12(VDD),
											.IN10(S1_XB),
											.OUT(OUT4),
											._1(1)
		);

		SPS13B6X6H1 sps_out3(
											.IN8(S1_XQ),
											.IN9(S1_YQ),
											.IN4(S0_XB),
											.IN5(S0_YB),
											.IN6(S1_X),
											.IN7(S1_Y),
											.IN0(S0_X),
											.IN1(S0_Y),
											.IN2(S0_XQ),
											.IN3(S0_YQ),
											.IN11(TBUFO),
											.IN12(VDD),
											.IN10(S1_XB),
											.OUT(OUT3),
											._1(1)
		);

		SPS13B6X6H1 sps_out2(
											.IN8(S1_XQ),
											.IN9(S1_YQ),
											.IN4(S0_XB),
											.IN5(S0_YB),
											.IN6(S1_X),
											.IN7(S1_Y),
											.IN0(S0_X),
											.IN1(S0_Y),
											.IN2(S0_XQ),
											.IN3(S0_YQ),
											.IN11(TBUFO),
											.IN12(VDD),
											.IN10(S1_XB),
											.OUT(OUT2),
											._1(1)
		);

		BUF1B0X2H5 buf_e9(
											.A(E9),
											.Y(E_P9)
		);

		BUF1B0X2H5 buf_e8(
											.A(E8),
											.Y(E_P8)
		);

		BUF1B0X2H5 buf_e7(
											.A(E7),
											.Y(E_P7)
		);

		BUF1B0X2H5 buf_e6(
											.A(E6),
											.Y(E_P6)
		);

		BUF1B0X2H5 buf_e5(
											.A(E5),
											.Y(E_P5)
		);

		BUF1B0X2H5 buf_e4(
											.A(E4),
											.Y(E_P4)
		);

		BUF1B0X2H5 buf_e3(
											.A(E3),
											.Y(E_P3)
		);

		BUF1B0X2H5 buf_e2(
											.A(E2),
											.Y(E_P2)
		);

		BUF1B0X2H5 buf_e1(
											.A(E1),
											.Y(E_P1)
		);

		BUF1B0X2H5 buf_e0(
											.A(E0),
											.Y(E_P0)
		);

		SPS6B3X11H1 sps_h6e9(
											.IN4(V6N4),
											.IN5(V6S9),
											.IN0(H6W9),
											.IN1(OUT2),
											.IN2(V6M8),
											.IN3(V6M9),
											.OUT(H6E9),
											._1(1)
		);

		SPS6T4X11H1 sps_h6e2(
											.IN4(V6S3),
											.IN5(H6W2),
											.IN0(LLH6),
											.IN1(OUT5),
											.IN2(V6M2),
											.IN3(V6N2),
											.OUT(H6E2),
											._1(1)
		);

		SPS6T4X11H1 sps_h6e3(
											.IN4(V6N3),
											.IN5(V6S0),
											.IN0(H6W3),
											.IN1(LLH6),
											.IN2(OUT7),
											.IN3(V6M3),
											.OUT(H6E3),
											._1(1)
		);

		SPS6T4X11H1 sps_h6e0(
											.IN4(V6S1),
											.IN5(H6W0),
											.IN0(LLH0),
											.IN1(OUT1),
											.IN2(V6M0),
											.IN3(V6N0),
											.OUT(H6E0),
											._1(1)
		);

		SPS6T4X11H1 sps_h6e1(
											.IN4(V6S2),
											.IN5(H6W1),
											.IN0(LLH0),
											.IN1(OUT3),
											.IN2(V6M1),
											.IN3(V6N1),
											.OUT(H6E1),
											._1(1)
		);

		SPS6B3X11H1 sps_h6e7(
											.IN4(V6N8),
											.IN5(V6S7),
											.IN0(H6W7),
											.IN1(OUT4),
											.IN2(V6M6),
											.IN3(V6M7),
											.OUT(H6E7),
											._1(1)
		);

		SPS6B3X11H1 sps_h6e5(
											.IN4(V6N10),
											.IN5(V6S5),
											.IN0(H6W5),
											.IN1(OUT0),
											.IN2(V6M4),
											.IN3(V6M5),
											.OUT(H6E5),
											._1(1)
		);

		BUF1B0X2H5 buf_s20(
											.A(S20),
											.Y(S_P20)
		);

		BUF1B0X2H5 buf_s21(
											.A(S21),
											.Y(S_P21)
		);

		BUF1B0X2H5 buf_s22(
											.A(S22),
											.Y(S_P22)
		);

		BUF1B0X2H5 buf_s23(
											.A(S23),
											.Y(S_P23)
		);

		SWITCH2N1X0H2 switch_s17_n17(
											.SOURCE(N17),
											.DRAIN(S17)
		);

		SWITCH2N1X0H1 switch_s22_e16(
											.SOURCE(E16),
											.DRAIN(S22)
		);

		SWITCH2N1X0H1 switch_n2_w7(
											.SOURCE(W7),
											.DRAIN(N2)
		);

		SPS28N9X0H1 sps_s1_f_b1(
											.IN8(W_P14),
											.IN9(N_P10),
											.IN4(W_P11),
											.IN5(E_P0),
											.IN6(E_P4),
											.IN7(E_P17),
											.IN0(GND),
											.IN1(E_P16),
											.IN2(E_P19),
											.IN3(E_P22),
											.IN18(N_P0),
											.IN19(W_P9),
											.IN16(E_P8),
											.IN17(N_P1),
											.IN14(S_P18),
											.IN15(S_P11),
											.IN12(W_P3),
											.IN13(S_P9),
											.IN10(N_P7),
											.IN11(S_P2),
											.OUT(S1_F_B1),
											.IN23(W_P1),
											.IN22(S_P8),
											.IN21(N_P5),
											.IN20(S_P16),
											.IN27(VDD),
											.IN26(OUT_E6),
											.IN25(S0_X),
											.IN24(N_P3),
											._1(1)
		);

		SWITCH2N1X0H2 switch_e11_w11(
											.SOURCE(W11),
											.DRAIN(E11)
		);

		SWITCH2N1X0H2 switch_s19_n19(
											.SOURCE(N19),
											.DRAIN(S19)
		);

		SWITCH2N1X0H1 switch_s15_w17(
											.SOURCE(W17),
											.DRAIN(S15)
		);

		SWITCH2N1X0H1 switch_n14_w19(
											.SOURCE(W19),
											.DRAIN(N14)
		);

		BUF1B0X2H5 buf_n21(
											.A(N21),
											.Y(N_P21)
		);

		BUF1B0X2H5 buf_n20(
											.A(N20),
											.Y(N_P20)
		);

		BUF1B0X2H5 buf_n23(
											.A(N23),
											.Y(N_P23)
		);

		BUF1B0X2H5 buf_n22(
											.A(N22),
											.Y(N_P22)
		);

		SWITCH2N1X0H1 switch_s12_w14(
											.SOURCE(W14),
											.DRAIN(S12)
		);

		SWITCH2N1X0H1 switch_s14_e8(
											.SOURCE(E8),
											.DRAIN(S14)
		);

		SWITCH2N1X0H1 switch_n6_w11(
											.SOURCE(W11),
											.DRAIN(N6)
		);

		SWITCH2N1X0H2 switch_e6_w6(
											.SOURCE(W6),
											.DRAIN(E6)
		);

		SWITCH2N1X0H1 switch_n23_e23(
											.SOURCE(E23),
											.DRAIN(N23)
		);

		SWITCH2N1X0H2 switch_e14_w14(
											.SOURCE(W14),
											.DRAIN(E14)
		);

		SWITCH2N1X0H2 switch_s8_n8(
											.SOURCE(N8),
											.DRAIN(S8)
		);

		SWITCH2N1X0H2 switch_s10_n10(
											.SOURCE(N10),
											.DRAIN(S10)
		);

		SPS16N6X0H3 sps_s0_sr_b(
											.IN8(W_P23),
											.IN9(V6A1),
											.IN4(S_P22),
											.IN5(W_P15),
											.IN6(N_P8),
											.IN7(E_P10),
											.IN0(S_P1),
											.IN1(V6N1),
											.IN2(N_P17),
											.IN3(N_P12),
											.OUT(S0_SR_B),
											.IN14(V6C1),
											.IN15(V6D1),
											.IN12(E_P21),
											.IN13(S_P7),
											.IN10(V6B1),
											.IN11(V6M1),
											._1(1)
		);

		SWITCH2N1X0H1 switch_s18_e12(
											.SOURCE(E12),
											.DRAIN(S18)
		);

		SWITCH2N1X0H2 switch_e0_w0(
											.SOURCE(W0),
											.DRAIN(E0)
		);

		BUFDUMMY coupling_s0_x(
											.IN(S0_F5),
											.OUT(S0_X)
		);

		SWITCH2N1X0H2 switch_s18_n18(
											.SOURCE(N18),
											.DRAIN(S18)
		);

		SWITCH2N1X0H2 switch_s11_n11(
											.SOURCE(N11),
											.DRAIN(S11)
		);

		BUF1B0X2H5 buf_s9(
											.A(S9),
											.Y(S_P9)
		);

		BUF1B0X2H5 buf_s8(
											.A(S8),
											.Y(S_P8)
		);

		SWITCH2N1X0H1 switch_n16_w21(
											.SOURCE(W21),
											.DRAIN(N16)
		);

		BUF1B0X2H5 buf_s1(
											.A(S1),
											.Y(S_P1)
		);

		BUF1B0X2H5 buf_s0(
											.A(S0),
											.Y(S_P0)
		);

		BUF1B0X2H5 buf_s3(
											.A(S3),
											.Y(S_P3)
		);

		BUF1B0X2H5 buf_s2(
											.A(S2),
											.Y(S_P2)
		);

		BUF1B0X2H5 buf_s5(
											.A(S5),
											.Y(S_P5)
		);

		BUF1B0X2H5 buf_s4(
											.A(S4),
											.Y(S_P4)
		);

		BUF1B0X2H5 buf_s7(
											.A(S7),
											.Y(S_P7)
		);

		BUF1B0X2H5 buf_s6(
											.A(S6),
											.Y(S_P6)
		);

		SWITCH2N1X0H1 switch_n15_e15(
											.SOURCE(E15),
											.DRAIN(N15)
		);

		SWITCH2N1X0H1 switch_s4_w6(
											.SOURCE(W6),
											.DRAIN(S4)
		);

		SWITCH2N1X0H2 switch_s23_n23(
											.SOURCE(N23),
											.DRAIN(S23)
		);

		SPS6B3X11H1 sps_h6w6(
											.IN4(V6S7),
											.IN5(H6E6),
											.IN0(OUT4),
											.IN1(V6M6),
											.IN2(V6M7),
											.IN3(V6N8),
											.OUT(H6W6),
											._1(1)
		);

		SPBU1AND1X10H1 spbu_tbuf0(
											.OUT(TBUF0),
											.IN(TBUF_OUT0)
		);

		SPBU1AND1X10H1 spbu_tbuf1(
											.OUT(TBUF1),
											.IN(TBUF_OUT1)
		);

		SPBU1AND1X10H1 spbu_tbuf2(
											.IN(TBUF_OUT0),
											.OUT(TBUF2)
		);

		SPBU1AND1X10H1 spbu_tbuf3(
											.OUT(TBUF3),
											.IN(TBUF_OUT1)
		);

		SWITCH2N1X0H2 switch_e3_w3(
											.SOURCE(W3),
											.DRAIN(E3)
		);

		SWITCH2N1X0H2 switch_s6_n6(
											.SOURCE(N6),
											.DRAIN(S6)
		);

		SWITCH2N1X0H2 switch_e20_w20(
											.SOURCE(W20),
											.DRAIN(E20)
		);

		SPS6B3X11H1 sps_v6n11(
											.IN4(H6E10),
											.IN5(V6S11),
											.IN0(OUT7),
											.IN1(H6W5),
											.IN2(H6M11),
											.IN3(H6M10),
											.OUT(V6N11),
											._1(1)
		);

		SWITCH2N1X0H1 switch_n21_e21(
											.SOURCE(E21),
											.DRAIN(N21)
		);

		SWITCH2N1X0H2 switch_s4_n4(
											.SOURCE(N4),
											.DRAIN(S4)
		);

		BUFDUMMY buf_s0_f5in(
											.OUT(S0_F5IN),
											.IN(S1_F5)
		);

		SWITCH2N1X0H2 switch_s9_n9(
											.SOURCE(N9),
											.DRAIN(S9)
		);

		SWITCH2N1X0H1 switch_s13_e15(
											.SOURCE(E15),
											.DRAIN(S13)
		);

		SWITCH2N1X0H1 switch_n9_e9(
											.SOURCE(E9),
											.DRAIN(N9)
		);

		SWITCH2N1X0H2 switch_s2_n2(
											.SOURCE(N2),
											.DRAIN(S2)
		);

		SWITCH2N1X0H1 switch_s6_w4(
											.SOURCE(W4),
											.DRAIN(S6)
		);

		SWITCH2N1X0H1 switch_n18_e14(
											.SOURCE(E14),
											.DRAIN(N18)
		);

		SWITCH2N1X0H1 switch_s4_e2(
											.SOURCE(E2),
											.DRAIN(S4)
		);

		SWITCH2N1X0H1 switch_s2_w0(
											.SOURCE(W0),
											.DRAIN(S2)
		);

		BUF1B0X2H5 buf_w20(
											.A(W20),
											.Y(W_P20)
		);

		BUF1B0X2H5 buf_w21(
											.A(W21),
											.Y(W_P21)
		);

		BUF1B0X2H5 buf_w22(
											.A(W22),
											.Y(W_P22)
		);

		BUF1B0X2H5 buf_w23(
											.A(W23),
											.Y(W_P23)
		);

		SWITCH2N1X0H1 switch_n4_e0(
											.SOURCE(E0),
											.DRAIN(N4)
		);

		SWITCH2N1X0H1 switch_n2_e22(
											.SOURCE(E22),
											.DRAIN(N2)
		);

		SWITCH2N1X0H1 switch_n10_w15(
											.SOURCE(W15),
											.DRAIN(N10)
		);

		SWITCH2N1X0H1 switch_n16_e12(
											.SOURCE(E12),
											.DRAIN(N16)
		);

		SWITCH2N1X0H1 switch_n17_e17(
											.SOURCE(E17),
											.DRAIN(N17)
		);

		SWITCH2N1X0H1 switch_n4_w9(
											.SOURCE(W9),
											.DRAIN(N4)
		);

		SWITCH2N1X0H1 switch_s9_e11(
											.SOURCE(E11),
											.DRAIN(S9)
		);

		SWITCH2N1X0H1 switch_s6_e0(
											.SOURCE(E0),
											.DRAIN(S6)
		);

		SPS16N6X0H3 sps_s1_sr_b(
											.IN8(E_P21),
											.IN9(S_P7),
											.IN4(S_P22),
											.IN5(W_P15),
											.IN6(N_P8),
											.IN7(E_P10),
											.IN0(S_P1),
											.IN1(V6N1),
											.IN2(N_P17),
											.IN3(N_P12),
											.OUT(S1_SR_B),
											.IN14(V6B1),
											.IN15(V6M1),
											.IN12(W_P23),
											.IN13(V6A1),
											.IN10(V6C1),
											.IN11(V6D1),
											._1(1)
		);

		SWITCH2N1X0H2 switch_e2_w2(
											.SOURCE(W2),
											.DRAIN(E2)
		);

		BUF1B0X2H5 buf_s19(
											.A(S19),
											.Y(S_P19)
		);

		BUF1B0X2H5 buf_s18(
											.A(S18),
											.Y(S_P18)
		);

		BUF1B0X2H5 buf_s15(
											.A(S15),
											.Y(S_P15)
		);

		BUF1B0X2H5 buf_s14(
											.A(S14),
											.Y(S_P14)
		);

		BUF1B0X2H5 buf_s17(
											.A(S17),
											.Y(S_P17)
		);

		BUF1B0X2H5 buf_s16(
											.A(S16),
											.Y(S_P16)
		);

		BUF1B0X2H5 buf_s11(
											.A(S11),
											.Y(S_P11)
		);

		BUF1B0X2H5 buf_s10(
											.A(S10),
											.Y(S_P10)
		);

		BUF1B0X2H5 buf_s13(
											.A(S13),
											.Y(S_P13)
		);

		BUF1B0X2H5 buf_s12(
											.A(S12),
											.Y(S_P12)
		);

		SWITCH2N1X0H1 switch_n3_w4(
											.SOURCE(W4),
											.DRAIN(N3)
		);

		SWITCH2N1X0H1 switch_s19_w21(
											.SOURCE(W21),
											.DRAIN(S19)
		);

		SWITCH2N1X0H2 switch_e15_w15(
											.SOURCE(W15),
											.DRAIN(E15)
		);

		SPS6B3X11H1 sps_v6s10(
											.IN4(H6M10),
											.IN5(H6E10),
											.IN0(V6N10),
											.IN1(OUT7),
											.IN2(H6W5),
											.IN3(H6M11),
											.OUT(V6S10),
											._1(1)
		);

		SWITCH2N1X0H1 switch_s3_e1(
											.SOURCE(E1),
											.DRAIN(S3)
		);

		SWITCH2N1X0H1 switch_s21_w3(
											.SOURCE(W3),
											.DRAIN(S21)
		);

		SWITCH2N1X0H2 switch_s13_n13(
											.SOURCE(N13),
											.DRAIN(S13)
		);

		SWITCH2N1X0H1 switch_s12_e10(
											.SOURCE(E10),
											.DRAIN(S12)
		);

		SWITCH2N1X0H1 switch_s5_w11(
											.SOURCE(W11),
											.DRAIN(S5)
		);

		SWITCH2N1X0H1 switch_n0_w5(
											.SOURCE(W5),
											.DRAIN(N0)
		);

		SWITCH2N1X0H2 switch_e13_w13(
											.SOURCE(W13),
											.DRAIN(E13)
		);

		SWITCH2N1X0H1 switch_s16_w18(
											.SOURCE(W18),
											.DRAIN(S16)
		);

		SPS2N2X0H1 sps_n22(
											.IN0(V6S11),
											.IN1(H6M3),
											.OUT(N22),
											._1(1)
		);

		SPS1N1X0H1 sps_n23(
											.IN(H6M11),
											.OUT(N23),
											._1(1)
		);

		SPS2N2X0H1 sps_n20(
											.IN0(OUT6),
											.IN1(H6W11),
											.OUT(N20),
											._1(1)
		);

		SPS2N2X0H1 sps_n21(
											.IN0(H6E10),
											.IN1(OUT7),
											.OUT(N21),
											._1(1)
		);

		SWITCH2N1X0H1 switch_n6_e2(
											.SOURCE(E2),
											.DRAIN(N6)
		);

		SWITCH2N1X0H2 switch_e12_w12(
											.SOURCE(W12),
											.DRAIN(E12)
		);

		SWITCH2N1X0H2 switch_s3_n3(
											.SOURCE(N3),
											.DRAIN(S3)
		);

		SWITCH2N1X0H1 switch_n19_e19(
											.SOURCE(E19),
											.DRAIN(N19)
		);

		SWITCH2N1X0H1 switch_s11_w13(
											.SOURCE(W13),
											.DRAIN(S11)
		);

		SWITCH2N1X0H1 switch_n3_e3(
											.SOURCE(E3),
											.DRAIN(N3)
		);

		SWITCH2N1X0H1 switch_n13_w14(
											.SOURCE(W14),
											.DRAIN(N13)
		);

		SWITCH2N1X0H2 switch_e5_w5(
											.SOURCE(W5),
											.DRAIN(E5)
		);

		SWITCH2N1X0H2 switch_s1_n1(
											.SOURCE(N1),
											.DRAIN(S1)
		);

		BUF1B0X2H5 buf_n8(
											.A(N8),
											.Y(N_P8)
		);

		BUF1B0X2H5 buf_n9(
											.A(N9),
											.Y(N_P9)
		);

		BUF1B0X2H5 buf_n6(
											.A(N6),
											.Y(N_P6)
		);

		BUF1B0X2H5 buf_n7(
											.A(N7),
											.Y(N_P7)
		);

		BUF1B0X2H5 buf_n4(
											.A(N4),
											.Y(N_P4)
		);

		BUF1B0X2H5 buf_n5(
											.A(N5),
											.Y(N_P5)
		);

		BUF1B0X2H5 buf_n2(
											.A(N2),
											.Y(N_P2)
		);

		BUF1B0X2H5 buf_n3(
											.A(N3),
											.Y(N_P3)
		);

		BUF1B0X2H5 buf_n0(
											.A(N0),
											.Y(N_P0)
		);

		BUF1B0X2H5 buf_n1(
											.A(N1),
											.Y(N_P1)
		);

		SWITCH2N1X0H1 switch_s14_w12(
											.SOURCE(W12),
											.DRAIN(S14)
		);

		SPS2N2X0H1 sps_e6(
											.IN0(H6W9),
											.IN1(OUT2),
											.OUT(E6),
											._1(1)
		);

		SPS1N1X0H1 sps_e7(
											.IN(V6M1),
											.OUT(E7),
											._1(1)
		);

		SPS1N1X0H1 sps_e4(
											.IN(V6M9),
											.OUT(E4),
											._1(1)
		);

		SPS2N2X0H1 sps_e5(
											.IN0(V6S5),
											.IN1(OUT1),
											.OUT(E5),
											._1(1)
		);

		SPS1N1X0H1 sps_e2(
											.IN(OUT0),
											.OUT(E2),
											._1(1)
		);

		SPS2N2X0H1 sps_e3(
											.IN0(H6W5),
											.IN1(OUT1),
											.OUT(E3),
											._1(1)
		);

		SPS2N2X0H1 sps_e0(
											.IN0(V6S0),
											.IN1(V6M4),
											.OUT(E0),
											._1(1)
		);

		SPS2N2X0H1 sps_e1(
											.IN0(V6M0),
											.IN1(V6N4),
											.OUT(E1),
											._1(1)
		);

		SPS1N1X0H1 sps_e8(
											.IN(OUT3),
											.OUT(E8),
											._1(1)
		);

		SPS2N2X0H1 sps_e9(
											.IN0(V6M8),
											.IN1(V6N1),
											.OUT(E9),
											._1(1)
		);

		SWITCH2N1X0H1 switch_s3_w5(
											.SOURCE(W5),
											.DRAIN(S3)
		);

		SWITCH2N1X0H2 switch_e9_w9(
											.SOURCE(W9),
											.DRAIN(E9)
		);

		SWITCH2N1X0H1 switch_s10_e4(
											.SOURCE(E4),
											.DRAIN(S10)
		);

		SPS1N1X0H1 sps_w0(
											.IN(V6M5),
											.OUT(W0),
											._1(1)
		);

		SPS1N1X0H1 sps_w1(
											.IN(V6M10),
											.OUT(W1),
											._1(1)
		);

		SPS1N1X0H1 sps_w2(
											.IN(V6M4),
											.OUT(W2),
											._1(1)
		);

		SPS2N2X0H1 sps_w3(
											.IN0(V6M0),
											.IN1(H6E4),
											.OUT(W3),
											._1(1)
		);

		SPS2N2X0H1 sps_w4(
											.IN0(V6N0),
											.IN1(OUT1),
											.OUT(W4),
											._1(1)
		);

		SPS2N2X0H1 sps_w5(
											.IN0(H6E0),
											.IN1(OUT1),
											.OUT(W5),
											._1(1)
		);

		SPS2N2X0H1 sps_w6(
											.IN0(V6M9),
											.IN1(H6E1),
											.OUT(W6),
											._1(1)
		);

		SPS1N1X0H1 sps_w7(
											.IN(OUT0),
											.OUT(W7),
											._1(1)
		);

		SPS2N2X0H1 sps_w8(
											.IN0(V6M1),
											.IN1(V6N8),
											.OUT(W8),
											._1(1)
		);

		SPS2N2X0H1 sps_w9(
											.IN0(V6S1),
											.IN1(OUT2),
											.OUT(W9),
											._1(1)
		);

		SWITCH2N1X0H1 switch_s10_w8(
											.SOURCE(W8),
											.DRAIN(S10)
		);

		SWITCH2N1X0H2 switch_s7_n7(
											.SOURCE(N7),
											.DRAIN(S7)
		);

		SWITCH2N1X0H1 switch_n21_w22(
											.SOURCE(W22),
											.DRAIN(N21)
		);

		SPS6B3X11H1 sps_h6w10(
											.IN4(V6S11),
											.IN5(H6E10),
											.IN0(OUT6),
											.IN1(V6M10),
											.IN2(V6M11),
											.IN3(V6N6),
											.OUT(H6W10),
											._1(1)
		);

		SWITCH2N1X0H1 switch_s11_e9(
											.SOURCE(E9),
											.DRAIN(S11)
		);

		SWITCH2N1X0H1 switch_s7_e5(
											.SOURCE(E5),
											.DRAIN(S7)
		);

		SWITCH2N1X0H2 switch_e23_w23(
											.SOURCE(W23),
											.DRAIN(E23)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_UL(
UL_H6E0, UL_H6E1, UL_H6E2, UL_H6E3, UL_H6E4, UL_H6E5, UL_H6A0, UL_H6A1, UL_H6A2, UL_H6A3, UL_H6A4, UL_H6A5, UL_H6B0, UL_H6B1, UL_H6B2, UL_H6B3, UL_H6B4, UL_H6B5, UL_H6M0, UL_H6M1, UL_H6M2, UL_H6M3, UL_H6M4, UL_H6M5, UL_H6C0, UL_H6C1, UL_H6C2, UL_H6C3, UL_H6C4, UL_H6C5, UL_H6D0, UL_H6D1, UL_H6D2, UL_H6D3, UL_H6D4, UL_H6D5, UL_LLV0, UL_LLV1, UL_LLV2, UL_LLV3, UL_LLV4, UL_LLV5, UL_LLV6, UL_LLV7, UL_LLV8, UL_LLV9, UL_LLV10, UL_LLV11, UL_LLH0, UL_LLH1, UL_LLH2, UL_LLH3, UL_LLH4, UL_LLH5, UL_LLH6, UL_LLH7, UL_LLH8, UL_LLH9, UL_LLH10, UL_LLH11, UL_GCLK0, UL_GCLK1, UL_GCLK2, UL_GCLK3, UL_V6A0, UL_V6A1, UL_V6A2, UL_V6A3, UL_V6B0, UL_V6B1, UL_V6B2, UL_V6B3, UL_V6M0, UL_V6M1, UL_V6M2, UL_V6M3, UL_V6C0, UL_V6C1, UL_V6C2, UL_V6C3, UL_V6D0, UL_V6D1, UL_V6D2, UL_V6D3, UL_V6S0, UL_V6S1, UL_V6S2, UL_V6S3, UL_RESET, UL_DRCK1, UL_DRCK2, UL_SHIFT, UL_TDI, UL_TDO1, UL_TDO2, UL_UPDATE, UL_SEL1, UL_SEL2, UL_STARTUP_CLK, UL_GSR, UL_GTS, UL_GWE, _1
);
inout	UL_H6E0;
inout	UL_H6E1;
inout	UL_H6E2;
inout	UL_H6E3;
inout	UL_H6E4;
inout	UL_H6E5;
inout	UL_H6A0;
inout	UL_H6A1;
inout	UL_H6A2;
inout	UL_H6A3;
inout	UL_H6A4;
inout	UL_H6A5;
inout	UL_H6B0;
inout	UL_H6B1;
inout	UL_H6B2;
inout	UL_H6B3;
inout	UL_H6B4;
inout	UL_H6B5;
inout	UL_H6M0;
inout	UL_H6M1;
inout	UL_H6M2;
inout	UL_H6M3;
inout	UL_H6M4;
inout	UL_H6M5;
inout	UL_H6C0;
inout	UL_H6C1;
inout	UL_H6C2;
inout	UL_H6C3;
inout	UL_H6C4;
inout	UL_H6C5;
inout	UL_H6D0;
inout	UL_H6D1;
inout	UL_H6D2;
inout	UL_H6D3;
inout	UL_H6D4;
inout	UL_H6D5;
inout	UL_LLV0;
inout	UL_LLV1;
inout	UL_LLV2;
inout	UL_LLV3;
inout	UL_LLV4;
inout	UL_LLV5;
inout	UL_LLV6;
inout	UL_LLV7;
inout	UL_LLV8;
inout	UL_LLV9;
inout	UL_LLV10;
inout	UL_LLV11;
inout	UL_LLH0;
inout	UL_LLH1;
inout	UL_LLH2;
inout	UL_LLH3;
inout	UL_LLH4;
inout	UL_LLH5;
inout	UL_LLH6;
inout	UL_LLH7;
inout	UL_LLH8;
inout	UL_LLH9;
inout	UL_LLH10;
inout	UL_LLH11;
inout	UL_GCLK0;
inout	UL_GCLK1;
inout	UL_GCLK2;
inout	UL_GCLK3;
inout	UL_V6A0;
inout	UL_V6A1;
inout	UL_V6A2;
inout	UL_V6A3;
inout	UL_V6B0;
inout	UL_V6B1;
inout	UL_V6B2;
inout	UL_V6B3;
inout	UL_V6M0;
inout	UL_V6M1;
inout	UL_V6M2;
inout	UL_V6M3;
inout	UL_V6C0;
inout	UL_V6C1;
inout	UL_V6C2;
inout	UL_V6C3;
inout	UL_V6D0;
inout	UL_V6D1;
inout	UL_V6D2;
inout	UL_V6D3;
inout	UL_V6S0;
inout	UL_V6S1;
inout	UL_V6S2;
inout	UL_V6S3;
inout	UL_RESET;
inout	UL_DRCK1;
inout	UL_DRCK2;
inout	UL_SHIFT;
inout	UL_TDI;
inout	UL_TDO1;
inout	UL_TDO2;
inout	UL_UPDATE;
inout	UL_SEL1;
inout	UL_SEL2;
inout	UL_STARTUP_CLK;
inout	UL_GSR;
inout	UL_GTS;
inout	UL_GWE;
inout	_1;

		SPS24B10X11H1 sps_gwe(
											.IN8(UL_V6M3),
											.IN9(UL_V6C3),
											.IN4(UL_H6B0),
											.IN5(UL_H6B1),
											.IN6(UL_V6A3),
											.IN7(UL_V6B3),
											.IN0(UL_H6E0),
											.IN1(UL_H6E1),
											.IN2(UL_H6A0),
											.IN3(UL_H6A1),
											.IN18(UL_H6M0),
											.IN19(UL_H6M1),
											.IN16(UL_V6D2),
											.IN17(UL_V6S2),
											.IN14(UL_V6M2),
											.IN15(UL_V6C2),
											.IN12(UL_V6A2),
											.IN13(UL_V6B2),
											.IN10(UL_V6D3),
											.IN11(UL_V6S3),
											.OUT(UL_GWE),
											.IN23(UL_H6D1),
											.IN22(UL_H6D0),
											.IN21(UL_H6C1),
											.IN20(UL_H6C0),
											._1(1)
		);

		SPS1T1X7H1 sps_llv7(
											.OUT(UL_LLV7),
											.IN(UL_H6D4)
		);

		SPS3T3X7H1 sps_v6m0(
											.IN3(UL_H6B0),
											.IN1(UL_LLV3),
											.IN2(UL_SHIFT),
											.OUT(UL_V6M0),
											._1(1)
		);

		SPS3T3X7H1 sps_v6a0(
											.IN3(UL_H6E0),
											.IN1(UL_LLV5),
											.IN2(UL_DRCK2),
											.OUT(UL_V6A0),
											._1(1)
		);

		SPS3T3X7H1 sps_v6m2(
											.IN3(UL_H6B2),
											.IN1(UL_LLV9),
											.IN2(UL_RESET),
											.OUT(UL_V6M2),
											._1(1)
		);

		SPS1T1X7H1 sps_llv6(
											.OUT(UL_LLV6),
											.IN(UL_H6E4)
		);

		SPS3T3X7H1 sps_v6s3(
											.IN3(UL_H6D3),
											.IN1(UL_LLV6),
											.IN2(UL_TDI),
											.OUT(UL_V6S3),
											._1(1)
		);

		SPS3T3X7H1 sps_v6a1(
											.IN3(UL_H6E1),
											.IN1(UL_LLV5),
											.IN2(UL_SHIFT),
											.OUT(UL_V6A1),
											._1(1)
		);

		SPS3T3X7H1 sps_h6m2(
											.OUT(UL_H6M2),
											.IN1(UL_LLH3),
											.IN2(UL_TDI),
											.IN3(UL_V6C2),
											._1(1)
		);

		SPS3T3X7H1 sps_h6m3(
											.OUT(UL_H6M3),
											.IN1(UL_LLH3),
											.IN2(UL_SEL2),
											.IN3(UL_V6C3),
											._1(1)
		);

		SPS3T3X7H1 sps_h6m0(
											.OUT(UL_H6M0),
											.IN1(UL_LLH9),
											.IN2(UL_DRCK1),
											.IN3(UL_V6C0),
											._1(1)
		);

		SPS3T3X7H1 sps_h6m1(
											.OUT(UL_H6M1),
											.IN1(UL_LLH9),
											.IN2(UL_UPDATE),
											.IN3(UL_V6C1),
											._1(1)
		);

		SPS1T1X7H1 sps_llv5(
											.OUT(UL_LLV5),
											.IN(UL_H6A5)
		);

		SPS1T1X7H1 sps_llv4(
											.OUT(UL_LLV4),
											.IN(UL_H6B5)
		);

		SPS2T2X7H1 sps_h6m4(
											.IN0(UL_LLH9),
											.IN1(UL_LLH3),
											.OUT(UL_H6M4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m5(
											.IN0(UL_LLH9),
											.IN1(UL_LLH3),
											.OUT(UL_H6M5),
											._1(1)
		);

		SPS1T1X7H1 sps_llv9(
											.OUT(UL_LLV9),
											.IN(UL_H6M4)
		);

		SPS1T1X7H1 sps_llv8(
											.OUT(UL_LLV8),
											.IN(UL_H6C4)
		);

		SPS24B10X11H1 sps_gsr(
											.IN8(UL_V6D0),
											.IN9(UL_V6A1),
											.IN4(UL_H6B2),
											.IN5(UL_H6B3),
											.IN6(UL_V6A0),
											.IN7(UL_V6M0),
											.IN0(UL_H6E2),
											.IN1(UL_H6E3),
											.IN2(UL_H6A2),
											.IN3(UL_H6A3),
											.IN18(UL_H6M2),
											.IN19(UL_H6M3),
											.IN16(UL_V6C1),
											.IN17(UL_V6S1),
											.IN14(UL_V6S0),
											.IN15(UL_V6B1),
											.IN12(UL_V6B0),
											.IN13(UL_V6C0),
											.IN10(UL_V6M1),
											.IN11(UL_V6D1),
											.OUT(UL_GSR),
											.IN23(UL_H6D3),
											.IN22(UL_H6D2),
											.IN21(UL_H6C3),
											.IN20(UL_H6C2),
											._1(1)
		);

		SPS3T3X7H1 sps_h6d2(
											.OUT(UL_H6D2),
											.IN1(UL_LLH1),
											.IN2(UL_SEL2),
											.IN3(UL_V6S2),
											._1(1)
		);

		SPS3T3X7H1 sps_v6b1(
											.IN3(UL_H6A1),
											.IN1(UL_LLV4),
											.IN2(UL_TDI),
											.OUT(UL_V6B1),
											._1(1)
		);

		SPS3T3X7H1 sps_v6b0(
											.IN3(UL_H6A0),
											.IN1(UL_LLV4),
											.IN2(UL_UPDATE),
											.OUT(UL_V6B0),
											._1(1)
		);

		SPS3T3X7H1 sps_v6b3(
											.IN3(UL_H6A3),
											.IN1(UL_LLV10),
											.IN2(UL_DRCK1),
											.OUT(UL_V6B3),
											._1(1)
		);

		SPS3T3X7H1 sps_v6b2(
											.IN3(UL_H6A2),
											.IN1(UL_LLV10),
											.IN2(UL_SEL2),
											.OUT(UL_V6B2),
											._1(1)
		);

		SPS3T3X7H1 sps_h6e2(
											.OUT(UL_H6E2),
											.IN1(UL_LLH6),
											.IN2(UL_DRCK2),
											.IN3(UL_V6A2),
											._1(1)
		);

		SPS3T3X7H1 sps_h6e3(
											.OUT(UL_H6E3),
											.IN1(UL_LLH6),
											.IN2(UL_SHIFT),
											.IN3(UL_V6A3),
											._1(1)
		);

		SPS3T3X7H1 sps_h6e0(
											.OUT(UL_H6E0),
											.IN1(UL_LLH0),
											.IN2(UL_SEL1),
											.IN3(UL_V6A0),
											._1(1)
		);

		SPS3T3X7H1 sps_h6e1(
											.OUT(UL_H6E1),
											.IN1(UL_LLH0),
											.IN2(UL_RESET),
											.IN3(UL_V6A1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6e4(
											.IN0(UL_LLH6),
											.IN1(UL_LLH0),
											.OUT(UL_H6E4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6e5(
											.IN0(UL_LLH6),
											.IN1(UL_LLH0),
											.OUT(UL_H6E5),
											._1(1)
		);

		SPS3T3X7H1 sps_v6d3(
											.IN3(UL_H6C3),
											.IN1(UL_LLV7),
											.IN2(UL_SHIFT),
											.OUT(UL_V6D3),
											._1(1)
		);

		SPS3T3X7H1 sps_v6d2(
											.IN3(UL_H6C2),
											.IN1(UL_LLV7),
											.IN2(UL_DRCK2),
											.OUT(UL_V6D2),
											._1(1)
		);

		SPS3T3X7H1 sps_v6d1(
											.IN3(UL_H6C1),
											.IN1(UL_LLV1),
											.IN2(UL_RESET),
											.OUT(UL_V6D1),
											._1(1)
		);

		SPS3T3X7H1 sps_v6d0(
											.IN3(UL_H6C0),
											.IN1(UL_LLV1),
											.IN2(UL_SEL1),
											.OUT(UL_V6D0),
											._1(1)
		);

		SPS3T3X7H1 sps_v6s0(
											.IN3(UL_H6D0),
											.IN1(UL_LLV0),
											.IN2(UL_SEL2),
											.OUT(UL_V6S0),
											._1(1)
		);

		SPS3T3X7H1 sps_v6m1(
											.IN3(UL_H6B1),
											.IN1(UL_LLV3),
											.IN2(UL_SEL1),
											.OUT(UL_V6M1),
											._1(1)
		);

		SPS3T3X7H1 sps_h6c0(
											.OUT(UL_H6C0),
											.IN1(UL_LLH8),
											.IN2(UL_DRCK2),
											.IN3(UL_V6D0),
											._1(1)
		);

		SPS3T3X7H1 sps_h6c1(
											.OUT(UL_H6C1),
											.IN1(UL_LLH8),
											.IN2(UL_SHIFT),
											.IN3(UL_V6D1),
											._1(1)
		);

		SPS3T3X7H1 sps_h6c2(
											.OUT(UL_H6C2),
											.IN1(UL_LLH2),
											.IN2(UL_SEL1),
											.IN3(UL_V6D2),
											._1(1)
		);

		SPS3T3X7H1 sps_h6c3(
											.OUT(UL_H6C3),
											.IN1(UL_LLH2),
											.IN2(UL_RESET),
											.IN3(UL_V6D3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c4(
											.IN0(UL_LLH8),
											.IN1(UL_LLH2),
											.OUT(UL_H6C4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c5(
											.IN0(UL_LLH8),
											.IN1(UL_LLH2),
											.OUT(UL_H6C5),
											._1(1)
		);

		SPS3T3X7H1 sps_h6a0(
											.OUT(UL_H6A0),
											.IN1(UL_LLH11),
											.IN2(UL_SEL2),
											.IN3(UL_V6B0),
											._1(1)
		);

		SPS3T3X7H1 sps_h6a1(
											.OUT(UL_H6A1),
											.IN1(UL_LLH11),
											.IN2(UL_DRCK1),
											.IN3(UL_V6B1),
											._1(1)
		);

		SPS3T3X7H1 sps_v6a2(
											.IN3(UL_H6E2),
											.IN1(UL_LLV11),
											.IN2(UL_SEL1),
											.OUT(UL_V6A2),
											._1(1)
		);

		SPS3T3X7H1 sps_v6m3(
											.IN3(UL_H6B3),
											.IN1(UL_LLV9),
											.IN2(UL_DRCK2),
											.OUT(UL_V6M3),
											._1(1)
		);

		SPS3T3X7H1 sps_v6s1(
											.IN3(UL_H6D1),
											.IN1(UL_LLV0),
											.IN2(UL_DRCK1),
											.OUT(UL_V6S1),
											._1(1)
		);

		SPS28B11X11H1 sps_clk(
											.IN8(UL_V6B2),
											.IN9(UL_V6M2),
											.IN4(UL_H6A1),
											.IN5(UL_H6B0),
											.IN6(UL_H6B1),
											.IN7(UL_V6A2),
											.IN0(UL_H6E0),
											.IN1(UL_H6E1),
											.IN2(UL_H6A0),
											.IN3(UL_GCLK0),
											.IN18(UL_V6D3),
											.IN19(UL_V6S3),
											.IN16(UL_V6M3),
											.IN17(UL_V6C3),
											.IN14(UL_V6A3),
											.IN15(UL_V6B3),
											.IN12(UL_V6S2),
											.IN13(UL_GCLK1),
											.IN10(UL_V6C2),
											.IN11(UL_V6D2),
											.OUT(UL_STARTUP_CLK),
											.IN23(UL_H6D0),
											.IN22(UL_H6M1),
											.IN21(UL_H6M0),
											.IN20(UL_GCLK2),
											.IN27(UL_GCLK3),
											.IN26(UL_H6D1),
											.IN25(UL_H6C1),
											.IN24(UL_H6C0),
											._1(1)
		);

		SPS3T3X7H1 sps_v6c3(
											.IN3(UL_H6M3),
											.IN1(UL_LLV8),
											.IN2(UL_UPDATE),
											.OUT(UL_V6C3),
											._1(1)
		);

		SPS3T3X7H1 sps_v6c0(
											.IN3(UL_H6M0),
											.IN1(UL_LLV2),
											.IN2(UL_TDI),
											.OUT(UL_V6C0),
											._1(1)
		);

		SPS24B10X11H1 sps_gts(
											.IN8(UL_V6D0),
											.IN9(UL_V6A1),
											.IN4(UL_H6B2),
											.IN5(UL_H6B3),
											.IN6(UL_V6A0),
											.IN7(UL_V6M0),
											.IN0(UL_H6E2),
											.IN1(UL_H6E3),
											.IN2(UL_H6A2),
											.IN3(UL_H6A3),
											.IN18(UL_H6M2),
											.IN19(UL_H6M3),
											.IN16(UL_V6C1),
											.IN17(UL_V6S1),
											.IN14(UL_V6S0),
											.IN15(UL_V6B1),
											.IN12(UL_V6B0),
											.IN13(UL_V6C0),
											.IN10(UL_V6M1),
											.IN11(UL_V6D1),
											.OUT(UL_GTS),
											.IN23(UL_H6D3),
											.IN22(UL_H6D2),
											.IN21(UL_H6C3),
											.IN20(UL_H6C2),
											._1(1)
		);

		SPS3T3X7H1 sps_v6c1(
											.IN3(UL_H6M1),
											.IN1(UL_LLV2),
											.IN2(UL_SEL2),
											.OUT(UL_V6C1),
											._1(1)
		);

		SPS24B10X11H1 sps_tdo2(
											.IN8(UL_V6D0),
											.IN9(UL_V6A1),
											.IN4(UL_H6B2),
											.IN5(UL_H6B3),
											.IN6(UL_V6A0),
											.IN7(UL_V6M0),
											.IN0(UL_H6E2),
											.IN1(UL_H6E3),
											.IN2(UL_H6A2),
											.IN3(UL_H6A3),
											.IN18(UL_H6M2),
											.IN19(UL_H6M3),
											.IN16(UL_V6C1),
											.IN17(UL_V6S1),
											.IN14(UL_V6S0),
											.IN15(UL_V6B1),
											.IN12(UL_V6B0),
											.IN13(UL_V6C0),
											.IN10(UL_V6M1),
											.IN11(UL_V6D1),
											.OUT(UL_TDO2),
											.IN23(UL_H6D3),
											.IN22(UL_H6D2),
											.IN21(UL_H6C3),
											.IN20(UL_H6C2),
											._1(1)
		);

		SPS24B10X11H1 sps_tdo1(
											.IN8(UL_V6M2),
											.IN9(UL_V6C2),
											.IN4(UL_H6B0),
											.IN5(UL_H6B1),
											.IN6(UL_V6A2),
											.IN7(UL_V6B2),
											.IN0(UL_H6E0),
											.IN1(UL_H6E1),
											.IN2(UL_H6A0),
											.IN3(UL_H6A1),
											.IN18(UL_H6M0),
											.IN19(UL_H6M1),
											.IN16(UL_V6D3),
											.IN17(UL_V6S3),
											.IN14(UL_V6M3),
											.IN15(UL_V6C3),
											.IN12(UL_V6A3),
											.IN13(UL_V6B3),
											.IN10(UL_V6D2),
											.IN11(UL_V6S2),
											.OUT(UL_TDO1),
											.IN23(UL_H6D1),
											.IN22(UL_H6D0),
											.IN21(UL_H6C1),
											.IN20(UL_H6C0),
											._1(1)
		);

		SPS3T3X7H1 sps_v6a3(
											.IN3(UL_H6E3),
											.IN1(UL_LLV11),
											.IN2(UL_RESET),
											.OUT(UL_V6A3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6a4(
											.IN0(UL_LLH11),
											.IN1(UL_LLH5),
											.OUT(UL_H6A4),
											._1(1)
		);

		SPS3T3X7H1 sps_v6c2(
											.IN3(UL_H6M2),
											.IN1(UL_LLV8),
											.IN2(UL_DRCK1),
											.OUT(UL_V6C2),
											._1(1)
		);

		SPS1T1X7H1 sps_llv1(
											.OUT(UL_LLV1),
											.IN(UL_H6D5)
		);

		SPS1T1X7H1 sps_llv3(
											.OUT(UL_LLV3),
											.IN(UL_H6M5)
		);

		SPS2T2X7H1 sps_h6a5(
											.IN0(UL_LLH11),
											.IN1(UL_LLH5),
											.OUT(UL_H6A5),
											._1(1)
		);

		SPS1T1X7H1 sps_llv0(
											.OUT(UL_LLV0),
											.IN(UL_H6E5)
		);

		SPS2T2X7H1 sps_h6d5(
											.IN0(UL_LLH7),
											.IN1(UL_LLH1),
											.OUT(UL_H6D5),
											._1(1)
		);

		SPS3T3X7H1 sps_h6a2(
											.OUT(UL_H6A2),
											.IN1(UL_LLH5),
											.IN2(UL_UPDATE),
											.IN3(UL_V6B2),
											._1(1)
		);

		SPS3T3X7H1 sps_v6s2(
											.IN3(UL_H6D2),
											.IN1(UL_LLV6),
											.IN2(UL_UPDATE),
											.OUT(UL_V6S2),
											._1(1)
		);

		SPS3T3X7H1 sps_h6d1(
											.OUT(UL_H6D1),
											.IN1(UL_LLH7),
											.IN2(UL_TDI),
											.IN3(UL_V6S1),
											._1(1)
		);

		SPS3T3X7H1 sps_h6d0(
											.OUT(UL_H6D0),
											.IN1(UL_LLH7),
											.IN2(UL_UPDATE),
											.IN3(UL_V6S0),
											._1(1)
		);

		SPS3T3X7H1 sps_h6d3(
											.OUT(UL_H6D3),
											.IN1(UL_LLH1),
											.IN2(UL_DRCK1),
											.IN3(UL_V6S3),
											._1(1)
		);

		SPS3T3X7H1 sps_h6a3(
											.OUT(UL_H6A3),
											.IN1(UL_LLH5),
											.IN2(UL_TDI),
											.IN3(UL_V6B3),
											._1(1)
		);

		SPS1T1X7H1 sps_llv11(
											.OUT(UL_LLV11),
											.IN(UL_H6A4)
		);

		SPS1T1X7H1 sps_llv10(
											.OUT(UL_LLV10),
											.IN(UL_H6B4)
		);

		SPS1T1X7H1 sps_llv2(
											.OUT(UL_LLV2),
											.IN(UL_H6C5)
		);

		SPS2T2X7H1 sps_h6d4(
											.IN0(UL_LLH7),
											.IN1(UL_LLH1),
											.OUT(UL_H6D4),
											._1(1)
		);

		SPS3T3X7H1 sps_h6b3(
											.OUT(UL_H6B3),
											.IN1(UL_LLH4),
											.IN2(UL_SEL1),
											.IN3(UL_V6M3),
											._1(1)
		);

		SPS3T3X7H1 sps_h6b2(
											.OUT(UL_H6B2),
											.IN1(UL_LLH4),
											.IN2(UL_SHIFT),
											.IN3(UL_V6M2),
											._1(1)
		);

		SPS3T3X7H1 sps_h6b1(
											.OUT(UL_H6B1),
											.IN1(UL_LLH10),
											.IN2(UL_DRCK2),
											.IN3(UL_V6M1),
											._1(1)
		);

		SPS3T3X7H1 sps_h6b0(
											.OUT(UL_H6B0),
											.IN1(UL_LLH10),
											.IN2(UL_RESET),
											.IN3(UL_V6M0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b5(
											.IN0(UL_LLH10),
											.IN1(UL_LLH4),
											.OUT(UL_H6B5),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b4(
											.IN0(UL_LLH10),
											.IN1(UL_LLH4),
											.OUT(UL_H6B4),
											._1(1)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_LL(
LL_H6D0, LL_H6C0, LL_H6M0, LL_H6B0, LL_H6A0, LL_H6E0, LL_H6D1, LL_H6C1, LL_H6M1, LL_H6B1, LL_H6A1, LL_H6E1, LL_H6D2, LL_H6C2, LL_H6M2, LL_H6B2, LL_H6A2, LL_H6E2, LL_H6D3, LL_H6C3, LL_H6M3, LL_H6B3, LL_H6A3, LL_H6E3, LL_H6D4, LL_H6C4, LL_H6M4, LL_H6B4, LL_H6A4, LL_H6E4, LL_H6D5, LL_H6C5, LL_H6M5, LL_H6B5, LL_H6A5, LL_H6E5, LL_LLH0, LL_LLH1, LL_LLH2, LL_LLH3, LL_LLH4, LL_LLH5, LL_LLH6, LL_LLH7, LL_LLH8, LL_LLH9, LL_LLH10, LL_LLH11, LL_GCLK0, LL_GCLK1, LL_GCLK2, LL_GCLK3, LL_LLV0, LL_LLV1, LL_LLV2, LL_LLV3, LL_LLV4, LL_LLV5, LL_LLV6, LL_LLV7, LL_LLV8, LL_LLV9, LL_LLV10, LL_LLV11, LL_V6D0, LL_V6C0, LL_V6M0, LL_V6B0, LL_V6A0, LL_V6N0, LL_V6D1, LL_V6C1, LL_V6M1, LL_V6B1, LL_V6A1, LL_V6N1, LL_V6D2, LL_V6C2, LL_V6M2, LL_V6B2, LL_V6A2, LL_V6N2, LL_V6D3, LL_V6C3, LL_V6M3, LL_V6B3, LL_V6A3, LL_V6N3, LL_CAP, LL_CAPTURE_CLK, _1
);
inout	LL_H6D0;
inout	LL_H6C0;
inout	LL_H6M0;
inout	LL_H6B0;
inout	LL_H6A0;
inout	LL_H6E0;
inout	LL_H6D1;
inout	LL_H6C1;
inout	LL_H6M1;
inout	LL_H6B1;
inout	LL_H6A1;
inout	LL_H6E1;
inout	LL_H6D2;
inout	LL_H6C2;
inout	LL_H6M2;
inout	LL_H6B2;
inout	LL_H6A2;
inout	LL_H6E2;
inout	LL_H6D3;
inout	LL_H6C3;
inout	LL_H6M3;
inout	LL_H6B3;
inout	LL_H6A3;
inout	LL_H6E3;
inout	LL_H6D4;
inout	LL_H6C4;
inout	LL_H6M4;
inout	LL_H6B4;
inout	LL_H6A4;
inout	LL_H6E4;
inout	LL_H6D5;
inout	LL_H6C5;
inout	LL_H6M5;
inout	LL_H6B5;
inout	LL_H6A5;
inout	LL_H6E5;
inout	LL_LLH0;
inout	LL_LLH1;
inout	LL_LLH2;
inout	LL_LLH3;
inout	LL_LLH4;
inout	LL_LLH5;
inout	LL_LLH6;
inout	LL_LLH7;
inout	LL_LLH8;
inout	LL_LLH9;
inout	LL_LLH10;
inout	LL_LLH11;
inout	LL_GCLK0;
inout	LL_GCLK1;
inout	LL_GCLK2;
inout	LL_GCLK3;
inout	LL_LLV0;
inout	LL_LLV1;
inout	LL_LLV2;
inout	LL_LLV3;
inout	LL_LLV4;
inout	LL_LLV5;
inout	LL_LLV6;
inout	LL_LLV7;
inout	LL_LLV8;
inout	LL_LLV9;
inout	LL_LLV10;
inout	LL_LLV11;
inout	LL_V6D0;
inout	LL_V6C0;
inout	LL_V6M0;
inout	LL_V6B0;
inout	LL_V6A0;
inout	LL_V6N0;
inout	LL_V6D1;
inout	LL_V6C1;
inout	LL_V6M1;
inout	LL_V6B1;
inout	LL_V6A1;
inout	LL_V6N1;
inout	LL_V6D2;
inout	LL_V6C2;
inout	LL_V6M2;
inout	LL_V6B2;
inout	LL_V6A2;
inout	LL_V6N2;
inout	LL_V6D3;
inout	LL_V6C3;
inout	LL_V6M3;
inout	LL_V6B3;
inout	LL_V6A3;
inout	LL_V6N3;
inout	LL_CAP;
inout	LL_CAPTURE_CLK;
inout	_1;

		SPS2T2X7H1 sps_v6n2(
											.IN0(LL_LLV6),
											.IN1(LL_H6D2),
											.OUT(LL_V6N2),
											._1(1)
		);

		SPS1T1X7H1 sps_llv7(
											.OUT(LL_LLV7),
											.IN(LL_H6D4)
		);

		SPS2T2X7H1 sps_v6m0(
											.IN0(LL_LLV9),
											.IN1(LL_H6B0),
											.OUT(LL_V6M0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6a0(
											.IN0(LL_LLV11),
											.IN1(LL_H6C0),
											.OUT(LL_V6A0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6m2(
											.IN0(LL_LLV3),
											.IN1(LL_H6B2),
											.OUT(LL_V6M2),
											._1(1)
		);

		SPS1T1X7H1 sps_llv6(
											.OUT(LL_LLV6),
											.IN(LL_H6E4)
		);

		SPS2T2X7H1 sps_v6n3(
											.IN0(LL_LLV6),
											.IN1(LL_H6D3),
											.OUT(LL_V6N3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6a1(
											.IN0(LL_LLV11),
											.IN1(LL_H6C1),
											.OUT(LL_V6A1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m2(
											.IN0(LL_LLH3),
											.IN1(LL_V6B2),
											.OUT(LL_H6M2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m3(
											.IN0(LL_LLH3),
											.IN1(LL_V6B3),
											.OUT(LL_H6M3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m0(
											.IN0(LL_LLH9),
											.IN1(LL_V6B0),
											.OUT(LL_H6M0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m1(
											.IN0(LL_LLH9),
											.IN1(LL_V6B1),
											.OUT(LL_H6M1),
											._1(1)
		);

		SPS1T1X7H1 sps_llv5(
											.OUT(LL_LLV5),
											.IN(LL_H6A5)
		);

		SPS1T1X7H1 sps_llv4(
											.OUT(LL_LLV4),
											.IN(LL_H6B5)
		);

		SPS2T2X7H1 sps_h6m4(
											.IN0(LL_LLH9),
											.IN1(LL_LLH3),
											.OUT(LL_H6M4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m5(
											.IN0(LL_LLH9),
											.IN1(LL_LLH3),
											.OUT(LL_H6M5),
											._1(1)
		);

		SPS1T1X7H1 sps_llv9(
											.OUT(LL_LLV9),
											.IN(LL_H6M4)
		);

		SPS1T1X7H1 sps_llv8(
											.OUT(LL_LLV8),
											.IN(LL_H6C4)
		);

		SPS2T2X7H1 sps_h6d2(
											.IN0(LL_LLH1),
											.IN1(LL_V6N2),
											.OUT(LL_H6D2),
											._1(1)
		);

		SPS2T2X7H1 sps_v6b1(
											.IN0(LL_LLV10),
											.IN1(LL_H6M1),
											.OUT(LL_V6B1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6b0(
											.IN0(LL_LLV10),
											.IN1(LL_H6M0),
											.OUT(LL_V6B0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6b3(
											.IN0(LL_LLV4),
											.IN1(LL_H6M3),
											.OUT(LL_V6B3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6b2(
											.IN0(LL_LLV4),
											.IN1(LL_H6M2),
											.OUT(LL_V6B2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6e2(
											.IN0(LL_LLH6),
											.IN1(LL_V6D2),
											.OUT(LL_H6E2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6e3(
											.IN0(LL_LLH6),
											.IN1(LL_V6D3),
											.OUT(LL_H6E3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6e0(
											.IN0(LL_LLH0),
											.IN1(LL_V6D0),
											.OUT(LL_H6E0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6e1(
											.IN0(LL_LLH0),
											.IN1(LL_V6D1),
											.OUT(LL_H6E1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6e4(
											.IN0(LL_LLH6),
											.IN1(LL_LLH0),
											.OUT(LL_H6E4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6e5(
											.IN0(LL_LLH6),
											.IN1(LL_LLH0),
											.OUT(LL_H6E5),
											._1(1)
		);

		SPS2T2X7H1 sps_v6d3(
											.IN0(LL_LLV1),
											.IN1(LL_H6E3),
											.OUT(LL_V6D3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6d2(
											.IN0(LL_LLV1),
											.IN1(LL_H6E2),
											.OUT(LL_V6D2),
											._1(1)
		);

		SPS2T2X7H1 sps_v6d1(
											.IN0(LL_LLV7),
											.IN1(LL_H6E1),
											.OUT(LL_V6D1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6d0(
											.IN0(LL_LLV7),
											.IN1(LL_H6E0),
											.OUT(LL_V6D0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6m1(
											.IN0(LL_LLV9),
											.IN1(LL_H6B1),
											.OUT(LL_V6M1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c0(
											.IN0(LL_LLH8),
											.IN1(LL_V6A0),
											.OUT(LL_H6C0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c1(
											.IN0(LL_LLH8),
											.IN1(LL_V6A1),
											.OUT(LL_H6C1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c2(
											.IN0(LL_LLH2),
											.IN1(LL_V6A2),
											.OUT(LL_H6C2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c3(
											.IN0(LL_LLH2),
											.IN1(LL_V6A3),
											.OUT(LL_H6C3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c4(
											.IN0(LL_LLH8),
											.IN1(LL_LLH2),
											.OUT(LL_H6C4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c5(
											.IN0(LL_LLH8),
											.IN1(LL_LLH2),
											.OUT(LL_H6C5),
											._1(1)
		);

		SPS2T2X7H1 sps_h6a0(
											.IN0(LL_LLH11),
											.IN1(LL_V6C0),
											.OUT(LL_H6A0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6a1(
											.IN0(LL_LLH11),
											.IN1(LL_V6C1),
											.OUT(LL_H6A1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6n1(
											.IN0(LL_LLV0),
											.IN1(LL_H6D1),
											.OUT(LL_V6N1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6n0(
											.IN0(LL_LLV0),
											.IN1(LL_H6D0),
											.OUT(LL_V6N0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6a2(
											.IN0(LL_LLV5),
											.IN1(LL_H6C2),
											.OUT(LL_V6A2),
											._1(1)
		);

		SPS2T2X7H1 sps_v6m3(
											.IN0(LL_LLV3),
											.IN1(LL_H6B3),
											.OUT(LL_V6M3),
											._1(1)
		);

		SPS28B11X11H1 sps_clk(
											.IN8(LL_V6A2),
											.IN9(LL_V6B2),
											.IN4(LL_V6C3),
											.IN5(LL_V6D3),
											.IN6(LL_GCLK0),
											.IN7(LL_V6N2),
											.IN0(LL_V6N3),
											.IN1(LL_V6A3),
											.IN2(LL_V6B3),
											.IN3(LL_V6M3),
											.IN18(LL_H6A1),
											.IN19(LL_H6E1),
											.IN16(LL_H6B0),
											.IN17(LL_H6B1),
											.IN14(LL_H6M0),
											.IN15(LL_H6M1),
											.IN12(LL_V6D2),
											.IN13(LL_GCLK1),
											.IN10(LL_V6M2),
											.IN11(LL_V6C2),
											.OUT(LL_CAPTURE_CLK),
											.IN23(LL_H6C0),
											.IN22(LL_H6D1),
											.IN21(LL_H6D0),
											.IN20(LL_GCLK2),
											.IN27(LL_GCLK3),
											.IN26(LL_H6E0),
											.IN25(LL_H6A0),
											.IN24(LL_H6C1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6c3(
											.IN0(LL_LLV2),
											.IN1(LL_H6A3),
											.OUT(LL_V6C3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6c0(
											.IN0(LL_LLV8),
											.IN1(LL_H6A0),
											.OUT(LL_V6C0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6c1(
											.IN0(LL_LLV8),
											.IN1(LL_H6A1),
											.OUT(LL_V6C1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6a3(
											.IN0(LL_LLV5),
											.IN1(LL_H6C3),
											.OUT(LL_V6A3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6a4(
											.IN0(LL_LLH11),
											.IN1(LL_LLH5),
											.OUT(LL_H6A4),
											._1(1)
		);

		SPS2T2X7H1 sps_v6c2(
											.IN0(LL_LLV2),
											.IN1(LL_H6A2),
											.OUT(LL_V6C2),
											._1(1)
		);

		SPS1T1X7H1 sps_llv1(
											.OUT(LL_LLV1),
											.IN(LL_H6D5)
		);

		SPS1T1X7H1 sps_llv3(
											.OUT(LL_LLV3),
											.IN(LL_H6M5)
		);

		SPS2T2X7H1 sps_h6a5(
											.IN0(LL_LLH11),
											.IN1(LL_LLH5),
											.OUT(LL_H6A5),
											._1(1)
		);

		SPS1T1X7H1 sps_llv0(
											.OUT(LL_LLV0),
											.IN(LL_H6E5)
		);

		SPS2T2X7H1 sps_h6d5(
											.IN0(LL_LLH7),
											.IN1(LL_LLH1),
											.OUT(LL_H6D5),
											._1(1)
		);

		SPS2T2X7H1 sps_h6a2(
											.IN0(LL_LLH5),
											.IN1(LL_V6C2),
											.OUT(LL_H6A2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6d1(
											.IN0(LL_LLH7),
											.IN1(LL_V6N1),
											.OUT(LL_H6D1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6d0(
											.IN0(LL_LLH7),
											.IN1(LL_V6N0),
											.OUT(LL_H6D0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6d3(
											.IN0(LL_LLH1),
											.IN1(LL_V6N3),
											.OUT(LL_H6D3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6a3(
											.IN0(LL_LLH5),
											.IN1(LL_V6C3),
											.OUT(LL_H6A3),
											._1(1)
		);

		SPS1T1X7H1 sps_llv11(
											.OUT(LL_LLV11),
											.IN(LL_H6A4)
		);

		SPS1T1X7H1 sps_llv10(
											.OUT(LL_LLV10),
											.IN(LL_H6B4)
		);

		SPS1T1X7H1 sps_llv2(
											.OUT(LL_LLV2),
											.IN(LL_H6C5)
		);

		SPS24B10X11H1 sps_cap(
											.IN8(LL_H6E2),
											.IN9(LL_H6C3),
											.IN4(LL_H6A3),
											.IN5(LL_H6M3),
											.IN6(LL_H6B2),
											.IN7(LL_H6A2),
											.IN0(LL_H6B3),
											.IN1(LL_H6D3),
											.IN2(LL_H6C2),
											.IN3(LL_H6D2),
											.IN18(LL_V6A1),
											.IN19(LL_V6N1),
											.IN16(LL_V6M0),
											.IN17(LL_V6M1),
											.IN14(LL_V6A0),
											.IN15(LL_V6B0),
											.IN12(LL_H6E3),
											.IN13(LL_V6N0),
											.IN10(LL_V6D1),
											.IN11(LL_H6M2),
											.OUT(LL_CAP),
											.IN23(LL_V6C1),
											.IN22(LL_V6B1),
											.IN21(LL_V6C0),
											.IN20(LL_V6D0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6d4(
											.IN0(LL_LLH7),
											.IN1(LL_LLH1),
											.OUT(LL_H6D4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b3(
											.IN0(LL_LLH4),
											.IN1(LL_V6M3),
											.OUT(LL_H6B3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b2(
											.IN0(LL_LLH4),
											.IN1(LL_V6M2),
											.OUT(LL_H6B2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b1(
											.IN0(LL_LLH10),
											.IN1(LL_V6M1),
											.OUT(LL_H6B1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b0(
											.IN0(LL_LLH10),
											.IN1(LL_V6M0),
											.OUT(LL_H6B0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b5(
											.IN0(LL_LLH10),
											.IN1(LL_LLH4),
											.OUT(LL_H6B5),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b4(
											.IN0(LL_LLH10),
											.IN1(LL_LLH4),
											.OUT(LL_H6B4),
											._1(1)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_LR(
LR_H6W0, LR_H6D0, LR_H6C0, LR_H6M0, LR_H6B0, LR_H6A0, LR_H6W1, LR_H6D1, LR_H6C1, LR_H6M1, LR_H6B1, LR_H6A1, LR_H6W2, LR_H6D2, LR_H6C2, LR_H6M2, LR_H6B2, LR_H6A2, LR_H6W3, LR_H6D3, LR_H6C3, LR_H6M3, LR_H6B3, LR_H6A3, LR_H6W4, LR_H6D4, LR_H6C4, LR_H6M4, LR_H6B4, LR_H6A4, LR_H6W5, LR_H6D5, LR_H6C5, LR_H6M5, LR_H6B5, LR_H6A5, LR_LLH0, LR_LLH1, LR_LLH2, LR_LLH3, LR_LLH4, LR_LLH5, LR_LLH6, LR_LLH7, LR_LLH8, LR_LLH9, LR_LLH10, LR_LLH11, LR_V6N0, LR_V6A0, LR_V6B0, LR_V6M0, LR_V6C0, LR_V6D0, LR_V6N1, LR_V6A1, LR_V6B1, LR_V6M1, LR_V6C1, LR_V6D1, LR_V6N2, LR_V6A2, LR_V6B2, LR_V6M2, LR_V6C2, LR_V6D2, LR_V6N3, LR_V6A3, LR_V6B3, LR_V6M3, LR_V6C3, LR_V6D3, LR_LLV0, LR_LLV1, LR_LLV2, LR_LLV3, LR_LLV4, LR_LLV5, LR_LLV6, LR_LLV7, LR_LLV8, LR_LLV9, LR_LLV10, LR_LLV11, _1
);
inout	LR_H6W0;
inout	LR_H6D0;
inout	LR_H6C0;
inout	LR_H6M0;
inout	LR_H6B0;
inout	LR_H6A0;
inout	LR_H6W1;
inout	LR_H6D1;
inout	LR_H6C1;
inout	LR_H6M1;
inout	LR_H6B1;
inout	LR_H6A1;
inout	LR_H6W2;
inout	LR_H6D2;
inout	LR_H6C2;
inout	LR_H6M2;
inout	LR_H6B2;
inout	LR_H6A2;
inout	LR_H6W3;
inout	LR_H6D3;
inout	LR_H6C3;
inout	LR_H6M3;
inout	LR_H6B3;
inout	LR_H6A3;
inout	LR_H6W4;
inout	LR_H6D4;
inout	LR_H6C4;
inout	LR_H6M4;
inout	LR_H6B4;
inout	LR_H6A4;
inout	LR_H6W5;
inout	LR_H6D5;
inout	LR_H6C5;
inout	LR_H6M5;
inout	LR_H6B5;
inout	LR_H6A5;
inout	LR_LLH0;
inout	LR_LLH1;
inout	LR_LLH2;
inout	LR_LLH3;
inout	LR_LLH4;
inout	LR_LLH5;
inout	LR_LLH6;
inout	LR_LLH7;
inout	LR_LLH8;
inout	LR_LLH9;
inout	LR_LLH10;
inout	LR_LLH11;
inout	LR_V6N0;
inout	LR_V6A0;
inout	LR_V6B0;
inout	LR_V6M0;
inout	LR_V6C0;
inout	LR_V6D0;
inout	LR_V6N1;
inout	LR_V6A1;
inout	LR_V6B1;
inout	LR_V6M1;
inout	LR_V6C1;
inout	LR_V6D1;
inout	LR_V6N2;
inout	LR_V6A2;
inout	LR_V6B2;
inout	LR_V6M2;
inout	LR_V6C2;
inout	LR_V6D2;
inout	LR_V6N3;
inout	LR_V6A3;
inout	LR_V6B3;
inout	LR_V6M3;
inout	LR_V6C3;
inout	LR_V6D3;
inout	LR_LLV0;
inout	LR_LLV1;
inout	LR_LLV2;
inout	LR_LLV3;
inout	LR_LLV4;
inout	LR_LLV5;
inout	LR_LLV6;
inout	LR_LLV7;
inout	LR_LLV8;
inout	LR_LLV9;
inout	LR_LLV10;
inout	LR_LLV11;
inout	_1;

		SPS2T2X7H1 sps_h6w4(
											.IN0(LR_LLH6),
											.IN1(LR_LLH0),
											.OUT(LR_H6W4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6w5(
											.IN0(LR_LLH6),
											.IN1(LR_LLH0),
											.OUT(LR_H6W5),
											._1(1)
		);

		SPS2T2X7H1 sps_h6w0(
											.IN0(LR_LLH0),
											.IN1(LR_V6D0),
											.OUT(LR_H6W0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6a3(
											.IN0(LR_LLH11),
											.IN1(LR_V6N3),
											.OUT(LR_H6A3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6w2(
											.IN0(LR_LLH6),
											.IN1(LR_V6D2),
											.OUT(LR_H6W2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6w3(
											.IN0(LR_LLH6),
											.IN1(LR_V6D3),
											.OUT(LR_H6W3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6m0(
											.IN0(LR_LLV9),
											.IN1(LR_H6C0),
											.OUT(LR_V6M0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6a0(
											.IN0(LR_LLV11),
											.IN1(LR_H6B0),
											.OUT(LR_V6A0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6m2(
											.IN0(LR_LLV3),
											.IN1(LR_H6C2),
											.OUT(LR_V6M2),
											._1(1)
		);

		SPS1T1X7H1 sps_llv6(
											.OUT(LR_LLV6),
											.IN(LR_H6W4)
		);

		SPS2T2X7H1 sps_v6n3(
											.IN0(LR_LLV6),
											.IN1(LR_H6A3),
											.OUT(LR_V6N3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6a1(
											.IN0(LR_LLV11),
											.IN1(LR_H6B1),
											.OUT(LR_V6A1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m2(
											.IN0(LR_LLH9),
											.IN1(LR_V6B2),
											.OUT(LR_H6M2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m3(
											.IN0(LR_LLH9),
											.IN1(LR_V6B3),
											.OUT(LR_H6M3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m0(
											.IN0(LR_LLH3),
											.IN1(LR_V6B0),
											.OUT(LR_H6M0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m1(
											.IN0(LR_LLH3),
											.IN1(LR_V6B1),
											.OUT(LR_H6M1),
											._1(1)
		);

		SPS1T1X7H1 sps_llv5(
											.OUT(LR_LLV5),
											.IN(LR_H6A5)
		);

		SPS1T1X7H1 sps_llv4(
											.OUT(LR_LLV4),
											.IN(LR_H6B5)
		);

		SPS2T2X7H1 sps_h6m4(
											.IN0(LR_LLH9),
											.IN1(LR_LLH3),
											.OUT(LR_H6M4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m5(
											.IN0(LR_LLH9),
											.IN1(LR_LLH3),
											.OUT(LR_H6M5),
											._1(1)
		);

		SPS1T1X7H1 sps_llv9(
											.OUT(LR_LLV9),
											.IN(LR_H6M4)
		);

		SPS1T1X7H1 sps_llv8(
											.OUT(LR_LLV8),
											.IN(LR_H6C4)
		);

		SPS2T2X7H1 sps_v6a3(
											.IN0(LR_LLV5),
											.IN1(LR_H6B3),
											.OUT(LR_V6A3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6w1(
											.IN0(LR_LLH0),
											.IN1(LR_V6D1),
											.OUT(LR_H6W1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6b1(
											.IN0(LR_LLV10),
											.IN1(LR_H6M1),
											.OUT(LR_V6B1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6b0(
											.IN0(LR_LLV10),
											.IN1(LR_H6M0),
											.OUT(LR_V6B0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6b3(
											.IN0(LR_LLV4),
											.IN1(LR_H6M3),
											.OUT(LR_V6B3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6b2(
											.IN0(LR_LLV4),
											.IN1(LR_H6M2),
											.OUT(LR_V6B2),
											._1(1)
		);

		SPS2T2X7H1 sps_v6d3(
											.IN0(LR_LLV1),
											.IN1(LR_H6W3),
											.OUT(LR_V6D3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6d2(
											.IN0(LR_LLV1),
											.IN1(LR_H6W2),
											.OUT(LR_V6D2),
											._1(1)
		);

		SPS2T2X7H1 sps_v6d1(
											.IN0(LR_LLV7),
											.IN1(LR_H6W1),
											.OUT(LR_V6D1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6d0(
											.IN0(LR_LLV7),
											.IN1(LR_H6W0),
											.OUT(LR_V6D0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6m1(
											.IN0(LR_LLV9),
											.IN1(LR_H6C1),
											.OUT(LR_V6M1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c0(
											.IN0(LR_LLH2),
											.IN1(LR_V6M0),
											.OUT(LR_H6C0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c1(
											.IN0(LR_LLH2),
											.IN1(LR_V6M1),
											.OUT(LR_H6C1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c2(
											.IN0(LR_LLH8),
											.IN1(LR_V6M2),
											.OUT(LR_H6C2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c3(
											.IN0(LR_LLH8),
											.IN1(LR_V6M3),
											.OUT(LR_H6C3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c4(
											.IN0(LR_LLH8),
											.IN1(LR_LLH2),
											.OUT(LR_H6C4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c5(
											.IN0(LR_LLH8),
											.IN1(LR_LLH2),
											.OUT(LR_H6C5),
											._1(1)
		);

		SPS2T2X7H1 sps_h6a0(
											.IN0(LR_LLH5),
											.IN1(LR_V6N0),
											.OUT(LR_H6A0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6a1(
											.IN0(LR_LLH5),
											.IN1(LR_V6N1),
											.OUT(LR_H6A1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6n1(
											.IN0(LR_LLV0),
											.IN1(LR_H6A1),
											.OUT(LR_V6N1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6n0(
											.IN0(LR_LLV0),
											.IN1(LR_H6A0),
											.OUT(LR_V6N0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6a2(
											.IN0(LR_LLV5),
											.IN1(LR_H6B2),
											.OUT(LR_V6A2),
											._1(1)
		);

		SPS2T2X7H1 sps_v6m3(
											.IN0(LR_LLV3),
											.IN1(LR_H6C3),
											.OUT(LR_V6M3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6c3(
											.IN0(LR_LLV2),
											.IN1(LR_H6D3),
											.OUT(LR_V6C3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6c0(
											.IN0(LR_LLV8),
											.IN1(LR_H6D0),
											.OUT(LR_V6C0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6c1(
											.IN0(LR_LLV8),
											.IN1(LR_H6D1),
											.OUT(LR_V6C1),
											._1(1)
		);

		SPS1T1X7H1 sps_llv7(
											.OUT(LR_LLV7),
											.IN(LR_H6D4)
		);

		SPS2T2X7H1 sps_h6a4(
											.IN0(LR_LLH11),
											.IN1(LR_LLH5),
											.OUT(LR_H6A4),
											._1(1)
		);

		SPS2T2X7H1 sps_v6c2(
											.IN0(LR_LLV2),
											.IN1(LR_H6D2),
											.OUT(LR_V6C2),
											._1(1)
		);

		SPS1T1X7H1 sps_llv1(
											.OUT(LR_LLV1),
											.IN(LR_H6D5)
		);

		SPS1T1X7H1 sps_llv3(
											.OUT(LR_LLV3),
											.IN(LR_H6M5)
		);

		SPS2T2X7H1 sps_h6a5(
											.IN0(LR_LLH11),
											.IN1(LR_LLH5),
											.OUT(LR_H6A5),
											._1(1)
		);

		SPS2T2X7H1 sps_v6n2(
											.IN0(LR_LLV6),
											.IN1(LR_H6A2),
											.OUT(LR_V6N2),
											._1(1)
		);

		SPS1T1X7H1 sps_llv0(
											.OUT(LR_LLV0),
											.IN(LR_H6W5)
		);

		SPS2T2X7H1 sps_h6d5(
											.IN0(LR_LLH7),
											.IN1(LR_LLH1),
											.OUT(LR_H6D5),
											._1(1)
		);

		SPS2T2X7H1 sps_h6a2(
											.IN0(LR_LLH11),
											.IN1(LR_V6N2),
											.OUT(LR_H6A2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6d1(
											.IN0(LR_LLH1),
											.IN1(LR_V6C1),
											.OUT(LR_H6D1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6d0(
											.IN0(LR_LLH1),
											.IN1(LR_V6C0),
											.OUT(LR_H6D0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6d3(
											.IN0(LR_LLH7),
											.IN1(LR_V6C3),
											.OUT(LR_H6D3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6d2(
											.IN0(LR_LLH7),
											.IN1(LR_V6C2),
											.OUT(LR_H6D2),
											._1(1)
		);

		SPS1T1X7H1 sps_llv11(
											.OUT(LR_LLV11),
											.IN(LR_H6A4)
		);

		SPS1T1X7H1 sps_llv10(
											.OUT(LR_LLV10),
											.IN(LR_H6B4)
		);

		SPS1T1X7H1 sps_llv2(
											.OUT(LR_LLV2),
											.IN(LR_H6C5)
		);

		SPS2T2X7H1 sps_h6d4(
											.IN0(LR_LLH7),
											.IN1(LR_LLH1),
											.OUT(LR_H6D4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b3(
											.IN0(LR_LLH10),
											.IN1(LR_V6A3),
											.OUT(LR_H6B3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b2(
											.IN0(LR_LLH10),
											.IN1(LR_V6A2),
											.OUT(LR_H6B2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b1(
											.IN0(LR_LLH4),
											.IN1(LR_V6A1),
											.OUT(LR_H6B1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b0(
											.IN0(LR_LLH4),
											.IN1(LR_V6A0),
											.OUT(LR_H6B0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b5(
											.IN0(LR_LLH10),
											.IN1(LR_LLH4),
											.OUT(LR_H6B5),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b4(
											.IN0(LR_LLH10),
											.IN1(LR_LLH4),
											.OUT(LR_H6B4),
											._1(1)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_LBRAMC(
BRAM_EC0, BRAM_EC1, BRAM_EC2, BRAM_EC3, BRAM_EC4, BRAM_EC5, BRAM_EC6, BRAM_EC7, BRAM_EC8, BRAM_EC9, BRAM_EC10, BRAM_EC11, BRAM_EC12, BRAM_EC13, BRAM_EC14, BRAM_EC15, BRAM_EC16, BRAM_EC17, BRAM_EC18, BRAM_EC19, BRAM_EC20, BRAM_EC21, BRAM_EC22, BRAM_EC23, BRAM_H6EC0, BRAM_H6EC1, BRAM_H6EC2, BRAM_H6EC3, BRAM_H6BC0, BRAM_H6BC1, BRAM_H6BC2, BRAM_H6BC3, BRAM_H6MC0, BRAM_H6MC1, BRAM_H6MC2, BRAM_H6MC3, BRAM_H6DC0, BRAM_H6DC1, BRAM_H6DC2, BRAM_H6DC3, BRAM_LHC0, BRAM_LHC3, BRAM_LHC6, BRAM_LHC9, BRAM_LLV0, BRAM_LLV1, BRAM_LLV2, BRAM_LLV3, BRAM_LLV4, BRAM_LLV5, BRAM_LLV6, BRAM_LLV7, BRAM_LLV8, BRAM_LLV9, BRAM_LLV10, BRAM_LLV11, BRAM_RDOUTS1, BRAM_RDOUTS5, BRAM_RDOUTS9, BRAM_RDOUTS10, BRAM_RDOUTS11, BRAM_RDOUTS12, BRAM_RDOUTS13, BRAM_RDOUTS17, BRAM_RDOUTS21, BRAM_RDOUTS25, BRAM_RDOUTS27, BRAM_RDOUTS28, BRAM_RDOUTS29, BRAM_RDOUTS30, BRAM_RDOUTS31, BRAM_RDINS1, BRAM_RDINS2, BRAM_RDINS3, BRAM_RDINS5, BRAM_RDINS6, BRAM_RDINS7, BRAM_RDINS9, BRAM_RDINS13, BRAM_RDINS17, BRAM_RDINS19, BRAM_RDINS20, BRAM_RDINS21, BRAM_RDINS23, BRAM_RDINS24, BRAM_RDINS25, BRAM_RDINS29, BRAM_RADDRS0, BRAM_RADDRS1, BRAM_RADDRS2, BRAM_RADDRS3, BRAM_RADDRS5, BRAM_RADDRS8, BRAM_RADDRS9, BRAM_RADDRS10, BRAM_RADDRS11, BRAM_RADDRS12, BRAM_RADDRS13, BRAM_RADDRS14, BRAM_RADDRS15, BRAM_RADDRS16, BRAM_RADDRS17, BRAM_RADDRS18, BRAM_RADDRS19, BRAM_RADDRS21, BRAM_RADDRS24, BRAM_RADDRS25, BRAM_RADDRS26, BRAM_RADDRS27, BRAM_RADDRS28, BRAM_RADDRS29, BRAM_RADDRS30, BRAM_RADDRS31, BRAM_DIA4, BRAM_DIA5, BRAM_DIA12, BRAM_DIA13, BRAM_DIB4, BRAM_DIB5, BRAM_DIB12, BRAM_DIB13, BRAM_DOA2, BRAM_DOA6, BRAM_DOA10, BRAM_DOA14, BRAM_DOB2, BRAM_DOB6, BRAM_DOB10, BRAM_DOB14, BRAM_ADDRA4, BRAM_ADDRA5, BRAM_ADDRA6, BRAM_ADDRA7, BRAM_ADDRB4, BRAM_ADDRB5, BRAM_ADDRB6, BRAM_ADDRB7, BRAM_CLKB, BRAM_WEB, BRAM_SELB, BRAM_RSTB, BRAM_GCLKIN0, BRAM_GCLKIN1, BRAM_GCLKIN2, BRAM_GCLKIN3, BRAM_GCLK_IOBC0, BRAM_GCLK_IOBC1, BRAM_GCLK_IOBC2, BRAM_GCLK_IOBC3, BRAM_GCLK_CLBC0, BRAM_GCLK_CLBC1, BRAM_GCLK_CLBC2, BRAM_GCLK_CLBC3, _1
);
inout	BRAM_EC0;
inout	BRAM_EC1;
inout	BRAM_EC2;
inout	BRAM_EC3;
inout	BRAM_EC4;
inout	BRAM_EC5;
inout	BRAM_EC6;
inout	BRAM_EC7;
inout	BRAM_EC8;
inout	BRAM_EC9;
inout	BRAM_EC10;
inout	BRAM_EC11;
inout	BRAM_EC12;
inout	BRAM_EC13;
inout	BRAM_EC14;
inout	BRAM_EC15;
inout	BRAM_EC16;
inout	BRAM_EC17;
inout	BRAM_EC18;
inout	BRAM_EC19;
inout	BRAM_EC20;
inout	BRAM_EC21;
inout	BRAM_EC22;
inout	BRAM_EC23;
inout	BRAM_H6EC0;
inout	BRAM_H6EC1;
inout	BRAM_H6EC2;
inout	BRAM_H6EC3;
inout	BRAM_H6BC0;
inout	BRAM_H6BC1;
inout	BRAM_H6BC2;
inout	BRAM_H6BC3;
inout	BRAM_H6MC0;
inout	BRAM_H6MC1;
inout	BRAM_H6MC2;
inout	BRAM_H6MC3;
inout	BRAM_H6DC0;
inout	BRAM_H6DC1;
inout	BRAM_H6DC2;
inout	BRAM_H6DC3;
inout	BRAM_LHC0;
inout	BRAM_LHC3;
inout	BRAM_LHC6;
inout	BRAM_LHC9;
inout	BRAM_LLV0;
inout	BRAM_LLV1;
inout	BRAM_LLV2;
inout	BRAM_LLV3;
inout	BRAM_LLV4;
inout	BRAM_LLV5;
inout	BRAM_LLV6;
inout	BRAM_LLV7;
inout	BRAM_LLV8;
inout	BRAM_LLV9;
inout	BRAM_LLV10;
inout	BRAM_LLV11;
inout	BRAM_RDOUTS1;
inout	BRAM_RDOUTS5;
inout	BRAM_RDOUTS9;
inout	BRAM_RDOUTS10;
inout	BRAM_RDOUTS11;
inout	BRAM_RDOUTS12;
inout	BRAM_RDOUTS13;
inout	BRAM_RDOUTS17;
inout	BRAM_RDOUTS21;
inout	BRAM_RDOUTS25;
inout	BRAM_RDOUTS27;
inout	BRAM_RDOUTS28;
inout	BRAM_RDOUTS29;
inout	BRAM_RDOUTS30;
inout	BRAM_RDOUTS31;
inout	BRAM_RDINS1;
inout	BRAM_RDINS2;
inout	BRAM_RDINS3;
inout	BRAM_RDINS5;
inout	BRAM_RDINS6;
inout	BRAM_RDINS7;
inout	BRAM_RDINS9;
inout	BRAM_RDINS13;
inout	BRAM_RDINS17;
inout	BRAM_RDINS19;
inout	BRAM_RDINS20;
inout	BRAM_RDINS21;
inout	BRAM_RDINS23;
inout	BRAM_RDINS24;
inout	BRAM_RDINS25;
inout	BRAM_RDINS29;
inout	BRAM_RADDRS0;
inout	BRAM_RADDRS1;
inout	BRAM_RADDRS2;
inout	BRAM_RADDRS3;
inout	BRAM_RADDRS5;
inout	BRAM_RADDRS8;
inout	BRAM_RADDRS9;
inout	BRAM_RADDRS10;
inout	BRAM_RADDRS11;
inout	BRAM_RADDRS12;
inout	BRAM_RADDRS13;
inout	BRAM_RADDRS14;
inout	BRAM_RADDRS15;
inout	BRAM_RADDRS16;
inout	BRAM_RADDRS17;
inout	BRAM_RADDRS18;
inout	BRAM_RADDRS19;
inout	BRAM_RADDRS21;
inout	BRAM_RADDRS24;
inout	BRAM_RADDRS25;
inout	BRAM_RADDRS26;
inout	BRAM_RADDRS27;
inout	BRAM_RADDRS28;
inout	BRAM_RADDRS29;
inout	BRAM_RADDRS30;
inout	BRAM_RADDRS31;
inout	BRAM_DIA4;
inout	BRAM_DIA5;
inout	BRAM_DIA12;
inout	BRAM_DIA13;
inout	BRAM_DIB4;
inout	BRAM_DIB5;
inout	BRAM_DIB12;
inout	BRAM_DIB13;
inout	BRAM_DOA2;
inout	BRAM_DOA6;
inout	BRAM_DOA10;
inout	BRAM_DOA14;
inout	BRAM_DOB2;
inout	BRAM_DOB6;
inout	BRAM_DOB10;
inout	BRAM_DOB14;
inout	BRAM_ADDRA4;
inout	BRAM_ADDRA5;
inout	BRAM_ADDRA6;
inout	BRAM_ADDRA7;
inout	BRAM_ADDRB4;
inout	BRAM_ADDRB5;
inout	BRAM_ADDRB6;
inout	BRAM_ADDRB7;
inout	BRAM_CLKB;
inout	BRAM_WEB;
inout	BRAM_SELB;
inout	BRAM_RSTB;
inout	BRAM_GCLKIN0;
inout	BRAM_GCLKIN1;
inout	BRAM_GCLKIN2;
inout	BRAM_GCLKIN3;
inout	BRAM_GCLK_IOBC0;
inout	BRAM_GCLK_IOBC1;
inout	BRAM_GCLK_IOBC2;
inout	BRAM_GCLK_IOBC3;
inout	BRAM_GCLK_CLBC0;
inout	BRAM_GCLK_CLBC1;
inout	BRAM_GCLK_CLBC2;
inout	BRAM_GCLK_CLBC3;
inout	_1;
		wire		VDD ;

		TRIBUF1T1X7H1 tribuf_doa2_rdouts28(
											.OUT(BRAM_RDOUTS28),
											.IN(BRAM_DOA2)
		);

		SPS8T6X11H2 sps_rdins1(
											.IN4(BRAM_EC4),
											.IN5(BRAM_EC0),
											.IN6(BRAM_H6DC0),
											.IN7(BRAM_H6EC0),
											.IN0(BRAM_EC20),
											.IN1(BRAM_EC16),
											.IN2(BRAM_EC12),
											.IN3(BRAM_EC8),
											.OUT(BRAM_RDINS1),
											._1(1)
		);

		SPS8T6X11H2 sps_rdins5(
											.IN4(BRAM_EC5),
											.IN5(BRAM_EC1),
											.IN6(BRAM_H6DC1),
											.IN7(BRAM_H6EC1),
											.IN0(BRAM_EC21),
											.IN1(BRAM_EC17),
											.IN2(BRAM_EC13),
											.IN3(BRAM_EC9),
											.OUT(BRAM_RDINS5),
											._1(1)
		);

		SPS8T6X11H2 sps_rdins9(
											.IN4(BRAM_EC6),
											.IN5(BRAM_EC2),
											.IN6(BRAM_H6DC2),
											.IN7(BRAM_H6EC2),
											.IN0(BRAM_EC22),
											.IN1(BRAM_EC18),
											.IN2(BRAM_EC14),
											.IN3(BRAM_EC10),
											.OUT(BRAM_RDINS9),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa2_rdouts27(
											.IN(BRAM_DOA2),
											.OUT(BRAM_RDOUTS27)
		);

		SPS8T6X11H1 sps_llv1(
											.IN4(BRAM_EC4),
											.IN5(BRAM_EC0),
											.IN6(BRAM_H6DC0),
											.IN7(BRAM_H6EC0),
											.IN0(BRAM_EC20),
											.IN1(BRAM_EC16),
											.IN2(BRAM_EC12),
											.IN3(BRAM_EC8),
											.OUT(BRAM_LLV1),
											._1(1)
		);

		SPS8T6X11H1 sps_llv5(
											.IN4(BRAM_EC5),
											.IN5(BRAM_EC1),
											.IN6(BRAM_H6DC1),
											.IN7(BRAM_H6EC1),
											.IN0(BRAM_EC21),
											.IN1(BRAM_EC17),
											.IN2(BRAM_EC13),
											.IN3(BRAM_EC9),
											.OUT(BRAM_LLV5),
											._1(1)
		);

		SPS2T2X7H2 sps_ec21(
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS5),
											.OUT(BRAM_EC21),
											._1(1)
		);

		SPS2T2X7H2 sps_ec20(
											.IN0(BRAM_RDOUTS17),
											.IN1(BRAM_RDOUTS1),
											.OUT(BRAM_EC20),
											._1(1)
		);

		SPS2T2X7H2 sps_ec23(
											.IN0(BRAM_RDOUTS29),
											.IN1(BRAM_RDOUTS13),
											.OUT(BRAM_EC23),
											._1(1)
		);

		SPS2T2X7H2 sps_ec22(
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS9),
											.OUT(BRAM_EC22),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob14_rdouts13(
											.IN(BRAM_DOB14),
											.OUT(BRAM_RDOUTS13)
		);

		SPS8T6X11H2 sps_rdins13(
											.IN4(BRAM_EC7),
											.IN5(BRAM_EC3),
											.IN6(BRAM_H6DC3),
											.IN7(BRAM_H6EC3),
											.IN0(BRAM_EC23),
											.IN1(BRAM_EC19),
											.IN2(BRAM_EC15),
											.IN3(BRAM_EC11),
											.OUT(BRAM_RDINS13),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins17(
											.IN4(BRAM_EC4),
											.IN5(BRAM_EC0),
											.IN6(BRAM_H6DC0),
											.IN7(BRAM_H6EC0),
											.IN0(BRAM_EC20),
											.IN1(BRAM_EC16),
											.IN2(BRAM_EC12),
											.IN3(BRAM_EC8),
											.OUT(BRAM_RDINS17),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob6_rdouts31(
											.OUT(BRAM_RDOUTS31),
											.IN(BRAM_DOB6)
		);

		TRIBUF1T1X7H1 tribuf_dob6_rdouts30(
											.IN(BRAM_DOB6),
											.OUT(BRAM_RDOUTS30)
		);

		SPS24B7X11H1 sps_web(
											.IN8(VDD),
											.IN9(VDD),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS0),
											.IN1(BRAM_RADDRS1),
											.IN2(BRAM_RADDRS2),
											.IN3(BRAM_RADDRS3),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(VDD),
											.IN11(VDD),
											.OUT(BRAM_WEB),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobc1(
											.OUT(BRAM_GCLK_IOBC1),
											.IN(BRAM_GCLKIN1)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobc0(
											.OUT(BRAM_GCLK_IOBC0),
											.IN(BRAM_GCLKIN0)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobc3(
											.OUT(BRAM_GCLK_IOBC3),
											.IN(BRAM_GCLKIN3)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobc2(
											.OUT(BRAM_GCLK_IOBC2),
											.IN(BRAM_GCLKIN2)
		);

		TRIBUF1T1X7H1 tribuf_dob2_rdouts28(
											.IN(BRAM_DOB2),
											.OUT(BRAM_RDOUTS28)
		);

		TRIBUF1T1X7H1 tribuf_dob2_rdouts29(
											.IN(BRAM_DOB2),
											.OUT(BRAM_RDOUTS29)
		);

		TRIBUF1T1X7H1 tribuf_dob10_rdouts28(
											.IN(BRAM_DOB10),
											.OUT(BRAM_RDOUTS28)
		);

		TRIBUF1T1X7H1 tribuf_doa6_rdouts30(
											.OUT(BRAM_RDOUTS30),
											.IN(BRAM_DOA6)
		);

		TRIBUF1T1X7H1 tribuf_doa14_rdouts12(
											.OUT(BRAM_RDOUTS12),
											.IN(BRAM_DOA14)
		);

		SPS8T6X11H1 sps_dib12(
											.IN4(BRAM_RDINS7),
											.IN5(BRAM_RDINS6),
											.IN6(BRAM_RDINS3),
											.IN7(BRAM_RDINS2),
											.IN0(BRAM_RDINS25),
											.IN1(BRAM_RDINS24),
											.IN2(BRAM_RDINS21),
											.IN3(BRAM_RDINS20),
											.OUT(BRAM_DIB12),
											._1(1)
		);

		SPS8T6X11H2 sps_dib13(
											.IN4(BRAM_RDINS7),
											.IN5(BRAM_RDINS6),
											.IN6(BRAM_RDINS3),
											.IN7(BRAM_RDINS2),
											.IN0(BRAM_RDINS25),
											.IN1(BRAM_RDINS24),
											.IN2(BRAM_RDINS21),
											.IN3(BRAM_RDINS20),
											.OUT(BRAM_DIB13),
											._1(1)
		);

		SPS8T6X11H2 sps_dia5(
											.IN4(BRAM_RDINS6),
											.IN5(BRAM_RDINS5),
											.IN6(BRAM_RDINS2),
											.IN7(BRAM_RDINS1),
											.IN0(BRAM_RDINS24),
											.IN1(BRAM_RDINS23),
											.IN2(BRAM_RDINS20),
											.IN3(BRAM_RDINS19),
											.OUT(BRAM_DIA5),
											._1(1)
		);

		SPS8T6X11H1 sps_dia4(
											.IN4(BRAM_RDINS6),
											.IN5(BRAM_RDINS5),
											.IN6(BRAM_RDINS2),
											.IN7(BRAM_RDINS1),
											.IN0(BRAM_RDINS24),
											.IN1(BRAM_RDINS23),
											.IN2(BRAM_RDINS20),
											.IN3(BRAM_RDINS19),
											.OUT(BRAM_DIA4),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa10_rdouts10(
											.OUT(BRAM_RDOUTS10),
											.IN(BRAM_DOA10)
		);

		TRIBUF1T1X7H1 tribuf_doa6_rdouts29(
											.IN(BRAM_DOA6),
											.OUT(BRAM_RDOUTS29)
		);

		SPS24B7X11H1 sps_selb(
											.IN8(VDD),
											.IN9(VDD),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS24),
											.IN1(BRAM_RADDRS25),
											.IN2(BRAM_RADDRS26),
											.IN3(BRAM_RADDRS27),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(VDD),
											.IN11(VDD),
											.OUT(BRAM_SELB),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		SPS24B7X11H1 sps_clkb(
											.IN8(BRAM_GCLKIN0),
											.IN9(BRAM_GCLKIN1),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS0),
											.IN1(BRAM_RADDRS1),
											.IN2(BRAM_RADDRS2),
											.IN3(BRAM_RADDRS3),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(BRAM_GCLKIN2),
											.IN11(BRAM_GCLKIN3),
											.OUT(BRAM_CLKB),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		SPS24B7X11H1 sps_rstb(
											.IN8(VDD),
											.IN9(VDD),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS24),
											.IN1(BRAM_RADDRS25),
											.IN2(BRAM_RADDRS26),
											.IN3(BRAM_RADDRS27),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(VDD),
											.IN11(VDD),
											.OUT(BRAM_RSTB),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		SPS8T6X11H1 sps_lhc6(
											.IN4(BRAM_RDOUTS17),
											.IN5(BRAM_RDOUTS21),
											.IN6(BRAM_RDOUTS25),
											.IN7(BRAM_RDOUTS29),
											.IN0(BRAM_RDOUTS1),
											.IN1(BRAM_RDOUTS5),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											.OUT(BRAM_LHC6),
											._1(1)
		);

		SPS8T6X11H1 sps_lhc3(
											.IN4(BRAM_RDOUTS17),
											.IN5(BRAM_RDOUTS21),
											.IN6(BRAM_RDOUTS25),
											.IN7(BRAM_RDOUTS29),
											.IN0(BRAM_RDOUTS1),
											.IN1(BRAM_RDOUTS5),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											.OUT(BRAM_LHC3),
											._1(1)
		);

		SPS8T6X11H1 sps_lhc0(
											.IN4(BRAM_RDOUTS17),
											.IN5(BRAM_RDOUTS21),
											.IN6(BRAM_RDOUTS25),
											.IN7(BRAM_RDOUTS29),
											.IN0(BRAM_RDOUTS1),
											.IN1(BRAM_RDOUTS5),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											.OUT(BRAM_LHC0),
											._1(1)
		);

		SPS8T6X11H1 sps_lhc9(
											.IN4(BRAM_RDOUTS17),
											.IN5(BRAM_RDOUTS21),
											.IN6(BRAM_RDOUTS25),
											.IN7(BRAM_RDOUTS29),
											.IN0(BRAM_RDOUTS1),
											.IN1(BRAM_RDOUTS5),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											.OUT(BRAM_LHC9),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins29(
											.IN4(BRAM_EC7),
											.IN5(BRAM_EC3),
											.IN6(BRAM_H6DC3),
											.IN7(BRAM_H6EC3),
											.IN0(BRAM_EC23),
											.IN1(BRAM_EC19),
											.IN2(BRAM_EC15),
											.IN3(BRAM_EC11),
											.OUT(BRAM_RDINS29),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa2_rdouts9(
											.IN(BRAM_DOA2),
											.OUT(BRAM_RDOUTS9)
		);

		SPS8T6X11H1 sps_rdins21(
											.IN4(BRAM_EC5),
											.IN5(BRAM_EC1),
											.IN6(BRAM_H6DC1),
											.IN7(BRAM_H6EC1),
											.IN0(BRAM_EC21),
											.IN1(BRAM_EC17),
											.IN2(BRAM_EC13),
											.IN3(BRAM_EC9),
											.OUT(BRAM_RDINS21),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb6(
											.IN4(BRAM_RADDRS15),
											.IN5(BRAM_RADDRS14),
											.IN6(BRAM_RADDRS13),
											.IN7(BRAM_RADDRS12),
											.IN0(BRAM_RADDRS19),
											.IN1(BRAM_RADDRS18),
											.IN2(BRAM_RADDRS17),
											.IN3(BRAM_RADDRS16),
											.OUT(BRAM_ADDRB6),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb7(
											.IN4(BRAM_RADDRS15),
											.IN5(BRAM_RADDRS14),
											.IN6(BRAM_RADDRS13),
											.IN7(BRAM_RADDRS12),
											.IN0(BRAM_RADDRS19),
											.IN1(BRAM_RADDRS18),
											.IN2(BRAM_RADDRS17),
											.IN3(BRAM_RADDRS16),
											.OUT(BRAM_ADDRB7),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb4(
											.IN4(BRAM_RADDRS11),
											.IN5(BRAM_RADDRS10),
											.IN6(BRAM_RADDRS9),
											.IN7(BRAM_RADDRS8),
											.IN0(BRAM_RADDRS15),
											.IN1(BRAM_RADDRS14),
											.IN2(BRAM_RADDRS13),
											.IN3(BRAM_RADDRS12),
											.OUT(BRAM_ADDRB4),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb5(
											.IN4(BRAM_RADDRS11),
											.IN5(BRAM_RADDRS10),
											.IN6(BRAM_RADDRS9),
											.IN7(BRAM_RADDRS8),
											.IN0(BRAM_RADDRS15),
											.IN1(BRAM_RADDRS14),
											.IN2(BRAM_RADDRS13),
											.IN3(BRAM_RADDRS12),
											.OUT(BRAM_ADDRB5),
											._1(1)
		);

		SPS8T6X11H2 sps_dia13(
											.IN4(BRAM_RDINS6),
											.IN5(BRAM_RDINS5),
											.IN6(BRAM_RDINS2),
											.IN7(BRAM_RDINS1),
											.IN0(BRAM_RDINS24),
											.IN1(BRAM_RDINS23),
											.IN2(BRAM_RDINS20),
											.IN3(BRAM_RDINS19),
											.OUT(BRAM_DIA13),
											._1(1)
		);

		SPS8T6X11H1 sps_dia12(
											.IN4(BRAM_RDINS6),
											.IN5(BRAM_RDINS5),
											.IN6(BRAM_RDINS2),
											.IN7(BRAM_RDINS1),
											.IN0(BRAM_RDINS24),
											.IN1(BRAM_RDINS23),
											.IN2(BRAM_RDINS20),
											.IN3(BRAM_RDINS19),
											.OUT(BRAM_DIA12),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob14_rdouts30(
											.IN(BRAM_DOB14),
											.OUT(BRAM_RDOUTS30)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbc2(
											.OUT(BRAM_GCLK_CLBC2),
											.IN(BRAM_GCLKIN2)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbc3(
											.OUT(BRAM_GCLK_CLBC3),
											.IN(BRAM_GCLKIN3)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbc0(
											.OUT(BRAM_GCLK_CLBC0),
											.IN(BRAM_GCLKIN0)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbc1(
											.OUT(BRAM_GCLK_CLBC1),
											.IN(BRAM_GCLKIN1)
		);

		SPS8T6X11H1 sps_llv9(
											.IN4(BRAM_EC6),
											.IN5(BRAM_EC2),
											.IN6(BRAM_H6DC2),
											.IN7(BRAM_H6EC2),
											.IN0(BRAM_EC22),
											.IN1(BRAM_EC18),
											.IN2(BRAM_EC14),
											.IN3(BRAM_EC10),
											.OUT(BRAM_LLV9),
											._1(1)
		);

		SPS8T6X11H2 sps_dib5(
											.IN4(BRAM_RDINS7),
											.IN5(BRAM_RDINS6),
											.IN6(BRAM_RDINS3),
											.IN7(BRAM_RDINS2),
											.IN0(BRAM_RDINS25),
											.IN1(BRAM_RDINS24),
											.IN2(BRAM_RDINS21),
											.IN3(BRAM_RDINS20),
											.OUT(BRAM_DIB5),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs9(
											.IN4(BRAM_EC6),
											.IN5(BRAM_EC2),
											.IN6(BRAM_H6DC2),
											.IN7(BRAM_H6EC2),
											.IN0(BRAM_EC22),
											.IN1(BRAM_EC18),
											.IN2(BRAM_EC14),
											.IN3(BRAM_EC10),
											.OUT(BRAM_RADDRS9),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs1(
											.IN4(BRAM_EC4),
											.IN5(BRAM_EC0),
											.IN6(BRAM_H6DC0),
											.IN7(BRAM_H6EC0),
											.IN0(BRAM_EC20),
											.IN1(BRAM_EC16),
											.IN2(BRAM_EC12),
											.IN3(BRAM_EC8),
											.OUT(BRAM_RADDRS1),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs5(
											.IN4(BRAM_EC5),
											.IN5(BRAM_EC1),
											.IN6(BRAM_H6DC1),
											.IN7(BRAM_H6EC1),
											.IN0(BRAM_EC21),
											.IN1(BRAM_EC17),
											.IN2(BRAM_EC13),
											.IN3(BRAM_EC9),
											.OUT(BRAM_RADDRS5),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob2_rdouts11(
											.IN(BRAM_DOB2),
											.OUT(BRAM_RDOUTS11)
		);

		TRIBUF1T1X7H1 tribuf_dob2_rdouts10(
											.IN(BRAM_DOB2),
											.OUT(BRAM_RDOUTS10)
		);

		SPS8T6X11H1 sps_rdins25(
											.IN4(BRAM_EC6),
											.IN5(BRAM_EC2),
											.IN6(BRAM_H6DC2),
											.IN7(BRAM_H6EC2),
											.IN0(BRAM_EC22),
											.IN1(BRAM_EC18),
											.IN2(BRAM_EC14),
											.IN3(BRAM_EC10),
											.OUT(BRAM_RDINS25),
											._1(1)
		);

		SPS4T3X11H2 sps_h6mc2(
											.OUT(BRAM_H6MC2),
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS17),
											.IN2(BRAM_RDOUTS5),
											.IN3(BRAM_RDOUTS1),
											._1(1)
		);

		SPS4T3X11H2 sps_h6mc3(
											.OUT(BRAM_H6MC3),
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS29),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											._1(1)
		);

		SPS4T3X11H2 sps_h6mc0(
											.OUT(BRAM_H6MC0),
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS17),
											.IN2(BRAM_RDOUTS5),
											.IN3(BRAM_RDOUTS1),
											._1(1)
		);

		SPS4T3X11H2 sps_h6mc1(
											.OUT(BRAM_H6MC1),
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS29),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											._1(1)
		);

		SPS2T2X7H2 sps_ec10(
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS9),
											.OUT(BRAM_EC10),
											._1(1)
		);

		SPS2T2X7H2 sps_ec11(
											.IN0(BRAM_RDOUTS29),
											.IN1(BRAM_RDOUTS13),
											.OUT(BRAM_EC11),
											._1(1)
		);

		SPS2T2X7H2 sps_ec12(
											.IN0(BRAM_RDOUTS17),
											.IN1(BRAM_RDOUTS1),
											.OUT(BRAM_EC12),
											._1(1)
		);

		SPS2T2X7H2 sps_ec13(
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS5),
											.OUT(BRAM_EC13),
											._1(1)
		);

		SPS2T2X7H2 sps_ec14(
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS9),
											.OUT(BRAM_EC14),
											._1(1)
		);

		SPS2T2X7H2 sps_ec15(
											.IN0(BRAM_RDOUTS29),
											.IN1(BRAM_RDOUTS13),
											.OUT(BRAM_EC15),
											._1(1)
		);

		SPS2T2X7H2 sps_ec16(
											.IN0(BRAM_RDOUTS17),
											.IN1(BRAM_RDOUTS1),
											.OUT(BRAM_EC16),
											._1(1)
		);

		SPS2T2X7H2 sps_ec17(
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS5),
											.OUT(BRAM_EC17),
											._1(1)
		);

		SPS2T2X7H2 sps_ec18(
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS9),
											.OUT(BRAM_EC18),
											._1(1)
		);

		SPS2T2X7H2 sps_ec19(
											.IN0(BRAM_RDOUTS29),
											.IN1(BRAM_RDOUTS13),
											.OUT(BRAM_EC19),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa2_rdouts10(
											.IN(BRAM_DOA2),
											.OUT(BRAM_RDOUTS10)
		);

		SPS8T6X11H1 sps_raddrs29(
											.IN4(BRAM_EC7),
											.IN5(BRAM_EC3),
											.IN6(BRAM_H6DC3),
											.IN7(BRAM_H6EC3),
											.IN0(BRAM_EC23),
											.IN1(BRAM_EC19),
											.IN2(BRAM_EC15),
											.IN3(BRAM_EC11),
											.OUT(BRAM_RADDRS29),
											._1(1)
		);

		SPS8T6X11H1 sps_addra7(
											.IN4(BRAM_RADDRS15),
											.IN5(BRAM_RADDRS14),
											.IN6(BRAM_RADDRS13),
											.IN7(BRAM_RADDRS12),
											.IN0(BRAM_RADDRS19),
											.IN1(BRAM_RADDRS18),
											.IN2(BRAM_RADDRS17),
											.IN3(BRAM_RADDRS16),
											.OUT(BRAM_ADDRA7),
											._1(1)
		);

		SPS8T6X11H1 sps_addra6(
											.IN4(BRAM_RADDRS15),
											.IN5(BRAM_RADDRS14),
											.IN6(BRAM_RADDRS13),
											.IN7(BRAM_RADDRS12),
											.IN0(BRAM_RADDRS19),
											.IN1(BRAM_RADDRS18),
											.IN2(BRAM_RADDRS17),
											.IN3(BRAM_RADDRS16),
											.OUT(BRAM_ADDRA6),
											._1(1)
		);

		SPS8T6X11H1 sps_addra5(
											.IN4(BRAM_RADDRS11),
											.IN5(BRAM_RADDRS10),
											.IN6(BRAM_RADDRS9),
											.IN7(BRAM_RADDRS8),
											.IN0(BRAM_RADDRS15),
											.IN1(BRAM_RADDRS14),
											.IN2(BRAM_RADDRS13),
											.IN3(BRAM_RADDRS12),
											.OUT(BRAM_ADDRA5),
											._1(1)
		);

		SPS8T6X11H1 sps_addra4(
											.IN4(BRAM_RADDRS11),
											.IN5(BRAM_RADDRS10),
											.IN6(BRAM_RADDRS9),
											.IN7(BRAM_RADDRS8),
											.IN0(BRAM_RADDRS15),
											.IN1(BRAM_RADDRS14),
											.IN2(BRAM_RADDRS13),
											.IN3(BRAM_RADDRS12),
											.OUT(BRAM_ADDRA4),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs25(
											.IN4(BRAM_EC6),
											.IN5(BRAM_EC2),
											.IN6(BRAM_H6DC2),
											.IN7(BRAM_H6EC2),
											.IN0(BRAM_EC22),
											.IN1(BRAM_EC18),
											.IN2(BRAM_EC14),
											.IN3(BRAM_EC10),
											.OUT(BRAM_RADDRS25),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa10_rdouts27(
											.OUT(BRAM_RDOUTS27),
											.IN(BRAM_DOA10)
		);

		TRIBUF1T1X7H1 tribuf_dob6_rdouts13(
											.IN(BRAM_DOB6),
											.OUT(BRAM_RDOUTS13)
		);

		TRIBUF1T1X7H1 tribuf_dob6_rdouts12(
											.IN(BRAM_DOB6),
											.OUT(BRAM_RDOUTS12)
		);

		TRIBUF1T1X7H1 tribuf_doa14_rdouts29(
											.IN(BRAM_DOA14),
											.OUT(BRAM_RDOUTS29)
		);

		SPS8T6X11H1 sps_raddrs21(
											.IN4(BRAM_EC5),
											.IN5(BRAM_EC1),
											.IN6(BRAM_H6DC1),
											.IN7(BRAM_H6EC1),
											.IN0(BRAM_EC21),
											.IN1(BRAM_EC17),
											.IN2(BRAM_EC13),
											.IN3(BRAM_EC9),
											.OUT(BRAM_RADDRS21),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bc1(
											.OUT(BRAM_H6BC1),
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS29),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bc0(
											.OUT(BRAM_H6BC0),
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS17),
											.IN2(BRAM_RDOUTS5),
											.IN3(BRAM_RDOUTS1),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bc3(
											.OUT(BRAM_H6BC3),
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS29),
											.IN2(BRAM_RDOUTS9),
											.IN3(BRAM_RDOUTS13),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bc2(
											.OUT(BRAM_H6BC2),
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS17),
											.IN2(BRAM_RDOUTS5),
											.IN3(BRAM_RDOUTS1),
											._1(1)
		);

		SPS2T2X7H2 sps_ec8(
											.IN0(BRAM_RDOUTS17),
											.IN1(BRAM_RDOUTS1),
											.OUT(BRAM_EC8),
											._1(1)
		);

		SPS2T2X7H2 sps_ec9(
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS5),
											.OUT(BRAM_EC9),
											._1(1)
		);

		SPS2T2X7H2 sps_ec6(
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS9),
											.OUT(BRAM_EC6),
											._1(1)
		);

		SPS2T2X7H2 sps_ec7(
											.IN0(BRAM_RDOUTS29),
											.IN1(BRAM_RDOUTS13),
											.OUT(BRAM_EC7),
											._1(1)
		);

		SPS2T2X7H2 sps_ec4(
											.IN0(BRAM_RDOUTS17),
											.IN1(BRAM_RDOUTS1),
											.OUT(BRAM_EC4),
											._1(1)
		);

		SPS2T2X7H2 sps_ec5(
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS5),
											.OUT(BRAM_EC5),
											._1(1)
		);

		SPS2T2X7H2 sps_ec2(
											.IN0(BRAM_RDOUTS25),
											.IN1(BRAM_RDOUTS9),
											.OUT(BRAM_EC2),
											._1(1)
		);

		SPS2T2X7H2 sps_ec3(
											.IN0(BRAM_RDOUTS29),
											.IN1(BRAM_RDOUTS13),
											.OUT(BRAM_EC3),
											._1(1)
		);

		SPS2T2X7H2 sps_ec0(
											.IN0(BRAM_RDOUTS17),
											.IN1(BRAM_RDOUTS1),
											.OUT(BRAM_EC0),
											._1(1)
		);

		SPS2T2X7H2 sps_ec1(
											.IN0(BRAM_RDOUTS21),
											.IN1(BRAM_RDOUTS5),
											.OUT(BRAM_EC1),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob10_rdouts11(
											.IN(BRAM_DOB10),
											.OUT(BRAM_RDOUTS11)
		);

		SPS8T6X11H1 sps_dib4(
											.IN4(BRAM_RDINS7),
											.IN5(BRAM_RDINS6),
											.IN6(BRAM_RDINS3),
											.IN7(BRAM_RDINS2),
											.IN0(BRAM_RDINS25),
											.IN1(BRAM_RDINS24),
											.IN2(BRAM_RDINS21),
											.IN3(BRAM_RDINS20),
											.OUT(BRAM_DIB4),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs13(
											.IN4(BRAM_EC7),
											.IN5(BRAM_EC3),
											.IN6(BRAM_H6DC3),
											.IN7(BRAM_H6EC3),
											.IN0(BRAM_EC23),
											.IN1(BRAM_EC19),
											.IN2(BRAM_EC15),
											.IN3(BRAM_EC11),
											.OUT(BRAM_RADDRS13),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs17(
											.IN4(BRAM_EC4),
											.IN5(BRAM_EC0),
											.IN6(BRAM_H6DC0),
											.IN7(BRAM_H6EC0),
											.IN0(BRAM_EC20),
											.IN1(BRAM_EC16),
											.IN2(BRAM_EC12),
											.IN3(BRAM_EC8),
											.OUT(BRAM_RADDRS17),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa6_rdouts11(
											.OUT(BRAM_RDOUTS11),
											.IN(BRAM_DOA6)
		);

		TRIBUF1T1X7H1 tribuf_doa6_rdouts12(
											.IN(BRAM_DOA6),
											.OUT(BRAM_RDOUTS12)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_LBRAMB(
BRAM_EB0, BRAM_EB1, BRAM_EB2, BRAM_EB3, BRAM_EB4, BRAM_EB5, BRAM_EB6, BRAM_EB7, BRAM_EB8, BRAM_EB9, BRAM_EB10, BRAM_EB11, BRAM_EB12, BRAM_EB13, BRAM_EB14, BRAM_EB15, BRAM_EB16, BRAM_EB17, BRAM_EB18, BRAM_EB19, BRAM_EB20, BRAM_EB21, BRAM_EB22, BRAM_EB23, BRAM_H6EB0, BRAM_H6EB1, BRAM_H6EB2, BRAM_H6EB3, BRAM_H6BB0, BRAM_H6BB1, BRAM_H6BB2, BRAM_H6BB3, BRAM_H6MB0, BRAM_H6MB1, BRAM_H6MB2, BRAM_H6MB3, BRAM_H6DB0, BRAM_H6DB1, BRAM_H6DB2, BRAM_H6DB3, BRAM_LHB0, BRAM_LHB3, BRAM_LHB6, BRAM_LHB9, BRAM_LLV0, BRAM_LLV1, BRAM_LLV2, BRAM_LLV3, BRAM_LLV4, BRAM_LLV5, BRAM_LLV6, BRAM_LLV7, BRAM_LLV8, BRAM_LLV9, BRAM_LLV10, BRAM_LLV11, BRAM_GCLKIN0, BRAM_GCLKIN1, BRAM_GCLKIN2, BRAM_GCLKIN3, BRAM_GCLK_IOBB0, BRAM_GCLK_IOBB1, BRAM_GCLK_IOBB2, BRAM_GCLK_IOBB3, BRAM_GCLK_CLBB0, BRAM_GCLK_CLBB1, BRAM_GCLK_CLBB2, BRAM_GCLK_CLBB3, BRAM_RDOUTS0, BRAM_RDOUTS1, BRAM_RDOUTS2, BRAM_RDOUTS5, BRAM_RDOUTS6, BRAM_RDOUTS7, BRAM_RDOUTS10, BRAM_RDOUTS14, BRAM_RDOUTS15, BRAM_RDOUTS17, BRAM_RDOUTS18, BRAM_RDOUTS19, BRAM_RDOUTS22, BRAM_RDOUTS23, BRAM_RDOUTS24, BRAM_RDOUTS25, BRAM_RDOUTS26, BRAM_RDOUTS30, BRAM_RDINS2, BRAM_RDINS6, BRAM_RDINS7, BRAM_RDINS8, BRAM_RDINS9, BRAM_RDINS10, BRAM_RDINS11, BRAM_RDINS12, BRAM_RDINS13, BRAM_RDINS14, BRAM_RDINS18, BRAM_RDINS22, BRAM_RDINS25, BRAM_RDINS26, BRAM_RDINS27, BRAM_RDINS29, BRAM_RDINS30, BRAM_RDINS31, BRAM_RADDRS0, BRAM_RADDRS1, BRAM_RADDRS2, BRAM_RADDRS3, BRAM_RADDRS4, BRAM_RADDRS5, BRAM_RADDRS6, BRAM_RADDRS7, BRAM_RADDRS8, BRAM_RADDRS9, BRAM_RADDRS10, BRAM_RADDRS11, BRAM_RADDRS14, BRAM_RADDRS18, BRAM_RADDRS22, BRAM_RADDRS24, BRAM_RADDRS25, BRAM_RADDRS26, BRAM_RADDRS27, BRAM_RADDRS28, BRAM_RADDRS29, BRAM_RADDRS30, BRAM_RADDRS31, BRAM_DIA1, BRAM_DIA3, BRAM_DIA9, BRAM_DIA11, BRAM_DIB1, BRAM_DIB3, BRAM_DIB9, BRAM_DIB11, BRAM_DOA1, BRAM_DOA5, BRAM_DOA9, BRAM_DOA13, BRAM_DOB1, BRAM_DOB5, BRAM_DOB9, BRAM_DOB13, BRAM_ADDRA0, BRAM_ADDRA1, BRAM_ADDRA2, BRAM_ADDRA3, BRAM_ADDRB0, BRAM_ADDRB1, BRAM_ADDRB2, BRAM_ADDRB3, BRAM_CLKA, BRAM_WEA, BRAM_SELA, BRAM_RSTA, _1
);
inout	BRAM_EB0;
inout	BRAM_EB1;
inout	BRAM_EB2;
inout	BRAM_EB3;
inout	BRAM_EB4;
inout	BRAM_EB5;
inout	BRAM_EB6;
inout	BRAM_EB7;
inout	BRAM_EB8;
inout	BRAM_EB9;
inout	BRAM_EB10;
inout	BRAM_EB11;
inout	BRAM_EB12;
inout	BRAM_EB13;
inout	BRAM_EB14;
inout	BRAM_EB15;
inout	BRAM_EB16;
inout	BRAM_EB17;
inout	BRAM_EB18;
inout	BRAM_EB19;
inout	BRAM_EB20;
inout	BRAM_EB21;
inout	BRAM_EB22;
inout	BRAM_EB23;
inout	BRAM_H6EB0;
inout	BRAM_H6EB1;
inout	BRAM_H6EB2;
inout	BRAM_H6EB3;
inout	BRAM_H6BB0;
inout	BRAM_H6BB1;
inout	BRAM_H6BB2;
inout	BRAM_H6BB3;
inout	BRAM_H6MB0;
inout	BRAM_H6MB1;
inout	BRAM_H6MB2;
inout	BRAM_H6MB3;
inout	BRAM_H6DB0;
inout	BRAM_H6DB1;
inout	BRAM_H6DB2;
inout	BRAM_H6DB3;
inout	BRAM_LHB0;
inout	BRAM_LHB3;
inout	BRAM_LHB6;
inout	BRAM_LHB9;
inout	BRAM_LLV0;
inout	BRAM_LLV1;
inout	BRAM_LLV2;
inout	BRAM_LLV3;
inout	BRAM_LLV4;
inout	BRAM_LLV5;
inout	BRAM_LLV6;
inout	BRAM_LLV7;
inout	BRAM_LLV8;
inout	BRAM_LLV9;
inout	BRAM_LLV10;
inout	BRAM_LLV11;
inout	BRAM_GCLKIN0;
inout	BRAM_GCLKIN1;
inout	BRAM_GCLKIN2;
inout	BRAM_GCLKIN3;
inout	BRAM_GCLK_IOBB0;
inout	BRAM_GCLK_IOBB1;
inout	BRAM_GCLK_IOBB2;
inout	BRAM_GCLK_IOBB3;
inout	BRAM_GCLK_CLBB0;
inout	BRAM_GCLK_CLBB1;
inout	BRAM_GCLK_CLBB2;
inout	BRAM_GCLK_CLBB3;
inout	BRAM_RDOUTS0;
inout	BRAM_RDOUTS1;
inout	BRAM_RDOUTS2;
inout	BRAM_RDOUTS5;
inout	BRAM_RDOUTS6;
inout	BRAM_RDOUTS7;
inout	BRAM_RDOUTS10;
inout	BRAM_RDOUTS14;
inout	BRAM_RDOUTS15;
inout	BRAM_RDOUTS17;
inout	BRAM_RDOUTS18;
inout	BRAM_RDOUTS19;
inout	BRAM_RDOUTS22;
inout	BRAM_RDOUTS23;
inout	BRAM_RDOUTS24;
inout	BRAM_RDOUTS25;
inout	BRAM_RDOUTS26;
inout	BRAM_RDOUTS30;
inout	BRAM_RDINS2;
inout	BRAM_RDINS6;
inout	BRAM_RDINS7;
inout	BRAM_RDINS8;
inout	BRAM_RDINS9;
inout	BRAM_RDINS10;
inout	BRAM_RDINS11;
inout	BRAM_RDINS12;
inout	BRAM_RDINS13;
inout	BRAM_RDINS14;
inout	BRAM_RDINS18;
inout	BRAM_RDINS22;
inout	BRAM_RDINS25;
inout	BRAM_RDINS26;
inout	BRAM_RDINS27;
inout	BRAM_RDINS29;
inout	BRAM_RDINS30;
inout	BRAM_RDINS31;
inout	BRAM_RADDRS0;
inout	BRAM_RADDRS1;
inout	BRAM_RADDRS2;
inout	BRAM_RADDRS3;
inout	BRAM_RADDRS4;
inout	BRAM_RADDRS5;
inout	BRAM_RADDRS6;
inout	BRAM_RADDRS7;
inout	BRAM_RADDRS8;
inout	BRAM_RADDRS9;
inout	BRAM_RADDRS10;
inout	BRAM_RADDRS11;
inout	BRAM_RADDRS14;
inout	BRAM_RADDRS18;
inout	BRAM_RADDRS22;
inout	BRAM_RADDRS24;
inout	BRAM_RADDRS25;
inout	BRAM_RADDRS26;
inout	BRAM_RADDRS27;
inout	BRAM_RADDRS28;
inout	BRAM_RADDRS29;
inout	BRAM_RADDRS30;
inout	BRAM_RADDRS31;
inout	BRAM_DIA1;
inout	BRAM_DIA3;
inout	BRAM_DIA9;
inout	BRAM_DIA11;
inout	BRAM_DIB1;
inout	BRAM_DIB3;
inout	BRAM_DIB9;
inout	BRAM_DIB11;
inout	BRAM_DOA1;
inout	BRAM_DOA5;
inout	BRAM_DOA9;
inout	BRAM_DOA13;
inout	BRAM_DOB1;
inout	BRAM_DOB5;
inout	BRAM_DOB9;
inout	BRAM_DOB13;
inout	BRAM_ADDRA0;
inout	BRAM_ADDRA1;
inout	BRAM_ADDRA2;
inout	BRAM_ADDRA3;
inout	BRAM_ADDRB0;
inout	BRAM_ADDRB1;
inout	BRAM_ADDRB2;
inout	BRAM_ADDRB3;
inout	BRAM_CLKA;
inout	BRAM_WEA;
inout	BRAM_SELA;
inout	BRAM_RSTA;
inout	_1;
		wire		VDD ;

		SPS8T6X11H2 sps_rdins2(
											.IN4(BRAM_EB4),
											.IN5(BRAM_EB0),
											.IN6(BRAM_H6DB0),
											.IN7(BRAM_H6EB0),
											.IN0(BRAM_EB20),
											.IN1(BRAM_EB16),
											.IN2(BRAM_EB12),
											.IN3(BRAM_EB8),
											.OUT(BRAM_RDINS2),
											._1(1)
		);

		SPS8T6X11H2 sps_rdins6(
											.IN4(BRAM_EB5),
											.IN5(BRAM_EB1),
											.IN6(BRAM_H6DB1),
											.IN7(BRAM_H6EB1),
											.IN0(BRAM_EB21),
											.IN1(BRAM_EB17),
											.IN2(BRAM_EB13),
											.IN3(BRAM_EB9),
											.OUT(BRAM_RDINS6),
											._1(1)
		);

		SPS8T6X11H1 sps_llv2(
											.IN4(BRAM_EB4),
											.IN5(BRAM_EB0),
											.IN6(BRAM_H6DB0),
											.IN7(BRAM_H6EB0),
											.IN0(BRAM_EB20),
											.IN1(BRAM_EB16),
											.IN2(BRAM_EB12),
											.IN3(BRAM_EB8),
											.OUT(BRAM_LLV2),
											._1(1)
		);

		SPS8T6X11H1 sps_llv6(
											.IN4(BRAM_EB5),
											.IN5(BRAM_EB1),
											.IN6(BRAM_H6DB1),
											.IN7(BRAM_H6EB1),
											.IN0(BRAM_EB21),
											.IN1(BRAM_EB17),
											.IN2(BRAM_EB13),
											.IN3(BRAM_EB9),
											.OUT(BRAM_LLV6),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob1_rdouts25(
											.OUT(BRAM_RDOUTS25),
											.IN(BRAM_DOB1)
		);

		TRIBUF1T1X7H1 tribuf_dob1_rdouts24(
											.IN(BRAM_DOB1),
											.OUT(BRAM_RDOUTS24)
		);

		TRIBUF1T1X7H1 tribuf_doa13_rdouts0(
											.OUT(BRAM_RDOUTS0),
											.IN(BRAM_DOA13)
		);

		SPS8T6X11H2 sps_rdins10(
											.IN4(BRAM_EB6),
											.IN5(BRAM_EB2),
											.IN6(BRAM_H6DB2),
											.IN7(BRAM_H6EB2),
											.IN0(BRAM_EB22),
											.IN1(BRAM_EB18),
											.IN2(BRAM_EB14),
											.IN3(BRAM_EB10),
											.OUT(BRAM_RDINS10),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa1_rdouts24(
											.OUT(BRAM_RDOUTS24),
											.IN(BRAM_DOA1)
		);

		SPS8T6X11H2 sps_rdins14(
											.IN4(BRAM_EB7),
											.IN5(BRAM_EB3),
											.IN6(BRAM_H6DB3),
											.IN7(BRAM_H6EB3),
											.IN0(BRAM_EB23),
											.IN1(BRAM_EB19),
											.IN2(BRAM_EB15),
											.IN3(BRAM_EB11),
											.OUT(BRAM_RDINS14),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins18(
											.IN4(BRAM_EB4),
											.IN5(BRAM_EB0),
											.IN6(BRAM_H6DB0),
											.IN7(BRAM_H6EB0),
											.IN0(BRAM_EB20),
											.IN1(BRAM_EB16),
											.IN2(BRAM_EB12),
											.IN3(BRAM_EB8),
											.OUT(BRAM_RDINS18),
											._1(1)
		);

		SPS24B7X11H1 sps_wea(
											.IN8(VDD),
											.IN9(VDD),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS0),
											.IN1(BRAM_RADDRS1),
											.IN2(BRAM_RADDRS2),
											.IN3(BRAM_RADDRS3),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(VDD),
											.IN11(VDD),
											.OUT(BRAM_WEA),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob9_rdouts24(
											.IN(BRAM_DOB9),
											.OUT(BRAM_RDOUTS24)
		);

		SPS2T2X7H2 sps_eb19(
											.IN0(BRAM_RDOUTS30),
											.IN1(BRAM_RDOUTS14),
											.OUT(BRAM_EB19),
											._1(1)
		);

		SPS2T2X7H2 sps_eb18(
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS10),
											.OUT(BRAM_EB18),
											._1(1)
		);

		SPS2T2X7H2 sps_eb15(
											.IN0(BRAM_RDOUTS30),
											.IN1(BRAM_RDOUTS14),
											.OUT(BRAM_EB15),
											._1(1)
		);

		SPS2T2X7H2 sps_eb14(
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS10),
											.OUT(BRAM_EB14),
											._1(1)
		);

		SPS2T2X7H2 sps_eb17(
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS6),
											.OUT(BRAM_EB17),
											._1(1)
		);

		SPS2T2X7H2 sps_eb16(
											.IN0(BRAM_RDOUTS18),
											.IN1(BRAM_RDOUTS2),
											.OUT(BRAM_EB16),
											._1(1)
		);

		SPS2T2X7H2 sps_eb11(
											.IN0(BRAM_RDOUTS30),
											.IN1(BRAM_RDOUTS14),
											.OUT(BRAM_EB11),
											._1(1)
		);

		SPS2T2X7H2 sps_eb10(
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS10),
											.OUT(BRAM_EB10),
											._1(1)
		);

		SPS2T2X7H2 sps_eb13(
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS6),
											.OUT(BRAM_EB13),
											._1(1)
		);

		SPS2T2X7H2 sps_eb12(
											.IN0(BRAM_RDOUTS18),
											.IN1(BRAM_RDOUTS2),
											.OUT(BRAM_EB12),
											._1(1)
		);

		SPS8T6X11H1 sps_llv10(
											.IN4(BRAM_EB6),
											.IN5(BRAM_EB2),
											.IN6(BRAM_H6DB2),
											.IN7(BRAM_H6EB2),
											.IN0(BRAM_EB22),
											.IN1(BRAM_EB18),
											.IN2(BRAM_EB14),
											.IN3(BRAM_EB10),
											.OUT(BRAM_LLV10),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob1_rdouts6(
											.IN(BRAM_DOB1),
											.OUT(BRAM_RDOUTS6)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobb2(
											.OUT(BRAM_GCLK_IOBB2),
											.IN(BRAM_GCLKIN2)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobb3(
											.OUT(BRAM_GCLK_IOBB3),
											.IN(BRAM_GCLKIN3)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobb0(
											.OUT(BRAM_GCLK_IOBB0),
											.IN(BRAM_GCLKIN0)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobb1(
											.OUT(BRAM_GCLK_IOBB1),
											.IN(BRAM_GCLKIN1)
		);

		TRIBUF1T1X7H1 tribuf_dob5_rdouts18(
											.IN(BRAM_DOB5),
											.OUT(BRAM_RDOUTS18)
		);

		SPS8T6X11H2 sps_dib11(
											.IN4(BRAM_RDINS13),
											.IN5(BRAM_RDINS12),
											.IN6(BRAM_RDINS9),
											.IN7(BRAM_RDINS8),
											.IN0(BRAM_RDINS31),
											.IN1(BRAM_RDINS30),
											.IN2(BRAM_RDINS27),
											.IN3(BRAM_RDINS26),
											.OUT(BRAM_DIB11),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob13_rdouts1(
											.IN(BRAM_DOB13),
											.OUT(BRAM_RDOUTS1)
		);

		SPS8T6X11H1 sps_dia1(
											.IN4(BRAM_RDINS12),
											.IN5(BRAM_RDINS11),
											.IN6(BRAM_RDINS8),
											.IN7(BRAM_RDINS7),
											.IN0(BRAM_RDINS30),
											.IN1(BRAM_RDINS29),
											.IN2(BRAM_RDINS26),
											.IN3(BRAM_RDINS25),
											.OUT(BRAM_DIA1),
											._1(1)
		);

		SPS8T6X11H2 sps_dia3(
											.IN4(BRAM_RDINS12),
											.IN5(BRAM_RDINS11),
											.IN6(BRAM_RDINS8),
											.IN7(BRAM_RDINS7),
											.IN0(BRAM_RDINS30),
											.IN1(BRAM_RDINS29),
											.IN2(BRAM_RDINS26),
											.IN3(BRAM_RDINS25),
											.OUT(BRAM_DIA3),
											._1(1)
		);

		SPS8T6X11H1 sps_dia9(
											.IN4(BRAM_RDINS12),
											.IN5(BRAM_RDINS11),
											.IN6(BRAM_RDINS8),
											.IN7(BRAM_RDINS7),
											.IN0(BRAM_RDINS30),
											.IN1(BRAM_RDINS29),
											.IN2(BRAM_RDINS26),
											.IN3(BRAM_RDINS25),
											.OUT(BRAM_DIA9),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins30(
											.IN4(BRAM_EB7),
											.IN5(BRAM_EB3),
											.IN6(BRAM_H6DB3),
											.IN7(BRAM_H6EB3),
											.IN0(BRAM_EB23),
											.IN1(BRAM_EB19),
											.IN2(BRAM_EB15),
											.IN3(BRAM_EB11),
											.OUT(BRAM_RDINS30),
											._1(1)
		);

		SPS24B7X11H1 sps_sela(
											.IN8(VDD),
											.IN9(VDD),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS24),
											.IN1(BRAM_RADDRS25),
											.IN2(BRAM_RADDRS26),
											.IN3(BRAM_RADDRS27),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(VDD),
											.IN11(VDD),
											.OUT(BRAM_SELA),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		SPS24B7X11H1 sps_rsta(
											.IN8(VDD),
											.IN9(VDD),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS24),
											.IN1(BRAM_RADDRS25),
											.IN2(BRAM_RADDRS26),
											.IN3(BRAM_RADDRS27),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(VDD),
											.IN11(VDD),
											.OUT(BRAM_RSTA),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbb1(
											.OUT(BRAM_GCLK_CLBB1),
											.IN(BRAM_GCLKIN1)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbb0(
											.OUT(BRAM_GCLK_CLBB0),
											.IN(BRAM_GCLKIN0)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbb3(
											.OUT(BRAM_GCLK_CLBB3),
											.IN(BRAM_GCLKIN3)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbb2(
											.OUT(BRAM_GCLK_CLBB2),
											.IN(BRAM_GCLKIN2)
		);

		TRIBUF1T1X7H1 tribuf_doa1_rdouts23(
											.IN(BRAM_DOA1),
											.OUT(BRAM_RDOUTS23)
		);

		SPS8T6X11H2 sps_addrb2(
											.IN4(BRAM_RADDRS7),
											.IN5(BRAM_RADDRS6),
											.IN6(BRAM_RADDRS5),
											.IN7(BRAM_RADDRS4),
											.IN0(BRAM_RADDRS11),
											.IN1(BRAM_RADDRS10),
											.IN2(BRAM_RADDRS9),
											.IN3(BRAM_RADDRS8),
											.OUT(BRAM_ADDRB2),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb3(
											.IN4(BRAM_RADDRS7),
											.IN5(BRAM_RADDRS6),
											.IN6(BRAM_RADDRS5),
											.IN7(BRAM_RADDRS4),
											.IN0(BRAM_RADDRS11),
											.IN1(BRAM_RADDRS10),
											.IN2(BRAM_RADDRS9),
											.IN3(BRAM_RADDRS8),
											.OUT(BRAM_ADDRB3),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb0(
											.IN4(BRAM_RADDRS3),
											.IN5(BRAM_RADDRS2),
											.IN6(BRAM_RADDRS1),
											.IN7(BRAM_RADDRS0),
											.IN0(BRAM_RADDRS7),
											.IN1(BRAM_RADDRS6),
											.IN2(BRAM_RADDRS5),
											.IN3(BRAM_RADDRS4),
											.OUT(BRAM_ADDRB0),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb1(
											.IN4(BRAM_RADDRS3),
											.IN5(BRAM_RADDRS2),
											.IN6(BRAM_RADDRS1),
											.IN7(BRAM_RADDRS0),
											.IN0(BRAM_RADDRS7),
											.IN1(BRAM_RADDRS6),
											.IN2(BRAM_RADDRS5),
											.IN3(BRAM_RADDRS4),
											.OUT(BRAM_ADDRB1),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins26(
											.IN4(BRAM_EB6),
											.IN5(BRAM_EB2),
											.IN6(BRAM_H6DB2),
											.IN7(BRAM_H6EB2),
											.IN0(BRAM_EB22),
											.IN1(BRAM_EB18),
											.IN2(BRAM_EB14),
											.IN3(BRAM_EB10),
											.OUT(BRAM_RDINS26),
											._1(1)
		);

		SPS8T6X11H2 sps_dia11(
											.IN4(BRAM_RDINS12),
											.IN5(BRAM_RDINS11),
											.IN6(BRAM_RDINS8),
											.IN7(BRAM_RDINS7),
											.IN0(BRAM_RDINS30),
											.IN1(BRAM_RDINS29),
											.IN2(BRAM_RDINS26),
											.IN3(BRAM_RDINS25),
											.OUT(BRAM_DIA11),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa9_rdouts6(
											.IN(BRAM_DOA9),
											.OUT(BRAM_RDOUTS6)
		);

		SPS4T3X11H2 sps_h6mb1(
											.OUT(BRAM_H6MB1),
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS30),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											._1(1)
		);

		SPS4T3X11H2 sps_h6mb0(
											.OUT(BRAM_H6MB0),
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS18),
											.IN2(BRAM_RDOUTS6),
											.IN3(BRAM_RDOUTS2),
											._1(1)
		);

		SPS4T3X11H2 sps_h6mb3(
											.OUT(BRAM_H6MB3),
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS30),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											._1(1)
		);

		SPS4T3X11H2 sps_h6mb2(
											.OUT(BRAM_H6MB2),
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS18),
											.IN2(BRAM_RDOUTS6),
											.IN3(BRAM_RDOUTS2),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa5_rdouts0(
											.IN(BRAM_DOA5),
											.OUT(BRAM_RDOUTS0)
		);

		SPS8T6X11H1 sps_rdins22(
											.IN4(BRAM_EB5),
											.IN5(BRAM_EB1),
											.IN6(BRAM_H6DB1),
											.IN7(BRAM_H6EB1),
											.IN0(BRAM_EB21),
											.IN1(BRAM_EB17),
											.IN2(BRAM_EB13),
											.IN3(BRAM_EB9),
											.OUT(BRAM_RDINS22),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob5_rdouts0(
											.IN(BRAM_DOB5),
											.OUT(BRAM_RDOUTS0)
		);

		TRIBUF1T1X7H1 tribuf_dob5_rdouts1(
											.OUT(BRAM_RDOUTS1),
											.IN(BRAM_DOB5)
		);

		TRIBUF1T1X7H1 tribuf_dob1_rdouts7(
											.OUT(BRAM_RDOUTS7),
											.IN(BRAM_DOB1)
		);

		SPS8T6X11H2 sps_raddrs2(
											.IN4(BRAM_EB4),
											.IN5(BRAM_EB0),
											.IN6(BRAM_H6DB0),
											.IN7(BRAM_H6EB0),
											.IN0(BRAM_EB20),
											.IN1(BRAM_EB16),
											.IN2(BRAM_EB12),
											.IN3(BRAM_EB8),
											.OUT(BRAM_RADDRS2),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob5_rdouts19(
											.OUT(BRAM_RDOUTS19),
											.IN(BRAM_DOB5)
		);

		SPS8T6X11H2 sps_raddrs6(
											.IN4(BRAM_EB5),
											.IN5(BRAM_EB1),
											.IN6(BRAM_H6DB1),
											.IN7(BRAM_H6EB1),
											.IN0(BRAM_EB21),
											.IN1(BRAM_EB17),
											.IN2(BRAM_EB13),
											.IN3(BRAM_EB9),
											.OUT(BRAM_RADDRS6),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa5_rdouts18(
											.IN(BRAM_DOA5),
											.OUT(BRAM_RDOUTS18)
		);

		TRIBUF1T1X7H1 tribuf_doa5_rdouts15(
											.OUT(BRAM_RDOUTS15),
											.IN(BRAM_DOA5)
		);

		TRIBUF1T1X7H1 tribuf_doa5_rdouts17(
											.IN(BRAM_DOA5),
											.OUT(BRAM_RDOUTS17)
		);

		SPS8T6X11H1 sps_raddrs30(
											.IN4(BRAM_EB7),
											.IN5(BRAM_EB3),
											.IN6(BRAM_H6DB3),
											.IN7(BRAM_H6EB3),
											.IN0(BRAM_EB23),
											.IN1(BRAM_EB19),
											.IN2(BRAM_EB15),
											.IN3(BRAM_EB11),
											.OUT(BRAM_RADDRS30),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa9_rdouts23(
											.OUT(BRAM_RDOUTS23),
											.IN(BRAM_DOA9)
		);

		SPS8T6X11H1 sps_lhb9(
											.IN4(BRAM_RDOUTS18),
											.IN5(BRAM_RDOUTS22),
											.IN6(BRAM_RDOUTS26),
											.IN7(BRAM_RDOUTS30),
											.IN0(BRAM_RDOUTS2),
											.IN1(BRAM_RDOUTS6),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											.OUT(BRAM_LHB9),
											._1(1)
		);

		SPS8T6X11H1 sps_lhb0(
											.IN4(BRAM_RDOUTS18),
											.IN5(BRAM_RDOUTS22),
											.IN6(BRAM_RDOUTS26),
											.IN7(BRAM_RDOUTS30),
											.IN0(BRAM_RDOUTS2),
											.IN1(BRAM_RDOUTS6),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											.OUT(BRAM_LHB0),
											._1(1)
		);

		SPS8T6X11H1 sps_lhb3(
											.IN4(BRAM_RDOUTS18),
											.IN5(BRAM_RDOUTS22),
											.IN6(BRAM_RDOUTS26),
											.IN7(BRAM_RDOUTS30),
											.IN0(BRAM_RDOUTS2),
											.IN1(BRAM_RDOUTS6),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											.OUT(BRAM_LHB3),
											._1(1)
		);

		SPS8T6X11H1 sps_lhb6(
											.IN4(BRAM_RDOUTS18),
											.IN5(BRAM_RDOUTS22),
											.IN6(BRAM_RDOUTS26),
											.IN7(BRAM_RDOUTS30),
											.IN0(BRAM_RDOUTS2),
											.IN1(BRAM_RDOUTS6),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											.OUT(BRAM_LHB6),
											._1(1)
		);

		SPS2T2X7H2 sps_eb1(
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS6),
											.OUT(BRAM_EB1),
											._1(1)
		);

		SPS2T2X7H2 sps_eb0(
											.IN0(BRAM_RDOUTS18),
											.IN1(BRAM_RDOUTS2),
											.OUT(BRAM_EB0),
											._1(1)
		);

		SPS2T2X7H2 sps_eb3(
											.IN0(BRAM_RDOUTS30),
											.IN1(BRAM_RDOUTS14),
											.OUT(BRAM_EB3),
											._1(1)
		);

		SPS2T2X7H2 sps_eb2(
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS10),
											.OUT(BRAM_EB2),
											._1(1)
		);

		SPS2T2X7H2 sps_eb5(
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS6),
											.OUT(BRAM_EB5),
											._1(1)
		);

		SPS2T2X7H2 sps_eb4(
											.IN0(BRAM_RDOUTS18),
											.IN1(BRAM_RDOUTS2),
											.OUT(BRAM_EB4),
											._1(1)
		);

		SPS2T2X7H2 sps_eb7(
											.IN0(BRAM_RDOUTS30),
											.IN1(BRAM_RDOUTS14),
											.OUT(BRAM_EB7),
											._1(1)
		);

		SPS2T2X7H2 sps_eb6(
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS10),
											.OUT(BRAM_EB6),
											._1(1)
		);

		SPS2T2X7H2 sps_eb9(
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS6),
											.OUT(BRAM_EB9),
											._1(1)
		);

		SPS2T2X7H2 sps_eb8(
											.IN0(BRAM_RDOUTS18),
											.IN1(BRAM_RDOUTS2),
											.OUT(BRAM_EB8),
											._1(1)
		);

		SPS8T6X11H1 sps_addra3(
											.IN4(BRAM_RADDRS7),
											.IN5(BRAM_RADDRS6),
											.IN6(BRAM_RADDRS5),
											.IN7(BRAM_RADDRS4),
											.IN0(BRAM_RADDRS11),
											.IN1(BRAM_RADDRS10),
											.IN2(BRAM_RADDRS9),
											.IN3(BRAM_RADDRS8),
											.OUT(BRAM_ADDRA3),
											._1(1)
		);

		SPS8T6X11H1 sps_addra2(
											.IN4(BRAM_RADDRS7),
											.IN5(BRAM_RADDRS6),
											.IN6(BRAM_RADDRS5),
											.IN7(BRAM_RADDRS4),
											.IN0(BRAM_RADDRS11),
											.IN1(BRAM_RADDRS10),
											.IN2(BRAM_RADDRS9),
											.IN3(BRAM_RADDRS8),
											.OUT(BRAM_ADDRA2),
											._1(1)
		);

		SPS8T6X11H1 sps_addra1(
											.IN4(BRAM_RADDRS3),
											.IN5(BRAM_RADDRS2),
											.IN6(BRAM_RADDRS1),
											.IN7(BRAM_RADDRS0),
											.IN0(BRAM_RADDRS7),
											.IN1(BRAM_RADDRS6),
											.IN2(BRAM_RADDRS5),
											.IN3(BRAM_RADDRS4),
											.OUT(BRAM_ADDRA1),
											._1(1)
		);

		SPS8T6X11H1 sps_addra0(
											.IN4(BRAM_RADDRS3),
											.IN5(BRAM_RADDRS2),
											.IN6(BRAM_RADDRS1),
											.IN7(BRAM_RADDRS0),
											.IN0(BRAM_RADDRS7),
											.IN1(BRAM_RADDRS6),
											.IN2(BRAM_RADDRS5),
											.IN3(BRAM_RADDRS4),
											.OUT(BRAM_ADDRA0),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs26(
											.IN4(BRAM_EB6),
											.IN5(BRAM_EB2),
											.IN6(BRAM_H6DB2),
											.IN7(BRAM_H6EB2),
											.IN0(BRAM_EB22),
											.IN1(BRAM_EB18),
											.IN2(BRAM_EB14),
											.IN3(BRAM_EB10),
											.OUT(BRAM_RADDRS26),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs22(
											.IN4(BRAM_EB5),
											.IN5(BRAM_EB1),
											.IN6(BRAM_H6DB1),
											.IN7(BRAM_H6EB1),
											.IN0(BRAM_EB21),
											.IN1(BRAM_EB17),
											.IN2(BRAM_EB13),
											.IN3(BRAM_EB9),
											.OUT(BRAM_RADDRS22),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob13_rdouts18(
											.IN(BRAM_DOB13),
											.OUT(BRAM_RDOUTS18)
		);

		SPS2T2X7H2 sps_eb20(
											.IN0(BRAM_RDOUTS18),
											.IN1(BRAM_RDOUTS2),
											.OUT(BRAM_EB20),
											._1(1)
		);

		SPS2T2X7H2 sps_eb21(
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS6),
											.OUT(BRAM_EB21),
											._1(1)
		);

		SPS2T2X7H2 sps_eb22(
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS10),
											.OUT(BRAM_EB22),
											._1(1)
		);

		SPS2T2X7H2 sps_eb23(
											.IN0(BRAM_RDOUTS30),
											.IN1(BRAM_RDOUTS14),
											.OUT(BRAM_EB23),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa1_rdouts5(
											.OUT(BRAM_RDOUTS5),
											.IN(BRAM_DOA1)
		);

		TRIBUF1T1X7H1 tribuf_doa1_rdouts6(
											.IN(BRAM_DOA1),
											.OUT(BRAM_RDOUTS6)
		);

		TRIBUF1T1X7H1 tribuf_doa13_rdouts17(
											.OUT(BRAM_RDOUTS17),
											.IN(BRAM_DOA13)
		);

		SPS24B7X11H1 sps_clka(
											.IN8(BRAM_GCLKIN0),
											.IN9(BRAM_GCLKIN1),
											.IN4(BRAM_RADDRS28),
											.IN5(BRAM_RADDRS29),
											.IN6(BRAM_RADDRS30),
											.IN7(BRAM_RADDRS31),
											.IN0(BRAM_RADDRS0),
											.IN1(BRAM_RADDRS1),
											.IN2(BRAM_RADDRS2),
											.IN3(BRAM_RADDRS3),
											.IN18(BRAM_LLV6),
											.IN19(BRAM_LLV7),
											.IN16(BRAM_LLV4),
											.IN17(BRAM_LLV5),
											.IN14(BRAM_LLV2),
											.IN15(BRAM_LLV3),
											.IN12(BRAM_LLV0),
											.IN13(BRAM_LLV1),
											.IN10(BRAM_GCLKIN2),
											.IN11(BRAM_GCLKIN3),
											.OUT(BRAM_CLKA),
											.IN23(BRAM_LLV11),
											.IN22(BRAM_LLV10),
											.IN21(BRAM_LLV9),
											.IN20(BRAM_LLV8),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs18(
											.IN4(BRAM_EB4),
											.IN5(BRAM_EB0),
											.IN6(BRAM_H6DB0),
											.IN7(BRAM_H6EB0),
											.IN0(BRAM_EB20),
											.IN1(BRAM_EB16),
											.IN2(BRAM_EB12),
											.IN3(BRAM_EB8),
											.OUT(BRAM_RADDRS18),
											._1(1)
		);

		SPS8T6X11H1 sps_dib9(
											.IN4(BRAM_RDINS13),
											.IN5(BRAM_RDINS12),
											.IN6(BRAM_RDINS9),
											.IN7(BRAM_RDINS8),
											.IN0(BRAM_RDINS31),
											.IN1(BRAM_RDINS30),
											.IN2(BRAM_RDINS27),
											.IN3(BRAM_RDINS26),
											.OUT(BRAM_DIB9),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs10(
											.IN4(BRAM_EB6),
											.IN5(BRAM_EB2),
											.IN6(BRAM_H6DB2),
											.IN7(BRAM_H6EB2),
											.IN0(BRAM_EB22),
											.IN1(BRAM_EB18),
											.IN2(BRAM_EB14),
											.IN3(BRAM_EB10),
											.OUT(BRAM_RADDRS10),
											._1(1)
		);

		SPS8T6X11H1 sps_dib1(
											.IN4(BRAM_RDINS13),
											.IN5(BRAM_RDINS12),
											.IN6(BRAM_RDINS9),
											.IN7(BRAM_RDINS8),
											.IN0(BRAM_RDINS31),
											.IN1(BRAM_RDINS30),
											.IN2(BRAM_RDINS27),
											.IN3(BRAM_RDINS26),
											.OUT(BRAM_DIB1),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs14(
											.IN4(BRAM_EB7),
											.IN5(BRAM_EB3),
											.IN6(BRAM_H6DB3),
											.IN7(BRAM_H6EB3),
											.IN0(BRAM_EB23),
											.IN1(BRAM_EB19),
											.IN2(BRAM_EB15),
											.IN3(BRAM_EB11),
											.OUT(BRAM_RADDRS14),
											._1(1)
		);

		SPS8T6X11H2 sps_dib3(
											.IN4(BRAM_RDINS13),
											.IN5(BRAM_RDINS12),
											.IN6(BRAM_RDINS9),
											.IN7(BRAM_RDINS8),
											.IN0(BRAM_RDINS31),
											.IN1(BRAM_RDINS30),
											.IN2(BRAM_RDINS27),
											.IN3(BRAM_RDINS26),
											.OUT(BRAM_DIB3),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob9_rdouts7(
											.IN(BRAM_DOB9),
											.OUT(BRAM_RDOUTS7)
		);

		SPS4T3X11H2 sps_h6bb2(
											.OUT(BRAM_H6BB2),
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS18),
											.IN2(BRAM_RDOUTS6),
											.IN3(BRAM_RDOUTS2),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bb3(
											.OUT(BRAM_H6BB3),
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS30),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bb0(
											.OUT(BRAM_H6BB0),
											.IN0(BRAM_RDOUTS22),
											.IN1(BRAM_RDOUTS18),
											.IN2(BRAM_RDOUTS6),
											.IN3(BRAM_RDOUTS2),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bb1(
											.OUT(BRAM_H6BB1),
											.IN0(BRAM_RDOUTS26),
											.IN1(BRAM_RDOUTS30),
											.IN2(BRAM_RDOUTS10),
											.IN3(BRAM_RDOUTS14),
											._1(1)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_LBRAMA(
BRAM_EA0, BRAM_EA1, BRAM_EA2, BRAM_EA3, BRAM_EA4, BRAM_EA5, BRAM_EA6, BRAM_EA7, BRAM_EA8, BRAM_EA9, BRAM_EA10, BRAM_EA11, BRAM_EA12, BRAM_EA13, BRAM_EA14, BRAM_EA15, BRAM_EA16, BRAM_EA17, BRAM_EA18, BRAM_EA19, BRAM_EA20, BRAM_EA21, BRAM_EA22, BRAM_EA23, BRAM_H6EA0, BRAM_H6EA1, BRAM_H6EA2, BRAM_H6EA3, BRAM_H6BA0, BRAM_H6BA1, BRAM_H6BA2, BRAM_H6BA3, BRAM_H6MA0, BRAM_H6MA1, BRAM_H6MA2, BRAM_H6MA3, BRAM_H6DA0, BRAM_H6DA1, BRAM_H6DA2, BRAM_H6DA3, BRAM_LHA0, BRAM_LHA3, BRAM_LHA6, BRAM_LHA9, BRAM_LLV3, BRAM_LLV7, BRAM_LLV11, BRAM_GCLKIN0, BRAM_GCLKIN1, BRAM_GCLKIN2, BRAM_GCLKIN3, BRAM_GCLK_IOBA0, BRAM_GCLK_IOBA1, BRAM_GCLK_IOBA2, BRAM_GCLK_IOBA3, BRAM_GCLK_CLBA0, BRAM_GCLK_CLBA1, BRAM_GCLK_CLBA2, BRAM_GCLK_CLBA3, BRAM_RADDRS0, BRAM_RADDRS1, BRAM_RADDRS2, BRAM_RADDRS3, BRAM_RADDRS4, BRAM_RADDRS5, BRAM_RADDRS6, BRAM_RADDRS7, BRAM_RADDRS8, BRAM_RADDRS9, BRAM_RADDRS10, BRAM_RADDRS11, BRAM_RADDRS12, BRAM_RADDRS13, BRAM_RADDRS14, BRAM_RADDRS15, BRAM_RADDRS16, BRAM_RADDRS17, BRAM_RADDRS18, BRAM_RADDRS19, BRAM_RADDRS20, BRAM_RADDRS21, BRAM_RADDRS22, BRAM_RADDRS23, BRAM_RADDRS24, BRAM_RADDRS25, BRAM_RADDRS26, BRAM_RADDRS27, BRAM_RADDRS28, BRAM_RADDRS29, BRAM_RADDRS30, BRAM_RADDRS31, BRAM_RDINS0, BRAM_RDINS1, BRAM_RDINS2, BRAM_RDINS3, BRAM_RDINS4, BRAM_RDINS5, BRAM_RDINS6, BRAM_RDINS7, BRAM_RDINS8, BRAM_RDINS9, BRAM_RDINS10, BRAM_RDINS11, BRAM_RDINS12, BRAM_RDINS13, BRAM_RDINS14, BRAM_RDINS15, BRAM_RDINS16, BRAM_RDINS17, BRAM_RDINS18, BRAM_RDINS19, BRAM_RDINS20, BRAM_RDINS21, BRAM_RDINS22, BRAM_RDINS23, BRAM_RDINS24, BRAM_RDINS25, BRAM_RDINS26, BRAM_RDINS27, BRAM_RDINS28, BRAM_RDINS29, BRAM_RDINS30, BRAM_RDINS31, BRAM_RDOUTS0, BRAM_RDOUTS1, BRAM_RDOUTS2, BRAM_RDOUTS3, BRAM_RDOUTS4, BRAM_RDOUTS5, BRAM_RDOUTS6, BRAM_RDOUTS7, BRAM_RDOUTS8, BRAM_RDOUTS9, BRAM_RDOUTS10, BRAM_RDOUTS11, BRAM_RDOUTS12, BRAM_RDOUTS13, BRAM_RDOUTS14, BRAM_RDOUTS15, BRAM_RDOUTS16, BRAM_RDOUTS17, BRAM_RDOUTS18, BRAM_RDOUTS19, BRAM_RDOUTS20, BRAM_RDOUTS21, BRAM_RDOUTS22, BRAM_RDOUTS23, BRAM_RDOUTS24, BRAM_RDOUTS25, BRAM_RDOUTS26, BRAM_RDOUTS27, BRAM_RDOUTS28, BRAM_RDOUTS29, BRAM_RDOUTS30, BRAM_RDOUTS31, BRAM_RADDRN0, BRAM_RADDRN1, BRAM_RADDRN2, BRAM_RADDRN3, BRAM_RADDRN4, BRAM_RADDRN5, BRAM_RADDRN6, BRAM_RADDRN7, BRAM_RADDRN8, BRAM_RADDRN9, BRAM_RADDRN10, BRAM_RADDRN11, BRAM_RADDRN12, BRAM_RADDRN13, BRAM_RADDRN14, BRAM_RADDRN15, BRAM_RADDRN16, BRAM_RADDRN17, BRAM_RADDRN18, BRAM_RADDRN19, BRAM_RADDRN20, BRAM_RADDRN21, BRAM_RADDRN22, BRAM_RADDRN23, BRAM_RADDRN24, BRAM_RADDRN25, BRAM_RADDRN26, BRAM_RADDRN27, BRAM_RADDRN28, BRAM_RADDRN29, BRAM_RADDRN30, BRAM_RADDRN31, BRAM_RDINN0, BRAM_RDINN1, BRAM_RDINN2, BRAM_RDINN3, BRAM_RDINN4, BRAM_RDINN5, BRAM_RDINN6, BRAM_RDINN7, BRAM_RDINN8, BRAM_RDINN9, BRAM_RDINN10, BRAM_RDINN11, BRAM_RDINN12, BRAM_RDINN13, BRAM_RDINN14, BRAM_RDINN15, BRAM_RDINN16, BRAM_RDINN17, BRAM_RDINN18, BRAM_RDINN19, BRAM_RDINN20, BRAM_RDINN21, BRAM_RDINN22, BRAM_RDINN23, BRAM_RDINN24, BRAM_RDINN25, BRAM_RDINN26, BRAM_RDINN27, BRAM_RDINN28, BRAM_RDINN29, BRAM_RDINN30, BRAM_RDINN31, BRAM_RDOUTN0, BRAM_RDOUTN1, BRAM_RDOUTN2, BRAM_RDOUTN3, BRAM_RDOUTN4, BRAM_RDOUTN5, BRAM_RDOUTN6, BRAM_RDOUTN7, BRAM_RDOUTN8, BRAM_RDOUTN9, BRAM_RDOUTN10, BRAM_RDOUTN11, BRAM_RDOUTN12, BRAM_RDOUTN13, BRAM_RDOUTN14, BRAM_RDOUTN15, BRAM_RDOUTN16, BRAM_RDOUTN17, BRAM_RDOUTN18, BRAM_RDOUTN19, BRAM_RDOUTN20, BRAM_RDOUTN21, BRAM_RDOUTN22, BRAM_RDOUTN23, BRAM_RDOUTN24, BRAM_RDOUTN25, BRAM_RDOUTN26, BRAM_RDOUTN27, BRAM_RDOUTN28, BRAM_RDOUTN29, BRAM_RDOUTN30, BRAM_RDOUTN31, BRAM_DIA0, BRAM_DIA2, BRAM_DIA8, BRAM_DIA10, BRAM_DIB0, BRAM_DIB2, BRAM_DIB8, BRAM_DIB10, BRAM_DOA0, BRAM_DOA4, BRAM_DOA8, BRAM_DOA12, BRAM_DOB0, BRAM_DOB4, BRAM_DOB8, BRAM_DOB12, _1
);
inout	BRAM_EA0;
inout	BRAM_EA1;
inout	BRAM_EA2;
inout	BRAM_EA3;
inout	BRAM_EA4;
inout	BRAM_EA5;
inout	BRAM_EA6;
inout	BRAM_EA7;
inout	BRAM_EA8;
inout	BRAM_EA9;
inout	BRAM_EA10;
inout	BRAM_EA11;
inout	BRAM_EA12;
inout	BRAM_EA13;
inout	BRAM_EA14;
inout	BRAM_EA15;
inout	BRAM_EA16;
inout	BRAM_EA17;
inout	BRAM_EA18;
inout	BRAM_EA19;
inout	BRAM_EA20;
inout	BRAM_EA21;
inout	BRAM_EA22;
inout	BRAM_EA23;
inout	BRAM_H6EA0;
inout	BRAM_H6EA1;
inout	BRAM_H6EA2;
inout	BRAM_H6EA3;
inout	BRAM_H6BA0;
inout	BRAM_H6BA1;
inout	BRAM_H6BA2;
inout	BRAM_H6BA3;
inout	BRAM_H6MA0;
inout	BRAM_H6MA1;
inout	BRAM_H6MA2;
inout	BRAM_H6MA3;
inout	BRAM_H6DA0;
inout	BRAM_H6DA1;
inout	BRAM_H6DA2;
inout	BRAM_H6DA3;
inout	BRAM_LHA0;
inout	BRAM_LHA3;
inout	BRAM_LHA6;
inout	BRAM_LHA9;
inout	BRAM_LLV3;
inout	BRAM_LLV7;
inout	BRAM_LLV11;
inout	BRAM_GCLKIN0;
inout	BRAM_GCLKIN1;
inout	BRAM_GCLKIN2;
inout	BRAM_GCLKIN3;
inout	BRAM_GCLK_IOBA0;
inout	BRAM_GCLK_IOBA1;
inout	BRAM_GCLK_IOBA2;
inout	BRAM_GCLK_IOBA3;
inout	BRAM_GCLK_CLBA0;
inout	BRAM_GCLK_CLBA1;
inout	BRAM_GCLK_CLBA2;
inout	BRAM_GCLK_CLBA3;
inout	BRAM_RADDRS0;
inout	BRAM_RADDRS1;
inout	BRAM_RADDRS2;
inout	BRAM_RADDRS3;
inout	BRAM_RADDRS4;
inout	BRAM_RADDRS5;
inout	BRAM_RADDRS6;
inout	BRAM_RADDRS7;
inout	BRAM_RADDRS8;
inout	BRAM_RADDRS9;
inout	BRAM_RADDRS10;
inout	BRAM_RADDRS11;
inout	BRAM_RADDRS12;
inout	BRAM_RADDRS13;
inout	BRAM_RADDRS14;
inout	BRAM_RADDRS15;
inout	BRAM_RADDRS16;
inout	BRAM_RADDRS17;
inout	BRAM_RADDRS18;
inout	BRAM_RADDRS19;
inout	BRAM_RADDRS20;
inout	BRAM_RADDRS21;
inout	BRAM_RADDRS22;
inout	BRAM_RADDRS23;
inout	BRAM_RADDRS24;
inout	BRAM_RADDRS25;
inout	BRAM_RADDRS26;
inout	BRAM_RADDRS27;
inout	BRAM_RADDRS28;
inout	BRAM_RADDRS29;
inout	BRAM_RADDRS30;
inout	BRAM_RADDRS31;
inout	BRAM_RDINS0;
inout	BRAM_RDINS1;
inout	BRAM_RDINS2;
inout	BRAM_RDINS3;
inout	BRAM_RDINS4;
inout	BRAM_RDINS5;
inout	BRAM_RDINS6;
inout	BRAM_RDINS7;
inout	BRAM_RDINS8;
inout	BRAM_RDINS9;
inout	BRAM_RDINS10;
inout	BRAM_RDINS11;
inout	BRAM_RDINS12;
inout	BRAM_RDINS13;
inout	BRAM_RDINS14;
inout	BRAM_RDINS15;
inout	BRAM_RDINS16;
inout	BRAM_RDINS17;
inout	BRAM_RDINS18;
inout	BRAM_RDINS19;
inout	BRAM_RDINS20;
inout	BRAM_RDINS21;
inout	BRAM_RDINS22;
inout	BRAM_RDINS23;
inout	BRAM_RDINS24;
inout	BRAM_RDINS25;
inout	BRAM_RDINS26;
inout	BRAM_RDINS27;
inout	BRAM_RDINS28;
inout	BRAM_RDINS29;
inout	BRAM_RDINS30;
inout	BRAM_RDINS31;
inout	BRAM_RDOUTS0;
inout	BRAM_RDOUTS1;
inout	BRAM_RDOUTS2;
inout	BRAM_RDOUTS3;
inout	BRAM_RDOUTS4;
inout	BRAM_RDOUTS5;
inout	BRAM_RDOUTS6;
inout	BRAM_RDOUTS7;
inout	BRAM_RDOUTS8;
inout	BRAM_RDOUTS9;
inout	BRAM_RDOUTS10;
inout	BRAM_RDOUTS11;
inout	BRAM_RDOUTS12;
inout	BRAM_RDOUTS13;
inout	BRAM_RDOUTS14;
inout	BRAM_RDOUTS15;
inout	BRAM_RDOUTS16;
inout	BRAM_RDOUTS17;
inout	BRAM_RDOUTS18;
inout	BRAM_RDOUTS19;
inout	BRAM_RDOUTS20;
inout	BRAM_RDOUTS21;
inout	BRAM_RDOUTS22;
inout	BRAM_RDOUTS23;
inout	BRAM_RDOUTS24;
inout	BRAM_RDOUTS25;
inout	BRAM_RDOUTS26;
inout	BRAM_RDOUTS27;
inout	BRAM_RDOUTS28;
inout	BRAM_RDOUTS29;
inout	BRAM_RDOUTS30;
inout	BRAM_RDOUTS31;
inout	BRAM_RADDRN0;
inout	BRAM_RADDRN1;
inout	BRAM_RADDRN2;
inout	BRAM_RADDRN3;
inout	BRAM_RADDRN4;
inout	BRAM_RADDRN5;
inout	BRAM_RADDRN6;
inout	BRAM_RADDRN7;
inout	BRAM_RADDRN8;
inout	BRAM_RADDRN9;
inout	BRAM_RADDRN10;
inout	BRAM_RADDRN11;
inout	BRAM_RADDRN12;
inout	BRAM_RADDRN13;
inout	BRAM_RADDRN14;
inout	BRAM_RADDRN15;
inout	BRAM_RADDRN16;
inout	BRAM_RADDRN17;
inout	BRAM_RADDRN18;
inout	BRAM_RADDRN19;
inout	BRAM_RADDRN20;
inout	BRAM_RADDRN21;
inout	BRAM_RADDRN22;
inout	BRAM_RADDRN23;
inout	BRAM_RADDRN24;
inout	BRAM_RADDRN25;
inout	BRAM_RADDRN26;
inout	BRAM_RADDRN27;
inout	BRAM_RADDRN28;
inout	BRAM_RADDRN29;
inout	BRAM_RADDRN30;
inout	BRAM_RADDRN31;
inout	BRAM_RDINN0;
inout	BRAM_RDINN1;
inout	BRAM_RDINN2;
inout	BRAM_RDINN3;
inout	BRAM_RDINN4;
inout	BRAM_RDINN5;
inout	BRAM_RDINN6;
inout	BRAM_RDINN7;
inout	BRAM_RDINN8;
inout	BRAM_RDINN9;
inout	BRAM_RDINN10;
inout	BRAM_RDINN11;
inout	BRAM_RDINN12;
inout	BRAM_RDINN13;
inout	BRAM_RDINN14;
inout	BRAM_RDINN15;
inout	BRAM_RDINN16;
inout	BRAM_RDINN17;
inout	BRAM_RDINN18;
inout	BRAM_RDINN19;
inout	BRAM_RDINN20;
inout	BRAM_RDINN21;
inout	BRAM_RDINN22;
inout	BRAM_RDINN23;
inout	BRAM_RDINN24;
inout	BRAM_RDINN25;
inout	BRAM_RDINN26;
inout	BRAM_RDINN27;
inout	BRAM_RDINN28;
inout	BRAM_RDINN29;
inout	BRAM_RDINN30;
inout	BRAM_RDINN31;
inout	BRAM_RDOUTN0;
inout	BRAM_RDOUTN1;
inout	BRAM_RDOUTN2;
inout	BRAM_RDOUTN3;
inout	BRAM_RDOUTN4;
inout	BRAM_RDOUTN5;
inout	BRAM_RDOUTN6;
inout	BRAM_RDOUTN7;
inout	BRAM_RDOUTN8;
inout	BRAM_RDOUTN9;
inout	BRAM_RDOUTN10;
inout	BRAM_RDOUTN11;
inout	BRAM_RDOUTN12;
inout	BRAM_RDOUTN13;
inout	BRAM_RDOUTN14;
inout	BRAM_RDOUTN15;
inout	BRAM_RDOUTN16;
inout	BRAM_RDOUTN17;
inout	BRAM_RDOUTN18;
inout	BRAM_RDOUTN19;
inout	BRAM_RDOUTN20;
inout	BRAM_RDOUTN21;
inout	BRAM_RDOUTN22;
inout	BRAM_RDOUTN23;
inout	BRAM_RDOUTN24;
inout	BRAM_RDOUTN25;
inout	BRAM_RDOUTN26;
inout	BRAM_RDOUTN27;
inout	BRAM_RDOUTN28;
inout	BRAM_RDOUTN29;
inout	BRAM_RDOUTN30;
inout	BRAM_RDOUTN31;
inout	BRAM_DIA0;
inout	BRAM_DIA2;
inout	BRAM_DIA8;
inout	BRAM_DIA10;
inout	BRAM_DIB0;
inout	BRAM_DIB2;
inout	BRAM_DIB8;
inout	BRAM_DIB10;
inout	BRAM_DOA0;
inout	BRAM_DOA4;
inout	BRAM_DOA8;
inout	BRAM_DOA12;
inout	BRAM_DOB0;
inout	BRAM_DOB4;
inout	BRAM_DOB8;
inout	BRAM_DOB12;
inout	_1;

		SPBU1NAND1X35H1 spbu_gclk_clba0(
											.OUT(BRAM_GCLK_CLBA0),
											.IN(BRAM_GCLKIN0)
		);

		SPBU1NAND1X35H1 spbu_gclk_clba1(
											.OUT(BRAM_GCLK_CLBA1),
											.IN(BRAM_GCLKIN1)
		);

		SPBB2T2X7H1 spbb_raddrs12_raddrn12(
											.A(BRAM_RADDRS12),
											.B(BRAM_RADDRN12)
		);

		SPBB2T2X7H1 spbb_rdins2_rdinn3(
											.A(BRAM_RDINS2),
											.B(BRAM_RDINN3)
		);

		SPS8T6X11H2 sps_rdins7(
											.IN4(BRAM_EA5),
											.IN5(BRAM_EA1),
											.IN6(BRAM_H6DA1),
											.IN7(BRAM_H6EA1),
											.IN0(BRAM_EA21),
											.IN1(BRAM_EA17),
											.IN2(BRAM_EA13),
											.IN3(BRAM_EA9),
											.OUT(BRAM_RDINS7),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob4_rdouts22(
											.IN(BRAM_DOB4),
											.OUT(BRAM_RDOUTS22)
		);

		SPBU1NAND1X35H1 spbu_gclk_clba2(
											.OUT(BRAM_GCLK_CLBA2),
											.IN(BRAM_GCLKIN2)
		);

		SPBB2T2X7H1 spbb_rdins29_rdinn30(
											.A(BRAM_RDINS29),
											.B(BRAM_RDINN30)
		);

		SPBU1NAND1X35H1 spbu_gclk_clba3(
											.OUT(BRAM_GCLK_CLBA3),
											.IN(BRAM_GCLKIN3)
		);

		SPBB2T2X7H1 spbb_raddrs13_raddrn13(
											.A(BRAM_RADDRS13),
											.B(BRAM_RADDRN13)
		);

		SPS8T6X11H1 sps_llv7(
											.IN4(BRAM_EA5),
											.IN5(BRAM_EA1),
											.IN6(BRAM_H6DA1),
											.IN7(BRAM_H6EA1),
											.IN0(BRAM_EA21),
											.IN1(BRAM_EA17),
											.IN2(BRAM_EA13),
											.IN3(BRAM_EA9),
											.OUT(BRAM_LLV7),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins31_rdinn16(
											.A(BRAM_RDINS31),
											.B(BRAM_RDINN16)
		);

		SPBB2T2X7H1 spbb_rdouts28_rdoutn29(
											.A(BRAM_RDOUTS28),
											.B(BRAM_RDOUTN29)
		);

		SPBB2T2X7H1 spbb_raddrs15_raddrn15(
											.A(BRAM_RADDRS15),
											.B(BRAM_RADDRN15)
		);

		TRIBUF1T1X7H1 tribuf_dob4_rdouts4(
											.IN(BRAM_DOB4),
											.OUT(BRAM_RDOUTS4)
		);

		TRIBUF1T1X7H1 tribuf_doa8_rdouts14(
											.OUT(BRAM_RDOUTS14),
											.IN(BRAM_DOA8)
		);

		SPS8T6X11H2 sps_rdins11(
											.IN4(BRAM_EA6),
											.IN5(BRAM_EA2),
											.IN6(BRAM_H6DA2),
											.IN7(BRAM_H6EA2),
											.IN0(BRAM_EA22),
											.IN1(BRAM_EA18),
											.IN2(BRAM_EA14),
											.IN3(BRAM_EA10),
											.OUT(BRAM_RDINS11),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins15_rdinn0(
											.A(BRAM_RDINS15),
											.B(BRAM_RDINN0)
		);

		SPS8T6X11H2 sps_rdins15(
											.IN4(BRAM_EA7),
											.IN5(BRAM_EA3),
											.IN6(BRAM_H6DA3),
											.IN7(BRAM_H6EA3),
											.IN0(BRAM_EA23),
											.IN1(BRAM_EA19),
											.IN2(BRAM_EA15),
											.IN3(BRAM_EA11),
											.OUT(BRAM_RDINS15),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins5_rdinn6(
											.A(BRAM_RDINS5),
											.B(BRAM_RDINN6)
		);

		SPS8T6X11H1 sps_rdins19(
											.IN4(BRAM_EA4),
											.IN5(BRAM_EA0),
											.IN6(BRAM_H6DA0),
											.IN7(BRAM_H6EA0),
											.IN0(BRAM_EA20),
											.IN1(BRAM_EA16),
											.IN2(BRAM_EA12),
											.IN3(BRAM_EA8),
											.OUT(BRAM_RDINS19),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs31(
											.IN4(BRAM_EA7),
											.IN5(BRAM_EA3),
											.IN6(BRAM_H6DA3),
											.IN7(BRAM_H6EA3),
											.IN0(BRAM_EA23),
											.IN1(BRAM_EA19),
											.IN2(BRAM_EA15),
											.IN3(BRAM_EA11),
											.OUT(BRAM_RADDRS31),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins26_rdinn27(
											.A(BRAM_RDINS26),
											.B(BRAM_RDINN27)
		);

		SPBB2T2X7H1 spbb_raddrs9_raddrn9(
											.A(BRAM_RADDRS9),
											.B(BRAM_RADDRN9)
		);

		SPS2T2X7H2 sps_ea23(
											.IN0(BRAM_RDOUTS31),
											.IN1(BRAM_RDOUTS15),
											.OUT(BRAM_EA23),
											._1(1)
		);

		SPS2T2X7H2 sps_ea22(
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS11),
											.OUT(BRAM_EA22),
											._1(1)
		);

		SPS2T2X7H2 sps_ea21(
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS7),
											.OUT(BRAM_EA21),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins17_rdinn18(
											.A(BRAM_RDINS17),
											.B(BRAM_RDINN18)
		);

		SPS4T3X11H2 sps_h6ba3(
											.OUT(BRAM_H6BA3),
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS31),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											._1(1)
		);

		SPS4T3X11H2 sps_h6ba2(
											.OUT(BRAM_H6BA2),
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS19),
											.IN2(BRAM_RDOUTS7),
											.IN3(BRAM_RDOUTS3),
											._1(1)
		);

		SPS4T3X11H2 sps_h6ba1(
											.OUT(BRAM_H6BA1),
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS31),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											._1(1)
		);

		SPS4T3X11H2 sps_h6ba0(
											.OUT(BRAM_H6BA0),
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS19),
											.IN2(BRAM_RDOUTS7),
											.IN3(BRAM_RDOUTS3),
											._1(1)
		);

		SPS8T6X11H1 sps_lha0(
											.IN4(BRAM_RDOUTS19),
											.IN5(BRAM_RDOUTS23),
											.IN6(BRAM_RDOUTS27),
											.IN7(BRAM_RDOUTS31),
											.IN0(BRAM_RDOUTS3),
											.IN1(BRAM_RDOUTS7),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											.OUT(BRAM_LHA0),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins13_rdinn14(
											.A(BRAM_RDINS13),
											.B(BRAM_RDINN14)
		);

		SPBB2T2X7H1 spbb_raddrs26_raddrn26(
											.A(BRAM_RADDRS26),
											.B(BRAM_RADDRN26)
		);

		SPS8T6X11H1 sps_lha6(
											.IN4(BRAM_RDOUTS19),
											.IN5(BRAM_RDOUTS23),
											.IN6(BRAM_RDOUTS27),
											.IN7(BRAM_RDOUTS31),
											.IN0(BRAM_RDOUTS3),
											.IN1(BRAM_RDOUTS7),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											.OUT(BRAM_LHA6),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts23_rdoutn24(
											.A(BRAM_RDOUTS23),
											.B(BRAM_RDOUTN24)
		);

		SPS8T6X11H1 sps_lha9(
											.IN4(BRAM_RDOUTS19),
											.IN5(BRAM_RDOUTS23),
											.IN6(BRAM_RDOUTS27),
											.IN7(BRAM_RDOUTS31),
											.IN0(BRAM_RDOUTS3),
											.IN1(BRAM_RDOUTS7),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											.OUT(BRAM_LHA9),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins21_rdinn22(
											.A(BRAM_RDINS21),
											.B(BRAM_RDINN22)
		);

		SPBB2T2X7H1 spbb_rdins27_rdinn28(
											.A(BRAM_RDINS27),
											.B(BRAM_RDINN28)
		);

		SPBB2T2X7H1 spbb_rdins10_rdinn11(
											.A(BRAM_RDINS10),
											.B(BRAM_RDINN11)
		);

		SPBB2T2X7H1 spbb_rdouts9_rdoutn10(
											.A(BRAM_RDOUTS9),
											.B(BRAM_RDOUTN10)
		);

		TRIBUF1T1X7H1 tribuf_doa12_rdouts21(
											.OUT(BRAM_RDOUTS21),
											.IN(BRAM_DOA12)
		);

		SPBB2T2X7H1 spbb_rdouts24_rdoutn25(
											.A(BRAM_RDOUTS24),
											.B(BRAM_RDOUTN25)
		);

		SPBB2T2X7H1 spbb_rdins19_rdinn20(
											.A(BRAM_RDINS19),
											.B(BRAM_RDINN20)
		);

		SPBB2T2X7H1 spbb_rdins28_rdinn29(
											.A(BRAM_RDINS28),
											.B(BRAM_RDINN29)
		);

		SPS8T6X11H1 sps_llv3(
											.IN4(BRAM_EA4),
											.IN5(BRAM_EA0),
											.IN6(BRAM_H6DA0),
											.IN7(BRAM_H6EA0),
											.IN0(BRAM_EA20),
											.IN1(BRAM_EA16),
											.IN2(BRAM_EA12),
											.IN3(BRAM_EA8),
											.OUT(BRAM_LLV3),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs10_raddrn10(
											.A(BRAM_RADDRS10),
											.B(BRAM_RADDRN10)
		);

		SPBB2T2X7H1 spbb_rdins30_rdinn31(
											.A(BRAM_RDINS30),
											.B(BRAM_RDINN31)
		);

		SPS8T6X11H1 sps_llv11(
											.IN4(BRAM_EA6),
											.IN5(BRAM_EA2),
											.IN6(BRAM_H6DA2),
											.IN7(BRAM_H6EA2),
											.IN0(BRAM_EA22),
											.IN1(BRAM_EA18),
											.IN2(BRAM_EA14),
											.IN3(BRAM_EA10),
											.OUT(BRAM_LLV11),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs22_raddrn22(
											.A(BRAM_RADDRS22),
											.B(BRAM_RADDRN22)
		);

		SPS2T2X7H2 sps_ea18(
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS11),
											.OUT(BRAM_EA18),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins25_rdinn26(
											.A(BRAM_RDINS25),
											.B(BRAM_RDINN26)
		);

		SPS2T2X7H2 sps_ea16(
											.IN0(BRAM_RDOUTS19),
											.IN1(BRAM_RDOUTS3),
											.OUT(BRAM_EA16),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts17_rdoutn18(
											.A(BRAM_RDOUTS17),
											.B(BRAM_RDOUTN18)
		);

		SPS2T2X7H2 sps_ea14(
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS11),
											.OUT(BRAM_EA14),
											._1(1)
		);

		SPS2T2X7H2 sps_ea15(
											.IN0(BRAM_RDOUTS31),
											.IN1(BRAM_RDOUTS15),
											.OUT(BRAM_EA15),
											._1(1)
		);

		SPS2T2X7H2 sps_ea12(
											.IN0(BRAM_RDOUTS19),
											.IN1(BRAM_RDOUTS3),
											.OUT(BRAM_EA12),
											._1(1)
		);

		SPS2T2X7H2 sps_ea13(
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS7),
											.OUT(BRAM_EA13),
											._1(1)
		);

		SPS2T2X7H2 sps_ea10(
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS11),
											.OUT(BRAM_EA10),
											._1(1)
		);

		SPS2T2X7H2 sps_ea11(
											.IN0(BRAM_RDOUTS31),
											.IN1(BRAM_RDOUTS15),
											.OUT(BRAM_EA11),
											._1(1)
		);

		SPS8T6X11H2 sps_dib10(
											.IN4(BRAM_RDINS5),
											.IN5(BRAM_RDINS4),
											.IN6(BRAM_RDINS1),
											.IN7(BRAM_RDINS0),
											.IN0(BRAM_RDINS23),
											.IN1(BRAM_RDINS22),
											.IN2(BRAM_RDINS19),
											.IN3(BRAM_RDINS18),
											.OUT(BRAM_DIB10),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa8_rdouts31(
											.IN(BRAM_DOA8),
											.OUT(BRAM_RDOUTS31)
		);

		SPS4T3X11H2 sps_h6ma3(
											.OUT(BRAM_H6MA3),
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS31),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											._1(1)
		);

		SPS8T6X11H1 sps_dia0(
											.IN4(BRAM_RDINS4),
											.IN5(BRAM_RDINS3),
											.IN6(BRAM_RDINS0),
											.IN7(BRAM_RDINS15),
											.IN0(BRAM_RDINS22),
											.IN1(BRAM_RDINS21),
											.IN2(BRAM_RDINS18),
											.IN3(BRAM_RDINS17),
											.OUT(BRAM_DIA0),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs6_raddrn6(
											.A(BRAM_RADDRS6),
											.B(BRAM_RADDRN6)
		);

		SPS8T6X11H2 sps_dia2(
											.IN4(BRAM_RDINS4),
											.IN5(BRAM_RDINS3),
											.IN6(BRAM_RDINS0),
											.IN7(BRAM_RDINS15),
											.IN0(BRAM_RDINS22),
											.IN1(BRAM_RDINS21),
											.IN2(BRAM_RDINS18),
											.IN3(BRAM_RDINS17),
											.OUT(BRAM_DIA2),
											._1(1)
		);

		SPS8T6X11H1 sps_dia8(
											.IN4(BRAM_RDINS4),
											.IN5(BRAM_RDINS3),
											.IN6(BRAM_RDINS0),
											.IN7(BRAM_RDINS15),
											.IN0(BRAM_RDINS22),
											.IN1(BRAM_RDINS21),
											.IN2(BRAM_RDINS18),
											.IN3(BRAM_RDINS17),
											.OUT(BRAM_DIA8),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs21_raddrn21(
											.A(BRAM_RADDRS21),
											.B(BRAM_RADDRN21)
		);

		SPBB2T2X7H1 spbb_rdouts8_rdoutn9(
											.A(BRAM_RDOUTS8),
											.B(BRAM_RDOUTN9)
		);

		SPS8T6X11H1 sps_rdins31(
											.IN4(BRAM_EA7),
											.IN5(BRAM_EA3),
											.IN6(BRAM_H6DA3),
											.IN7(BRAM_H6EA3),
											.IN0(BRAM_EA23),
											.IN1(BRAM_EA19),
											.IN2(BRAM_EA15),
											.IN3(BRAM_EA11),
											.OUT(BRAM_RDINS31),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins20_rdinn21(
											.A(BRAM_RDINS20),
											.B(BRAM_RDINN21)
		);

		SPBB2T2X7H1 spbb_raddrs7_raddrn7(
											.A(BRAM_RADDRS7),
											.B(BRAM_RADDRN7)
		);

		SPBB2T2X7H1 spbb_rdouts14_rdoutn15(
											.A(BRAM_RDOUTS14),
											.B(BRAM_RDOUTN15)
		);

		SPBB2T2X7H1 spbb_rdins8_rdinn9(
											.A(BRAM_RDINS8),
											.B(BRAM_RDINN9)
		);

		SPBB2T2X7H1 spbb_raddrs14_raddrn14(
											.A(BRAM_RADDRS14),
											.B(BRAM_RADDRN14)
		);

		SPBB2T2X7H1 spbb_rdouts5_rdoutn6(
											.A(BRAM_RDOUTS5),
											.B(BRAM_RDOUTN6)
		);

		TRIBUF1T1X7H1 tribuf_dob8_rdouts16(
											.IN(BRAM_DOB8),
											.OUT(BRAM_RDOUTS16)
		);

		SPBB2T2X7H1 spbb_rdins24_rdinn25(
											.A(BRAM_RDINS24),
											.B(BRAM_RDINN25)
		);

		SPBB2T2X7H1 spbb_rdouts27_rdoutn28(
											.A(BRAM_RDOUTS27),
											.B(BRAM_RDOUTN28)
		);

		TRIBUF1T1X7H1 tribuf_doa12_rdouts4(
											.OUT(BRAM_RDOUTS4),
											.IN(BRAM_DOA12)
		);

		SPBB2T2X7H1 spbb_raddrs0_raddrn0(
											.A(BRAM_RADDRS0),
											.B(BRAM_RADDRN0)
		);

		SPBB2T2X7H1 spbb_rdouts25_rdoutn26(
											.A(BRAM_RDOUTS25),
											.B(BRAM_RDOUTN26)
		);

		SPBB2T2X7H1 spbb_raddrs24_raddrn24(
											.A(BRAM_RADDRS24),
											.B(BRAM_RADDRN24)
		);

		SPBB2T2X7H1 spbb_rdouts6_rdoutn7(
											.A(BRAM_RDOUTS6),
											.B(BRAM_RDOUTN7)
		);

		SPBB2T2X7H1 spbb_raddrs30_raddrn30(
											.A(BRAM_RADDRS30),
											.B(BRAM_RADDRN30)
		);

		SPBB2T2X7H1 spbb_raddrs2_raddrn2(
											.A(BRAM_RADDRS2),
											.B(BRAM_RADDRN2)
		);

		SPS2T2X7H2 sps_ea17(
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS7),
											.OUT(BRAM_EA17),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins23(
											.IN4(BRAM_EA5),
											.IN5(BRAM_EA1),
											.IN6(BRAM_H6DA1),
											.IN7(BRAM_H6EA1),
											.IN0(BRAM_EA21),
											.IN1(BRAM_EA17),
											.IN2(BRAM_EA13),
											.IN3(BRAM_EA9),
											.OUT(BRAM_RDINS23),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins27(
											.IN4(BRAM_EA6),
											.IN5(BRAM_EA2),
											.IN6(BRAM_H6DA2),
											.IN7(BRAM_H6EA2),
											.IN0(BRAM_EA22),
											.IN1(BRAM_EA18),
											.IN2(BRAM_EA14),
											.IN3(BRAM_EA10),
											.OUT(BRAM_RDINS27),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs25_raddrn25(
											.A(BRAM_RADDRS25),
											.B(BRAM_RADDRN25)
		);

		SPBB2T2X7H1 spbb_rdins6_rdinn7(
											.A(BRAM_RDINS6),
											.B(BRAM_RDINN7)
		);

		SPBB2T2X7H1 spbb_raddrs19_raddrn19(
											.A(BRAM_RADDRS19),
											.B(BRAM_RADDRN19)
		);

		SPS8T6X11H2 sps_dia10(
											.IN4(BRAM_RDINS4),
											.IN5(BRAM_RDINS3),
											.IN6(BRAM_RDINS0),
											.IN7(BRAM_RDINS15),
											.IN0(BRAM_RDINS22),
											.IN1(BRAM_RDINS21),
											.IN2(BRAM_RDINS18),
											.IN3(BRAM_RDINS17),
											.OUT(BRAM_DIA10),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts21_rdoutn22(
											.A(BRAM_RDOUTS21),
											.B(BRAM_RDOUTN22)
		);

		SPBB2T2X7H1 spbb_rdins4_rdinn5(
											.A(BRAM_RDINS4),
											.B(BRAM_RDINN5)
		);

		SPBB2T2X7H1 spbb_rdins9_rdinn10(
											.A(BRAM_RDINS9),
											.B(BRAM_RDINN10)
		);

		SPBB2T2X7H1 spbb_rdouts31_rdoutn16(
											.A(BRAM_RDOUTS31),
											.B(BRAM_RDOUTN16)
		);

		SPBB2T2X7H1 spbb_rdins16_rdinn17(
											.A(BRAM_RDINS16),
											.B(BRAM_RDINN17)
		);

		SPBB2T2X7H1 spbb_rdins7_rdinn8(
											.A(BRAM_RDINS7),
											.B(BRAM_RDINN8)
		);

		SPBB2T2X7H1 spbb_raddrs28_raddrn28(
											.A(BRAM_RADDRS28),
											.B(BRAM_RADDRN28)
		);

		SPBB2T2X7H1 spbb_rdouts2_rdoutn3(
											.A(BRAM_RDOUTS2),
											.B(BRAM_RDOUTN3)
		);

		SPBB2T2X7H1 spbb_rdouts19_rdoutn20(
											.A(BRAM_RDOUTS19),
											.B(BRAM_RDOUTN20)
		);

		SPBB2T2X7H1 spbb_rdins22_rdinn23(
											.A(BRAM_RDINS22),
											.B(BRAM_RDINN23)
		);

		SPBB2T2X7H1 spbb_rdouts15_rdoutn0(
											.A(BRAM_RDOUTS15),
											.B(BRAM_RDOUTN0)
		);

		SPBB2T2X7H1 spbb_raddrs3_raddrn3(
											.A(BRAM_RADDRS3),
											.B(BRAM_RADDRN3)
		);

		SPS8T6X11H2 sps_raddrs11(
											.IN4(BRAM_EA6),
											.IN5(BRAM_EA2),
											.IN6(BRAM_H6DA2),
											.IN7(BRAM_H6EA2),
											.IN0(BRAM_EA22),
											.IN1(BRAM_EA18),
											.IN2(BRAM_EA14),
											.IN3(BRAM_EA10),
											.OUT(BRAM_RADDRS11),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs3(
											.IN4(BRAM_EA4),
											.IN5(BRAM_EA0),
											.IN6(BRAM_H6DA0),
											.IN7(BRAM_H6EA0),
											.IN0(BRAM_EA20),
											.IN1(BRAM_EA16),
											.IN2(BRAM_EA12),
											.IN3(BRAM_EA8),
											.OUT(BRAM_RADDRS3),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob8_rdouts15(
											.IN(BRAM_DOB8),
											.OUT(BRAM_RDOUTS15)
		);

		SPBB2T2X7H1 spbb_raddrs27_raddrn27(
											.A(BRAM_RADDRS27),
											.B(BRAM_RADDRN27)
		);

		SPS8T6X11H2 sps_raddrs7(
											.IN4(BRAM_EA5),
											.IN5(BRAM_EA1),
											.IN6(BRAM_H6DA1),
											.IN7(BRAM_H6EA1),
											.IN0(BRAM_EA21),
											.IN1(BRAM_EA17),
											.IN2(BRAM_EA13),
											.IN3(BRAM_EA9),
											.OUT(BRAM_RADDRS7),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa0_rdouts13(
											.OUT(BRAM_RDOUTS13),
											.IN(BRAM_DOA0)
		);

		TRIBUF1T1X7H1 tribuf_dob12_rdouts5(
											.IN(BRAM_DOB12),
											.OUT(BRAM_RDOUTS5)
		);

		TRIBUF1T1X7H1 tribuf_doa0_rdouts16(
											.OUT(BRAM_RDOUTS16),
											.IN(BRAM_DOA0)
		);

		TRIBUF1T1X7H1 tribuf_doa0_rdouts14(
											.IN(BRAM_DOA0),
											.OUT(BRAM_RDOUTS14)
		);

		SPBB2T2X7H1 spbb_rdouts18_rdoutn19(
											.A(BRAM_RDOUTS18),
											.B(BRAM_RDOUTN19)
		);

		TRIBUF1T1X7H1 tribuf_doa4_rdouts21(
											.IN(BRAM_DOA4),
											.OUT(BRAM_RDOUTS21)
		);

		SPS8T6X11H2 sps_raddrs15(
											.IN4(BRAM_EA7),
											.IN5(BRAM_EA3),
											.IN6(BRAM_H6DA3),
											.IN7(BRAM_H6EA3),
											.IN0(BRAM_EA23),
											.IN1(BRAM_EA19),
											.IN2(BRAM_EA15),
											.IN3(BRAM_EA11),
											.OUT(BRAM_RADDRS15),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins3_rdinn4(
											.A(BRAM_RDINS3),
											.B(BRAM_RDINN4)
		);

		SPBU1NAND1X35H1 spbu_gclk_ioba3(
											.OUT(BRAM_GCLK_IOBA3),
											.IN(BRAM_GCLKIN3)
		);

		SPBU1NAND1X35H1 spbu_gclk_ioba2(
											.OUT(BRAM_GCLK_IOBA2),
											.IN(BRAM_GCLKIN2)
		);

		SPBU1NAND1X35H1 spbu_gclk_ioba1(
											.OUT(BRAM_GCLK_IOBA1),
											.IN(BRAM_GCLKIN1)
		);

		SPBU1NAND1X35H1 spbu_gclk_ioba0(
											.OUT(BRAM_GCLK_IOBA0),
											.IN(BRAM_GCLKIN0)
		);

		SPBB2T2X7H1 spbb_raddrs17_raddrn17(
											.A(BRAM_RADDRS17),
											.B(BRAM_RADDRN17)
		);

		SPS2T2X7H2 sps_ea1(
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS7),
											.OUT(BRAM_EA1),
											._1(1)
		);

		SPS2T2X7H2 sps_ea2(
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS11),
											.OUT(BRAM_EA2),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts26_rdoutn27(
											.A(BRAM_RDOUTS26),
											.B(BRAM_RDOUTN27)
		);

		TRIBUF1T1X7H1 tribuf_dob4_rdouts23(
											.IN(BRAM_DOB4),
											.OUT(BRAM_RDOUTS23)
		);

		SPS2T2X7H2 sps_ea8(
											.IN0(BRAM_RDOUTS19),
											.IN1(BRAM_RDOUTS3),
											.OUT(BRAM_EA8),
											._1(1)
		);

		SPS2T2X7H2 sps_ea9(
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS7),
											.OUT(BRAM_EA9),
											._1(1)
		);

		SPS4T3X11H2 sps_h6ma0(
											.OUT(BRAM_H6MA0),
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS19),
											.IN2(BRAM_RDOUTS7),
											.IN3(BRAM_RDOUTS3),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins14_rdinn15(
											.A(BRAM_RDINS14),
											.B(BRAM_RDINN15)
		);

		SPS4T3X11H2 sps_h6ma1(
											.OUT(BRAM_H6MA1),
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS31),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											._1(1)
		);

		SPS4T3X11H2 sps_h6ma2(
											.OUT(BRAM_H6MA2),
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS19),
											.IN2(BRAM_RDOUTS7),
											.IN3(BRAM_RDOUTS3),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs20_raddrn20(
											.A(BRAM_RADDRS20),
											.B(BRAM_RADDRN20)
		);

		TRIBUF1T1X7H1 tribuf_doa0_rdouts31(
											.IN(BRAM_DOA0),
											.OUT(BRAM_RDOUTS31)
		);

		SPS2T2X7H2 sps_ea20(
											.IN0(BRAM_RDOUTS19),
											.IN1(BRAM_RDOUTS3),
											.OUT(BRAM_EA20),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts16_rdoutn17(
											.A(BRAM_RDOUTS16),
											.B(BRAM_RDOUTN17)
		);

		SPBB2T2X7H1 spbb_rdouts10_rdoutn11(
											.A(BRAM_RDOUTS10),
											.B(BRAM_RDOUTN11)
		);

		SPS2T2X7H2 sps_ea19(
											.IN0(BRAM_RDOUTS31),
											.IN1(BRAM_RDOUTS15),
											.OUT(BRAM_EA19),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs5_raddrn5(
											.A(BRAM_RADDRS5),
											.B(BRAM_RADDRN5)
		);

		SPBB2T2X7H1 spbb_rdins23_rdinn24(
											.A(BRAM_RDINS23),
											.B(BRAM_RDINN24)
		);

		TRIBUF1T1X7H1 tribuf_dob0_rdouts15(
											.IN(BRAM_DOB0),
											.OUT(BRAM_RDOUTS15)
		);

		TRIBUF1T1X7H1 tribuf_dob0_rdouts14(
											.IN(BRAM_DOB0),
											.OUT(BRAM_RDOUTS14)
		);

		TRIBUF1T1X7H1 tribuf_dob0_rdouts17(
											.OUT(BRAM_RDOUTS17),
											.IN(BRAM_DOB0)
		);

		TRIBUF1T1X7H1 tribuf_dob0_rdouts16(
											.IN(BRAM_DOB0),
											.OUT(BRAM_RDOUTS16)
		);

		SPBB2T2X7H1 spbb_rdouts0_rdoutn1(
											.A(BRAM_RDOUTS0),
											.B(BRAM_RDOUTN1)
		);

		TRIBUF1T1X7H1 tribuf_doa4_rdouts22(
											.OUT(BRAM_RDOUTS22),
											.IN(BRAM_DOA4)
		);

		SPBB2T2X7H1 spbb_raddrs29_raddrn29(
											.A(BRAM_RADDRS29),
											.B(BRAM_RADDRN29)
		);

		SPS2T2X7H2 sps_ea4(
											.IN0(BRAM_RDOUTS19),
											.IN1(BRAM_RDOUTS3),
											.OUT(BRAM_EA4),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob12_rdouts22(
											.IN(BRAM_DOB12),
											.OUT(BRAM_RDOUTS22)
		);

		SPBB2T2X7H1 spbb_rdouts4_rdoutn5(
											.A(BRAM_RDOUTS4),
											.B(BRAM_RDOUTN5)
		);

		SPS2T2X7H2 sps_ea5(
											.IN0(BRAM_RDOUTS23),
											.IN1(BRAM_RDOUTS7),
											.OUT(BRAM_EA5),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts13_rdoutn14(
											.A(BRAM_RDOUTS13),
											.B(BRAM_RDOUTN14)
		);

		SPS2T2X7H2 sps_ea6(
											.IN0(BRAM_RDOUTS27),
											.IN1(BRAM_RDOUTS11),
											.OUT(BRAM_EA6),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs27(
											.IN4(BRAM_EA6),
											.IN5(BRAM_EA2),
											.IN6(BRAM_H6DA2),
											.IN7(BRAM_H6EA2),
											.IN0(BRAM_EA22),
											.IN1(BRAM_EA18),
											.IN2(BRAM_EA14),
											.IN3(BRAM_EA10),
											.OUT(BRAM_RADDRS27),
											._1(1)
		);

		SPS2T2X7H2 sps_ea7(
											.IN0(BRAM_RDOUTS31),
											.IN1(BRAM_RDOUTS15),
											.OUT(BRAM_EA7),
											._1(1)
		);

		SPS2T2X7H2 sps_ea0(
											.IN0(BRAM_RDOUTS19),
											.IN1(BRAM_RDOUTS3),
											.OUT(BRAM_EA0),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts1_rdoutn2(
											.A(BRAM_RDOUTS1),
											.B(BRAM_RDOUTN2)
		);

		SPBB2T2X7H1 spbb_raddrs11_raddrn11(
											.A(BRAM_RADDRS11),
											.B(BRAM_RADDRN11)
		);

		SPBB2T2X7H1 spbb_rdins12_rdinn13(
											.A(BRAM_RDINS12),
											.B(BRAM_RDINN13)
		);

		SPBB2T2X7H1 spbb_raddrs18_raddrn18(
											.A(BRAM_RADDRS18),
											.B(BRAM_RADDRN18)
		);

		SPS8T6X11H1 sps_lha3(
											.IN4(BRAM_RDOUTS19),
											.IN5(BRAM_RDOUTS23),
											.IN6(BRAM_RDOUTS27),
											.IN7(BRAM_RDOUTS31),
											.IN0(BRAM_RDOUTS3),
											.IN1(BRAM_RDOUTS7),
											.IN2(BRAM_RDOUTS11),
											.IN3(BRAM_RDOUTS15),
											.OUT(BRAM_LHA3),
											._1(1)
		);

		SPS8T6X11H2 sps_rdins3(
											.IN4(BRAM_EA4),
											.IN5(BRAM_EA0),
											.IN6(BRAM_H6DA0),
											.IN7(BRAM_H6EA0),
											.IN0(BRAM_EA20),
											.IN1(BRAM_EA16),
											.IN2(BRAM_EA12),
											.IN3(BRAM_EA8),
											.OUT(BRAM_RDINS3),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs23(
											.IN4(BRAM_EA5),
											.IN5(BRAM_EA1),
											.IN6(BRAM_H6DA1),
											.IN7(BRAM_H6EA1),
											.IN0(BRAM_EA21),
											.IN1(BRAM_EA17),
											.IN2(BRAM_EA13),
											.IN3(BRAM_EA9),
											.OUT(BRAM_RADDRS23),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins0_rdinn1(
											.A(BRAM_RDINS0),
											.B(BRAM_RDINN1)
		);

		SPBB2T2X7H1 spbb_rdouts12_rdoutn13(
											.A(BRAM_RDOUTS12),
											.B(BRAM_RDOUTN13)
		);

		SPBB2T2X7H1 spbb_rdouts29_rdoutn30(
											.A(BRAM_RDOUTS29),
											.B(BRAM_RDOUTN30)
		);

		TRIBUF1T1X7H1 tribuf_dob4_rdouts5(
											.OUT(BRAM_RDOUTS5),
											.IN(BRAM_DOB4)
		);

		SPBB2T2X7H1 spbb_rdouts30_rdoutn31(
											.A(BRAM_RDOUTS30),
											.B(BRAM_RDOUTN31)
		);

		SPBB2T2X7H1 spbb_raddrs1_raddrn1(
											.A(BRAM_RADDRS1),
											.B(BRAM_RADDRN1)
		);

		SPBB2T2X7H1 spbb_raddrs16_raddrn16(
											.A(BRAM_RADDRS16),
											.B(BRAM_RADDRN16)
		);

		SPBB2T2X7H1 spbb_raddrs23_raddrn23(
											.A(BRAM_RADDRS23),
											.B(BRAM_RADDRN23)
		);

		SPBB2T2X7H1 spbb_rdins1_rdinn2(
											.A(BRAM_RDINS1),
											.B(BRAM_RDINN2)
		);

		SPS8T6X11H1 sps_raddrs19(
											.IN4(BRAM_EA4),
											.IN5(BRAM_EA0),
											.IN6(BRAM_H6DA0),
											.IN7(BRAM_H6EA0),
											.IN0(BRAM_EA20),
											.IN1(BRAM_EA16),
											.IN2(BRAM_EA12),
											.IN3(BRAM_EA8),
											.OUT(BRAM_RADDRS19),
											._1(1)
		);

		SPS8T6X11H1 sps_dib8(
											.IN4(BRAM_RDINS5),
											.IN5(BRAM_RDINS4),
											.IN6(BRAM_RDINS1),
											.IN7(BRAM_RDINS0),
											.IN0(BRAM_RDINS23),
											.IN1(BRAM_RDINS22),
											.IN2(BRAM_RDINS19),
											.IN3(BRAM_RDINS18),
											.OUT(BRAM_DIB8),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts7_rdoutn8(
											.A(BRAM_RDOUTS7),
											.B(BRAM_RDOUTN8)
		);

		SPBB2T2X7H1 spbb_rdouts22_rdoutn23(
											.A(BRAM_RDOUTS22),
											.B(BRAM_RDOUTN23)
		);

		SPBB2T2X7H1 spbb_rdouts20_rdoutn21(
											.A(BRAM_RDOUTS20),
											.B(BRAM_RDOUTN21)
		);

		SPS8T6X11H1 sps_dib0(
											.IN4(BRAM_RDINS5),
											.IN5(BRAM_RDINS4),
											.IN6(BRAM_RDINS1),
											.IN7(BRAM_RDINS0),
											.IN0(BRAM_RDINS23),
											.IN1(BRAM_RDINS22),
											.IN2(BRAM_RDINS19),
											.IN3(BRAM_RDINS18),
											.OUT(BRAM_DIB0),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdouts3_rdoutn4(
											.A(BRAM_RDOUTS3),
											.B(BRAM_RDOUTN4)
		);

		SPS8T6X11H2 sps_dib2(
											.IN4(BRAM_RDINS5),
											.IN5(BRAM_RDINS4),
											.IN6(BRAM_RDINS1),
											.IN7(BRAM_RDINS0),
											.IN0(BRAM_RDINS23),
											.IN1(BRAM_RDINS22),
											.IN2(BRAM_RDINS19),
											.IN3(BRAM_RDINS18),
											.OUT(BRAM_DIB2),
											._1(1)
		);

		SPBB2T2X7H1 spbb_rdins18_rdinn19(
											.A(BRAM_RDINS18),
											.B(BRAM_RDINN19)
		);

		TRIBUF1T1X7H1 tribuf_doa4_rdouts4(
											.IN(BRAM_DOA4),
											.OUT(BRAM_RDOUTS4)
		);

		TRIBUF1T1X7H1 tribuf_doa4_rdouts3(
											.IN(BRAM_DOA4),
											.OUT(BRAM_RDOUTS3)
		);

		SPS2T2X7H2 sps_ea3(
											.IN0(BRAM_RDOUTS31),
											.IN1(BRAM_RDOUTS15),
											.OUT(BRAM_EA3),
											._1(1)
		);

		SPBB2T2X7H1 spbb_raddrs31_raddrn31(
											.A(BRAM_RADDRS31),
											.B(BRAM_RADDRN31)
		);

		SPBB2T2X7H1 spbb_rdouts11_rdoutn12(
											.A(BRAM_RDOUTS11),
											.B(BRAM_RDOUTN12)
		);

		SPBB2T2X7H1 spbb_raddrs4_raddrn4(
											.A(BRAM_RADDRS4),
											.B(BRAM_RADDRN4)
		);

		SPBB2T2X7H1 spbb_rdins11_rdinn12(
											.A(BRAM_RDINS11),
											.B(BRAM_RDINN12)
		);

		SPBB2T2X7H1 spbb_raddrs8_raddrn8(
											.A(BRAM_RADDRS8),
											.B(BRAM_RADDRN8)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_TOP(
TOP_S23, TOP_S22, TOP_S21, TOP_S20, TOP_S19, TOP_S18, TOP_S17, TOP_S16, TOP_S15, TOP_S14, TOP_S13, TOP_S12, TOP_S11, TOP_S10, TOP_S9, TOP_S8, TOP_S7, TOP_S6, TOP_S5, TOP_S4, TOP_S3, TOP_S2, TOP_S1, TOP_S0, TOP_H6E0, TOP_H6E1, TOP_H6E2, TOP_H6E3, TOP_H6E4, TOP_H6E5, TOP_H6A0, TOP_H6A1, TOP_H6A2, TOP_H6A3, TOP_H6A4, TOP_H6A5, TOP_H6B0, TOP_H6B1, TOP_H6B2, TOP_H6B3, TOP_H6B4, TOP_H6B5, TOP_H6M0, TOP_H6M1, TOP_H6M2, TOP_H6M3, TOP_H6M4, TOP_H6M5, TOP_H6C0, TOP_H6C1, TOP_H6C2, TOP_H6C3, TOP_H6C4, TOP_H6C5, TOP_H6D0, TOP_H6D1, TOP_H6D2, TOP_H6D3, TOP_H6D4, TOP_H6D5, TOP_H6W0, TOP_H6W1, TOP_H6W2, TOP_H6W3, TOP_H6W4, TOP_H6W5, TOP_V6A0, TOP_V6A1, TOP_V6A2, TOP_V6A3, TOP_V6A4, TOP_V6A5, TOP_V6A6, TOP_V6A7, TOP_V6A8, TOP_V6A9, TOP_V6A10, TOP_V6A11, TOP_V6B0, TOP_V6B1, TOP_V6B2, TOP_V6B3, TOP_V6B4, TOP_V6B5, TOP_V6B6, TOP_V6B7, TOP_V6B8, TOP_V6B9, TOP_V6B10, TOP_V6B11, TOP_V6M0, TOP_V6M1, TOP_V6M2, TOP_V6M3, TOP_V6M4, TOP_V6M5, TOP_V6M6, TOP_V6M7, TOP_V6M8, TOP_V6M9, TOP_V6M10, TOP_V6M11, TOP_V6C0, TOP_V6C1, TOP_V6C2, TOP_V6C3, TOP_V6C4, TOP_V6C5, TOP_V6C6, TOP_V6C7, TOP_V6C8, TOP_V6C9, TOP_V6C10, TOP_V6C11, TOP_V6D0, TOP_V6D1, TOP_V6D2, TOP_V6D3, TOP_V6D4, TOP_V6D5, TOP_V6D6, TOP_V6D7, TOP_V6D8, TOP_V6D9, TOP_V6D10, TOP_V6D11, TOP_V6S0, TOP_V6S1, TOP_V6S2, TOP_V6S3, TOP_V6S4, TOP_V6S5, TOP_V6S6, TOP_V6S7, TOP_V6S8, TOP_V6S9, TOP_V6S10, TOP_V6S11, TOP_LLH0, TOP_LLH6, TOP_LLV0, TOP_LLV1, TOP_LLV2, TOP_LLV3, TOP_LLV4, TOP_LLV5, TOP_LLV6, TOP_LLV7, TOP_LLV8, TOP_LLV9, TOP_LLV10, TOP_LLV11, TOP_HGCLK0, TOP_HGCLK1, TOP_HGCLK2, TOP_HGCLK3, TOP_I2, TOP_I1, TOP_IQ2, TOP_IQ1, TOP_ICE2, TOP_ICE1, TOP_O2, TOP_O1, TOP_OCE2, TOP_OCE1, TOP_T2, TOP_T1, TOP_TCE2, TOP_TCE1, TOP_CLK2, TOP_CLK1, TOP_SR_B2, TOP_SR_B1, _1
);
inout	TOP_S23;
inout	TOP_S22;
inout	TOP_S21;
inout	TOP_S20;
inout	TOP_S19;
inout	TOP_S18;
inout	TOP_S17;
inout	TOP_S16;
inout	TOP_S15;
inout	TOP_S14;
inout	TOP_S13;
inout	TOP_S12;
inout	TOP_S11;
inout	TOP_S10;
inout	TOP_S9;
inout	TOP_S8;
inout	TOP_S7;
inout	TOP_S6;
inout	TOP_S5;
inout	TOP_S4;
inout	TOP_S3;
inout	TOP_S2;
inout	TOP_S1;
inout	TOP_S0;
inout	TOP_H6E0;
inout	TOP_H6E1;
inout	TOP_H6E2;
inout	TOP_H6E3;
inout	TOP_H6E4;
inout	TOP_H6E5;
inout	TOP_H6A0;
inout	TOP_H6A1;
inout	TOP_H6A2;
inout	TOP_H6A3;
inout	TOP_H6A4;
inout	TOP_H6A5;
inout	TOP_H6B0;
inout	TOP_H6B1;
inout	TOP_H6B2;
inout	TOP_H6B3;
inout	TOP_H6B4;
inout	TOP_H6B5;
inout	TOP_H6M0;
inout	TOP_H6M1;
inout	TOP_H6M2;
inout	TOP_H6M3;
inout	TOP_H6M4;
inout	TOP_H6M5;
inout	TOP_H6C0;
inout	TOP_H6C1;
inout	TOP_H6C2;
inout	TOP_H6C3;
inout	TOP_H6C4;
inout	TOP_H6C5;
inout	TOP_H6D0;
inout	TOP_H6D1;
inout	TOP_H6D2;
inout	TOP_H6D3;
inout	TOP_H6D4;
inout	TOP_H6D5;
inout	TOP_H6W0;
inout	TOP_H6W1;
inout	TOP_H6W2;
inout	TOP_H6W3;
inout	TOP_H6W4;
inout	TOP_H6W5;
inout	TOP_V6A0;
inout	TOP_V6A1;
inout	TOP_V6A2;
inout	TOP_V6A3;
inout	TOP_V6A4;
inout	TOP_V6A5;
inout	TOP_V6A6;
inout	TOP_V6A7;
inout	TOP_V6A8;
inout	TOP_V6A9;
inout	TOP_V6A10;
inout	TOP_V6A11;
inout	TOP_V6B0;
inout	TOP_V6B1;
inout	TOP_V6B2;
inout	TOP_V6B3;
inout	TOP_V6B4;
inout	TOP_V6B5;
inout	TOP_V6B6;
inout	TOP_V6B7;
inout	TOP_V6B8;
inout	TOP_V6B9;
inout	TOP_V6B10;
inout	TOP_V6B11;
inout	TOP_V6M0;
inout	TOP_V6M1;
inout	TOP_V6M2;
inout	TOP_V6M3;
inout	TOP_V6M4;
inout	TOP_V6M5;
inout	TOP_V6M6;
inout	TOP_V6M7;
inout	TOP_V6M8;
inout	TOP_V6M9;
inout	TOP_V6M10;
inout	TOP_V6M11;
inout	TOP_V6C0;
inout	TOP_V6C1;
inout	TOP_V6C2;
inout	TOP_V6C3;
inout	TOP_V6C4;
inout	TOP_V6C5;
inout	TOP_V6C6;
inout	TOP_V6C7;
inout	TOP_V6C8;
inout	TOP_V6C9;
inout	TOP_V6C10;
inout	TOP_V6C11;
inout	TOP_V6D0;
inout	TOP_V6D1;
inout	TOP_V6D2;
inout	TOP_V6D3;
inout	TOP_V6D4;
inout	TOP_V6D5;
inout	TOP_V6D6;
inout	TOP_V6D7;
inout	TOP_V6D8;
inout	TOP_V6D9;
inout	TOP_V6D10;
inout	TOP_V6D11;
inout	TOP_V6S0;
inout	TOP_V6S1;
inout	TOP_V6S2;
inout	TOP_V6S3;
inout	TOP_V6S4;
inout	TOP_V6S5;
inout	TOP_V6S6;
inout	TOP_V6S7;
inout	TOP_V6S8;
inout	TOP_V6S9;
inout	TOP_V6S10;
inout	TOP_V6S11;
inout	TOP_LLH0;
inout	TOP_LLH6;
inout	TOP_LLV0;
inout	TOP_LLV1;
inout	TOP_LLV2;
inout	TOP_LLV3;
inout	TOP_LLV4;
inout	TOP_LLV5;
inout	TOP_LLV6;
inout	TOP_LLV7;
inout	TOP_LLV8;
inout	TOP_LLV9;
inout	TOP_LLV10;
inout	TOP_LLV11;
inout	TOP_HGCLK0;
inout	TOP_HGCLK1;
inout	TOP_HGCLK2;
inout	TOP_HGCLK3;
inout	TOP_I2;
inout	TOP_I1;
inout	TOP_IQ2;
inout	TOP_IQ1;
inout	TOP_ICE2;
inout	TOP_ICE1;
inout	TOP_O2;
inout	TOP_O1;
inout	TOP_OCE2;
inout	TOP_OCE1;
inout	TOP_T2;
inout	TOP_T1;
inout	TOP_TCE2;
inout	TOP_TCE1;
inout	TOP_CLK2;
inout	TOP_CLK1;
inout	TOP_SR_B2;
inout	TOP_SR_B1;
inout	_1;
		wire		TOP_S_BUF23 ;
		wire		TOP_S_BUF22 ;
		wire		TOP_S_BUF21 ;
		wire		TOP_S_BUF20 ;
		wire		TOP_S_BUF19 ;
		wire		TOP_S_BUF18 ;
		wire		TOP_S_BUF17 ;
		wire		TOP_S_BUF16 ;
		wire		TOP_S_BUF15 ;
		wire		TOP_S_BUF14 ;
		wire		TOP_S_BUF13 ;
		wire		TOP_S_BUF12 ;
		wire		TOP_S_BUF11 ;
		wire		TOP_S_BUF10 ;
		wire		TOP_S_BUF9 ;
		wire		TOP_S_BUF8 ;
		wire		TOP_S_BUF7 ;
		wire		TOP_S_BUF6 ;
		wire		TOP_S_BUF5 ;
		wire		TOP_S_BUF4 ;
		wire		TOP_S_BUF3 ;
		wire		TOP_S_BUF2 ;
		wire		TOP_S_BUF1 ;
		wire		TOP_S_BUF0 ;
		wire		TOP_H6A_BUF0 ;
		wire		TOP_H6A_BUF1 ;
		wire		TOP_H6A_BUF2 ;
		wire		TOP_H6A_BUF3 ;
		wire		TOP_H6B_BUF0 ;
		wire		TOP_H6B_BUF1 ;
		wire		TOP_H6B_BUF2 ;
		wire		TOP_H6B_BUF3 ;
		wire		TOP_H6M_BUF0 ;
		wire		TOP_H6M_BUF1 ;
		wire		TOP_H6M_BUF2 ;
		wire		TOP_H6M_BUF3 ;
		wire		TOP_H6C_BUF0 ;
		wire		TOP_H6C_BUF1 ;
		wire		TOP_H6C_BUF2 ;
		wire		TOP_H6C_BUF3 ;
		wire		TOP_H6D_BUF0 ;
		wire		TOP_H6D_BUF1 ;
		wire		TOP_H6D_BUF2 ;
		wire		TOP_H6D_BUF3 ;
		wire		TOP_H6W_BUF0 ;
		wire		TOP_H6W_BUF1 ;
		wire		TOP_H6W_BUF2 ;
		wire		TOP_H6W_BUF3 ;
		wire		TOP_V6A_BUF0 ;
		wire		TOP_V6A_BUF1 ;
		wire		TOP_V6A_BUF2 ;
		wire		TOP_V6A_BUF3 ;
		wire		TOP_V6B_BUF0 ;
		wire		TOP_V6B_BUF1 ;
		wire		TOP_V6B_BUF2 ;
		wire		TOP_V6B_BUF3 ;
		wire		TOP_V6M_BUF0 ;
		wire		TOP_V6M_BUF1 ;
		wire		TOP_V6M_BUF2 ;
		wire		TOP_V6M_BUF3 ;
		wire		TOP_V6C_BUF0 ;
		wire		TOP_V6C_BUF1 ;
		wire		TOP_V6C_BUF2 ;
		wire		TOP_V6C_BUF3 ;
		wire		TOP_V6D_BUF0 ;
		wire		TOP_V6D_BUF1 ;
		wire		TOP_V6D_BUF2 ;
		wire		TOP_V6D_BUF3 ;
		wire		TOP_V6S_BUF0 ;
		wire		TOP_V6S_BUF1 ;
		wire		TOP_V6S_BUF2 ;
		wire		TOP_V6S_BUF3 ;
		wire		TOP_FAKE_LLH6 ;
		wire		TOP_FAKE_LLH0 ;
		wire		TOP_I3 ;
		wire		TOP_I0 ;
		wire		TOP_IQ3 ;
		wire		TOP_IQ0 ;
		wire		TOP_GCLK0 ;
		wire		TOP_GCLK1 ;
		wire		TOP_GCLK2 ;
		wire		TOP_GCLK3 ;

		SPS16N6X0H2 sps_t2(
											.IN8(TOP_V6B_BUF0),
											.IN9(TOP_V6A_BUF0),
											.IN4(TOP_V6S_BUF0),
											.IN5(TOP_V6D_BUF0),
											.IN6(TOP_V6C_BUF0),
											.IN7(TOP_V6M_BUF0),
											.IN0(TOP_S_BUF3),
											.IN1(TOP_S_BUF2),
											.IN2(TOP_S_BUF1),
											.IN3(TOP_S_BUF0),
											.OUT(TOP_T2),
											.IN14(TOP_H6D_BUF0),
											.IN15(TOP_H6W_BUF0),
											.IN12(TOP_H6M_BUF0),
											.IN13(TOP_H6C_BUF0),
											.IN10(TOP_H6A_BUF0),
											.IN11(TOP_H6B_BUF0),
											._1(1)
		);

		SPS2T2X11H2 sps_llv1(
											.IN0(TOP_I0),
											.IN1(TOP_H6D5),
											.OUT(TOP_LLV1),
											._1(1)
		);

		SPS2T2X11H2 sps_llv0(
											.IN0(TOP_IQ0),
											.IN1(TOP_H6W5),
											.OUT(TOP_LLV0),
											._1(1)
		);

		SPS2T2X11H2 sps_llv3(
											.IN0(TOP_IQ1),
											.IN1(TOP_H6M5),
											.OUT(TOP_LLV3),
											._1(1)
		);

		SPS2T2X11H2 sps_llv2(
											.IN0(TOP_IQ1),
											.IN1(TOP_H6C5),
											.OUT(TOP_LLV2),
											._1(1)
		);

		SPS2T2X11H2 sps_llv5(
											.IN0(TOP_I1),
											.IN1(TOP_H6A5),
											.OUT(TOP_LLV5),
											._1(1)
		);

		SPS2T2X11H2 sps_llv4(
											.IN0(TOP_I1),
											.IN1(TOP_H6B5),
											.OUT(TOP_LLV4),
											._1(1)
		);

		SPS2T2X11H2 sps_llv7(
											.IN0(TOP_IQ2),
											.IN1(TOP_H6D4),
											.OUT(TOP_LLV7),
											._1(1)
		);

		SPS16N6X0H2 sps_ice1(
											.IN8(TOP_V6B_BUF3),
											.IN9(TOP_V6A_BUF3),
											.IN4(TOP_V6S_BUF3),
											.IN5(TOP_V6D_BUF3),
											.IN6(TOP_V6C_BUF3),
											.IN7(TOP_V6M_BUF3),
											.IN0(TOP_S_BUF23),
											.IN1(TOP_S_BUF22),
											.IN2(TOP_S_BUF21),
											.IN3(TOP_S_BUF20),
											.OUT(TOP_ICE1),
											.IN14(TOP_H6D_BUF3),
											.IN15(TOP_H6W_BUF3),
											.IN12(TOP_H6M_BUF3),
											.IN13(TOP_H6C_BUF3),
											.IN10(TOP_H6A_BUF3),
											.IN11(TOP_H6B_BUF3),
											._1(1)
		);

		BUF1B0X2H3 buf_v6d2(
											.A(TOP_V6D2),
											.Y(TOP_V6D_BUF2)
		);

		BUF1B0X2H3 buf_v6d3(
											.A(TOP_V6D3),
											.Y(TOP_V6D_BUF3)
		);

		BUF1B0X2H3 buf_v6d0(
											.A(TOP_V6D0),
											.Y(TOP_V6D_BUF0)
		);

		BUF1B0X2H3 buf_v6d1(
											.A(TOP_V6D1),
											.Y(TOP_V6D_BUF1)
		);

		SPS16N6X0H2 sps_ice2(
											.IN8(TOP_V6B_BUF3),
											.IN9(TOP_V6A_BUF3),
											.IN4(TOP_V6S_BUF3),
											.IN5(TOP_V6D_BUF3),
											.IN6(TOP_V6C_BUF3),
											.IN7(TOP_V6M_BUF3),
											.IN0(TOP_S_BUF23),
											.IN1(TOP_S_BUF22),
											.IN2(TOP_S_BUF21),
											.IN3(TOP_S_BUF20),
											.OUT(TOP_ICE2),
											.IN14(TOP_H6D_BUF3),
											.IN15(TOP_H6W_BUF3),
											.IN12(TOP_H6M_BUF3),
											.IN13(TOP_H6C_BUF3),
											.IN10(TOP_H6A_BUF3),
											.IN11(TOP_H6B_BUF3),
											._1(1)
		);

		BUF1B0X2H3 buf_h6a3(
											.A(TOP_H6A3),
											.Y(TOP_H6A_BUF3)
		);

		BUF1B0X2H3 buf_h6a2(
											.A(TOP_H6A2),
											.Y(TOP_H6A_BUF2)
		);

		BUF1B0X2H3 buf_h6a1(
											.A(TOP_H6A1),
											.Y(TOP_H6A_BUF1)
		);

		BUF1B0X2H3 buf_h6a0(
											.A(TOP_H6A0),
											.Y(TOP_H6A_BUF0)
		);

		SPS12T8X11H1 sps_h6e2(
											.IN8(TOP_I0),
											.IN9(TOP_FAKE_LLH6),
											.IN4(TOP_I2),
											.IN5(TOP_IQ1),
											.IN6(TOP_I1),
											.IN7(TOP_IQ0),
											.IN0(TOP_H6W2),
											.IN1(TOP_IQ3),
											.IN2(TOP_I3),
											.IN3(TOP_IQ2),
											.OUT(TOP_H6E2),
											.IN10(TOP_V6M0),
											.IN11(TOP_V6S1),
											._1(1)
		);

		SPS12T8X11H1 sps_h6e3(
											.IN8(TOP_I0),
											.IN9(TOP_FAKE_LLH6),
											.IN4(TOP_I2),
											.IN5(TOP_IQ1),
											.IN6(TOP_I1),
											.IN7(TOP_IQ0),
											.IN0(TOP_H6W3),
											.IN1(TOP_IQ3),
											.IN2(TOP_I3),
											.IN3(TOP_IQ2),
											.OUT(TOP_H6E3),
											.IN10(TOP_V6M1),
											.IN11(TOP_V6S2),
											._1(1)
		);

		SPS12T8X11H1 sps_h6e0(
											.IN8(TOP_I0),
											.IN9(TOP_FAKE_LLH0),
											.IN4(TOP_I2),
											.IN5(TOP_IQ1),
											.IN6(TOP_I1),
											.IN7(TOP_IQ0),
											.IN0(TOP_H6W0),
											.IN1(TOP_IQ3),
											.IN2(TOP_I3),
											.IN3(TOP_IQ2),
											.OUT(TOP_H6E0),
											.IN10(TOP_V6M2),
											.IN11(TOP_V6S3),
											._1(1)
		);

		SPS12T8X11H1 sps_h6e1(
											.IN8(TOP_I0),
											.IN9(TOP_FAKE_LLH0),
											.IN4(TOP_I2),
											.IN5(TOP_IQ1),
											.IN6(TOP_I1),
											.IN7(TOP_IQ0),
											.IN0(TOP_H6W1),
											.IN1(TOP_IQ3),
											.IN2(TOP_I3),
											.IN3(TOP_IQ2),
											.OUT(TOP_H6E1),
											.IN10(TOP_V6M3),
											.IN11(TOP_V6S0),
											._1(1)
		);

		SPS12T8X11H2 sps_h6e4(
											.IN8(TOP_I0),
											.IN9(TOP_FAKE_LLH6),
											.IN4(TOP_I2),
											.IN5(TOP_IQ1),
											.IN6(TOP_I1),
											.IN7(TOP_IQ0),
											.IN0(TOP_H6W4),
											.IN1(TOP_IQ3),
											.IN2(TOP_I3),
											.IN3(TOP_IQ2),
											.OUT(TOP_H6E4),
											.IN10(TOP_S_BUF7),
											.IN11(TOP_S_BUF0),
											._1(1)
		);

		SPS12T8X11H2 sps_h6e5(
											.IN8(TOP_I0),
											.IN9(TOP_FAKE_LLH0),
											.IN4(TOP_I2),
											.IN5(TOP_IQ1),
											.IN6(TOP_I1),
											.IN7(TOP_IQ0),
											.IN0(TOP_H6W5),
											.IN1(TOP_IQ3),
											.IN2(TOP_I3),
											.IN3(TOP_IQ2),
											.OUT(TOP_H6E5),
											.IN10(TOP_S_BUF19),
											.IN11(TOP_S_BUF12),
											._1(1)
		);

		BUF1B0X2H5 buf_s20(
											.A(TOP_S20),
											.Y(TOP_S_BUF20)
		);

		BUF1B0X2H5 buf_s21(
											.A(TOP_S21),
											.Y(TOP_S_BUF21)
		);

		BUF1B0X2H5 buf_s22(
											.A(TOP_S22),
											.Y(TOP_S_BUF22)
		);

		BUF1B0X2H5 buf_s23(
											.A(TOP_S23),
											.Y(TOP_S_BUF23)
		);

		SPS4T5X11H1 sps_v6m1(
											.IN3(TOP_LLV3),
											.IN0(TOP_I0),
											.IN1(TOP_I1),
											.IN2(TOP_IQ3),
											.OUT(TOP_V6M1),
											._1(1)
		);

		BUF1B0X2H3 buf_v6c5_v6m4(
											.A(TOP_V6C5),
											.Y(TOP_V6M4)
		);

		SPS2N2X0H2 sps_s11(
											.IN0(TOP_I0),
											.IN1(TOP_H6E1),
											.OUT(TOP_S11),
											._1(1)
		);

		BUF1B0X2H3 buf_v6m1(
											.A(TOP_V6M1),
											.Y(TOP_V6M_BUF1)
		);

		BUF1B0X2H3 buf_v6m0(
											.A(TOP_V6M0),
											.Y(TOP_V6M_BUF0)
		);

		BUF1B0X2H3 buf_v6m3(
											.A(TOP_V6M3),
											.Y(TOP_V6M_BUF3)
		);

		BUF1B0X2H3 buf_v6m2(
											.A(TOP_V6M2),
											.Y(TOP_V6M_BUF2)
		);

		SPS16N6X0H2 sps_t1(
											.IN8(TOP_V6B_BUF0),
											.IN9(TOP_V6A_BUF0),
											.IN4(TOP_V6S_BUF0),
											.IN5(TOP_V6D_BUF0),
											.IN6(TOP_V6C_BUF0),
											.IN7(TOP_V6M_BUF0),
											.IN0(TOP_S_BUF3),
											.IN1(TOP_S_BUF2),
											.IN2(TOP_S_BUF1),
											.IN3(TOP_S_BUF0),
											.OUT(TOP_T1),
											.IN14(TOP_H6D_BUF0),
											.IN15(TOP_H6W_BUF0),
											.IN12(TOP_H6M_BUF0),
											.IN13(TOP_H6C_BUF0),
											.IN10(TOP_H6A_BUF0),
											.IN11(TOP_H6B_BUF0),
											._1(1)
		);

		SPS6B6X2H1 sps_v6d4(
											.IN4(TOP_H6E2),
											.IN5(TOP_V6B5),
											.IN0(TOP_IQ0),
											.IN1(TOP_I0),
											.IN2(TOP_H6W0),
											.IN3(TOP_H6M1),
											.OUT(TOP_V6D4),
											._1(1)
		);

		BUF1B0X2H3 buf_h6b2(
											.A(TOP_H6B2),
											.Y(TOP_H6B_BUF2)
		);

		BUF1B0X2H3 buf_h6b3(
											.A(TOP_H6B3),
											.Y(TOP_H6B_BUF3)
		);

		BUF1B0X2H3 buf_h6b0(
											.A(TOP_H6B0),
											.Y(TOP_H6B_BUF0)
		);

		BUF1B0X2H3 buf_h6b1(
											.A(TOP_H6B1),
											.Y(TOP_H6B_BUF1)
		);

		BUF1B0X2H3 buf_v6s9_v6a8(
											.A(TOP_V6S9),
											.Y(TOP_V6A8)
		);

		SPS4T5X11H1 sps_v6a0(
											.IN3(TOP_LLV5),
											.IN0(TOP_IQ0),
											.IN1(TOP_I2),
											.IN2(TOP_I3),
											.OUT(TOP_V6A0),
											._1(1)
		);

		SPS4T5X11H1 sps_v6a1(
											.IN3(TOP_LLV5),
											.IN0(TOP_IQ0),
											.IN1(TOP_IQ1),
											.IN2(TOP_IQ2),
											.OUT(TOP_V6A1),
											._1(1)
		);

		SPS4T5X11H1 sps_v6a2(
											.IN3(TOP_LLV11),
											.IN0(TOP_I0),
											.IN1(TOP_IQ2),
											.IN2(TOP_IQ3),
											.OUT(TOP_V6A2),
											._1(1)
		);

		SPS4T5X11H1 sps_v6a3(
											.IN3(TOP_LLV11),
											.IN0(TOP_I0),
											.IN1(TOP_I1),
											.IN2(TOP_I2),
											.OUT(TOP_V6A3),
											._1(1)
		);

		SPS2T2X11H2 sps_llv11(
											.IN0(TOP_I3),
											.IN1(TOP_H6A4),
											.OUT(TOP_LLV11),
											._1(1)
		);

		SPS2T2X11H2 sps_llv10(
											.IN0(TOP_IQ3),
											.IN1(TOP_H6B4),
											.OUT(TOP_LLV10),
											._1(1)
		);

		BUF1B0X2H5 buf_s19(
											.A(TOP_S19),
											.Y(TOP_S_BUF19)
		);

		BUF1B0X2H5 buf_s18(
											.A(TOP_S18),
											.Y(TOP_S_BUF18)
		);

		SPS2N2X0H2 sps_s18(
											.IN0(TOP_I1),
											.IN1(TOP_H6W3),
											.OUT(TOP_S18),
											._1(1)
		);

		SPS2N2X0H2 sps_s19(
											.IN0(TOP_I0),
											.IN1(TOP_H6M3),
											.OUT(TOP_S19),
											._1(1)
		);

		BUF1B0X2H5 buf_s15(
											.A(TOP_S15),
											.Y(TOP_S_BUF15)
		);

		BUF1B0X2H5 buf_s14(
											.A(TOP_S14),
											.Y(TOP_S_BUF14)
		);

		BUF1B0X2H5 buf_s17(
											.A(TOP_S17),
											.Y(TOP_S_BUF17)
		);

		BUF1B0X2H5 buf_s16(
											.A(TOP_S16),
											.Y(TOP_S_BUF16)
		);

		BUF1B0X2H5 buf_s11(
											.A(TOP_S11),
											.Y(TOP_S_BUF11)
		);

		BUF1B0X2H5 buf_s10(
											.A(TOP_S10),
											.Y(TOP_S_BUF10)
		);

		BUF1B0X2H5 buf_s13(
											.A(TOP_S13),
											.Y(TOP_S_BUF13)
		);

		BUF1B0X2H5 buf_s12(
											.A(TOP_S12),
											.Y(TOP_S_BUF12)
		);

		SPS2N2X0H2 sps_s4(
											.IN0(TOP_IQ3),
											.IN1(TOP_H6M0),
											.OUT(TOP_S4),
											._1(1)
		);

		SPS2N2X0H2 sps_s5(
											.IN0(TOP_IQ2),
											.IN1(TOP_H6E0),
											.OUT(TOP_S5),
											._1(1)
		);

		SPS2N2X0H2 sps_s6(
											.IN0(TOP_IQ1),
											.IN1(TOP_H6W1),
											.OUT(TOP_S6),
											._1(1)
		);

		SPS2N2X0H2 sps_s7(
											.IN0(TOP_IQ0),
											.IN1(TOP_H6M1),
											.OUT(TOP_S7),
											._1(1)
		);

		SPS2N2X0H2 sps_s0(
											.IN0(TOP_I3),
											.IN1(TOP_H6W0),
											.OUT(TOP_S0),
											._1(1)
		);

		SPS2N2X0H2 sps_s1(
											.IN0(TOP_I2),
											.IN1(TOP_H6M0),
											.OUT(TOP_S1),
											._1(1)
		);

		SPS2N2X0H2 sps_s2(
											.IN0(TOP_I1),
											.IN1(TOP_H6E0),
											.OUT(TOP_S2),
											._1(1)
		);

		SPS2N2X0H2 sps_s3(
											.IN0(TOP_I0),
											.IN1(TOP_H6W0),
											.OUT(TOP_S3),
											._1(1)
		);

		SPS2T2X11H2 sps_llv6(
											.IN0(TOP_IQ2),
											.IN1(TOP_H6W4),
											.OUT(TOP_LLV6),
											._1(1)
		);

		SPS2N2X0H2 sps_s8(
											.IN0(TOP_I3),
											.IN1(TOP_H6E1),
											.OUT(TOP_S8),
											._1(1)
		);

		SPS2N2X0H2 sps_s9(
											.IN0(TOP_I2),
											.IN1(TOP_H6W1),
											.OUT(TOP_S9),
											._1(1)
		);

		SPS6T7X11H1 sps_v6s2(
											.IN4(TOP_H6M1),
											.IN5(TOP_H6E3),
											.IN0(TOP_IQ0),
											.IN1(TOP_IQ1),
											.IN2(TOP_LLV6),
											.IN3(TOP_H6W2),
											.OUT(TOP_V6S2),
											._1(1)
		);

		SPS2T2X11H2 sps_llv9(
											.IN0(TOP_I2),
											.IN1(TOP_H6M4),
											.OUT(TOP_LLV9),
											._1(1)
		);

		SPS6T7X11H1 sps_v6s0(
											.IN4(TOP_H6M3),
											.IN5(TOP_H6E1),
											.IN0(TOP_I0),
											.IN1(TOP_I1),
											.IN2(TOP_LLV0),
											.IN3(TOP_H6W0),
											.OUT(TOP_V6S0),
											._1(1)
		);

		SPS6T7X11H1 sps_v6s1(
											.IN4(TOP_H6M0),
											.IN5(TOP_H6E2),
											.IN0(TOP_I2),
											.IN1(TOP_I3),
											.IN2(TOP_LLV0),
											.IN3(TOP_H6W1),
											.OUT(TOP_V6S1),
											._1(1)
		);

		SPS6B6X2H1 sps_v6s6(
											.IN4(TOP_H6W3),
											.IN5(TOP_V6A7),
											.IN0(TOP_IQ1),
											.IN1(TOP_I1),
											.IN2(TOP_H6E1),
											.IN3(TOP_H6M0),
											.OUT(TOP_V6S6),
											._1(1)
		);

		SPS16N6X0H2 sps_tce2(
											.IN8(TOP_V6B_BUF3),
											.IN9(TOP_V6A_BUF3),
											.IN4(TOP_V6S_BUF3),
											.IN5(TOP_V6D_BUF3),
											.IN6(TOP_V6C_BUF3),
											.IN7(TOP_V6M_BUF3),
											.IN0(TOP_S_BUF13),
											.IN1(TOP_S_BUF12),
											.IN2(TOP_S_BUF11),
											.IN3(TOP_S_BUF10),
											.OUT(TOP_TCE2),
											.IN14(TOP_H6D_BUF3),
											.IN15(TOP_H6W_BUF3),
											.IN12(TOP_H6M_BUF3),
											.IN13(TOP_H6C_BUF3),
											.IN10(TOP_H6A_BUF3),
											.IN11(TOP_H6B_BUF3),
											._1(1)
		);

		SPS16N6X0H2 sps_tce1(
											.IN8(TOP_V6B_BUF3),
											.IN9(TOP_V6A_BUF3),
											.IN4(TOP_V6S_BUF3),
											.IN5(TOP_V6D_BUF3),
											.IN6(TOP_V6C_BUF3),
											.IN7(TOP_V6M_BUF3),
											.IN0(TOP_S_BUF13),
											.IN1(TOP_S_BUF12),
											.IN2(TOP_S_BUF11),
											.IN3(TOP_S_BUF10),
											.OUT(TOP_TCE1),
											.IN14(TOP_H6D_BUF3),
											.IN15(TOP_H6W_BUF3),
											.IN12(TOP_H6M_BUF3),
											.IN13(TOP_H6C_BUF3),
											.IN10(TOP_H6A_BUF3),
											.IN11(TOP_H6B_BUF3),
											._1(1)
		);

		BUF1B0X2H3 buf_v6c9_v6m8(
											.A(TOP_V6C9),
											.Y(TOP_V6M8)
		);

		BUF1B0X2H3 buf_v6s3(
											.A(TOP_V6S3),
											.Y(TOP_V6S_BUF3)
		);

		BUF1B0X2H3 buf_v6s2(
											.A(TOP_V6S2),
											.Y(TOP_V6S_BUF2)
		);

		BUF1B0X2H3 buf_v6s1(
											.A(TOP_V6S1),
											.Y(TOP_V6S_BUF1)
		);

		BUF1B0X2H3 buf_v6s0(
											.A(TOP_V6S0),
											.Y(TOP_V6S_BUF0)
		);

		BUF1B0X2H3 buf_h6c1(
											.A(TOP_H6C1),
											.Y(TOP_H6C_BUF1)
		);

		BUF1B0X2H3 buf_h6c0(
											.A(TOP_H6C0),
											.Y(TOP_H6C_BUF0)
		);

		BUF1B0X2H3 buf_h6c3(
											.A(TOP_H6C3),
											.Y(TOP_H6C_BUF3)
		);

		BUF1B0X2H3 buf_h6c2(
											.A(TOP_H6C2),
											.Y(TOP_H6C_BUF2)
		);

		BUF1B0X2H3 buf_v6d11_v6b10(
											.A(TOP_V6D11),
											.Y(TOP_V6B10)
		);

		BUF1B0X2H3 buf_v6b0(
											.A(TOP_V6B0),
											.Y(TOP_V6B_BUF0)
		);

		BUF1B0X2H3 buf_v6b1(
											.A(TOP_V6B1),
											.Y(TOP_V6B_BUF1)
		);

		BUF1B0X2H3 buf_v6b2(
											.A(TOP_V6B2),
											.Y(TOP_V6B_BUF2)
		);

		BUF1B0X2H3 buf_v6b3(
											.A(TOP_V6B3),
											.Y(TOP_V6B_BUF3)
		);

		SPS2N2X0H2 sps_s12(
											.IN0(TOP_IQ3),
											.IN1(TOP_H6W2),
											.OUT(TOP_S12),
											._1(1)
		);

		SPS16N6X0H2 sps_oce2(
											.IN8(TOP_V6B_BUF3),
											.IN9(TOP_V6A_BUF3),
											.IN4(TOP_V6S_BUF3),
											.IN5(TOP_V6D_BUF3),
											.IN6(TOP_V6C_BUF3),
											.IN7(TOP_V6M_BUF3),
											.IN0(TOP_S_BUF19),
											.IN1(TOP_S_BUF18),
											.IN2(TOP_S_BUF17),
											.IN3(TOP_S_BUF16),
											.OUT(TOP_OCE2),
											.IN14(TOP_H6D_BUF3),
											.IN15(TOP_H6W_BUF3),
											.IN12(TOP_H6M_BUF3),
											.IN13(TOP_H6C_BUF3),
											.IN10(TOP_H6A_BUF3),
											.IN11(TOP_H6B_BUF3),
											._1(1)
		);

		SPS16N6X0H2 sps_oce1(
											.IN8(TOP_V6B_BUF3),
											.IN9(TOP_V6A_BUF3),
											.IN4(TOP_V6S_BUF3),
											.IN5(TOP_V6D_BUF3),
											.IN6(TOP_V6C_BUF3),
											.IN7(TOP_V6M_BUF3),
											.IN0(TOP_S_BUF19),
											.IN1(TOP_S_BUF18),
											.IN2(TOP_S_BUF17),
											.IN3(TOP_S_BUF16),
											.OUT(TOP_OCE1),
											.IN14(TOP_H6D_BUF3),
											.IN15(TOP_H6W_BUF3),
											.IN12(TOP_H6M_BUF3),
											.IN13(TOP_H6C_BUF3),
											.IN10(TOP_H6A_BUF3),
											.IN11(TOP_H6B_BUF3),
											._1(1)
		);

		BUF1B0X2H3 buf_v6d7_v6b6(
											.A(TOP_V6D7),
											.Y(TOP_V6B6)
		);

		SPS4T5X11H1 sps_v6c1(
											.IN3(TOP_LLV2),
											.IN0(TOP_I0),
											.IN1(TOP_I1),
											.IN2(TOP_IQ3),
											.OUT(TOP_V6C1),
											._1(1)
		);

		SPS16T10X11H1 sps_llh6(
											.IN8(TOP_S_BUF23),
											.IN9(TOP_S_BUF22),
											.IN4(TOP_IQ2),
											.IN5(TOP_I2),
											.IN6(TOP_IQ3),
											.IN7(TOP_I3),
											.IN0(TOP_IQ0),
											.IN1(TOP_I0),
											.IN2(TOP_IQ1),
											.IN3(TOP_I1),
											.OUT(TOP_LLH6),
											.IN14(TOP_S_BUF6),
											.IN15(TOP_S_BUF5),
											.IN12(TOP_S_BUF11),
											.IN13(TOP_S_BUF10),
											.IN10(TOP_S_BUF18),
											.IN11(TOP_S_BUF17),
											._1(1)
		);

		SPS16T10X11H1 sps_llh0(
											.IN8(TOP_S_BUF23),
											.IN9(TOP_S_BUF22),
											.IN4(TOP_IQ2),
											.IN5(TOP_I2),
											.IN6(TOP_IQ3),
											.IN7(TOP_I3),
											.IN0(TOP_IQ0),
											.IN1(TOP_I0),
											.IN2(TOP_IQ1),
											.IN3(TOP_I1),
											.OUT(TOP_LLH0),
											.IN14(TOP_S_BUF6),
											.IN15(TOP_S_BUF5),
											.IN12(TOP_S_BUF11),
											.IN13(TOP_S_BUF10),
											.IN10(TOP_S_BUF18),
											.IN11(TOP_S_BUF17),
											._1(1)
		);

		BUF1B0X2H3 buf_v6d5_v6b4(
											.A(TOP_V6D5),
											.Y(TOP_V6B4)
		);

		SPS2N2X0H2 sps_s17(
											.IN0(TOP_I2),
											.IN1(TOP_H6E2),
											.OUT(TOP_S17),
											._1(1)
		);

		SPS4T5X11H1 sps_v6b1(
											.IN3(TOP_LLV4),
											.IN0(TOP_IQ0),
											.IN1(TOP_IQ1),
											.IN2(TOP_IQ2),
											.OUT(TOP_V6B1),
											._1(1)
		);

		BUF1B0X2H5 buf_s1(
											.A(TOP_S1),
											.Y(TOP_S_BUF1)
		);

		SPS4T5X11H1 sps_v6b0(
											.IN3(TOP_LLV4),
											.IN0(TOP_IQ0),
											.IN1(TOP_I2),
											.IN2(TOP_I3),
											.OUT(TOP_V6B0),
											._1(1)
		);

		BUF1B0X2H5 buf_s9(
											.A(TOP_S9),
											.Y(TOP_S_BUF9)
		);

		BUF1B0X2H5 buf_s8(
											.A(TOP_S8),
											.Y(TOP_S_BUF8)
		);

		SPS4T5X11H1 sps_v6c0(
											.IN3(TOP_LLV2),
											.IN0(TOP_IQ1),
											.IN1(TOP_IQ2),
											.IN2(TOP_IQ3),
											.OUT(TOP_V6C0),
											._1(1)
		);

		BUF1B0X2H3 buf_v6m9_v6c8(
											.A(TOP_V6M9),
											.Y(TOP_V6C8)
		);

		BUF1B0X2H3 buf_v6c3(
											.A(TOP_V6C3),
											.Y(TOP_V6C_BUF3)
		);

		BUF1B0X2H3 buf_v6c2(
											.A(TOP_V6C2),
											.Y(TOP_V6C_BUF2)
		);

		BUF1B0X2H5 buf_s3(
											.A(TOP_S3),
											.Y(TOP_S_BUF3)
		);

		BUF1B0X2H5 buf_s2(
											.A(TOP_S2),
											.Y(TOP_S_BUF2)
		);

		BUF1B0X2H5 buf_s5(
											.A(TOP_S5),
											.Y(TOP_S_BUF5)
		);

		BUF1B0X2H5 buf_s4(
											.A(TOP_S4),
											.Y(TOP_S_BUF4)
		);

		BUF1B0X2H5 buf_s7(
											.A(TOP_S7),
											.Y(TOP_S_BUF7)
		);

		BUF1B0X2H5 buf_s6(
											.A(TOP_S6),
											.Y(TOP_S_BUF6)
		);

		SPS2N2X0H2 sps_s10(
											.IN0(TOP_I1),
											.IN1(TOP_H6M1),
											.OUT(TOP_S10),
											._1(1)
		);

		BUF1B0X2H5 buf_s0(
											.A(TOP_S0),
											.Y(TOP_S_BUF0)
		);

		SPS4T5X11H1 sps_v6m0(
											.IN3(TOP_LLV3),
											.IN0(TOP_IQ1),
											.IN1(TOP_IQ2),
											.IN2(TOP_IQ3),
											.OUT(TOP_V6M0),
											._1(1)
		);

		SPS6B6X2H1 sps_v6d6(
											.IN4(TOP_H6W3),
											.IN5(TOP_V6B7),
											.IN0(TOP_IQ1),
											.IN1(TOP_I1),
											.IN2(TOP_H6E1),
											.IN3(TOP_H6M0),
											.OUT(TOP_V6D6),
											._1(1)
		);

		SPS4T5X11H1 sps_v6m2(
											.IN3(TOP_LLV9),
											.IN0(TOP_I1),
											.IN1(TOP_I2),
											.IN2(TOP_I3),
											.OUT(TOP_V6M2),
											._1(1)
		);

		SPS4T5X11H1 sps_v6m3(
											.IN3(TOP_LLV9),
											.IN0(TOP_IQ0),
											.IN1(TOP_IQ1),
											.IN2(TOP_I3),
											.OUT(TOP_V6M3),
											._1(1)
		);

		BUF1B0X2H3 buf_h6m3(
											.A(TOP_H6M3),
											.Y(TOP_H6M_BUF3)
		);

		BUF1B0X2H3 buf_h6m2(
											.A(TOP_H6M2),
											.Y(TOP_H6M_BUF2)
		);

		BUF1B0X2H3 buf_h6m1(
											.A(TOP_H6M1),
											.Y(TOP_H6M_BUF1)
		);

		BUF1B0X2H3 buf_h6m0(
											.A(TOP_H6M0),
											.Y(TOP_H6M_BUF0)
		);

		SPS16N6X0H2 sps_sr_b1(
											.IN8(TOP_V6B_BUF1),
											.IN9(TOP_V6A_BUF1),
											.IN4(TOP_V6S_BUF1),
											.IN5(TOP_V6D_BUF1),
											.IN6(TOP_V6C_BUF1),
											.IN7(TOP_V6M_BUF1),
											.IN0(TOP_S_BUF7),
											.IN1(TOP_S_BUF6),
											.IN2(TOP_S_BUF5),
											.IN3(TOP_S_BUF4),
											.OUT(TOP_SR_B1),
											.IN14(TOP_H6D_BUF1),
											.IN15(TOP_H6W_BUF1),
											.IN12(TOP_H6M_BUF1),
											.IN13(TOP_H6C_BUF1),
											.IN10(TOP_H6A_BUF1),
											.IN11(TOP_H6B_BUF1),
											._1(1)
		);

		BUF1B0X2H3 buf_llh0(
											.A(TOP_LLH0),
											.Y(TOP_FAKE_LLH0)
		);

		BUF1B0X2H3 buf_llh6(
											.A(TOP_LLH6),
											.Y(TOP_FAKE_LLH6)
		);

		SPS16N6X0H2 sps_sr_b2(
											.IN8(TOP_V6B_BUF1),
											.IN9(TOP_V6A_BUF1),
											.IN4(TOP_V6S_BUF1),
											.IN5(TOP_V6D_BUF1),
											.IN6(TOP_V6C_BUF1),
											.IN7(TOP_V6M_BUF1),
											.IN0(TOP_S_BUF7),
											.IN1(TOP_S_BUF6),
											.IN2(TOP_S_BUF5),
											.IN3(TOP_S_BUF4),
											.OUT(TOP_SR_B2),
											.IN14(TOP_H6D_BUF1),
											.IN15(TOP_H6W_BUF1),
											.IN12(TOP_H6M_BUF1),
											.IN13(TOP_H6C_BUF1),
											.IN10(TOP_H6A_BUF1),
											.IN11(TOP_H6B_BUF1),
											._1(1)
		);

		SPS4T5X11H1 sps_v6b3(
											.IN3(TOP_LLV10),
											.IN0(TOP_I0),
											.IN1(TOP_I1),
											.IN2(TOP_I2),
											.OUT(TOP_V6B3),
											._1(1)
		);

		SPS4T5X11H1 sps_v6b2(
											.IN3(TOP_LLV10),
											.IN0(TOP_I0),
											.IN1(TOP_IQ2),
											.IN2(TOP_IQ3),
											.OUT(TOP_V6B2),
											._1(1)
		);

		BUF1B0X2H3 buf_v6c7_v6m6(
											.A(TOP_V6C7),
											.Y(TOP_V6M6)
		);

		BUF1B0X2H3 buf_v6m7_v6c6(
											.A(TOP_V6M7),
											.Y(TOP_V6C6)
		);

		SPS2T2X11H2 sps_llv8(
											.IN0(TOP_I2),
											.IN1(TOP_H6C4),
											.OUT(TOP_LLV8),
											._1(1)
		);

		SPS4T5X11H1 sps_v6c2(
											.IN3(TOP_LLV8),
											.IN0(TOP_I1),
											.IN1(TOP_I2),
											.IN2(TOP_I3),
											.OUT(TOP_V6C2),
											._1(1)
		);

		BUF1B0X2H3 buf_v6m5_v6c4(
											.A(TOP_V6M5),
											.Y(TOP_V6C4)
		);

		SPS4T5X11H1 sps_v6c3(
											.IN3(TOP_LLV8),
											.IN0(TOP_IQ0),
											.IN1(TOP_IQ1),
											.IN2(TOP_I3),
											.OUT(TOP_V6C3),
											._1(1)
		);

		SPS2N2X0H2 sps_s13(
											.IN0(TOP_IQ2),
											.IN1(TOP_H6M2),
											.OUT(TOP_S13),
											._1(1)
		);

		BUF1B0X2H3 buf_v6s11_v6a10(
											.A(TOP_V6S11),
											.Y(TOP_V6A10)
		);

		BUF1B0X2H3 buf_h6w1(
											.A(TOP_H6W1),
											.Y(TOP_H6W_BUF1)
		);

		BUF1B0X2H3 buf_h6w0(
											.A(TOP_H6W0),
											.Y(TOP_H6W_BUF0)
		);

		BUF1B0X2H3 buf_h6w3(
											.A(TOP_H6W3),
											.Y(TOP_H6W_BUF3)
		);

		BUF1B0X2H3 buf_h6w2(
											.A(TOP_H6W2),
											.Y(TOP_H6W_BUF2)
		);

		BUFDUMMY buf_gclk0(
											.OUT(TOP_GCLK0),
											.IN(TOP_HGCLK0)
		);

		BUFDUMMY buf_gclk1(
											.OUT(TOP_GCLK1),
											.IN(TOP_HGCLK1)
		);

		BUFDUMMY buf_gclk2(
											.OUT(TOP_GCLK2),
											.IN(TOP_HGCLK2)
		);

		BUFDUMMY buf_gclk3(
											.OUT(TOP_GCLK3),
											.IN(TOP_HGCLK3)
		);

		BUF1B0X2H3 buf_v6m11_v6c10(
											.A(TOP_V6M11),
											.Y(TOP_V6C10)
		);

		BUF1B0X2H3 buf_v6a1(
											.A(TOP_V6A1),
											.Y(TOP_V6A_BUF1)
		);

		BUF1B0X2H3 buf_v6a0(
											.A(TOP_V6A0),
											.Y(TOP_V6A_BUF0)
		);

		BUF1B0X2H3 buf_v6a3(
											.A(TOP_V6A3),
											.Y(TOP_V6A_BUF3)
		);

		BUF1B0X2H3 buf_v6a2(
											.A(TOP_V6A2),
											.Y(TOP_V6A_BUF2)
		);

		SPS6T7X11H1 sps_v6s3(
											.IN4(TOP_H6M2),
											.IN5(TOP_H6E0),
											.IN0(TOP_IQ2),
											.IN1(TOP_IQ3),
											.IN2(TOP_LLV6),
											.IN3(TOP_H6W3),
											.OUT(TOP_V6S3),
											._1(1)
		);

		BUF1B0X2H3 buf_h6d0(
											.A(TOP_H6D0),
											.Y(TOP_H6D_BUF0)
		);

		BUF1B0X2H3 buf_h6d1(
											.A(TOP_H6D1),
											.Y(TOP_H6D_BUF1)
		);

		BUF1B0X2H3 buf_h6d2(
											.A(TOP_H6D2),
											.Y(TOP_H6D_BUF2)
		);

		BUF1B0X2H3 buf_v6c1(
											.A(TOP_V6C1),
											.Y(TOP_V6C_BUF1)
		);

		SPS12T8X11H2 sps_h6w4(
											.IN8(TOP_I0),
											.IN9(TOP_FAKE_LLH0),
											.IN4(TOP_I2),
											.IN5(TOP_IQ1),
											.IN6(TOP_I1),
											.IN7(TOP_IQ0),
											.IN0(TOP_H6E4),
											.IN1(TOP_IQ3),
											.IN2(TOP_I3),
											.IN3(TOP_IQ2),
											.OUT(TOP_H6W4),
											.IN10(TOP_S_BUF19),
											.IN11(TOP_S_BUF12),
											._1(1)
		);

		SPS12T8X11H2 sps_h6w5(
											.IN8(TOP_I0),
											.IN9(TOP_FAKE_LLH6),
											.IN4(TOP_I2),
											.IN5(TOP_IQ1),
											.IN6(TOP_I1),
											.IN7(TOP_IQ0),
											.IN0(TOP_H6E5),
											.IN1(TOP_IQ3),
											.IN2(TOP_I3),
											.IN3(TOP_IQ2),
											.OUT(TOP_H6W5),
											.IN10(TOP_S_BUF7),
											.IN11(TOP_S_BUF0),
											._1(1)
		);

		BUF1B0X2H3 buf_v6c0(
											.A(TOP_V6C0),
											.Y(TOP_V6C_BUF0)
		);

		SPS12T8X11H1 sps_h6w0(
											.IN8(TOP_I0),
											.IN9(TOP_FAKE_LLH0),
											.IN4(TOP_I2),
											.IN5(TOP_IQ1),
											.IN6(TOP_I1),
											.IN7(TOP_IQ0),
											.IN0(TOP_H6E0),
											.IN1(TOP_IQ3),
											.IN2(TOP_I3),
											.IN3(TOP_IQ2),
											.OUT(TOP_H6W0),
											.IN10(TOP_V6M2),
											.IN11(TOP_V6S0),
											._1(1)
		);

		SPS12T8X11H1 sps_h6w1(
											.IN8(TOP_I0),
											.IN9(TOP_FAKE_LLH0),
											.IN4(TOP_I2),
											.IN5(TOP_IQ1),
											.IN6(TOP_I1),
											.IN7(TOP_IQ0),
											.IN0(TOP_H6E1),
											.IN1(TOP_IQ3),
											.IN2(TOP_I3),
											.IN3(TOP_IQ2),
											.OUT(TOP_H6W1),
											.IN10(TOP_V6M3),
											.IN11(TOP_V6S1),
											._1(1)
		);

		SPS12T8X11H1 sps_h6w2(
											.IN8(TOP_I0),
											.IN9(TOP_FAKE_LLH6),
											.IN4(TOP_I2),
											.IN5(TOP_IQ1),
											.IN6(TOP_I1),
											.IN7(TOP_IQ0),
											.IN0(TOP_H6E2),
											.IN1(TOP_IQ3),
											.IN2(TOP_I3),
											.IN3(TOP_IQ2),
											.OUT(TOP_H6W2),
											.IN10(TOP_V6M0),
											.IN11(TOP_V6S2),
											._1(1)
		);

		SPS12T8X11H1 sps_h6w3(
											.IN8(TOP_I0),
											.IN9(TOP_FAKE_LLH6),
											.IN4(TOP_I2),
											.IN5(TOP_IQ1),
											.IN6(TOP_I1),
											.IN7(TOP_IQ0),
											.IN0(TOP_H6E3),
											.IN1(TOP_IQ3),
											.IN2(TOP_I3),
											.IN3(TOP_IQ2),
											.OUT(TOP_H6W3),
											.IN10(TOP_V6M1),
											.IN11(TOP_V6S3),
											._1(1)
		);

		SPS6B6X2H1 sps_v6d10(
											.IN4(TOP_H6E3),
											.IN5(TOP_V6B11),
											.IN0(TOP_IQ3),
											.IN1(TOP_I3),
											.IN2(TOP_H6W1),
											.IN3(TOP_H6M2),
											.OUT(TOP_V6D10),
											._1(1)
		);

		BUF1B0X2H3 buf_h6d3(
											.A(TOP_H6D3),
											.Y(TOP_H6D_BUF3)
		);

		SPS2N2X0H2 sps_s16(
											.IN0(TOP_I3),
											.IN1(TOP_H6M2),
											.OUT(TOP_S16),
											._1(1)
		);

		SPS6B6X2H1 sps_v6s8(
											.IN4(TOP_H6E0),
											.IN5(TOP_V6A9),
											.IN0(TOP_IQ2),
											.IN1(TOP_I2),
											.IN2(TOP_H6W2),
											.IN3(TOP_H6M3),
											.OUT(TOP_V6S8),
											._1(1)
		);

		BUF1B0X2H3 buf_v6s7_v6a6(
											.A(TOP_V6S7),
											.Y(TOP_V6A6)
		);

		BUF1B0X2H3 buf_v6s5_v6a4(
											.A(TOP_V6S5),
											.Y(TOP_V6A4)
		);

		SPS4T5X11H1 sps_v6d3(
											.IN3(TOP_LLV7),
											.IN0(TOP_IQ2),
											.IN1(TOP_IQ3),
											.IN2(TOP_I2),
											.OUT(TOP_V6D3),
											._1(1)
		);

		SPS4T5X11H1 sps_v6d2(
											.IN3(TOP_LLV7),
											.IN0(TOP_IQ0),
											.IN1(TOP_IQ1),
											.IN2(TOP_I3),
											.OUT(TOP_V6D2),
											._1(1)
		);

		SPS4T5X11H1 sps_v6d1(
											.IN3(TOP_LLV1),
											.IN0(TOP_I2),
											.IN1(TOP_I3),
											.IN2(TOP_IQ0),
											.OUT(TOP_V6D1),
											._1(1)
		);

		SPS4T5X11H1 sps_v6d0(
											.IN3(TOP_LLV1),
											.IN0(TOP_I0),
											.IN1(TOP_I1),
											.IN2(TOP_IQ1),
											.OUT(TOP_V6D0),
											._1(1)
		);

		SPS2N2X0H2 sps_s23(
											.IN0(TOP_IQ0),
											.IN1(TOP_H6E3),
											.OUT(TOP_S23),
											._1(1)
		);

		SPS2N2X0H2 sps_s22(
											.IN0(TOP_IQ1),
											.IN1(TOP_H6M3),
											.OUT(TOP_S22),
											._1(1)
		);

		SPS2N2X0H2 sps_s21(
											.IN0(TOP_IQ2),
											.IN1(TOP_H6W3),
											.OUT(TOP_S21),
											._1(1)
		);

		SPS2N2X0H2 sps_s20(
											.IN0(TOP_IQ3),
											.IN1(TOP_H6E3),
											.OUT(TOP_S20),
											._1(1)
		);

		SPS20N8X0H1 sps_clk2(
											.IN8(TOP_V6B_BUF2),
											.IN9(TOP_V6A_BUF2),
											.IN4(TOP_V6S_BUF2),
											.IN5(TOP_V6D_BUF2),
											.IN6(TOP_V6C_BUF2),
											.IN7(TOP_V6M_BUF2),
											.IN0(TOP_S_BUF15),
											.IN1(TOP_S_BUF14),
											.IN2(TOP_S_BUF9),
											.IN3(TOP_S_BUF8),
											.OUT(TOP_CLK2),
											.IN18(TOP_GCLK2),
											.IN19(TOP_GCLK3),
											.IN16(TOP_GCLK0),
											.IN17(TOP_GCLK1),
											.IN14(TOP_H6D_BUF2),
											.IN15(TOP_H6W_BUF2),
											.IN12(TOP_H6M_BUF2),
											.IN13(TOP_H6C_BUF2),
											.IN10(TOP_H6A_BUF2),
											.IN11(TOP_H6B_BUF2),
											._1(1)
		);

		SPS20N8X0H1 sps_clk1(
											.IN8(TOP_V6B_BUF2),
											.IN9(TOP_V6A_BUF2),
											.IN4(TOP_V6S_BUF2),
											.IN5(TOP_V6D_BUF2),
											.IN6(TOP_V6C_BUF2),
											.IN7(TOP_V6M_BUF2),
											.IN0(TOP_S_BUF15),
											.IN1(TOP_S_BUF14),
											.IN2(TOP_S_BUF9),
											.IN3(TOP_S_BUF8),
											.OUT(TOP_CLK1),
											.IN18(TOP_GCLK2),
											.IN19(TOP_GCLK3),
											.IN16(TOP_GCLK0),
											.IN17(TOP_GCLK1),
											.IN14(TOP_H6D_BUF2),
											.IN15(TOP_H6W_BUF2),
											.IN12(TOP_H6M_BUF2),
											.IN13(TOP_H6C_BUF2),
											.IN10(TOP_H6A_BUF2),
											.IN11(TOP_H6B_BUF2),
											._1(1)
		);

		SPS6B6X2H1 sps_v6d8(
											.IN4(TOP_H6E0),
											.IN5(TOP_V6B9),
											.IN0(TOP_IQ2),
											.IN1(TOP_I2),
											.IN2(TOP_H6W2),
											.IN3(TOP_H6M3),
											.OUT(TOP_V6D8),
											._1(1)
		);

		SPS6B6X2H1 sps_v6s4(
											.IN4(TOP_H6E2),
											.IN5(TOP_V6A5),
											.IN0(TOP_IQ0),
											.IN1(TOP_I0),
											.IN2(TOP_H6W0),
											.IN3(TOP_H6M1),
											.OUT(TOP_V6S4),
											._1(1)
		);

		SPS2N2X0H2 sps_s14(
											.IN0(TOP_IQ1),
											.IN1(TOP_H6E2),
											.OUT(TOP_S14),
											._1(1)
		);

		SPS16N6X0H2 sps_o1(
											.IN8(TOP_S_BUF3),
											.IN9(TOP_S_BUF2),
											.IN4(TOP_S_BUF7),
											.IN5(TOP_S_BUF6),
											.IN6(TOP_S_BUF5),
											.IN7(TOP_S_BUF4),
											.IN0(TOP_S_BUF11),
											.IN1(TOP_S_BUF10),
											.IN2(TOP_S_BUF9),
											.IN3(TOP_S_BUF8),
											.OUT(TOP_O1),
											.IN14(TOP_V6C_BUF1),
											.IN15(TOP_V6M_BUF1),
											.IN12(TOP_V6S_BUF1),
											.IN13(TOP_V6D_BUF1),
											.IN10(TOP_S_BUF1),
											.IN11(TOP_S_BUF0),
											._1(1)
		);

		SPS16N6X0H2 sps_o2(
											.IN8(TOP_S_BUF15),
											.IN9(TOP_S_BUF14),
											.IN4(TOP_S_BUF19),
											.IN5(TOP_S_BUF18),
											.IN6(TOP_S_BUF17),
											.IN7(TOP_S_BUF16),
											.IN0(TOP_S_BUF23),
											.IN1(TOP_S_BUF22),
											.IN2(TOP_S_BUF21),
											.IN3(TOP_S_BUF20),
											.OUT(TOP_O2),
											.IN14(TOP_V6C_BUF2),
											.IN15(TOP_V6M_BUF2),
											.IN12(TOP_V6S_BUF2),
											.IN13(TOP_V6D_BUF2),
											.IN10(TOP_S_BUF13),
											.IN11(TOP_S_BUF12),
											._1(1)
		);

		BUF1B0X2H3 buf_v6c11_v6m10(
											.A(TOP_V6C11),
											.Y(TOP_V6M10)
		);

		SPS6B6X2H1 sps_v6s10(
											.IN4(TOP_H6E3),
											.IN5(TOP_V6A11),
											.IN0(TOP_IQ3),
											.IN1(TOP_I3),
											.IN2(TOP_H6W1),
											.IN3(TOP_H6M2),
											.OUT(TOP_V6S10),
											._1(1)
		);

		SPS2N2X0H2 sps_s15(
											.IN0(TOP_IQ0),
											.IN1(TOP_H6W2),
											.OUT(TOP_S15),
											._1(1)
		);

		BUF1B0X2H3 buf_v6d9_v6b8(
											.A(TOP_V6D9),
											.Y(TOP_V6B8)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_UR(
UR_H6W0, UR_H6D0, UR_H6C0, UR_H6M0, UR_H6B0, UR_H6A0, UR_H6W1, UR_H6D1, UR_H6C1, UR_H6M1, UR_H6B1, UR_H6A1, UR_H6W2, UR_H6D2, UR_H6C2, UR_H6M2, UR_H6B2, UR_H6A2, UR_H6W3, UR_H6D3, UR_H6C3, UR_H6M3, UR_H6B3, UR_H6A3, UR_H6W4, UR_H6D4, UR_H6C4, UR_H6M4, UR_H6B4, UR_H6A4, UR_H6W5, UR_H6D5, UR_H6C5, UR_H6M5, UR_H6B5, UR_H6A5, UR_LLH0, UR_LLH1, UR_LLH2, UR_LLH3, UR_LLH4, UR_LLH5, UR_LLH6, UR_LLH7, UR_LLH8, UR_LLH9, UR_LLH10, UR_LLH11, UR_V6S0, UR_V6D0, UR_V6C0, UR_V6M0, UR_V6B0, UR_V6A0, UR_V6S1, UR_V6D1, UR_V6C1, UR_V6M1, UR_V6B1, UR_V6A1, UR_V6S2, UR_V6D2, UR_V6C2, UR_V6M2, UR_V6B2, UR_V6A2, UR_V6S3, UR_V6D3, UR_V6C3, UR_V6M3, UR_V6B3, UR_V6A3, UR_LLV0, UR_LLV1, UR_LLV2, UR_LLV3, UR_LLV4, UR_LLV5, UR_LLV6, UR_LLV7, UR_LLV8, UR_LLV9, UR_LLV10, UR_LLV11, _1
);
inout	UR_H6W0;
inout	UR_H6D0;
inout	UR_H6C0;
inout	UR_H6M0;
inout	UR_H6B0;
inout	UR_H6A0;
inout	UR_H6W1;
inout	UR_H6D1;
inout	UR_H6C1;
inout	UR_H6M1;
inout	UR_H6B1;
inout	UR_H6A1;
inout	UR_H6W2;
inout	UR_H6D2;
inout	UR_H6C2;
inout	UR_H6M2;
inout	UR_H6B2;
inout	UR_H6A2;
inout	UR_H6W3;
inout	UR_H6D3;
inout	UR_H6C3;
inout	UR_H6M3;
inout	UR_H6B3;
inout	UR_H6A3;
inout	UR_H6W4;
inout	UR_H6D4;
inout	UR_H6C4;
inout	UR_H6M4;
inout	UR_H6B4;
inout	UR_H6A4;
inout	UR_H6W5;
inout	UR_H6D5;
inout	UR_H6C5;
inout	UR_H6M5;
inout	UR_H6B5;
inout	UR_H6A5;
inout	UR_LLH0;
inout	UR_LLH1;
inout	UR_LLH2;
inout	UR_LLH3;
inout	UR_LLH4;
inout	UR_LLH5;
inout	UR_LLH6;
inout	UR_LLH7;
inout	UR_LLH8;
inout	UR_LLH9;
inout	UR_LLH10;
inout	UR_LLH11;
inout	UR_V6S0;
inout	UR_V6D0;
inout	UR_V6C0;
inout	UR_V6M0;
inout	UR_V6B0;
inout	UR_V6A0;
inout	UR_V6S1;
inout	UR_V6D1;
inout	UR_V6C1;
inout	UR_V6M1;
inout	UR_V6B1;
inout	UR_V6A1;
inout	UR_V6S2;
inout	UR_V6D2;
inout	UR_V6C2;
inout	UR_V6M2;
inout	UR_V6B2;
inout	UR_V6A2;
inout	UR_V6S3;
inout	UR_V6D3;
inout	UR_V6C3;
inout	UR_V6M3;
inout	UR_V6B3;
inout	UR_V6A3;
inout	UR_LLV0;
inout	UR_LLV1;
inout	UR_LLV2;
inout	UR_LLV3;
inout	UR_LLV4;
inout	UR_LLV5;
inout	UR_LLV6;
inout	UR_LLV7;
inout	UR_LLV8;
inout	UR_LLV9;
inout	UR_LLV10;
inout	UR_LLV11;
inout	_1;

		SPS2T2X7H1 sps_h6w4(
											.IN0(UR_LLH6),
											.IN1(UR_LLH0),
											.OUT(UR_H6W4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6w5(
											.IN0(UR_LLH6),
											.IN1(UR_LLH0),
											.OUT(UR_H6W5),
											._1(1)
		);

		SPS2T2X7H1 sps_h6w0(
											.IN0(UR_LLH0),
											.IN1(UR_V6A0),
											.OUT(UR_H6W0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6a3(
											.IN0(UR_LLH11),
											.IN1(UR_V6S3),
											.OUT(UR_H6A3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6w2(
											.IN0(UR_LLH6),
											.IN1(UR_V6A2),
											.OUT(UR_H6W2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6w3(
											.IN0(UR_LLH6),
											.IN1(UR_V6A3),
											.OUT(UR_H6W3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6m0(
											.IN0(UR_LLV3),
											.IN1(UR_H6C0),
											.OUT(UR_V6M0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6a0(
											.IN0(UR_LLV5),
											.IN1(UR_H6W0),
											.OUT(UR_V6A0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6m2(
											.IN0(UR_LLV9),
											.IN1(UR_H6C2),
											.OUT(UR_V6M2),
											._1(1)
		);

		SPS1T1X7H1 sps_llv6(
											.OUT(UR_LLV6),
											.IN(UR_H6W4)
		);

		SPS2T2X7H1 sps_v6a1(
											.IN0(UR_LLV5),
											.IN1(UR_H6W1),
											.OUT(UR_V6A1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m2(
											.IN0(UR_LLH9),
											.IN1(UR_V6C2),
											.OUT(UR_H6M2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m3(
											.IN0(UR_LLH9),
											.IN1(UR_V6C3),
											.OUT(UR_H6M3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m0(
											.IN0(UR_LLH3),
											.IN1(UR_V6C0),
											.OUT(UR_H6M0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m1(
											.IN0(UR_LLH3),
											.IN1(UR_V6C1),
											.OUT(UR_H6M1),
											._1(1)
		);

		SPS1T1X7H1 sps_llv5(
											.OUT(UR_LLV5),
											.IN(UR_H6A5)
		);

		SPS1T1X7H1 sps_llv4(
											.OUT(UR_LLV4),
											.IN(UR_H6B5)
		);

		SPS2T2X7H1 sps_h6m4(
											.IN0(UR_LLH9),
											.IN1(UR_LLH3),
											.OUT(UR_H6M4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6m5(
											.IN0(UR_LLH9),
											.IN1(UR_LLH3),
											.OUT(UR_H6M5),
											._1(1)
		);

		SPS1T1X7H1 sps_llv9(
											.OUT(UR_LLV9),
											.IN(UR_H6M4)
		);

		SPS1T1X7H1 sps_llv8(
											.OUT(UR_LLV8),
											.IN(UR_H6C4)
		);

		SPS2T2X7H1 sps_v6a3(
											.IN0(UR_LLV11),
											.IN1(UR_H6W3),
											.OUT(UR_V6A3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6w1(
											.IN0(UR_LLH0),
											.IN1(UR_V6A1),
											.OUT(UR_H6W1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6b1(
											.IN0(UR_LLV4),
											.IN1(UR_H6D1),
											.OUT(UR_V6B1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6b0(
											.IN0(UR_LLV4),
											.IN1(UR_H6D0),
											.OUT(UR_V6B0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6b3(
											.IN0(UR_LLV10),
											.IN1(UR_H6D3),
											.OUT(UR_V6B3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6b2(
											.IN0(UR_LLV10),
											.IN1(UR_H6D2),
											.OUT(UR_V6B2),
											._1(1)
		);

		SPS2T2X7H1 sps_v6s3(
											.IN0(UR_LLV6),
											.IN1(UR_H6A3),
											.OUT(UR_V6S3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6d3(
											.IN0(UR_LLV7),
											.IN1(UR_H6B3),
											.OUT(UR_V6D3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6d2(
											.IN0(UR_LLV7),
											.IN1(UR_H6B2),
											.OUT(UR_V6D2),
											._1(1)
		);

		SPS2T2X7H1 sps_v6d1(
											.IN0(UR_LLV1),
											.IN1(UR_H6B1),
											.OUT(UR_V6D1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6d0(
											.IN0(UR_LLV1),
											.IN1(UR_H6B0),
											.OUT(UR_V6D0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6s0(
											.IN0(UR_LLV0),
											.IN1(UR_H6A0),
											.OUT(UR_V6S0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6m1(
											.IN0(UR_LLV3),
											.IN1(UR_H6C1),
											.OUT(UR_V6M1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c0(
											.IN0(UR_LLH2),
											.IN1(UR_V6M0),
											.OUT(UR_H6C0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c1(
											.IN0(UR_LLH2),
											.IN1(UR_V6M1),
											.OUT(UR_H6C1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c2(
											.IN0(UR_LLH8),
											.IN1(UR_V6M2),
											.OUT(UR_H6C2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c3(
											.IN0(UR_LLH8),
											.IN1(UR_V6M3),
											.OUT(UR_H6C3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c4(
											.IN0(UR_LLH8),
											.IN1(UR_LLH2),
											.OUT(UR_H6C4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6c5(
											.IN0(UR_LLH8),
											.IN1(UR_LLH2),
											.OUT(UR_H6C5),
											._1(1)
		);

		SPS2T2X7H1 sps_h6a0(
											.IN0(UR_LLH5),
											.IN1(UR_V6S0),
											.OUT(UR_H6A0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6a1(
											.IN0(UR_LLH5),
											.IN1(UR_V6S1),
											.OUT(UR_H6A1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6a2(
											.IN0(UR_LLV11),
											.IN1(UR_H6W2),
											.OUT(UR_V6A2),
											._1(1)
		);

		SPS2T2X7H1 sps_v6m3(
											.IN0(UR_LLV9),
											.IN1(UR_H6C3),
											.OUT(UR_V6M3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6s1(
											.IN0(UR_LLV0),
											.IN1(UR_H6A1),
											.OUT(UR_V6S1),
											._1(1)
		);

		SPS2T2X7H1 sps_v6c3(
											.IN0(UR_LLV8),
											.IN1(UR_H6M3),
											.OUT(UR_V6C3),
											._1(1)
		);

		SPS2T2X7H1 sps_v6c0(
											.IN0(UR_LLV2),
											.IN1(UR_H6M0),
											.OUT(UR_V6C0),
											._1(1)
		);

		SPS2T2X7H1 sps_v6c1(
											.IN0(UR_LLV2),
											.IN1(UR_H6M1),
											.OUT(UR_V6C1),
											._1(1)
		);

		SPS1T1X7H1 sps_llv7(
											.OUT(UR_LLV7),
											.IN(UR_H6D4)
		);

		SPS2T2X7H1 sps_h6a4(
											.IN0(UR_LLH11),
											.IN1(UR_LLH5),
											.OUT(UR_H6A4),
											._1(1)
		);

		SPS2T2X7H1 sps_v6c2(
											.IN0(UR_LLV8),
											.IN1(UR_H6M2),
											.OUT(UR_V6C2),
											._1(1)
		);

		SPS1T1X7H1 sps_llv1(
											.OUT(UR_LLV1),
											.IN(UR_H6D5)
		);

		SPS1T1X7H1 sps_llv3(
											.OUT(UR_LLV3),
											.IN(UR_H6M5)
		);

		SPS2T2X7H1 sps_h6a5(
											.IN0(UR_LLH11),
											.IN1(UR_LLH5),
											.OUT(UR_H6A5),
											._1(1)
		);

		SPS1T1X7H1 sps_llv0(
											.OUT(UR_LLV0),
											.IN(UR_H6W5)
		);

		SPS2T2X7H1 sps_h6d5(
											.IN0(UR_LLH7),
											.IN1(UR_LLH1),
											.OUT(UR_H6D5),
											._1(1)
		);

		SPS2T2X7H1 sps_h6a2(
											.IN0(UR_LLH11),
											.IN1(UR_V6S2),
											.OUT(UR_H6A2),
											._1(1)
		);

		SPS2T2X7H1 sps_v6s2(
											.IN0(UR_LLV6),
											.IN1(UR_H6A2),
											.OUT(UR_V6S2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6d1(
											.IN0(UR_LLH1),
											.IN1(UR_V6B1),
											.OUT(UR_H6D1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6d0(
											.IN0(UR_LLH1),
											.IN1(UR_V6B0),
											.OUT(UR_H6D0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6d3(
											.IN0(UR_LLH7),
											.IN1(UR_V6B3),
											.OUT(UR_H6D3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6d2(
											.IN0(UR_LLH7),
											.IN1(UR_V6B2),
											.OUT(UR_H6D2),
											._1(1)
		);

		SPS1T1X7H1 sps_llv11(
											.OUT(UR_LLV11),
											.IN(UR_H6A4)
		);

		SPS1T1X7H1 sps_llv10(
											.OUT(UR_LLV10),
											.IN(UR_H6B4)
		);

		SPS1T1X7H1 sps_llv2(
											.OUT(UR_LLV2),
											.IN(UR_H6C5)
		);

		SPS2T2X7H1 sps_h6d4(
											.IN0(UR_LLH7),
											.IN1(UR_LLH1),
											.OUT(UR_H6D4),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b3(
											.IN0(UR_LLH10),
											.IN1(UR_V6D3),
											.OUT(UR_H6B3),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b2(
											.IN0(UR_LLH10),
											.IN1(UR_V6D2),
											.OUT(UR_H6B2),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b1(
											.IN0(UR_LLH4),
											.IN1(UR_V6D1),
											.OUT(UR_H6B1),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b0(
											.IN0(UR_LLH4),
											.IN1(UR_V6D0),
											.OUT(UR_H6B0),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b5(
											.IN0(UR_LLH10),
											.IN1(UR_LLH4),
											.OUT(UR_H6B5),
											._1(1)
		);

		SPS2T2X7H1 sps_h6b4(
											.IN0(UR_LLH10),
											.IN1(UR_LLH4),
											.OUT(UR_H6B4),
											._1(1)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_LBRAMD(
BRAM_ED0, BRAM_ED1, BRAM_ED2, BRAM_ED3, BRAM_ED4, BRAM_ED5, BRAM_ED6, BRAM_ED7, BRAM_ED8, BRAM_ED9, BRAM_ED10, BRAM_ED11, BRAM_ED12, BRAM_ED13, BRAM_ED14, BRAM_ED15, BRAM_ED16, BRAM_ED17, BRAM_ED18, BRAM_ED19, BRAM_ED20, BRAM_ED21, BRAM_ED22, BRAM_ED23, BRAM_H6ED0, BRAM_H6ED1, BRAM_H6ED2, BRAM_H6ED3, BRAM_H6BD0, BRAM_H6BD1, BRAM_H6BD2, BRAM_H6BD3, BRAM_H6MD0, BRAM_H6MD1, BRAM_H6MD2, BRAM_H6MD3, BRAM_H6DD0, BRAM_H6DD1, BRAM_H6DD2, BRAM_H6DD3, BRAM_LHD0, BRAM_LHD3, BRAM_LHD6, BRAM_LHD9, BRAM_LLV0, BRAM_LLV4, BRAM_LLV8, BRAM_RDOUTS0, BRAM_RDOUTS1, BRAM_RDOUTS2, BRAM_RDOUTS3, BRAM_RDOUTS4, BRAM_RDOUTS7, BRAM_RDOUTS8, BRAM_RDOUTS9, BRAM_RDOUTS12, BRAM_RDOUTS16, BRAM_RDOUTS19, BRAM_RDOUTS20, BRAM_RDOUTS21, BRAM_RDOUTS24, BRAM_RDOUTS25, BRAM_RDOUTS26, BRAM_RDOUTS27, BRAM_RDOUTS28, BRAM_RADDRS0, BRAM_RADDRS4, BRAM_RADDRS8, BRAM_RADDRS12, BRAM_RADDRS16, BRAM_RADDRS17, BRAM_RADDRS18, BRAM_RADDRS19, BRAM_RADDRS20, BRAM_RADDRS21, BRAM_RADDRS22, BRAM_RADDRS23, BRAM_RADDRS24, BRAM_RADDRS25, BRAM_RADDRS26, BRAM_RADDRS27, BRAM_RADDRS28, BRAM_RDINS0, BRAM_RDINS4, BRAM_RDINS8, BRAM_RDINS9, BRAM_RDINS10, BRAM_RDINS11, BRAM_RDINS12, BRAM_RDINS13, BRAM_RDINS14, BRAM_RDINS15, BRAM_RDINS16, BRAM_RDINS17, BRAM_RDINS20, BRAM_RDINS24, BRAM_RDINS27, BRAM_RDINS28, BRAM_RDINS29, BRAM_RDINS31, BRAM_GCLKIN0, BRAM_GCLKIN1, BRAM_GCLKIN2, BRAM_GCLKIN3, BRAM_GCLK_IOBD0, BRAM_GCLK_IOBD1, BRAM_GCLK_IOBD2, BRAM_GCLK_IOBD3, BRAM_GCLK_CLBD0, BRAM_GCLK_CLBD1, BRAM_GCLK_CLBD2, BRAM_GCLK_CLBD3, BRAM_DIA6, BRAM_DIA7, BRAM_DIA14, BRAM_DIA15, BRAM_DIB6, BRAM_DIB7, BRAM_DIB14, BRAM_DIB15, BRAM_DOA3, BRAM_DOA7, BRAM_DOA11, BRAM_DOA15, BRAM_DOB3, BRAM_DOB7, BRAM_DOB11, BRAM_DOB15, BRAM_ADDRB8, BRAM_ADDRB9, BRAM_ADDRB10, BRAM_ADDRB11, BRAM_ADDRA8, BRAM_ADDRA9, BRAM_ADDRA10, BRAM_ADDRA11, _1
);
inout	BRAM_ED0;
inout	BRAM_ED1;
inout	BRAM_ED2;
inout	BRAM_ED3;
inout	BRAM_ED4;
inout	BRAM_ED5;
inout	BRAM_ED6;
inout	BRAM_ED7;
inout	BRAM_ED8;
inout	BRAM_ED9;
inout	BRAM_ED10;
inout	BRAM_ED11;
inout	BRAM_ED12;
inout	BRAM_ED13;
inout	BRAM_ED14;
inout	BRAM_ED15;
inout	BRAM_ED16;
inout	BRAM_ED17;
inout	BRAM_ED18;
inout	BRAM_ED19;
inout	BRAM_ED20;
inout	BRAM_ED21;
inout	BRAM_ED22;
inout	BRAM_ED23;
inout	BRAM_H6ED0;
inout	BRAM_H6ED1;
inout	BRAM_H6ED2;
inout	BRAM_H6ED3;
inout	BRAM_H6BD0;
inout	BRAM_H6BD1;
inout	BRAM_H6BD2;
inout	BRAM_H6BD3;
inout	BRAM_H6MD0;
inout	BRAM_H6MD1;
inout	BRAM_H6MD2;
inout	BRAM_H6MD3;
inout	BRAM_H6DD0;
inout	BRAM_H6DD1;
inout	BRAM_H6DD2;
inout	BRAM_H6DD3;
inout	BRAM_LHD0;
inout	BRAM_LHD3;
inout	BRAM_LHD6;
inout	BRAM_LHD9;
inout	BRAM_LLV0;
inout	BRAM_LLV4;
inout	BRAM_LLV8;
inout	BRAM_RDOUTS0;
inout	BRAM_RDOUTS1;
inout	BRAM_RDOUTS2;
inout	BRAM_RDOUTS3;
inout	BRAM_RDOUTS4;
inout	BRAM_RDOUTS7;
inout	BRAM_RDOUTS8;
inout	BRAM_RDOUTS9;
inout	BRAM_RDOUTS12;
inout	BRAM_RDOUTS16;
inout	BRAM_RDOUTS19;
inout	BRAM_RDOUTS20;
inout	BRAM_RDOUTS21;
inout	BRAM_RDOUTS24;
inout	BRAM_RDOUTS25;
inout	BRAM_RDOUTS26;
inout	BRAM_RDOUTS27;
inout	BRAM_RDOUTS28;
inout	BRAM_RADDRS0;
inout	BRAM_RADDRS4;
inout	BRAM_RADDRS8;
inout	BRAM_RADDRS12;
inout	BRAM_RADDRS16;
inout	BRAM_RADDRS17;
inout	BRAM_RADDRS18;
inout	BRAM_RADDRS19;
inout	BRAM_RADDRS20;
inout	BRAM_RADDRS21;
inout	BRAM_RADDRS22;
inout	BRAM_RADDRS23;
inout	BRAM_RADDRS24;
inout	BRAM_RADDRS25;
inout	BRAM_RADDRS26;
inout	BRAM_RADDRS27;
inout	BRAM_RADDRS28;
inout	BRAM_RDINS0;
inout	BRAM_RDINS4;
inout	BRAM_RDINS8;
inout	BRAM_RDINS9;
inout	BRAM_RDINS10;
inout	BRAM_RDINS11;
inout	BRAM_RDINS12;
inout	BRAM_RDINS13;
inout	BRAM_RDINS14;
inout	BRAM_RDINS15;
inout	BRAM_RDINS16;
inout	BRAM_RDINS17;
inout	BRAM_RDINS20;
inout	BRAM_RDINS24;
inout	BRAM_RDINS27;
inout	BRAM_RDINS28;
inout	BRAM_RDINS29;
inout	BRAM_RDINS31;
inout	BRAM_GCLKIN0;
inout	BRAM_GCLKIN1;
inout	BRAM_GCLKIN2;
inout	BRAM_GCLKIN3;
inout	BRAM_GCLK_IOBD0;
inout	BRAM_GCLK_IOBD1;
inout	BRAM_GCLK_IOBD2;
inout	BRAM_GCLK_IOBD3;
inout	BRAM_GCLK_CLBD0;
inout	BRAM_GCLK_CLBD1;
inout	BRAM_GCLK_CLBD2;
inout	BRAM_GCLK_CLBD3;
inout	BRAM_DIA6;
inout	BRAM_DIA7;
inout	BRAM_DIA14;
inout	BRAM_DIA15;
inout	BRAM_DIB6;
inout	BRAM_DIB7;
inout	BRAM_DIB14;
inout	BRAM_DIB15;
inout	BRAM_DOA3;
inout	BRAM_DOA7;
inout	BRAM_DOA11;
inout	BRAM_DOA15;
inout	BRAM_DOB3;
inout	BRAM_DOB7;
inout	BRAM_DOB11;
inout	BRAM_DOB15;
inout	BRAM_ADDRB8;
inout	BRAM_ADDRB9;
inout	BRAM_ADDRB10;
inout	BRAM_ADDRB11;
inout	BRAM_ADDRA8;
inout	BRAM_ADDRA9;
inout	BRAM_ADDRA10;
inout	BRAM_ADDRA11;
inout	_1;

		SPS2T2X7H2 sps_ed9(
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS4),
											.OUT(BRAM_ED9),
											._1(1)
		);

		SPS8T6X11H2 sps_rdins0(
											.IN4(BRAM_ED4),
											.IN5(BRAM_ED0),
											.IN6(BRAM_H6DD0),
											.IN7(BRAM_H6ED0),
											.IN0(BRAM_ED20),
											.IN1(BRAM_ED16),
											.IN2(BRAM_ED12),
											.IN3(BRAM_ED8),
											.OUT(BRAM_RDINS0),
											._1(1)
		);

		SPS8T6X11H2 sps_rdins4(
											.IN4(BRAM_ED5),
											.IN5(BRAM_ED1),
											.IN6(BRAM_H6DD1),
											.IN7(BRAM_H6ED1),
											.IN0(BRAM_ED21),
											.IN1(BRAM_ED17),
											.IN2(BRAM_ED13),
											.IN3(BRAM_ED9),
											.OUT(BRAM_RDINS4),
											._1(1)
		);

		SPS2T2X7H2 sps_ed3(
											.IN0(BRAM_RDOUTS28),
											.IN1(BRAM_RDOUTS12),
											.OUT(BRAM_ED3),
											._1(1)
		);

		SPS2T2X7H2 sps_ed2(
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS8),
											.OUT(BRAM_ED2),
											._1(1)
		);

		SPS2T2X7H2 sps_ed1(
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS4),
											.OUT(BRAM_ED1),
											._1(1)
		);

		SPS2T2X7H2 sps_ed0(
											.IN0(BRAM_RDOUTS16),
											.IN1(BRAM_RDOUTS0),
											.OUT(BRAM_ED0),
											._1(1)
		);

		SPS2T2X7H2 sps_ed7(
											.IN0(BRAM_RDOUTS28),
											.IN1(BRAM_RDOUTS12),
											.OUT(BRAM_ED7),
											._1(1)
		);

		SPS2T2X7H2 sps_ed6(
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS8),
											.OUT(BRAM_ED6),
											._1(1)
		);

		SPS2T2X7H2 sps_ed5(
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS4),
											.OUT(BRAM_ED5),
											._1(1)
		);

		SPS2T2X7H2 sps_ed4(
											.IN0(BRAM_RDOUTS16),
											.IN1(BRAM_RDOUTS0),
											.OUT(BRAM_ED4),
											._1(1)
		);

		SPS8T6X11H1 sps_llv0(
											.IN4(BRAM_ED4),
											.IN5(BRAM_ED0),
											.IN6(BRAM_H6DD0),
											.IN7(BRAM_H6ED0),
											.IN0(BRAM_ED20),
											.IN1(BRAM_ED16),
											.IN2(BRAM_ED12),
											.IN3(BRAM_ED8),
											.OUT(BRAM_LLV0),
											._1(1)
		);

		SPS2T2X7H2 sps_ed8(
											.IN0(BRAM_RDOUTS16),
											.IN1(BRAM_RDOUTS0),
											.OUT(BRAM_ED8),
											._1(1)
		);

		SPS8T6X11H1 sps_llv4(
											.IN4(BRAM_ED5),
											.IN5(BRAM_ED1),
											.IN6(BRAM_H6DD1),
											.IN7(BRAM_H6ED1),
											.IN0(BRAM_ED21),
											.IN1(BRAM_ED17),
											.IN2(BRAM_ED13),
											.IN3(BRAM_ED9),
											.OUT(BRAM_LLV4),
											._1(1)
		);

		SPS8T6X11H1 sps_llv8(
											.IN4(BRAM_ED6),
											.IN5(BRAM_ED2),
											.IN6(BRAM_H6DD2),
											.IN7(BRAM_H6ED2),
											.IN0(BRAM_ED22),
											.IN1(BRAM_ED18),
											.IN2(BRAM_ED14),
											.IN3(BRAM_ED10),
											.OUT(BRAM_LLV8),
											._1(1)
		);

		SPS8T6X11H2 sps_rdins12(
											.IN4(BRAM_ED7),
											.IN5(BRAM_ED3),
											.IN6(BRAM_H6DD3),
											.IN7(BRAM_H6ED3),
											.IN0(BRAM_ED23),
											.IN1(BRAM_ED19),
											.IN2(BRAM_ED15),
											.IN3(BRAM_ED11),
											.OUT(BRAM_RDINS12),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins16(
											.IN4(BRAM_ED4),
											.IN5(BRAM_ED0),
											.IN6(BRAM_H6DD0),
											.IN7(BRAM_H6ED0),
											.IN0(BRAM_ED20),
											.IN1(BRAM_ED16),
											.IN2(BRAM_ED12),
											.IN3(BRAM_ED8),
											.OUT(BRAM_RDINS16),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob15_rdouts9(
											.IN(BRAM_DOB15),
											.OUT(BRAM_RDOUTS9)
		);

		SPS8T6X11H2 sps_rdins8(
											.IN4(BRAM_ED6),
											.IN5(BRAM_ED2),
											.IN6(BRAM_H6DD2),
											.IN7(BRAM_H6ED2),
											.IN0(BRAM_ED22),
											.IN1(BRAM_ED18),
											.IN2(BRAM_ED14),
											.IN3(BRAM_ED10),
											.OUT(BRAM_RDINS8),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa11_rdouts2(
											.OUT(BRAM_RDOUTS2),
											.IN(BRAM_DOA11)
		);

		TRIBUF1T1X7H1 tribuf_dob3_rdouts2(
											.IN(BRAM_DOB3),
											.OUT(BRAM_RDOUTS2)
		);

		TRIBUF1T1X7H1 tribuf_dob3_rdouts3(
											.OUT(BRAM_RDOUTS3),
											.IN(BRAM_DOB3)
		);

		SPS8T6X11H1 sps_dib14(
											.IN4(BRAM_RDINS15),
											.IN5(BRAM_RDINS14),
											.IN6(BRAM_RDINS11),
											.IN7(BRAM_RDINS10),
											.IN0(BRAM_RDINS29),
											.IN1(BRAM_RDINS28),
											.IN2(BRAM_RDINS17),
											.IN3(BRAM_RDINS16),
											.OUT(BRAM_DIB14),
											._1(1)
		);

		SPS8T6X11H2 sps_dib15(
											.IN4(BRAM_RDINS15),
											.IN5(BRAM_RDINS14),
											.IN6(BRAM_RDINS11),
											.IN7(BRAM_RDINS10),
											.IN0(BRAM_RDINS29),
											.IN1(BRAM_RDINS28),
											.IN2(BRAM_RDINS17),
											.IN3(BRAM_RDINS16),
											.OUT(BRAM_DIB15),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb10(
											.IN4(BRAM_RADDRS23),
											.IN5(BRAM_RADDRS22),
											.IN6(BRAM_RADDRS21),
											.IN7(BRAM_RADDRS20),
											.IN0(BRAM_RADDRS27),
											.IN1(BRAM_RADDRS26),
											.IN2(BRAM_RADDRS25),
											.IN3(BRAM_RADDRS24),
											.OUT(BRAM_ADDRB10),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb11(
											.IN4(BRAM_RADDRS23),
											.IN5(BRAM_RADDRS22),
											.IN6(BRAM_RADDRS21),
											.IN7(BRAM_RADDRS20),
											.IN0(BRAM_RADDRS27),
											.IN1(BRAM_RADDRS26),
											.IN2(BRAM_RADDRS25),
											.IN3(BRAM_RADDRS24),
											.OUT(BRAM_ADDRB11),
											._1(1)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobd0(
											.OUT(BRAM_GCLK_IOBD0),
											.IN(BRAM_GCLKIN0)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobd1(
											.OUT(BRAM_GCLK_IOBD1),
											.IN(BRAM_GCLKIN1)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobd2(
											.OUT(BRAM_GCLK_IOBD2),
											.IN(BRAM_GCLKIN2)
		);

		SPBU1NAND1X35H1 spbu_gclk_iobd3(
											.OUT(BRAM_GCLK_IOBD3),
											.IN(BRAM_GCLKIN3)
		);

		SPS8T6X11H2 sps_dia7(
											.IN4(BRAM_RDINS14),
											.IN5(BRAM_RDINS13),
											.IN6(BRAM_RDINS10),
											.IN7(BRAM_RDINS9),
											.IN0(BRAM_RDINS28),
											.IN1(BRAM_RDINS27),
											.IN2(BRAM_RDINS16),
											.IN3(BRAM_RDINS31),
											.OUT(BRAM_DIA7),
											._1(1)
		);

		SPS8T6X11H1 sps_dia6(
											.IN4(BRAM_RDINS14),
											.IN5(BRAM_RDINS13),
											.IN6(BRAM_RDINS10),
											.IN7(BRAM_RDINS9),
											.IN0(BRAM_RDINS28),
											.IN1(BRAM_RDINS27),
											.IN2(BRAM_RDINS16),
											.IN3(BRAM_RDINS31),
											.OUT(BRAM_DIA6),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa7_rdouts7(
											.OUT(BRAM_RDOUTS7),
											.IN(BRAM_DOA7)
		);

		TRIBUF1T1X7H1 tribuf_doa7_rdouts8(
											.IN(BRAM_DOA7),
											.OUT(BRAM_RDOUTS8)
		);

		TRIBUF1T1X7H1 tribuf_dob7_rdouts27(
											.OUT(BRAM_RDOUTS27),
											.IN(BRAM_DOB7)
		);

		TRIBUF1T1X7H1 tribuf_dob7_rdouts26(
											.IN(BRAM_DOB7),
											.OUT(BRAM_RDOUTS26)
		);

		TRIBUF1T1X7H1 tribuf_doa15_rdouts25(
											.OUT(BRAM_RDOUTS25),
											.IN(BRAM_DOA15)
		);

		TRIBUF1T1X7H1 tribuf_doa11_rdouts19(
											.OUT(BRAM_RDOUTS19),
											.IN(BRAM_DOA11)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbd3(
											.OUT(BRAM_GCLK_CLBD3),
											.IN(BRAM_GCLKIN3)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbd2(
											.OUT(BRAM_GCLK_CLBD2),
											.IN(BRAM_GCLKIN2)
		);

		TRIBUF1T1X7H1 tribuf_doa3_rdouts19(
											.IN(BRAM_DOA3),
											.OUT(BRAM_RDOUTS19)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbd0(
											.OUT(BRAM_GCLK_CLBD0),
											.IN(BRAM_GCLKIN0)
		);

		TRIBUF1T1X7H1 tribuf_dob3_rdouts21(
											.OUT(BRAM_RDOUTS21),
											.IN(BRAM_DOB3)
		);

		TRIBUF1T1X7H1 tribuf_dob3_rdouts20(
											.IN(BRAM_DOB3),
											.OUT(BRAM_RDOUTS20)
		);

		SPS8T6X11H1 sps_rdins28(
											.IN4(BRAM_ED7),
											.IN5(BRAM_ED3),
											.IN6(BRAM_H6DD3),
											.IN7(BRAM_H6ED3),
											.IN0(BRAM_ED23),
											.IN1(BRAM_ED19),
											.IN2(BRAM_ED15),
											.IN3(BRAM_ED11),
											.OUT(BRAM_RDINS28),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb9(
											.IN4(BRAM_RADDRS19),
											.IN5(BRAM_RADDRS18),
											.IN6(BRAM_RADDRS17),
											.IN7(BRAM_RADDRS16),
											.IN0(BRAM_RADDRS23),
											.IN1(BRAM_RADDRS22),
											.IN2(BRAM_RADDRS21),
											.IN3(BRAM_RADDRS20),
											.OUT(BRAM_ADDRB9),
											._1(1)
		);

		SPBU1NAND1X35H1 spbu_gclk_clbd1(
											.OUT(BRAM_GCLK_CLBD1),
											.IN(BRAM_GCLKIN1)
		);

		SPS8T6X11H1 sps_rdins20(
											.IN4(BRAM_ED5),
											.IN5(BRAM_ED1),
											.IN6(BRAM_H6DD1),
											.IN7(BRAM_H6ED1),
											.IN0(BRAM_ED21),
											.IN1(BRAM_ED17),
											.IN2(BRAM_ED13),
											.IN3(BRAM_ED9),
											.OUT(BRAM_RDINS20),
											._1(1)
		);

		SPS8T6X11H1 sps_rdins24(
											.IN4(BRAM_ED6),
											.IN5(BRAM_ED2),
											.IN6(BRAM_H6DD2),
											.IN7(BRAM_H6ED2),
											.IN0(BRAM_ED22),
											.IN1(BRAM_ED18),
											.IN2(BRAM_ED14),
											.IN3(BRAM_ED10),
											.OUT(BRAM_RDINS24),
											._1(1)
		);

		SPS8T6X11H2 sps_dia15(
											.IN4(BRAM_RDINS14),
											.IN5(BRAM_RDINS13),
											.IN6(BRAM_RDINS10),
											.IN7(BRAM_RDINS9),
											.IN0(BRAM_RDINS28),
											.IN1(BRAM_RDINS27),
											.IN2(BRAM_RDINS16),
											.IN3(BRAM_RDINS31),
											.OUT(BRAM_DIA15),
											._1(1)
		);

		SPS8T6X11H1 sps_dia14(
											.IN4(BRAM_RDINS14),
											.IN5(BRAM_RDINS13),
											.IN6(BRAM_RDINS10),
											.IN7(BRAM_RDINS9),
											.IN0(BRAM_RDINS28),
											.IN1(BRAM_RDINS27),
											.IN2(BRAM_RDINS16),
											.IN3(BRAM_RDINS31),
											.OUT(BRAM_DIA14),
											._1(1)
		);

		SPS8T6X11H2 sps_addrb8(
											.IN4(BRAM_RADDRS19),
											.IN5(BRAM_RADDRS18),
											.IN6(BRAM_RADDRS17),
											.IN7(BRAM_RADDRS16),
											.IN0(BRAM_RADDRS23),
											.IN1(BRAM_RADDRS22),
											.IN2(BRAM_RADDRS21),
											.IN3(BRAM_RADDRS20),
											.OUT(BRAM_ADDRB8),
											._1(1)
		);

		SPS4T3X11H2 sps_h6md3(
											.OUT(BRAM_H6MD3),
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS28),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa3_rdouts2(
											.IN(BRAM_DOA3),
											.OUT(BRAM_RDOUTS2)
		);

		TRIBUF1T1X7H1 tribuf_doa3_rdouts1(
											.OUT(BRAM_RDOUTS1),
											.IN(BRAM_DOA3)
		);

		SPS4T3X11H2 sps_h6md0(
											.OUT(BRAM_H6MD0),
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS16),
											.IN2(BRAM_RDOUTS4),
											.IN3(BRAM_RDOUTS0),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa3_rdouts20(
											.IN(BRAM_DOA3),
											.OUT(BRAM_RDOUTS20)
		);

		TRIBUF1T1X7H1 tribuf_doa15_rdouts8(
											.IN(BRAM_DOA15),
											.OUT(BRAM_RDOUTS8)
		);

		TRIBUF1T1X7H1 tribuf_dob7_rdouts8(
											.IN(BRAM_DOB7),
											.OUT(BRAM_RDOUTS8)
		);

		TRIBUF1T1X7H1 tribuf_dob7_rdouts9(
											.OUT(BRAM_RDOUTS9),
											.IN(BRAM_DOB7)
		);

		SPS8T6X11H2 sps_raddrs8(
											.IN4(BRAM_ED6),
											.IN5(BRAM_ED2),
											.IN6(BRAM_H6DD2),
											.IN7(BRAM_H6ED2),
											.IN0(BRAM_ED22),
											.IN1(BRAM_ED18),
											.IN2(BRAM_ED14),
											.IN3(BRAM_ED10),
											.OUT(BRAM_RADDRS8),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs0(
											.IN4(BRAM_ED4),
											.IN5(BRAM_ED0),
											.IN6(BRAM_H6DD0),
											.IN7(BRAM_H6ED0),
											.IN0(BRAM_ED20),
											.IN1(BRAM_ED16),
											.IN2(BRAM_ED12),
											.IN3(BRAM_ED8),
											.OUT(BRAM_RADDRS0),
											._1(1)
		);

		SPS8T6X11H1 sps_addra11(
											.IN4(BRAM_RADDRS23),
											.IN5(BRAM_RADDRS22),
											.IN6(BRAM_RADDRS21),
											.IN7(BRAM_RADDRS20),
											.IN0(BRAM_RADDRS27),
											.IN1(BRAM_RADDRS26),
											.IN2(BRAM_RADDRS25),
											.IN3(BRAM_RADDRS24),
											.OUT(BRAM_ADDRA11),
											._1(1)
		);

		SPS8T6X11H2 sps_raddrs4(
											.IN4(BRAM_ED5),
											.IN5(BRAM_ED1),
											.IN6(BRAM_H6DD1),
											.IN7(BRAM_H6ED1),
											.IN0(BRAM_ED21),
											.IN1(BRAM_ED17),
											.IN2(BRAM_ED13),
											.IN3(BRAM_ED9),
											.OUT(BRAM_RADDRS4),
											._1(1)
		);

		SPS2T2X7H2 sps_ed19(
											.IN0(BRAM_RDOUTS28),
											.IN1(BRAM_RDOUTS12),
											.OUT(BRAM_ED19),
											._1(1)
		);

		SPS2T2X7H2 sps_ed18(
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS8),
											.OUT(BRAM_ED18),
											._1(1)
		);

		SPS2T2X7H2 sps_ed17(
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS4),
											.OUT(BRAM_ED17),
											._1(1)
		);

		SPS2T2X7H2 sps_ed16(
											.IN0(BRAM_RDOUTS16),
											.IN1(BRAM_RDOUTS0),
											.OUT(BRAM_ED16),
											._1(1)
		);

		SPS2T2X7H2 sps_ed15(
											.IN0(BRAM_RDOUTS28),
											.IN1(BRAM_RDOUTS12),
											.OUT(BRAM_ED15),
											._1(1)
		);

		SPS2T2X7H2 sps_ed14(
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS8),
											.OUT(BRAM_ED14),
											._1(1)
		);

		SPS2T2X7H2 sps_ed13(
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS4),
											.OUT(BRAM_ED13),
											._1(1)
		);

		SPS2T2X7H2 sps_ed12(
											.IN0(BRAM_RDOUTS16),
											.IN1(BRAM_RDOUTS0),
											.OUT(BRAM_ED12),
											._1(1)
		);

		SPS2T2X7H2 sps_ed11(
											.IN0(BRAM_RDOUTS28),
											.IN1(BRAM_RDOUTS12),
											.OUT(BRAM_ED11),
											._1(1)
		);

		SPS2T2X7H2 sps_ed10(
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS8),
											.OUT(BRAM_ED10),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bd0(
											.OUT(BRAM_H6BD0),
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS16),
											.IN2(BRAM_RDOUTS4),
											.IN3(BRAM_RDOUTS0),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bd1(
											.OUT(BRAM_H6BD1),
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS28),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bd2(
											.OUT(BRAM_H6BD2),
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS16),
											.IN2(BRAM_RDOUTS4),
											.IN3(BRAM_RDOUTS0),
											._1(1)
		);

		SPS4T3X11H2 sps_h6bd3(
											.OUT(BRAM_H6BD3),
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS28),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_doa7_rdouts26(
											.OUT(BRAM_RDOUTS26),
											.IN(BRAM_DOA7)
		);

		TRIBUF1T1X7H1 tribuf_doa7_rdouts25(
											.IN(BRAM_DOA7),
											.OUT(BRAM_RDOUTS25)
		);

		SPS2T2X7H2 sps_ed22(
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS8),
											.OUT(BRAM_ED22),
											._1(1)
		);

		SPS2T2X7H2 sps_ed23(
											.IN0(BRAM_RDOUTS28),
											.IN1(BRAM_RDOUTS12),
											.OUT(BRAM_ED23),
											._1(1)
		);

		SPS2T2X7H2 sps_ed20(
											.IN0(BRAM_RDOUTS16),
											.IN1(BRAM_RDOUTS0),
											.OUT(BRAM_ED20),
											._1(1)
		);

		SPS2T2X7H2 sps_ed21(
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS4),
											.OUT(BRAM_ED21),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs28(
											.IN4(BRAM_ED7),
											.IN5(BRAM_ED3),
											.IN6(BRAM_H6DD3),
											.IN7(BRAM_H6ED3),
											.IN0(BRAM_ED23),
											.IN1(BRAM_ED19),
											.IN2(BRAM_ED15),
											.IN3(BRAM_ED11),
											.OUT(BRAM_RADDRS28),
											._1(1)
		);

		SPS8T6X11H1 sps_addra9(
											.IN4(BRAM_RADDRS19),
											.IN5(BRAM_RADDRS18),
											.IN6(BRAM_RADDRS17),
											.IN7(BRAM_RADDRS16),
											.IN0(BRAM_RADDRS23),
											.IN1(BRAM_RADDRS22),
											.IN2(BRAM_RADDRS21),
											.IN3(BRAM_RADDRS20),
											.OUT(BRAM_ADDRA9),
											._1(1)
		);

		SPS8T6X11H1 sps_addra8(
											.IN4(BRAM_RADDRS19),
											.IN5(BRAM_RADDRS18),
											.IN6(BRAM_RADDRS17),
											.IN7(BRAM_RADDRS16),
											.IN0(BRAM_RADDRS23),
											.IN1(BRAM_RADDRS22),
											.IN2(BRAM_RADDRS21),
											.IN3(BRAM_RADDRS20),
											.OUT(BRAM_ADDRA8),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs20(
											.IN4(BRAM_ED5),
											.IN5(BRAM_ED1),
											.IN6(BRAM_H6DD1),
											.IN7(BRAM_H6ED1),
											.IN0(BRAM_ED21),
											.IN1(BRAM_ED17),
											.IN2(BRAM_ED13),
											.IN3(BRAM_ED9),
											.OUT(BRAM_RADDRS20),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs24(
											.IN4(BRAM_ED6),
											.IN5(BRAM_ED2),
											.IN6(BRAM_H6DD2),
											.IN7(BRAM_H6ED2),
											.IN0(BRAM_ED22),
											.IN1(BRAM_ED18),
											.IN2(BRAM_ED14),
											.IN3(BRAM_ED10),
											.OUT(BRAM_RADDRS24),
											._1(1)
		);

		SPS4T3X11H2 sps_h6md2(
											.OUT(BRAM_H6MD2),
											.IN0(BRAM_RDOUTS20),
											.IN1(BRAM_RDOUTS16),
											.IN2(BRAM_RDOUTS4),
											.IN3(BRAM_RDOUTS0),
											._1(1)
		);

		SPS4T3X11H2 sps_h6md1(
											.OUT(BRAM_H6MD1),
											.IN0(BRAM_RDOUTS24),
											.IN1(BRAM_RDOUTS28),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											._1(1)
		);

		SPS8T6X11H1 sps_addra10(
											.IN4(BRAM_RADDRS23),
											.IN5(BRAM_RADDRS22),
											.IN6(BRAM_RADDRS21),
											.IN7(BRAM_RADDRS20),
											.IN0(BRAM_RADDRS27),
											.IN1(BRAM_RADDRS26),
											.IN2(BRAM_RADDRS25),
											.IN3(BRAM_RADDRS24),
											.OUT(BRAM_ADDRA10),
											._1(1)
		);

		TRIBUF1T1X7H1 tribuf_dob11_rdouts3(
											.IN(BRAM_DOB11),
											.OUT(BRAM_RDOUTS3)
		);

		TRIBUF1T1X7H1 tribuf_dob15_rdouts26(
											.IN(BRAM_DOB15),
											.OUT(BRAM_RDOUTS26)
		);

		TRIBUF1T1X7H1 tribuf_dob11_rdouts20(
											.IN(BRAM_DOB11),
											.OUT(BRAM_RDOUTS20)
		);

		SPS8T6X11H2 sps_raddrs12(
											.IN4(BRAM_ED7),
											.IN5(BRAM_ED3),
											.IN6(BRAM_H6DD3),
											.IN7(BRAM_H6ED3),
											.IN0(BRAM_ED23),
											.IN1(BRAM_ED19),
											.IN2(BRAM_ED15),
											.IN3(BRAM_ED11),
											.OUT(BRAM_RADDRS12),
											._1(1)
		);

		SPS8T6X11H1 sps_dib6(
											.IN4(BRAM_RDINS15),
											.IN5(BRAM_RDINS14),
											.IN6(BRAM_RDINS11),
											.IN7(BRAM_RDINS10),
											.IN0(BRAM_RDINS29),
											.IN1(BRAM_RDINS28),
											.IN2(BRAM_RDINS17),
											.IN3(BRAM_RDINS16),
											.OUT(BRAM_DIB6),
											._1(1)
		);

		SPS8T6X11H2 sps_dib7(
											.IN4(BRAM_RDINS15),
											.IN5(BRAM_RDINS14),
											.IN6(BRAM_RDINS11),
											.IN7(BRAM_RDINS10),
											.IN0(BRAM_RDINS29),
											.IN1(BRAM_RDINS28),
											.IN2(BRAM_RDINS17),
											.IN3(BRAM_RDINS16),
											.OUT(BRAM_DIB7),
											._1(1)
		);

		SPS8T6X11H1 sps_raddrs16(
											.IN4(BRAM_ED4),
											.IN5(BRAM_ED0),
											.IN6(BRAM_H6DD0),
											.IN7(BRAM_H6ED0),
											.IN0(BRAM_ED20),
											.IN1(BRAM_ED16),
											.IN2(BRAM_ED12),
											.IN3(BRAM_ED8),
											.OUT(BRAM_RADDRS16),
											._1(1)
		);

		SPS8T6X11H1 sps_lhd9(
											.IN4(BRAM_RDOUTS16),
											.IN5(BRAM_RDOUTS20),
											.IN6(BRAM_RDOUTS24),
											.IN7(BRAM_RDOUTS28),
											.IN0(BRAM_RDOUTS0),
											.IN1(BRAM_RDOUTS4),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											.OUT(BRAM_LHD9),
											._1(1)
		);

		SPS8T6X11H1 sps_lhd6(
											.IN4(BRAM_RDOUTS16),
											.IN5(BRAM_RDOUTS20),
											.IN6(BRAM_RDOUTS24),
											.IN7(BRAM_RDOUTS28),
											.IN0(BRAM_RDOUTS0),
											.IN1(BRAM_RDOUTS4),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											.OUT(BRAM_LHD6),
											._1(1)
		);

		SPS8T6X11H1 sps_lhd3(
											.IN4(BRAM_RDOUTS16),
											.IN5(BRAM_RDOUTS20),
											.IN6(BRAM_RDOUTS24),
											.IN7(BRAM_RDOUTS28),
											.IN0(BRAM_RDOUTS0),
											.IN1(BRAM_RDOUTS4),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											.OUT(BRAM_LHD3),
											._1(1)
		);

		SPS8T6X11H1 sps_lhd0(
											.IN4(BRAM_RDOUTS16),
											.IN5(BRAM_RDOUTS20),
											.IN6(BRAM_RDOUTS24),
											.IN7(BRAM_RDOUTS28),
											.IN0(BRAM_RDOUTS0),
											.IN1(BRAM_RDOUTS4),
											.IN2(BRAM_RDOUTS8),
											.IN3(BRAM_RDOUTS12),
											.OUT(BRAM_LHD0),
											._1(1)
		);

endmodule

 `timescale 1 ns/1 ns

module GSB_BOT(
BOT_N23, BOT_N22, BOT_N21, BOT_N20, BOT_N19, BOT_N18, BOT_N17, BOT_N16, BOT_N15, BOT_N14, BOT_N13, BOT_N12, BOT_N11, BOT_N10, BOT_N9, BOT_N8, BOT_N7, BOT_N6, BOT_N5, BOT_N4, BOT_N3, BOT_N2, BOT_N1, BOT_N0, BOT_H6E0, BOT_H6E1, BOT_H6E2, BOT_H6E3, BOT_H6E4, BOT_H6E5, BOT_H6A0, BOT_H6A1, BOT_H6A2, BOT_H6A3, BOT_H6A4, BOT_H6A5, BOT_H6B0, BOT_H6B1, BOT_H6B2, BOT_H6B3, BOT_H6B4, BOT_H6B5, BOT_H6M0, BOT_H6M1, BOT_H6M2, BOT_H6M3, BOT_H6M4, BOT_H6M5, BOT_H6C0, BOT_H6C1, BOT_H6C2, BOT_H6C3, BOT_H6C4, BOT_H6C5, BOT_H6D0, BOT_H6D1, BOT_H6D2, BOT_H6D3, BOT_H6D4, BOT_H6D5, BOT_H6W0, BOT_H6W1, BOT_H6W2, BOT_H6W3, BOT_H6W4, BOT_H6W5, BOT_V6N0, BOT_V6N1, BOT_V6N2, BOT_V6N3, BOT_V6N4, BOT_V6N5, BOT_V6N6, BOT_V6N7, BOT_V6N8, BOT_V6N9, BOT_V6N10, BOT_V6N11, BOT_V6A0, BOT_V6A1, BOT_V6A2, BOT_V6A3, BOT_V6A4, BOT_V6A5, BOT_V6A6, BOT_V6A7, BOT_V6A8, BOT_V6A9, BOT_V6A10, BOT_V6A11, BOT_V6B0, BOT_V6B1, BOT_V6B2, BOT_V6B3, BOT_V6B4, BOT_V6B5, BOT_V6B6, BOT_V6B7, BOT_V6B8, BOT_V6B9, BOT_V6B10, BOT_V6B11, BOT_V6M0, BOT_V6M1, BOT_V6M2, BOT_V6M3, BOT_V6M4, BOT_V6M5, BOT_V6M6, BOT_V6M7, BOT_V6M8, BOT_V6M9, BOT_V6M10, BOT_V6M11, BOT_V6C0, BOT_V6C1, BOT_V6C2, BOT_V6C3, BOT_V6C4, BOT_V6C5, BOT_V6C6, BOT_V6C7, BOT_V6C8, BOT_V6C9, BOT_V6C10, BOT_V6C11, BOT_V6D0, BOT_V6D1, BOT_V6D2, BOT_V6D3, BOT_V6D4, BOT_V6D5, BOT_V6D6, BOT_V6D7, BOT_V6D8, BOT_V6D9, BOT_V6D10, BOT_V6D11, BOT_LLH0, BOT_LLH6, BOT_LLV0, BOT_LLV1, BOT_LLV2, BOT_LLV3, BOT_LLV4, BOT_LLV5, BOT_LLV6, BOT_LLV7, BOT_LLV8, BOT_LLV9, BOT_LLV10, BOT_LLV11, BOT_HGCLK0, BOT_HGCLK1, BOT_HGCLK2, BOT_HGCLK3, BOT_I2, BOT_I1, BOT_IQ2, BOT_IQ1, BOT_ICE2, BOT_ICE1, BOT_O2, BOT_O1, BOT_OCE2, BOT_OCE1, BOT_T2, BOT_T1, BOT_TCE2, BOT_TCE1, BOT_CLK2, BOT_CLK1, BOT_SR_B2, BOT_SR_B1, _1
);
inout	BOT_N23;
inout	BOT_N22;
inout	BOT_N21;
inout	BOT_N20;
inout	BOT_N19;
inout	BOT_N18;
inout	BOT_N17;
inout	BOT_N16;
inout	BOT_N15;
inout	BOT_N14;
inout	BOT_N13;
inout	BOT_N12;
inout	BOT_N11;
inout	BOT_N10;
inout	BOT_N9;
inout	BOT_N8;
inout	BOT_N7;
inout	BOT_N6;
inout	BOT_N5;
inout	BOT_N4;
inout	BOT_N3;
inout	BOT_N2;
inout	BOT_N1;
inout	BOT_N0;
inout	BOT_H6E0;
inout	BOT_H6E1;
inout	BOT_H6E2;
inout	BOT_H6E3;
inout	BOT_H6E4;
inout	BOT_H6E5;
inout	BOT_H6A0;
inout	BOT_H6A1;
inout	BOT_H6A2;
inout	BOT_H6A3;
inout	BOT_H6A4;
inout	BOT_H6A5;
inout	BOT_H6B0;
inout	BOT_H6B1;
inout	BOT_H6B2;
inout	BOT_H6B3;
inout	BOT_H6B4;
inout	BOT_H6B5;
inout	BOT_H6M0;
inout	BOT_H6M1;
inout	BOT_H6M2;
inout	BOT_H6M3;
inout	BOT_H6M4;
inout	BOT_H6M5;
inout	BOT_H6C0;
inout	BOT_H6C1;
inout	BOT_H6C2;
inout	BOT_H6C3;
inout	BOT_H6C4;
inout	BOT_H6C5;
inout	BOT_H6D0;
inout	BOT_H6D1;
inout	BOT_H6D2;
inout	BOT_H6D3;
inout	BOT_H6D4;
inout	BOT_H6D5;
inout	BOT_H6W0;
inout	BOT_H6W1;
inout	BOT_H6W2;
inout	BOT_H6W3;
inout	BOT_H6W4;
inout	BOT_H6W5;
inout	BOT_V6N0;
inout	BOT_V6N1;
inout	BOT_V6N2;
inout	BOT_V6N3;
inout	BOT_V6N4;
inout	BOT_V6N5;
inout	BOT_V6N6;
inout	BOT_V6N7;
inout	BOT_V6N8;
inout	BOT_V6N9;
inout	BOT_V6N10;
inout	BOT_V6N11;
inout	BOT_V6A0;
inout	BOT_V6A1;
inout	BOT_V6A2;
inout	BOT_V6A3;
inout	BOT_V6A4;
inout	BOT_V6A5;
inout	BOT_V6A6;
inout	BOT_V6A7;
inout	BOT_V6A8;
inout	BOT_V6A9;
inout	BOT_V6A10;
inout	BOT_V6A11;
inout	BOT_V6B0;
inout	BOT_V6B1;
inout	BOT_V6B2;
inout	BOT_V6B3;
inout	BOT_V6B4;
inout	BOT_V6B5;
inout	BOT_V6B6;
inout	BOT_V6B7;
inout	BOT_V6B8;
inout	BOT_V6B9;
inout	BOT_V6B10;
inout	BOT_V6B11;
inout	BOT_V6M0;
inout	BOT_V6M1;
inout	BOT_V6M2;
inout	BOT_V6M3;
inout	BOT_V6M4;
inout	BOT_V6M5;
inout	BOT_V6M6;
inout	BOT_V6M7;
inout	BOT_V6M8;
inout	BOT_V6M9;
inout	BOT_V6M10;
inout	BOT_V6M11;
inout	BOT_V6C0;
inout	BOT_V6C1;
inout	BOT_V6C2;
inout	BOT_V6C3;
inout	BOT_V6C4;
inout	BOT_V6C5;
inout	BOT_V6C6;
inout	BOT_V6C7;
inout	BOT_V6C8;
inout	BOT_V6C9;
inout	BOT_V6C10;
inout	BOT_V6C11;
inout	BOT_V6D0;
inout	BOT_V6D1;
inout	BOT_V6D2;
inout	BOT_V6D3;
inout	BOT_V6D4;
inout	BOT_V6D5;
inout	BOT_V6D6;
inout	BOT_V6D7;
inout	BOT_V6D8;
inout	BOT_V6D9;
inout	BOT_V6D10;
inout	BOT_V6D11;
inout	BOT_LLH0;
inout	BOT_LLH6;
inout	BOT_LLV0;
inout	BOT_LLV1;
inout	BOT_LLV2;
inout	BOT_LLV3;
inout	BOT_LLV4;
inout	BOT_LLV5;
inout	BOT_LLV6;
inout	BOT_LLV7;
inout	BOT_LLV8;
inout	BOT_LLV9;
inout	BOT_LLV10;
inout	BOT_LLV11;
inout	BOT_HGCLK0;
inout	BOT_HGCLK1;
inout	BOT_HGCLK2;
inout	BOT_HGCLK3;
inout	BOT_I2;
inout	BOT_I1;
inout	BOT_IQ2;
inout	BOT_IQ1;
inout	BOT_ICE2;
inout	BOT_ICE1;
inout	BOT_O2;
inout	BOT_O1;
inout	BOT_OCE2;
inout	BOT_OCE1;
inout	BOT_T2;
inout	BOT_T1;
inout	BOT_TCE2;
inout	BOT_TCE1;
inout	BOT_CLK2;
inout	BOT_CLK1;
inout	BOT_SR_B2;
inout	BOT_SR_B1;
inout	_1;
		wire		BOT_N_BUF23 ;
		wire		BOT_N_BUF22 ;
		wire		BOT_N_BUF21 ;
		wire		BOT_N_BUF20 ;
		wire		BOT_N_BUF19 ;
		wire		BOT_N_BUF18 ;
		wire		BOT_N_BUF17 ;
		wire		BOT_N_BUF16 ;
		wire		BOT_N_BUF15 ;
		wire		BOT_N_BUF14 ;
		wire		BOT_N_BUF13 ;
		wire		BOT_N_BUF12 ;
		wire		BOT_N_BUF11 ;
		wire		BOT_N_BUF10 ;
		wire		BOT_N_BUF9 ;
		wire		BOT_N_BUF8 ;
		wire		BOT_N_BUF7 ;
		wire		BOT_N_BUF6 ;
		wire		BOT_N_BUF5 ;
		wire		BOT_N_BUF4 ;
		wire		BOT_N_BUF3 ;
		wire		BOT_N_BUF2 ;
		wire		BOT_N_BUF1 ;
		wire		BOT_N_BUF0 ;
		wire		BOT_H6A_BUF0 ;
		wire		BOT_H6A_BUF1 ;
		wire		BOT_H6A_BUF2 ;
		wire		BOT_H6A_BUF3 ;
		wire		BOT_H6B_BUF0 ;
		wire		BOT_H6B_BUF1 ;
		wire		BOT_H6B_BUF2 ;
		wire		BOT_H6B_BUF3 ;
		wire		BOT_H6M_BUF0 ;
		wire		BOT_H6M_BUF1 ;
		wire		BOT_H6M_BUF2 ;
		wire		BOT_H6M_BUF3 ;
		wire		BOT_H6C_BUF0 ;
		wire		BOT_H6C_BUF1 ;
		wire		BOT_H6C_BUF2 ;
		wire		BOT_H6C_BUF3 ;
		wire		BOT_H6D_BUF0 ;
		wire		BOT_H6D_BUF1 ;
		wire		BOT_H6D_BUF2 ;
		wire		BOT_H6D_BUF3 ;
		wire		BOT_H6W_BUF0 ;
		wire		BOT_H6W_BUF1 ;
		wire		BOT_H6W_BUF2 ;
		wire		BOT_H6W_BUF3 ;
		wire		BOT_V6N_BUF0 ;
		wire		BOT_V6N_BUF1 ;
		wire		BOT_V6N_BUF2 ;
		wire		BOT_V6N_BUF3 ;
		wire		BOT_V6A_BUF0 ;
		wire		BOT_V6A_BUF1 ;
		wire		BOT_V6A_BUF2 ;
		wire		BOT_V6A_BUF3 ;
		wire		BOT_V6B_BUF0 ;
		wire		BOT_V6B_BUF1 ;
		wire		BOT_V6B_BUF2 ;
		wire		BOT_V6B_BUF3 ;
		wire		BOT_V6M_BUF0 ;
		wire		BOT_V6M_BUF1 ;
		wire		BOT_V6M_BUF2 ;
		wire		BOT_V6M_BUF3 ;
		wire		BOT_V6C_BUF0 ;
		wire		BOT_V6C_BUF1 ;
		wire		BOT_V6C_BUF2 ;
		wire		BOT_V6C_BUF3 ;
		wire		BOT_V6D_BUF0 ;
		wire		BOT_V6D_BUF1 ;
		wire		BOT_V6D_BUF2 ;
		wire		BOT_V6D_BUF3 ;
		wire		BOT_FAKE_LLH0 ;
		wire		BOT_FAKE_LLH6 ;
		wire		BOT_I3 ;
		wire		BOT_I0 ;
		wire		BOT_IQ3 ;
		wire		BOT_IQ0 ;
		wire		BOT_GCLK0 ;
		wire		BOT_GCLK1 ;
		wire		BOT_GCLK2 ;
		wire		BOT_GCLK3 ;

		SPS2N2X0H2 sps_n7(
											.IN0(BOT_IQ0),
											.IN1(BOT_H6M1),
											.OUT(BOT_N7),
											._1(1)
		);

		SPS2N2X0H2 sps_n6(
											.IN0(BOT_IQ1),
											.IN1(BOT_H6W1),
											.OUT(BOT_N6),
											._1(1)
		);

		SPS2N2X0H2 sps_n5(
											.IN0(BOT_IQ2),
											.IN1(BOT_H6E0),
											.OUT(BOT_N5),
											._1(1)
		);

		SPS2N2X0H2 sps_n4(
											.IN0(BOT_IQ3),
											.IN1(BOT_H6M0),
											.OUT(BOT_N4),
											._1(1)
		);

		SPS2N2X0H2 sps_n3(
											.IN0(BOT_I0),
											.IN1(BOT_H6W0),
											.OUT(BOT_N3),
											._1(1)
		);

		SPS2N2X0H2 sps_n2(
											.IN0(BOT_I1),
											.IN1(BOT_H6E0),
											.OUT(BOT_N2),
											._1(1)
		);

		SPS2N2X0H2 sps_n1(
											.IN0(BOT_I2),
											.IN1(BOT_H6M0),
											.OUT(BOT_N1),
											._1(1)
		);

		SPS2N2X0H2 sps_n0(
											.IN0(BOT_I3),
											.IN1(BOT_H6W0),
											.OUT(BOT_N0),
											._1(1)
		);

		SPS16N6X0H2 sps_t2(
											.IN8(BOT_V6C_BUF0),
											.IN9(BOT_V6D_BUF0),
											.IN4(BOT_V6N_BUF0),
											.IN5(BOT_V6A_BUF0),
											.IN6(BOT_V6B_BUF0),
											.IN7(BOT_V6M_BUF0),
											.IN0(BOT_N_BUF3),
											.IN1(BOT_N_BUF2),
											.IN2(BOT_N_BUF1),
											.IN3(BOT_N_BUF0),
											.OUT(BOT_T2),
											.IN14(BOT_H6D_BUF0),
											.IN15(BOT_H6W_BUF0),
											.IN12(BOT_H6M_BUF0),
											.IN13(BOT_H6C_BUF0),
											.IN10(BOT_H6A_BUF0),
											.IN11(BOT_H6B_BUF0),
											._1(1)
		);

		SPS2N2X0H2 sps_n9(
											.IN0(BOT_I2),
											.IN1(BOT_H6W1),
											.OUT(BOT_N9),
											._1(1)
		);

		SPS2N2X0H2 sps_n8(
											.IN0(BOT_I3),
											.IN1(BOT_H6E1),
											.OUT(BOT_N8),
											._1(1)
		);

		SPS2T2X11H2 sps_llv1(
											.IN0(BOT_I0),
											.IN1(BOT_H6D5),
											.OUT(BOT_LLV1),
											._1(1)
		);

		SPS2T2X11H2 sps_llv0(
											.IN0(BOT_IQ0),
											.IN1(BOT_H6W5),
											.OUT(BOT_LLV0),
											._1(1)
		);

		SPS2T2X11H2 sps_llv3(
											.IN0(BOT_IQ1),
											.IN1(BOT_H6M5),
											.OUT(BOT_LLV3),
											._1(1)
		);

		SPS2T2X11H2 sps_llv2(
											.IN0(BOT_IQ1),
											.IN1(BOT_H6C5),
											.OUT(BOT_LLV2),
											._1(1)
		);

		SPS2T2X11H2 sps_llv5(
											.IN0(BOT_I1),
											.IN1(BOT_H6A5),
											.OUT(BOT_LLV5),
											._1(1)
		);

		SPS2T2X11H2 sps_llv4(
											.IN0(BOT_I1),
											.IN1(BOT_H6B5),
											.OUT(BOT_LLV4),
											._1(1)
		);

		SPS2T2X11H2 sps_llv7(
											.IN0(BOT_IQ2),
											.IN1(BOT_H6D4),
											.OUT(BOT_LLV7),
											._1(1)
		);

		SPS16N6X0H2 sps_ice1(
											.IN8(BOT_V6C_BUF3),
											.IN9(BOT_V6D_BUF3),
											.IN4(BOT_V6N_BUF3),
											.IN5(BOT_V6A_BUF3),
											.IN6(BOT_V6B_BUF3),
											.IN7(BOT_V6M_BUF3),
											.IN0(BOT_N_BUF23),
											.IN1(BOT_N_BUF22),
											.IN2(BOT_N_BUF21),
											.IN3(BOT_N_BUF20),
											.OUT(BOT_ICE1),
											.IN14(BOT_H6D_BUF3),
											.IN15(BOT_H6W_BUF3),
											.IN12(BOT_H6M_BUF3),
											.IN13(BOT_H6C_BUF3),
											.IN10(BOT_H6A_BUF3),
											.IN11(BOT_H6B_BUF3),
											._1(1)
		);

		BUF1B0X2H3 buf_v6d2(
											.A(BOT_V6D2),
											.Y(BOT_V6D_BUF2)
		);

		BUF1B0X2H3 buf_v6d3(
											.A(BOT_V6D3),
											.Y(BOT_V6D_BUF3)
		);

		BUF1B0X2H3 buf_v6d0(
											.A(BOT_V6D0),
											.Y(BOT_V6D_BUF0)
		);

		BUF1B0X2H3 buf_v6d1(
											.A(BOT_V6D1),
											.Y(BOT_V6D_BUF1)
		);

		SPS16N6X0H2 sps_ice2(
											.IN8(BOT_V6C_BUF3),
											.IN9(BOT_V6D_BUF3),
											.IN4(BOT_V6N_BUF3),
											.IN5(BOT_V6A_BUF3),
											.IN6(BOT_V6B_BUF3),
											.IN7(BOT_V6M_BUF3),
											.IN0(BOT_N_BUF23),
											.IN1(BOT_N_BUF22),
											.IN2(BOT_N_BUF21),
											.IN3(BOT_N_BUF20),
											.OUT(BOT_ICE2),
											.IN14(BOT_H6D_BUF3),
											.IN15(BOT_H6W_BUF3),
											.IN12(BOT_H6M_BUF3),
											.IN13(BOT_H6C_BUF3),
											.IN10(BOT_H6A_BUF3),
											.IN11(BOT_H6B_BUF3),
											._1(1)
		);

		BUF1B0X2H5 buf_n18(
											.A(BOT_N18),
											.Y(BOT_N_BUF18)
		);

		BUF1B0X2H3 buf_h6a2(
											.A(BOT_H6A2),
											.Y(BOT_H6A_BUF2)
		);

		BUF1B0X2H3 buf_h6a1(
											.A(BOT_H6A1),
											.Y(BOT_H6A_BUF1)
		);

		BUF1B0X2H3 buf_h6a0(
											.A(BOT_H6A0),
											.Y(BOT_H6A_BUF0)
		);

		BUF1B0X2H5 buf_n14(
											.A(BOT_N14),
											.Y(BOT_N_BUF14)
		);

		BUF1B0X2H5 buf_n15(
											.A(BOT_N15),
											.Y(BOT_N_BUF15)
		);

		BUF1B0X2H5 buf_n16(
											.A(BOT_N16),
											.Y(BOT_N_BUF16)
		);

		BUF1B0X2H5 buf_n17(
											.A(BOT_N17),
											.Y(BOT_N_BUF17)
		);

		BUF1B0X2H5 buf_n10(
											.A(BOT_N10),
											.Y(BOT_N_BUF10)
		);

		BUF1B0X2H5 buf_n11(
											.A(BOT_N11),
											.Y(BOT_N_BUF11)
		);

		BUF1B0X2H5 buf_n12(
											.A(BOT_N12),
											.Y(BOT_N_BUF12)
		);

		BUF1B0X2H5 buf_n13(
											.A(BOT_N13),
											.Y(BOT_N_BUF13)
		);

		SPS2N2X0H2 sps_n17(
											.IN0(BOT_I2),
											.IN1(BOT_H6E2),
											.OUT(BOT_N17),
											._1(1)
		);

		SPS2N2X0H2 sps_n16(
											.IN0(BOT_I3),
											.IN1(BOT_H6M2),
											.OUT(BOT_N16),
											._1(1)
		);

		SPS2N2X0H2 sps_n15(
											.IN0(BOT_IQ0),
											.IN1(BOT_H6W2),
											.OUT(BOT_N15),
											._1(1)
		);

		SPS2N2X0H2 sps_n14(
											.IN0(BOT_IQ1),
											.IN1(BOT_H6E2),
											.OUT(BOT_N14),
											._1(1)
		);

		SPS2N2X0H2 sps_n13(
											.IN0(BOT_IQ2),
											.IN1(BOT_H6M2),
											.OUT(BOT_N13),
											._1(1)
		);

		SPS2N2X0H2 sps_n12(
											.IN0(BOT_IQ3),
											.IN1(BOT_H6W2),
											.OUT(BOT_N12),
											._1(1)
		);

		SPS2N2X0H2 sps_n11(
											.IN0(BOT_I0),
											.IN1(BOT_H6E1),
											.OUT(BOT_N11),
											._1(1)
		);

		SPS2N2X0H2 sps_n10(
											.IN0(BOT_I1),
											.IN1(BOT_H6M1),
											.OUT(BOT_N10),
											._1(1)
		);

		SPS2N2X0H2 sps_n19(
											.IN0(BOT_I0),
											.IN1(BOT_H6M3),
											.OUT(BOT_N19),
											._1(1)
		);

		SPS2N2X0H2 sps_n18(
											.IN0(BOT_I1),
											.IN1(BOT_H6W3),
											.OUT(BOT_N18),
											._1(1)
		);

		SPS6B6X2H1 sps_v6n11(
											.IN4(BOT_H6E3),
											.IN5(BOT_V6D10),
											.IN0(BOT_IQ3),
											.IN1(BOT_I3),
											.IN2(BOT_H6W1),
											.IN3(BOT_H6M2),
											.OUT(BOT_V6N11),
											._1(1)
		);

		BUF1B0X2H3 buf_v6m1(
											.A(BOT_V6M1),
											.Y(BOT_V6M_BUF1)
		);

		BUF1B0X2H3 buf_v6m0(
											.A(BOT_V6M0),
											.Y(BOT_V6M_BUF0)
		);

		BUF1B0X2H3 buf_v6m3(
											.A(BOT_V6M3),
											.Y(BOT_V6M_BUF3)
		);

		BUF1B0X2H3 buf_v6m2(
											.A(BOT_V6M2),
											.Y(BOT_V6M_BUF2)
		);

		BUF1B0X2H3 buf_v6a4_v6c5(
											.A(BOT_V6A4),
											.Y(BOT_V6C5)
		);

		SPS20N8X0H1 sps_clk2(
											.IN8(BOT_V6C_BUF2),
											.IN9(BOT_V6D_BUF2),
											.IN4(BOT_V6N_BUF2),
											.IN5(BOT_V6A_BUF2),
											.IN6(BOT_V6B_BUF2),
											.IN7(BOT_V6M_BUF2),
											.IN0(BOT_N_BUF15),
											.IN1(BOT_N_BUF14),
											.IN2(BOT_N_BUF9),
											.IN3(BOT_N_BUF8),
											.OUT(BOT_CLK2),
											.IN18(BOT_GCLK2),
											.IN19(BOT_GCLK3),
											.IN16(BOT_GCLK0),
											.IN17(BOT_GCLK1),
											.IN14(BOT_H6D_BUF2),
											.IN15(BOT_H6W_BUF2),
											.IN12(BOT_H6M_BUF2),
											.IN13(BOT_H6C_BUF2),
											.IN10(BOT_H6A_BUF2),
											.IN11(BOT_H6B_BUF2),
											._1(1)
		);

		BUF1B0X2H3 buf_h6b2(
											.A(BOT_H6B2),
											.Y(BOT_H6B_BUF2)
		);

		BUF1B0X2H3 buf_h6b3(
											.A(BOT_H6B3),
											.Y(BOT_H6B_BUF3)
		);

		BUF1B0X2H3 buf_h6b0(
											.A(BOT_H6B0),
											.Y(BOT_H6B_BUF0)
		);

		BUF1B0X2H3 buf_h6b1(
											.A(BOT_H6B1),
											.Y(BOT_H6B_BUF1)
		);

		SPS6B6X2H1 sps_v6a9(
											.IN4(BOT_H6E0),
											.IN5(BOT_V6C8),
											.IN0(BOT_IQ2),
											.IN1(BOT_I2),
											.IN2(BOT_H6W2),
											.IN3(BOT_H6M3),
											.OUT(BOT_V6A9),
											._1(1)
		);

		BUF1B0X2H5 buf_n21(
											.A(BOT_N21),
											.Y(BOT_N_BUF21)
		);

		BUF1B0X2H5 buf_n20(
											.A(BOT_N20),
											.Y(BOT_N_BUF20)
		);

		BUF1B0X2H5 buf_n23(
											.A(BOT_N23),
											.Y(BOT_N_BUF23)
		);

		BUF1B0X2H5 buf_n22(
											.A(BOT_N22),
											.Y(BOT_N_BUF22)
		);

		SPS4T5X11H1 sps_v6a0(
											.IN3(BOT_LLV11),
											.IN0(BOT_I0),
											.IN1(BOT_I1),
											.IN2(BOT_IQ1),
											.OUT(BOT_V6A0),
											._1(1)
		);

		SPS4T5X11H1 sps_v6a1(
											.IN3(BOT_LLV11),
											.IN0(BOT_I2),
											.IN1(BOT_I3),
											.IN2(BOT_IQ0),
											.OUT(BOT_V6A1),
											._1(1)
		);

		SPS4T5X11H1 sps_v6a2(
											.IN3(BOT_LLV5),
											.IN0(BOT_IQ0),
											.IN1(BOT_IQ1),
											.IN2(BOT_I3),
											.OUT(BOT_V6A2),
											._1(1)
		);

		SPS4T5X11H1 sps_v6a3(
											.IN3(BOT_LLV5),
											.IN0(BOT_IQ2),
											.IN1(BOT_IQ3),
											.IN2(BOT_I2),
											.OUT(BOT_V6A3),
											._1(1)
		);

		SPS2T2X11H2 sps_llv11(
											.IN0(BOT_I3),
											.IN1(BOT_H6A4),
											.OUT(BOT_LLV11),
											._1(1)
		);

		SPS2T2X11H2 sps_llv10(
											.IN0(BOT_IQ3),
											.IN1(BOT_H6B4),
											.OUT(BOT_LLV10),
											._1(1)
		);

		SPS6B6X2H1 sps_v6a5(
											.IN4(BOT_H6E2),
											.IN5(BOT_V6C4),
											.IN0(BOT_IQ0),
											.IN1(BOT_I0),
											.IN2(BOT_H6W0),
											.IN3(BOT_H6M1),
											.OUT(BOT_V6A5),
											._1(1)
		);

		BUF1B0X2H3 buf_v6n4_v6d5(
											.A(BOT_V6N4),
											.Y(BOT_V6D5)
		);

		SPS6B6X2H1 sps_v6a7(
											.IN4(BOT_H6W3),
											.IN5(BOT_V6C6),
											.IN0(BOT_IQ1),
											.IN1(BOT_I1),
											.IN2(BOT_H6E1),
											.IN3(BOT_H6M0),
											.OUT(BOT_V6A7),
											._1(1)
		);

		BUF1B0X2H3 buf_v6b8_v6m9(
											.A(BOT_V6B8),
											.Y(BOT_V6M9)
		);

		SPS16N6X0H2 sps_sr_b1(
											.IN8(BOT_V6C_BUF1),
											.IN9(BOT_V6D_BUF1),
											.IN4(BOT_V6N_BUF1),
											.IN5(BOT_V6A_BUF1),
											.IN6(BOT_V6B_BUF1),
											.IN7(BOT_V6M_BUF1),
											.IN0(BOT_N_BUF7),
											.IN1(BOT_N_BUF6),
											.IN2(BOT_N_BUF5),
											.IN3(BOT_N_BUF4),
											.OUT(BOT_SR_B1),
											.IN14(BOT_H6D_BUF1),
											.IN15(BOT_H6W_BUF1),
											.IN12(BOT_H6M_BUF1),
											.IN13(BOT_H6C_BUF1),
											.IN10(BOT_H6A_BUF1),
											.IN11(BOT_H6B_BUF1),
											._1(1)
		);

		SPS16N6X0H2 sps_sr_b2(
											.IN8(BOT_V6C_BUF1),
											.IN9(BOT_V6D_BUF1),
											.IN4(BOT_V6N_BUF1),
											.IN5(BOT_V6A_BUF1),
											.IN6(BOT_V6B_BUF1),
											.IN7(BOT_V6M_BUF1),
											.IN0(BOT_N_BUF7),
											.IN1(BOT_N_BUF6),
											.IN2(BOT_N_BUF5),
											.IN3(BOT_N_BUF4),
											.OUT(BOT_SR_B2),
											.IN14(BOT_H6D_BUF1),
											.IN15(BOT_H6W_BUF1),
											.IN12(BOT_H6M_BUF1),
											.IN13(BOT_H6C_BUF1),
											.IN10(BOT_H6A_BUF1),
											.IN11(BOT_H6B_BUF1),
											._1(1)
		);

		BUF1B0X2H3 buf_v6n10_v6d11(
											.A(BOT_V6N10),
											.Y(BOT_V6D11)
		);

		SPS2T2X11H2 sps_llv6(
											.IN0(BOT_IQ2),
											.IN1(BOT_H6W4),
											.OUT(BOT_LLV6),
											._1(1)
		);

		SPS16N6X0H2 sps_tce1(
											.IN8(BOT_V6C_BUF3),
											.IN9(BOT_V6D_BUF3),
											.IN4(BOT_V6N_BUF3),
											.IN5(BOT_V6A_BUF3),
											.IN6(BOT_V6B_BUF3),
											.IN7(BOT_V6M_BUF3),
											.IN0(BOT_N_BUF13),
											.IN1(BOT_N_BUF12),
											.IN2(BOT_N_BUF11),
											.IN3(BOT_N_BUF10),
											.OUT(BOT_TCE1),
											.IN14(BOT_H6D_BUF3),
											.IN15(BOT_H6W_BUF3),
											.IN12(BOT_H6M_BUF3),
											.IN13(BOT_H6C_BUF3),
											.IN10(BOT_H6A_BUF3),
											.IN11(BOT_H6B_BUF3),
											._1(1)
		);

		SPS2T2X11H2 sps_llv9(
											.IN0(BOT_I2),
											.IN1(BOT_H6M4),
											.OUT(BOT_LLV9),
											._1(1)
		);

		BUF1B0X2H3 buf_v6n8_v6d9(
											.A(BOT_V6N8),
											.Y(BOT_V6D9)
		);

		SPS16N6X0H2 sps_tce2(
											.IN8(BOT_V6C_BUF3),
											.IN9(BOT_V6D_BUF3),
											.IN4(BOT_V6N_BUF3),
											.IN5(BOT_V6A_BUF3),
											.IN6(BOT_V6B_BUF3),
											.IN7(BOT_V6M_BUF3),
											.IN0(BOT_N_BUF13),
											.IN1(BOT_N_BUF12),
											.IN2(BOT_N_BUF11),
											.IN3(BOT_N_BUF10),
											.OUT(BOT_TCE2),
											.IN14(BOT_H6D_BUF3),
											.IN15(BOT_H6W_BUF3),
											.IN12(BOT_H6M_BUF3),
											.IN13(BOT_H6C_BUF3),
											.IN10(BOT_H6A_BUF3),
											.IN11(BOT_H6B_BUF3),
											._1(1)
		);

		BUF1B0X2H3 buf_v6b10_v6m11(
											.A(BOT_V6B10),
											.Y(BOT_V6M11)
		);

		SPS2T2X11H2 sps_llv8(
											.IN0(BOT_I2),
											.IN1(BOT_H6C4),
											.OUT(BOT_LLV8),
											._1(1)
		);

		BUF1B0X2H3 buf_h6c1(
											.A(BOT_H6C1),
											.Y(BOT_H6C_BUF1)
		);

		BUF1B0X2H3 buf_h6c0(
											.A(BOT_H6C0),
											.Y(BOT_H6C_BUF0)
		);

		BUF1B0X2H3 buf_h6c3(
											.A(BOT_H6C3),
											.Y(BOT_H6C_BUF3)
		);

		BUF1B0X2H3 buf_h6c2(
											.A(BOT_H6C2),
											.Y(BOT_H6C_BUF2)
		);

		SPS6B6X2H1 sps_v6n7(
											.IN4(BOT_H6W3),
											.IN5(BOT_V6D6),
											.IN0(BOT_IQ1),
											.IN1(BOT_I1),
											.IN2(BOT_H6E1),
											.IN3(BOT_H6M0),
											.OUT(BOT_V6N7),
											._1(1)
		);

		BUF1B0X2H3 buf_v6b0(
											.A(BOT_V6B0),
											.Y(BOT_V6B_BUF0)
		);

		BUF1B0X2H3 buf_v6b1(
											.A(BOT_V6B1),
											.Y(BOT_V6B_BUF1)
		);

		BUF1B0X2H3 buf_v6b2(
											.A(BOT_V6B2),
											.Y(BOT_V6B_BUF2)
		);

		BUF1B0X2H3 buf_v6b3(
											.A(BOT_V6B3),
											.Y(BOT_V6B_BUF3)
		);

		SPS16N6X0H2 sps_oce2(
											.IN8(BOT_V6C_BUF3),
											.IN9(BOT_V6D_BUF3),
											.IN4(BOT_V6N_BUF3),
											.IN5(BOT_V6A_BUF3),
											.IN6(BOT_V6B_BUF3),
											.IN7(BOT_V6M_BUF3),
											.IN0(BOT_N_BUF19),
											.IN1(BOT_N_BUF18),
											.IN2(BOT_N_BUF17),
											.IN3(BOT_N_BUF16),
											.OUT(BOT_OCE2),
											.IN14(BOT_H6D_BUF3),
											.IN15(BOT_H6W_BUF3),
											.IN12(BOT_H6M_BUF3),
											.IN13(BOT_H6C_BUF3),
											.IN10(BOT_H6A_BUF3),
											.IN11(BOT_H6B_BUF3),
											._1(1)
		);

		SPS16N6X0H2 sps_oce1(
											.IN8(BOT_V6C_BUF3),
											.IN9(BOT_V6D_BUF3),
											.IN4(BOT_V6N_BUF3),
											.IN5(BOT_V6A_BUF3),
											.IN6(BOT_V6B_BUF3),
											.IN7(BOT_V6M_BUF3),
											.IN0(BOT_N_BUF19),
											.IN1(BOT_N_BUF18),
											.IN2(BOT_N_BUF17),
											.IN3(BOT_N_BUF16),
											.OUT(BOT_OCE1),
											.IN14(BOT_H6D_BUF3),
											.IN15(BOT_H6W_BUF3),
											.IN12(BOT_H6M_BUF3),
											.IN13(BOT_H6C_BUF3),
											.IN10(BOT_H6A_BUF3),
											.IN11(BOT_H6B_BUF3),
											._1(1)
		);

		SPS16T10X11H1 sps_llh6(
											.IN8(BOT_N_BUF23),
											.IN9(BOT_N_BUF22),
											.IN4(BOT_IQ2),
											.IN5(BOT_I2),
											.IN6(BOT_IQ3),
											.IN7(BOT_I3),
											.IN0(BOT_IQ0),
											.IN1(BOT_I0),
											.IN2(BOT_IQ1),
											.IN3(BOT_I1),
											.OUT(BOT_LLH6),
											.IN14(BOT_N_BUF6),
											.IN15(BOT_N_BUF5),
											.IN12(BOT_N_BUF11),
											.IN13(BOT_N_BUF10),
											.IN10(BOT_N_BUF18),
											.IN11(BOT_N_BUF17),
											._1(1)
		);

		SPS16T10X11H1 sps_llh0(
											.IN8(BOT_N_BUF23),
											.IN9(BOT_N_BUF22),
											.IN4(BOT_IQ2),
											.IN5(BOT_I2),
											.IN6(BOT_IQ3),
											.IN7(BOT_I3),
											.IN0(BOT_IQ0),
											.IN1(BOT_I0),
											.IN2(BOT_IQ1),
											.IN3(BOT_I1),
											.OUT(BOT_LLH0),
											.IN14(BOT_N_BUF6),
											.IN15(BOT_N_BUF5),
											.IN12(BOT_N_BUF11),
											.IN13(BOT_N_BUF10),
											.IN10(BOT_N_BUF18),
											.IN11(BOT_N_BUF17),
											._1(1)
		);

		BUF1B0X2H3 buf_h6a3(
											.A(BOT_H6A3),
											.Y(BOT_H6A_BUF3)
		);

		BUF1B0X2H5 buf_n19(
											.A(BOT_N19),
											.Y(BOT_N_BUF19)
		);

		SPS4T5X11H1 sps_v6c2(
											.IN3(BOT_LLV2),
											.IN0(BOT_I0),
											.IN1(BOT_IQ2),
											.IN2(BOT_IQ3),
											.OUT(BOT_V6C2),
											._1(1)
		);

		SPS4T5X11H1 sps_v6c3(
											.IN3(BOT_LLV2),
											.IN0(BOT_I0),
											.IN1(BOT_I1),
											.IN2(BOT_I2),
											.OUT(BOT_V6C3),
											._1(1)
		);

		SPS4T5X11H1 sps_v6c0(
											.IN3(BOT_LLV8),
											.IN0(BOT_IQ0),
											.IN1(BOT_I2),
											.IN2(BOT_I3),
											.OUT(BOT_V6C0),
											._1(1)
		);

		SPS4T5X11H1 sps_v6c1(
											.IN3(BOT_LLV8),
											.IN0(BOT_IQ0),
											.IN1(BOT_IQ1),
											.IN2(BOT_IQ2),
											.OUT(BOT_V6C1),
											._1(1)
		);

		BUF1B0X2H3 buf_v6c3(
											.A(BOT_V6C3),
											.Y(BOT_V6C_BUF3)
		);

		BUF1B0X2H3 buf_h6d1(
											.A(BOT_H6D1),
											.Y(BOT_H6D_BUF1)
		);

		BUF1B0X2H3 buf_v6c1(
											.A(BOT_V6C1),
											.Y(BOT_V6C_BUF1)
		);

		BUF1B0X2H3 buf_h6d3(
											.A(BOT_H6D3),
											.Y(BOT_H6D_BUF3)
		);

		BUF1B0X2H3 buf_v6b4_v6m5(
											.A(BOT_V6B4),
											.Y(BOT_V6M5)
		);

		SPS12T8X11H1 sps_h6e2(
											.IN8(BOT_I0),
											.IN9(BOT_FAKE_LLH6),
											.IN4(BOT_I2),
											.IN5(BOT_IQ1),
											.IN6(BOT_I1),
											.IN7(BOT_IQ0),
											.IN0(BOT_H6W2),
											.IN1(BOT_IQ3),
											.IN2(BOT_I3),
											.IN3(BOT_IQ2),
											.OUT(BOT_H6E2),
											.IN10(BOT_V6M0),
											.IN11(BOT_V6N1),
											._1(1)
		);

		SPS12T8X11H1 sps_h6e3(
											.IN8(BOT_I0),
											.IN9(BOT_FAKE_LLH6),
											.IN4(BOT_I2),
											.IN5(BOT_IQ1),
											.IN6(BOT_I1),
											.IN7(BOT_IQ0),
											.IN0(BOT_H6W3),
											.IN1(BOT_IQ3),
											.IN2(BOT_I3),
											.IN3(BOT_IQ2),
											.OUT(BOT_H6E3),
											.IN10(BOT_V6M1),
											.IN11(BOT_V6N2),
											._1(1)
		);

		BUF1B0X2H3 buf_v6b6_v6m7(
											.A(BOT_V6B6),
											.Y(BOT_V6M7)
		);

		SPS12T8X11H1 sps_h6e0(
											.IN8(BOT_I0),
											.IN9(BOT_FAKE_LLH0),
											.IN4(BOT_I2),
											.IN5(BOT_IQ1),
											.IN6(BOT_I1),
											.IN7(BOT_IQ0),
											.IN0(BOT_H6W0),
											.IN1(BOT_IQ3),
											.IN2(BOT_I3),
											.IN3(BOT_IQ2),
											.OUT(BOT_H6E0),
											.IN10(BOT_V6M2),
											.IN11(BOT_V6N3),
											._1(1)
		);

		SPS2N2X0H2 sps_n20(
											.IN0(BOT_IQ3),
											.IN1(BOT_H6E3),
											.OUT(BOT_N20),
											._1(1)
		);

		SPS2N2X0H2 sps_n21(
											.IN0(BOT_IQ2),
											.IN1(BOT_H6W3),
											.OUT(BOT_N21),
											._1(1)
		);

		SPS12T8X11H1 sps_h6e1(
											.IN8(BOT_I0),
											.IN9(BOT_FAKE_LLH0),
											.IN4(BOT_I2),
											.IN5(BOT_IQ1),
											.IN6(BOT_I1),
											.IN7(BOT_IQ0),
											.IN0(BOT_H6W1),
											.IN1(BOT_IQ3),
											.IN2(BOT_I3),
											.IN3(BOT_IQ2),
											.OUT(BOT_H6E1),
											.IN10(BOT_V6M3),
											.IN11(BOT_V6N0),
											._1(1)
		);

		SPS4T5X11H1 sps_v6m0(
											.IN3(BOT_LLV9),
											.IN0(BOT_IQ1),
											.IN1(BOT_IQ2),
											.IN2(BOT_IQ3),
											.OUT(BOT_V6M0),
											._1(1)
		);

		SPS4T5X11H1 sps_v6m1(
											.IN3(BOT_LLV9),
											.IN0(BOT_I0),
											.IN1(BOT_I1),
											.IN2(BOT_IQ3),
											.OUT(BOT_V6M1),
											._1(1)
		);

		SPS4T5X11H1 sps_v6m2(
											.IN3(BOT_LLV3),
											.IN0(BOT_I1),
											.IN1(BOT_I2),
											.IN2(BOT_I3),
											.OUT(BOT_V6M2),
											._1(1)
		);

		SPS4T5X11H1 sps_v6m3(
											.IN3(BOT_LLV3),
											.IN0(BOT_IQ0),
											.IN1(BOT_IQ1),
											.IN2(BOT_I3),
											.OUT(BOT_V6M3),
											._1(1)
		);

		BUF1B0X2H3 buf_v6a8_v6c9(
											.A(BOT_V6A8),
											.Y(BOT_V6C9)
		);

		BUF1B0X2H3 buf_h6m3(
											.A(BOT_H6M3),
											.Y(BOT_H6M_BUF3)
		);

		BUF1B0X2H3 buf_h6m2(
											.A(BOT_H6M2),
											.Y(BOT_H6M_BUF2)
		);

		BUF1B0X2H3 buf_h6m1(
											.A(BOT_H6M1),
											.Y(BOT_H6M_BUF1)
		);

		BUF1B0X2H3 buf_h6m0(
											.A(BOT_H6M0),
											.Y(BOT_H6M_BUF0)
		);

		SPS12T8X11H2 sps_h6e4(
											.IN8(BOT_I0),
											.IN9(BOT_FAKE_LLH6),
											.IN4(BOT_I2),
											.IN5(BOT_IQ1),
											.IN6(BOT_I1),
											.IN7(BOT_IQ0),
											.IN0(BOT_H6W4),
											.IN1(BOT_IQ3),
											.IN2(BOT_I3),
											.IN3(BOT_IQ2),
											.OUT(BOT_H6E4),
											.IN10(BOT_N_BUF7),
											.IN11(BOT_N_BUF0),
											._1(1)
		);

		SPS12T8X11H2 sps_h6e5(
											.IN8(BOT_I0),
											.IN9(BOT_FAKE_LLH0),
											.IN4(BOT_I2),
											.IN5(BOT_IQ1),
											.IN6(BOT_I1),
											.IN7(BOT_IQ0),
											.IN0(BOT_H6W5),
											.IN1(BOT_IQ3),
											.IN2(BOT_I3),
											.IN3(BOT_IQ2),
											.OUT(BOT_H6E5),
											.IN10(BOT_N_BUF19),
											.IN11(BOT_N_BUF12),
											._1(1)
		);

		BUF1B0X2H3 buf_v6m8_v6b9(
											.A(BOT_V6M8),
											.Y(BOT_V6B9)
		);

		BUF1B0X2H3 buf_llh0(
											.A(BOT_LLH0),
											.Y(BOT_FAKE_LLH0)
		);

		BUF1B0X2H3 buf_llh6(
											.A(BOT_LLH6),
											.Y(BOT_FAKE_LLH6)
		);

		SPS4T5X11H1 sps_v6b0(
											.IN3(BOT_LLV10),
											.IN0(BOT_IQ1),
											.IN1(BOT_IQ2),
											.IN2(BOT_IQ3),
											.OUT(BOT_V6B0),
											._1(1)
		);

		SPS4T5X11H1 sps_v6b3(
											.IN3(BOT_LLV4),
											.IN0(BOT_IQ0),
											.IN1(BOT_IQ1),
											.IN2(BOT_I3),
											.OUT(BOT_V6B3),
											._1(1)
		);

		SPS4T5X11H1 sps_v6b2(
											.IN3(BOT_LLV4),
											.IN0(BOT_I1),
											.IN1(BOT_I2),
											.IN2(BOT_I3),
											.OUT(BOT_V6B2),
											._1(1)
		);

		BUF1B0X2H3 buf_v6m6_v6b7(
											.A(BOT_V6M6),
											.Y(BOT_V6B7)
		);

		BUF1B0X2H5 buf_n9(
											.A(BOT_N9),
											.Y(BOT_N_BUF9)
		);

		BUF1B0X2H5 buf_n6(
											.A(BOT_N6),
											.Y(BOT_N_BUF6)
		);

		BUF1B0X2H5 buf_n7(
											.A(BOT_N7),
											.Y(BOT_N_BUF7)
		);

		BUF1B0X2H5 buf_n4(
											.A(BOT_N4),
											.Y(BOT_N_BUF4)
		);

		BUF1B0X2H5 buf_n5(
											.A(BOT_N5),
											.Y(BOT_N_BUF5)
		);

		BUF1B0X2H5 buf_n2(
											.A(BOT_N2),
											.Y(BOT_N_BUF2)
		);

		BUF1B0X2H5 buf_n3(
											.A(BOT_N3),
											.Y(BOT_N_BUF3)
		);

		BUF1B0X2H5 buf_n0(
											.A(BOT_N0),
											.Y(BOT_N_BUF0)
		);

		BUF1B0X2H5 buf_n1(
											.A(BOT_N1),
											.Y(BOT_N_BUF1)
		);

		BUF1B0X2H3 buf_h6w1(
											.A(BOT_H6W1),
											.Y(BOT_H6W_BUF1)
		);

		BUF1B0X2H3 buf_h6w0(
											.A(BOT_H6W0),
											.Y(BOT_H6W_BUF0)
		);

		BUF1B0X2H3 buf_h6w3(
											.A(BOT_H6W3),
											.Y(BOT_H6W_BUF3)
		);

		BUF1B0X2H3 buf_h6w2(
											.A(BOT_H6W2),
											.Y(BOT_H6W_BUF2)
		);

		BUFDUMMY buf_gclk0(
											.OUT(BOT_GCLK0),
											.IN(BOT_HGCLK0)
		);

		BUFDUMMY buf_gclk1(
											.OUT(BOT_GCLK1),
											.IN(BOT_HGCLK1)
		);

		BUFDUMMY buf_gclk2(
											.OUT(BOT_GCLK2),
											.IN(BOT_HGCLK2)
		);

		BUFDUMMY buf_gclk3(
											.OUT(BOT_GCLK3),
											.IN(BOT_HGCLK3)
		);

		SPS6B6X2H1 sps_v6a11(
											.IN4(BOT_H6E3),
											.IN5(BOT_V6C10),
											.IN0(BOT_IQ3),
											.IN1(BOT_I3),
											.IN2(BOT_H6W1),
											.IN3(BOT_H6M2),
											.OUT(BOT_V6A11),
											._1(1)
		);

		BUF1B0X2H3 buf_v6a1(
											.A(BOT_V6A1),
											.Y(BOT_V6A_BUF1)
		);

		BUF1B0X2H3 buf_v6a0(
											.A(BOT_V6A0),
											.Y(BOT_V6A_BUF0)
		);

		BUF1B0X2H3 buf_v6a3(
											.A(BOT_V6A3),
											.Y(BOT_V6A_BUF3)
		);

		BUF1B0X2H3 buf_v6a2(
											.A(BOT_V6A2),
											.Y(BOT_V6A_BUF2)
		);

		BUF1B0X2H3 buf_h6d0(
											.A(BOT_H6D0),
											.Y(BOT_H6D_BUF0)
		);

		BUF1B0X2H3 buf_v6c2(
											.A(BOT_V6C2),
											.Y(BOT_V6C_BUF2)
		);

		BUF1B0X2H3 buf_h6d2(
											.A(BOT_H6D2),
											.Y(BOT_H6D_BUF2)
		);

		SPS12T8X11H2 sps_h6w4(
											.IN8(BOT_I0),
											.IN9(BOT_FAKE_LLH0),
											.IN4(BOT_I2),
											.IN5(BOT_IQ1),
											.IN6(BOT_I1),
											.IN7(BOT_IQ0),
											.IN0(BOT_H6E4),
											.IN1(BOT_IQ3),
											.IN2(BOT_I3),
											.IN3(BOT_IQ2),
											.OUT(BOT_H6W4),
											.IN10(BOT_N_BUF19),
											.IN11(BOT_N_BUF12),
											._1(1)
		);

		SPS12T8X11H2 sps_h6w5(
											.IN8(BOT_I0),
											.IN9(BOT_FAKE_LLH6),
											.IN4(BOT_I2),
											.IN5(BOT_IQ1),
											.IN6(BOT_I1),
											.IN7(BOT_IQ0),
											.IN0(BOT_H6E5),
											.IN1(BOT_IQ3),
											.IN2(BOT_I3),
											.IN3(BOT_IQ2),
											.OUT(BOT_H6W5),
											.IN10(BOT_N_BUF7),
											.IN11(BOT_N_BUF0),
											._1(1)
		);

		BUF1B0X2H3 buf_v6c0(
											.A(BOT_V6C0),
											.Y(BOT_V6C_BUF0)
		);

		SPS12T8X11H1 sps_h6w0(
											.IN8(BOT_I0),
											.IN9(BOT_FAKE_LLH0),
											.IN4(BOT_I2),
											.IN5(BOT_IQ1),
											.IN6(BOT_I1),
											.IN7(BOT_IQ0),
											.IN0(BOT_H6E0),
											.IN1(BOT_IQ3),
											.IN2(BOT_I3),
											.IN3(BOT_IQ2),
											.OUT(BOT_H6W0),
											.IN10(BOT_V6M2),
											.IN11(BOT_V6N0),
											._1(1)
		);

		SPS12T8X11H1 sps_h6w1(
											.IN8(BOT_I0),
											.IN9(BOT_FAKE_LLH0),
											.IN4(BOT_I2),
											.IN5(BOT_IQ1),
											.IN6(BOT_I1),
											.IN7(BOT_IQ0),
											.IN0(BOT_H6E1),
											.IN1(BOT_IQ3),
											.IN2(BOT_I3),
											.IN3(BOT_IQ2),
											.OUT(BOT_H6W1),
											.IN10(BOT_V6M3),
											.IN11(BOT_V6N1),
											._1(1)
		);

		SPS12T8X11H1 sps_h6w2(
											.IN8(BOT_I0),
											.IN9(BOT_FAKE_LLH6),
											.IN4(BOT_I2),
											.IN5(BOT_IQ1),
											.IN6(BOT_I1),
											.IN7(BOT_IQ0),
											.IN0(BOT_H6E2),
											.IN1(BOT_IQ3),
											.IN2(BOT_I3),
											.IN3(BOT_IQ2),
											.OUT(BOT_H6W2),
											.IN10(BOT_V6M0),
											.IN11(BOT_V6N2),
											._1(1)
		);

		SPS12T8X11H1 sps_h6w3(
											.IN8(BOT_I0),
											.IN9(BOT_FAKE_LLH6),
											.IN4(BOT_I2),
											.IN5(BOT_IQ1),
											.IN6(BOT_I1),
											.IN7(BOT_IQ0),
											.IN0(BOT_H6E3),
											.IN1(BOT_IQ3),
											.IN2(BOT_I3),
											.IN3(BOT_IQ2),
											.OUT(BOT_H6W3),
											.IN10(BOT_V6M1),
											.IN11(BOT_V6N3),
											._1(1)
		);

		BUF1B0X2H3 buf_v6n0(
											.A(BOT_V6N0),
											.Y(BOT_V6N_BUF0)
		);

		BUF1B0X2H3 buf_v6n1(
											.A(BOT_V6N1),
											.Y(BOT_V6N_BUF1)
		);

		BUF1B0X2H3 buf_v6n2(
											.A(BOT_V6N2),
											.Y(BOT_V6N_BUF2)
		);

		BUF1B0X2H3 buf_v6n3(
											.A(BOT_V6N3),
											.Y(BOT_V6N_BUF3)
		);

		BUF1B0X2H5 buf_n8(
											.A(BOT_N8),
											.Y(BOT_N_BUF8)
		);

		SPS4T5X11H1 sps_v6d3(
											.IN3(BOT_LLV1),
											.IN0(BOT_I0),
											.IN1(BOT_I1),
											.IN2(BOT_I2),
											.OUT(BOT_V6D3),
											._1(1)
		);

		SPS4T5X11H1 sps_v6d2(
											.IN3(BOT_LLV1),
											.IN0(BOT_I0),
											.IN1(BOT_IQ2),
											.IN2(BOT_IQ3),
											.OUT(BOT_V6D2),
											._1(1)
		);

		SPS4T5X11H1 sps_v6d1(
											.IN3(BOT_LLV7),
											.IN0(BOT_IQ0),
											.IN1(BOT_IQ1),
											.IN2(BOT_IQ2),
											.OUT(BOT_V6D1),
											._1(1)
		);

		SPS4T5X11H1 sps_v6d0(
											.IN3(BOT_LLV7),
											.IN0(BOT_IQ0),
											.IN1(BOT_I2),
											.IN2(BOT_I3),
											.OUT(BOT_V6D0),
											._1(1)
		);

		BUF1B0X2H3 buf_v6a6_v6c7(
											.A(BOT_V6A6),
											.Y(BOT_V6C7)
		);

		SPS20N8X0H1 sps_clk1(
											.IN8(BOT_V6C_BUF2),
											.IN9(BOT_V6D_BUF2),
											.IN4(BOT_V6N_BUF2),
											.IN5(BOT_V6A_BUF2),
											.IN6(BOT_V6B_BUF2),
											.IN7(BOT_V6M_BUF2),
											.IN0(BOT_N_BUF15),
											.IN1(BOT_N_BUF14),
											.IN2(BOT_N_BUF9),
											.IN3(BOT_N_BUF8),
											.OUT(BOT_CLK1),
											.IN18(BOT_GCLK2),
											.IN19(BOT_GCLK3),
											.IN16(BOT_GCLK0),
											.IN17(BOT_GCLK1),
											.IN14(BOT_H6D_BUF2),
											.IN15(BOT_H6W_BUF2),
											.IN12(BOT_H6M_BUF2),
											.IN13(BOT_H6C_BUF2),
											.IN10(BOT_H6A_BUF2),
											.IN11(BOT_H6B_BUF2),
											._1(1)
		);

		SPS6T7X11H1 sps_v6n1(
											.IN4(BOT_H6M0),
											.IN5(BOT_H6E2),
											.IN0(BOT_I2),
											.IN1(BOT_I3),
											.IN2(BOT_LLV0),
											.IN3(BOT_H6W1),
											.OUT(BOT_V6N1),
											._1(1)
		);

		SPS6T7X11H1 sps_v6n0(
											.IN4(BOT_H6M3),
											.IN5(BOT_H6E1),
											.IN0(BOT_I0),
											.IN1(BOT_I1),
											.IN2(BOT_LLV0),
											.IN3(BOT_H6W0),
											.OUT(BOT_V6N0),
											._1(1)
		);

		SPS6T7X11H1 sps_v6n3(
											.IN4(BOT_H6M2),
											.IN5(BOT_H6E0),
											.IN0(BOT_IQ2),
											.IN1(BOT_IQ3),
											.IN2(BOT_LLV6),
											.IN3(BOT_H6W3),
											.OUT(BOT_V6N3),
											._1(1)
		);

		SPS6T7X11H1 sps_v6n2(
											.IN4(BOT_H6M1),
											.IN5(BOT_H6E3),
											.IN0(BOT_IQ0),
											.IN1(BOT_IQ1),
											.IN2(BOT_LLV6),
											.IN3(BOT_H6W2),
											.OUT(BOT_V6N2),
											._1(1)
		);

		SPS6B6X2H1 sps_v6n5(
											.IN4(BOT_H6E2),
											.IN5(BOT_V6D4),
											.IN0(BOT_IQ0),
											.IN1(BOT_I0),
											.IN2(BOT_H6W0),
											.IN3(BOT_H6M1),
											.OUT(BOT_V6N5),
											._1(1)
		);

		BUF1B0X2H3 buf_v6m4_v6b5(
											.A(BOT_V6M4),
											.Y(BOT_V6B5)
		);

		SPS6B6X2H1 sps_v6n9(
											.IN4(BOT_H6E0),
											.IN5(BOT_V6D8),
											.IN0(BOT_IQ2),
											.IN1(BOT_I2),
											.IN2(BOT_H6W2),
											.IN3(BOT_H6M3),
											.OUT(BOT_V6N9),
											._1(1)
		);

		BUF1B0X2H3 buf_v6n6_v6d7(
											.A(BOT_V6N6),
											.Y(BOT_V6D7)
		);

		SPS16N6X0H2 sps_o1(
											.IN8(BOT_N_BUF3),
											.IN9(BOT_N_BUF2),
											.IN4(BOT_N_BUF7),
											.IN5(BOT_N_BUF6),
											.IN6(BOT_N_BUF5),
											.IN7(BOT_N_BUF4),
											.IN0(BOT_N_BUF11),
											.IN1(BOT_N_BUF10),
											.IN2(BOT_N_BUF9),
											.IN3(BOT_N_BUF8),
											.OUT(BOT_O1),
											.IN14(BOT_V6B_BUF1),
											.IN15(BOT_V6M_BUF1),
											.IN12(BOT_V6N_BUF1),
											.IN13(BOT_V6A_BUF1),
											.IN10(BOT_N_BUF1),
											.IN11(BOT_N_BUF0),
											._1(1)
		);

		SPS16N6X0H2 sps_o2(
											.IN8(BOT_N_BUF15),
											.IN9(BOT_N_BUF14),
											.IN4(BOT_N_BUF19),
											.IN5(BOT_N_BUF18),
											.IN6(BOT_N_BUF17),
											.IN7(BOT_N_BUF16),
											.IN0(BOT_N_BUF23),
											.IN1(BOT_N_BUF22),
											.IN2(BOT_N_BUF21),
											.IN3(BOT_N_BUF20),
											.OUT(BOT_O2),
											.IN14(BOT_V6B_BUF2),
											.IN15(BOT_V6M_BUF2),
											.IN12(BOT_V6N_BUF2),
											.IN13(BOT_V6A_BUF2),
											.IN10(BOT_N_BUF13),
											.IN11(BOT_N_BUF12),
											._1(1)
		);

		BUF1B0X2H3 buf_v6a10_v6c11(
											.A(BOT_V6A10),
											.Y(BOT_V6C11)
		);

		SPS4T5X11H1 sps_v6b1(
											.IN3(BOT_LLV10),
											.IN0(BOT_I0),
											.IN1(BOT_I1),
											.IN2(BOT_IQ3),
											.OUT(BOT_V6B1),
											._1(1)
		);

		SPS2N2X0H2 sps_n22(
											.IN0(BOT_IQ1),
											.IN1(BOT_H6M3),
											.OUT(BOT_N22),
											._1(1)
		);

		SPS2N2X0H2 sps_n23(
											.IN0(BOT_IQ0),
											.IN1(BOT_H6E3),
											.OUT(BOT_N23),
											._1(1)
		);

		BUF1B0X2H3 buf_v6m10_v6b11(
											.A(BOT_V6M10),
											.Y(BOT_V6B11)
		);

		SPS16N6X0H2 sps_t1(
											.IN8(BOT_V6C_BUF0),
											.IN9(BOT_V6D_BUF0),
											.IN4(BOT_V6N_BUF0),
											.IN5(BOT_V6A_BUF0),
											.IN6(BOT_V6B_BUF0),
											.IN7(BOT_V6M_BUF0),
											.IN0(BOT_N_BUF3),
											.IN1(BOT_N_BUF2),
											.IN2(BOT_N_BUF1),
											.IN3(BOT_N_BUF0),
											.OUT(BOT_T1),
											.IN14(BOT_H6D_BUF0),
											.IN15(BOT_H6W_BUF0),
											.IN12(BOT_H6M_BUF0),
											.IN13(BOT_H6C_BUF0),
											.IN10(BOT_H6A_BUF0),
											.IN11(BOT_H6B_BUF0),
											._1(1)
		);

endmodule

