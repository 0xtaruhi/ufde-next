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
	    $display("Attribute Syntax Error : The attribute CLKDV_DIVIDE on X_CLKDLLE instance %m is set to %0.1f.  Legal values for this attribute are 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0, 7.5, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, or 16.0.", CKDV_DIVIDE);
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
