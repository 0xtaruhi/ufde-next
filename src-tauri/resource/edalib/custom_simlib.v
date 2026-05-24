/*==============================================================
 *  Description: Custom Simulation Library for UFDE+
 *  Contains RAM Simulation Models
 *  Constraint: For dual-port RAMB4_Sx_Sy, y must be >= x
 *  Author: Yuhang Cheng
 *=============================================================*/

`timescale 1 ns/1 ns

/*===========================================================================
 * Single-Port Block RAM Primitives (RAMB4_Sx)
 *===========================================================================*/

module RAMB4_S1(ADDR, CLK, RST, DI, DO, WE, EN);
    input [11:0] ADDR;
    input CLK, RST, WE, EN;
    input [0:0] DI;
    output reg [0:0] DO;
    
    // Initialization parameters (256 bits each, 16 total = 4096 bits)
    parameter INIT_00 = 256'h0;
    parameter INIT_01 = 256'h0;
    parameter INIT_02 = 256'h0;
    parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0;
    parameter INIT_05 = 256'h0;
    parameter INIT_06 = 256'h0;
    parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0;
    parameter INIT_09 = 256'h0;
    parameter INIT_0A = 256'h0;
    parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0;
    parameter INIT_0D = 256'h0;
    parameter INIT_0E = 256'h0;
    parameter INIT_0F = 256'h0;
    
    reg [0:0] mem [0:4095];
    integer i;
    
    // Initialize memory from parameters
    initial begin
        for (i = 0; i < 256; i = i + 1) mem[i] = INIT_00[i];
        for (i = 0; i < 256; i = i + 1) mem[i+256] = INIT_01[i];
        for (i = 0; i < 256; i = i + 1) mem[i+512] = INIT_02[i];
        for (i = 0; i < 256; i = i + 1) mem[i+768] = INIT_03[i];
        for (i = 0; i < 256; i = i + 1) mem[i+1024] = INIT_04[i];
        for (i = 0; i < 256; i = i + 1) mem[i+1280] = INIT_05[i];
        for (i = 0; i < 256; i = i + 1) mem[i+1536] = INIT_06[i];
        for (i = 0; i < 256; i = i + 1) mem[i+1792] = INIT_07[i];
        for (i = 0; i < 256; i = i + 1) mem[i+2048] = INIT_08[i];
        for (i = 0; i < 256; i = i + 1) mem[i+2304] = INIT_09[i];
        for (i = 0; i < 256; i = i + 1) mem[i+2560] = INIT_0A[i];
        for (i = 0; i < 256; i = i + 1) mem[i+2816] = INIT_0B[i];
        for (i = 0; i < 256; i = i + 1) mem[i+3072] = INIT_0C[i];
        for (i = 0; i < 256; i = i + 1) mem[i+3328] = INIT_0D[i];
        for (i = 0; i < 256; i = i + 1) mem[i+3584] = INIT_0E[i];
        for (i = 0; i < 256; i = i + 1) mem[i+3840] = INIT_0F[i];
    end
    
    always @(posedge CLK) begin
        if (EN) begin
            if (RST) DO <= 1'b0;
            else if (WE) begin mem[ADDR] <= DI; DO <= DI; end
            else DO <= mem[ADDR];
        end
    end
endmodule

module RAMB4_S2(ADDR, CLK, RST, DI, DO, WE, EN);
    input [10:0] ADDR;
    input CLK, RST, WE, EN;
    input [1:0] DI;
    output reg [1:0] DO;
    
    parameter INIT_00 = 256'h0;
    parameter INIT_01 = 256'h0;
    parameter INIT_02 = 256'h0;
    parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0;
    parameter INIT_05 = 256'h0;
    parameter INIT_06 = 256'h0;
    parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0;
    parameter INIT_09 = 256'h0;
    parameter INIT_0A = 256'h0;
    parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0;
    parameter INIT_0D = 256'h0;
    parameter INIT_0E = 256'h0;
    parameter INIT_0F = 256'h0;
    
    reg [1:0] mem [0:2047];
    integer i;
    
    initial begin
        for (i = 0; i < 128; i = i + 1) mem[i] = INIT_00[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+128] = INIT_01[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+256] = INIT_02[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+384] = INIT_03[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+512] = INIT_04[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+640] = INIT_05[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+768] = INIT_06[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+896] = INIT_07[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+1024] = INIT_08[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+1152] = INIT_09[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+1280] = INIT_0A[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+1408] = INIT_0B[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+1536] = INIT_0C[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+1664] = INIT_0D[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+1792] = INIT_0E[i*2 +: 2];
        for (i = 0; i < 128; i = i + 1) mem[i+1920] = INIT_0F[i*2 +: 2];
    end
    
    always @(posedge CLK) begin
        if (EN) begin
            if (RST) DO <= 2'b00;
            else if (WE) begin mem[ADDR] <= DI; DO <= DI; end
            else DO <= mem[ADDR];
        end
    end
endmodule

module RAMB4_S4(ADDR, CLK, RST, DI, DO, WE, EN);
    input [9:0] ADDR;
    input CLK, RST, WE, EN;
    input [3:0] DI;
    output reg [3:0] DO;
    
    parameter INIT_00 = 256'h0;
    parameter INIT_01 = 256'h0;
    parameter INIT_02 = 256'h0;
    parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0;
    parameter INIT_05 = 256'h0;
    parameter INIT_06 = 256'h0;
    parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0;
    parameter INIT_09 = 256'h0;
    parameter INIT_0A = 256'h0;
    parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0;
    parameter INIT_0D = 256'h0;
    parameter INIT_0E = 256'h0;
    parameter INIT_0F = 256'h0;
    
    reg [3:0] mem [0:1023];
    integer i;
    
    initial begin
        for (i = 0; i < 64; i = i + 1) mem[i] = INIT_00[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+64] = INIT_01[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+128] = INIT_02[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+192] = INIT_03[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+256] = INIT_04[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+320] = INIT_05[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+384] = INIT_06[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+448] = INIT_07[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+512] = INIT_08[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+576] = INIT_09[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+640] = INIT_0A[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+704] = INIT_0B[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+768] = INIT_0C[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+832] = INIT_0D[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+896] = INIT_0E[i*4 +: 4];
        for (i = 0; i < 64; i = i + 1) mem[i+960] = INIT_0F[i*4 +: 4];
    end
    
    always @(posedge CLK) begin
        if (EN) begin
            if (RST) DO <= 4'b0000;
            else if (WE) begin mem[ADDR] <= DI; DO <= DI; end
            else DO <= mem[ADDR];
        end
    end
endmodule

module RAMB4_S8(ADDR, CLK, RST, DI, DO, WE, EN);
    input [8:0] ADDR;
    input CLK, RST, WE, EN;
    input [7:0] DI;
    output reg [7:0] DO;
    
    parameter INIT_00 = 256'h0;
    parameter INIT_01 = 256'h0;
    parameter INIT_02 = 256'h0;
    parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0;
    parameter INIT_05 = 256'h0;
    parameter INIT_06 = 256'h0;
    parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0;
    parameter INIT_09 = 256'h0;
    parameter INIT_0A = 256'h0;
    parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0;
    parameter INIT_0D = 256'h0;
    parameter INIT_0E = 256'h0;
    parameter INIT_0F = 256'h0;
    
    reg [7:0] mem [0:511];
    integer i;
    
    initial begin
        for (i = 0; i < 32; i = i + 1) mem[i] = INIT_00[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+32] = INIT_01[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+64] = INIT_02[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+96] = INIT_03[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+128] = INIT_04[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+160] = INIT_05[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+192] = INIT_06[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+224] = INIT_07[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+256] = INIT_08[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+288] = INIT_09[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+320] = INIT_0A[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+352] = INIT_0B[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+384] = INIT_0C[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+416] = INIT_0D[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+448] = INIT_0E[i*8 +: 8];
        for (i = 0; i < 32; i = i + 1) mem[i+480] = INIT_0F[i*8 +: 8];
    end
    
    always @(posedge CLK) begin
        if (EN) begin
            if (RST) DO <= 8'h00;
            else if (WE) begin mem[ADDR] <= DI; DO <= DI; end
            else DO <= mem[ADDR];
        end
    end
endmodule

module RAMB4_S16(ADDR, CLK, RST, DI, DO, WE, EN);
    input [7:0] ADDR;
    input CLK, RST, WE, EN;
    input [15:0] DI;
    output reg [15:0] DO;
    
    parameter INIT_00 = 256'h0;
    parameter INIT_01 = 256'h0;
    parameter INIT_02 = 256'h0;
    parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0;
    parameter INIT_05 = 256'h0;
    parameter INIT_06 = 256'h0;
    parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0;
    parameter INIT_09 = 256'h0;
    parameter INIT_0A = 256'h0;
    parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0;
    parameter INIT_0D = 256'h0;
    parameter INIT_0E = 256'h0;
    parameter INIT_0F = 256'h0;
    
    reg [15:0] mem [0:255];
    integer i;
    
    initial begin
        for (i = 0; i < 16; i = i + 1) mem[i] = INIT_00[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+16] = INIT_01[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+32] = INIT_02[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+48] = INIT_03[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+64] = INIT_04[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+80] = INIT_05[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+96] = INIT_06[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+112] = INIT_07[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+128] = INIT_08[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+144] = INIT_09[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+160] = INIT_0A[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+176] = INIT_0B[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+192] = INIT_0C[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+208] = INIT_0D[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+224] = INIT_0E[i*16 +: 16];
        for (i = 0; i < 16; i = i + 1) mem[i+240] = INIT_0F[i*16 +: 16];
    end
    
    always @(posedge CLK) begin
        if (EN) begin
            if (RST) DO <= 16'h0000;
            else if (WE) begin mem[ADDR] <= DI; DO <= DI; end
            else DO <= mem[ADDR];
        end
    end
endmodule


/*===========================================================================
 * Dual-Port Block RAM Primitives (RAMB4_Sx_Sy)
 * Constraint: y >= x (Port B width >= Port A width)
 * Total: 15 modules (5+4+3+2+1)
 *===========================================================================*/

// RAMB4_S1_Sx series (y >= 1): S1_S1, S1_S2, S1_S4, S1_S8, S1_S16
module RAMB4_S1_S1(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [11:0] ADDRA, ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [0:0] DIA, DIB;
    output reg [0:0] DOA, DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [0:0] mem [0:4095];
    integer i;
    
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = INIT_00[i];
            mem[i+256] = INIT_01[i];
            mem[i+512] = INIT_02[i];
            mem[i+768] = INIT_03[i];
            mem[i+1024] = INIT_04[i];
            mem[i+1280] = INIT_05[i];
            mem[i+1536] = INIT_06[i];
            mem[i+1792] = INIT_07[i];
            mem[i+2048] = INIT_08[i];
            mem[i+2304] = INIT_09[i];
            mem[i+2560] = INIT_0A[i];
            mem[i+2816] = INIT_0B[i];
            mem[i+3072] = INIT_0C[i];
            mem[i+3328] = INIT_0D[i];
            mem[i+3584] = INIT_0E[i];
            mem[i+3840] = INIT_0F[i];
        end
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 1'b0; else if (WEA) begin mem[ADDRA] <= DIA; DOA <= DIA; end else DOA <= mem[ADDRA]; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 1'b0; else if (WEB) begin mem[ADDRB] <= DIB; DOB <= DIB; end else DOB <= mem[ADDRB]; end
endmodule

module RAMB4_S1_S2(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [11:0] ADDRA;
    input [10:0] ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [0:0] DIA;
    input [1:0] DIB;
    output reg [0:0] DOA;
    output reg [1:0] DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [0:0] mem [0:4095];
    integer i;
    
    initial for (i = 0; i < 256; i = i + 1) begin
        mem[i] = INIT_00[i]; mem[i+256] = INIT_01[i]; mem[i+512] = INIT_02[i]; mem[i+768] = INIT_03[i];
        mem[i+1024] = INIT_04[i]; mem[i+1280] = INIT_05[i]; mem[i+1536] = INIT_06[i]; mem[i+1792] = INIT_07[i];
        mem[i+2048] = INIT_08[i]; mem[i+2304] = INIT_09[i]; mem[i+2560] = INIT_0A[i]; mem[i+2816] = INIT_0B[i];
        mem[i+3072] = INIT_0C[i]; mem[i+3328] = INIT_0D[i]; mem[i+3584] = INIT_0E[i]; mem[i+3840] = INIT_0F[i];
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 1'b0; else if (WEA) begin mem[ADDRA] <= DIA; DOA <= DIA; end else DOA <= mem[ADDRA]; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 2'b00; else if (WEB) begin mem[{ADDRB, 1'b0}] <= DIB[0]; mem[{ADDRB, 1'b1}] <= DIB[1]; DOB <= DIB; end else DOB <= {mem[{ADDRB, 1'b1}], mem[{ADDRB, 1'b0}]}; end
endmodule

module RAMB4_S1_S4(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [11:0] ADDRA;
    input [9:0] ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [0:0] DIA;
    input [3:0] DIB;
    output reg [0:0] DOA;
    output reg [3:0] DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [0:0] mem [0:4095];
    integer i;
    
    initial for (i = 0; i < 256; i = i + 1) begin
        mem[i] = INIT_00[i]; mem[i+256] = INIT_01[i]; mem[i+512] = INIT_02[i]; mem[i+768] = INIT_03[i];
        mem[i+1024] = INIT_04[i]; mem[i+1280] = INIT_05[i]; mem[i+1536] = INIT_06[i]; mem[i+1792] = INIT_07[i];
        mem[i+2048] = INIT_08[i]; mem[i+2304] = INIT_09[i]; mem[i+2560] = INIT_0A[i]; mem[i+2816] = INIT_0B[i];
        mem[i+3072] = INIT_0C[i]; mem[i+3328] = INIT_0D[i]; mem[i+3584] = INIT_0E[i]; mem[i+3840] = INIT_0F[i];
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 1'b0; else if (WEA) begin mem[ADDRA] <= DIA; DOA <= DIA; end else DOA <= mem[ADDRA]; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 4'b0000; else if (WEB) begin mem[{ADDRB, 2'b00}] <= DIB[0]; mem[{ADDRB, 2'b01}] <= DIB[1]; mem[{ADDRB, 2'b10}] <= DIB[2]; mem[{ADDRB, 2'b11}] <= DIB[3]; DOB <= DIB; end else DOB <= {mem[{ADDRB, 2'b11}], mem[{ADDRB, 2'b10}], mem[{ADDRB, 2'b01}], mem[{ADDRB, 2'b00}]}; end
endmodule

module RAMB4_S1_S8(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [11:0] ADDRA;
    input [8:0] ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [0:0] DIA;
    input [7:0] DIB;
    output reg [0:0] DOA;
    output reg [7:0] DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [0:0] mem [0:4095];
    integer i;
    
    initial for (i = 0; i < 256; i = i + 1) begin
        mem[i] = INIT_00[i]; mem[i+256] = INIT_01[i]; mem[i+512] = INIT_02[i]; mem[i+768] = INIT_03[i];
        mem[i+1024] = INIT_04[i]; mem[i+1280] = INIT_05[i]; mem[i+1536] = INIT_06[i]; mem[i+1792] = INIT_07[i];
        mem[i+2048] = INIT_08[i]; mem[i+2304] = INIT_09[i]; mem[i+2560] = INIT_0A[i]; mem[i+2816] = INIT_0B[i];
        mem[i+3072] = INIT_0C[i]; mem[i+3328] = INIT_0D[i]; mem[i+3584] = INIT_0E[i]; mem[i+3840] = INIT_0F[i];
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 1'b0; else if (WEA) begin mem[ADDRA] <= DIA; DOA <= DIA; end else DOA <= mem[ADDRA]; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 8'h00; else if (WEB) begin mem[{ADDRB, 3'b000}] <= DIB[0]; mem[{ADDRB, 3'b001}] <= DIB[1]; mem[{ADDRB, 3'b010}] <= DIB[2]; mem[{ADDRB, 3'b011}] <= DIB[3]; mem[{ADDRB, 3'b100}] <= DIB[4]; mem[{ADDRB, 3'b101}] <= DIB[5]; mem[{ADDRB, 3'b110}] <= DIB[6]; mem[{ADDRB, 3'b111}] <= DIB[7]; DOB <= DIB; end else DOB <= {mem[{ADDRB, 3'b111}], mem[{ADDRB, 3'b110}], mem[{ADDRB, 3'b101}], mem[{ADDRB, 3'b100}], mem[{ADDRB, 3'b011}], mem[{ADDRB, 3'b010}], mem[{ADDRB, 3'b001}], mem[{ADDRB, 3'b000}]}; end
endmodule

module RAMB4_S1_S16(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [11:0] ADDRA;
    input [7:0] ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [0:0] DIA;
    input [15:0] DIB;
    output reg [0:0] DOA;
    output reg [15:0] DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [0:0] mem [0:4095];
    integer i;
    
    initial for (i = 0; i < 256; i = i + 1) begin
        mem[i] = INIT_00[i]; mem[i+256] = INIT_01[i]; mem[i+512] = INIT_02[i]; mem[i+768] = INIT_03[i];
        mem[i+1024] = INIT_04[i]; mem[i+1280] = INIT_05[i]; mem[i+1536] = INIT_06[i]; mem[i+1792] = INIT_07[i];
        mem[i+2048] = INIT_08[i]; mem[i+2304] = INIT_09[i]; mem[i+2560] = INIT_0A[i]; mem[i+2816] = INIT_0B[i];
        mem[i+3072] = INIT_0C[i]; mem[i+3328] = INIT_0D[i]; mem[i+3584] = INIT_0E[i]; mem[i+3840] = INIT_0F[i];
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 1'b0; else if (WEA) begin mem[ADDRA] <= DIA; DOA <= DIA; end else DOA <= mem[ADDRA]; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 16'h0000; else if (WEB) begin mem[{ADDRB, 4'h0}] <= DIB[0]; mem[{ADDRB, 4'h1}] <= DIB[1]; mem[{ADDRB, 4'h2}] <= DIB[2]; mem[{ADDRB, 4'h3}] <= DIB[3]; mem[{ADDRB, 4'h4}] <= DIB[4]; mem[{ADDRB, 4'h5}] <= DIB[5]; mem[{ADDRB, 4'h6}] <= DIB[6]; mem[{ADDRB, 4'h7}] <= DIB[7]; mem[{ADDRB, 4'h8}] <= DIB[8]; mem[{ADDRB, 4'h9}] <= DIB[9]; mem[{ADDRB, 4'hA}] <= DIB[10]; mem[{ADDRB, 4'hB}] <= DIB[11]; mem[{ADDRB, 4'hC}] <= DIB[12]; mem[{ADDRB, 4'hD}] <= DIB[13]; mem[{ADDRB, 4'hE}] <= DIB[14]; mem[{ADDRB, 4'hF}] <= DIB[15]; DOB <= DIB; end else DOB <= {mem[{ADDRB, 4'hF}], mem[{ADDRB, 4'hE}], mem[{ADDRB, 4'hD}], mem[{ADDRB, 4'hC}], mem[{ADDRB, 4'hB}], mem[{ADDRB, 4'hA}], mem[{ADDRB, 4'h9}], mem[{ADDRB, 4'h8}], mem[{ADDRB, 4'h7}], mem[{ADDRB, 4'h6}], mem[{ADDRB, 4'h5}], mem[{ADDRB, 4'h4}], mem[{ADDRB, 4'h3}], mem[{ADDRB, 4'h2}], mem[{ADDRB, 4'h1}], mem[{ADDRB, 4'h0}]}; end
endmodule


// RAMB4_S2_Sx series (y >= 2): S2_S2, S2_S4, S2_S8, S2_S16
module RAMB4_S2_S2(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [10:0] ADDRA, ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [1:0] DIA, DIB;
    output reg [1:0] DOA, DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [1:0] mem [0:2047];
    integer i;
    
    initial for (i = 0; i < 128; i = i + 1) begin
        mem[i] = INIT_00[i*2 +: 2]; mem[i+128] = INIT_01[i*2 +: 2]; mem[i+256] = INIT_02[i*2 +: 2]; mem[i+384] = INIT_03[i*2 +: 2];
        mem[i+512] = INIT_04[i*2 +: 2]; mem[i+640] = INIT_05[i*2 +: 2]; mem[i+768] = INIT_06[i*2 +: 2]; mem[i+896] = INIT_07[i*2 +: 2];
        mem[i+1024] = INIT_08[i*2 +: 2]; mem[i+1152] = INIT_09[i*2 +: 2]; mem[i+1280] = INIT_0A[i*2 +: 2]; mem[i+1408] = INIT_0B[i*2 +: 2];
        mem[i+1536] = INIT_0C[i*2 +: 2]; mem[i+1664] = INIT_0D[i*2 +: 2]; mem[i+1792] = INIT_0E[i*2 +: 2]; mem[i+1920] = INIT_0F[i*2 +: 2];
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 2'b00; else if (WEA) begin mem[ADDRA] <= DIA; DOA <= DIA; end else DOA <= mem[ADDRA]; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 2'b00; else if (WEB) begin mem[ADDRB] <= DIB; DOB <= DIB; end else DOB <= mem[ADDRB]; end
endmodule

module RAMB4_S2_S4(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [10:0] ADDRA;
    input [9:0] ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [1:0] DIA;
    input [3:0] DIB;
    output reg [1:0] DOA;
    output reg [3:0] DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [0:0] mem [0:4095];
    integer i;
    
    initial for (i = 0; i < 256; i = i + 1) begin
        mem[i] = INIT_00[i]; mem[i+256] = INIT_01[i]; mem[i+512] = INIT_02[i]; mem[i+768] = INIT_03[i];
        mem[i+1024] = INIT_04[i]; mem[i+1280] = INIT_05[i]; mem[i+1536] = INIT_06[i]; mem[i+1792] = INIT_07[i];
        mem[i+2048] = INIT_08[i]; mem[i+2304] = INIT_09[i]; mem[i+2560] = INIT_0A[i]; mem[i+2816] = INIT_0B[i];
        mem[i+3072] = INIT_0C[i]; mem[i+3328] = INIT_0D[i]; mem[i+3584] = INIT_0E[i]; mem[i+3840] = INIT_0F[i];
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 2'b00; else if (WEA) begin mem[{ADDRA, 1'b0}] <= DIA[0]; mem[{ADDRA, 1'b1}] <= DIA[1]; DOA <= DIA; end else DOA <= {mem[{ADDRA, 1'b1}], mem[{ADDRA, 1'b0}]}; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 4'b0000; else if (WEB) begin mem[{ADDRB, 2'b00}] <= DIB[0]; mem[{ADDRB, 2'b01}] <= DIB[1]; mem[{ADDRB, 2'b10}] <= DIB[2]; mem[{ADDRB, 2'b11}] <= DIB[3]; DOB <= DIB; end else DOB <= {mem[{ADDRB, 2'b11}], mem[{ADDRB, 2'b10}], mem[{ADDRB, 2'b01}], mem[{ADDRB, 2'b00}]}; end
endmodule

module RAMB4_S2_S8(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [10:0] ADDRA;
    input [8:0] ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [1:0] DIA;
    input [7:0] DIB;
    output reg [1:0] DOA;
    output reg [7:0] DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [0:0] mem [0:4095];
    integer i;
    
    initial for (i = 0; i < 256; i = i + 1) begin
        mem[i] = INIT_00[i]; mem[i+256] = INIT_01[i]; mem[i+512] = INIT_02[i]; mem[i+768] = INIT_03[i];
        mem[i+1024] = INIT_04[i]; mem[i+1280] = INIT_05[i]; mem[i+1536] = INIT_06[i]; mem[i+1792] = INIT_07[i];
        mem[i+2048] = INIT_08[i]; mem[i+2304] = INIT_09[i]; mem[i+2560] = INIT_0A[i]; mem[i+2816] = INIT_0B[i];
        mem[i+3072] = INIT_0C[i]; mem[i+3328] = INIT_0D[i]; mem[i+3584] = INIT_0E[i]; mem[i+3840] = INIT_0F[i];
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 2'b00; else if (WEA) begin mem[{ADDRA, 1'b0}] <= DIA[0]; mem[{ADDRA, 1'b1}] <= DIA[1]; DOA <= DIA; end else DOA <= {mem[{ADDRA, 1'b1}], mem[{ADDRA, 1'b0}]}; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 8'h00; else if (WEB) begin mem[{ADDRB, 3'b000}] <= DIB[0]; mem[{ADDRB, 3'b001}] <= DIB[1]; mem[{ADDRB, 3'b010}] <= DIB[2]; mem[{ADDRB, 3'b011}] <= DIB[3]; mem[{ADDRB, 3'b100}] <= DIB[4]; mem[{ADDRB, 3'b101}] <= DIB[5]; mem[{ADDRB, 3'b110}] <= DIB[6]; mem[{ADDRB, 3'b111}] <= DIB[7]; DOB <= DIB; end else DOB <= {mem[{ADDRB, 3'b111}], mem[{ADDRB, 3'b110}], mem[{ADDRB, 3'b101}], mem[{ADDRB, 3'b100}], mem[{ADDRB, 3'b011}], mem[{ADDRB, 3'b010}], mem[{ADDRB, 3'b001}], mem[{ADDRB, 3'b000}]}; end
endmodule

module RAMB4_S2_S16(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [10:0] ADDRA;
    input [7:0] ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [1:0] DIA;
    input [15:0] DIB;
    output reg [1:0] DOA;
    output reg [15:0] DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [0:0] mem [0:4095];
    integer i;
    
    initial for (i = 0; i < 256; i = i + 1) begin
        mem[i] = INIT_00[i]; mem[i+256] = INIT_01[i]; mem[i+512] = INIT_02[i]; mem[i+768] = INIT_03[i];
        mem[i+1024] = INIT_04[i]; mem[i+1280] = INIT_05[i]; mem[i+1536] = INIT_06[i]; mem[i+1792] = INIT_07[i];
        mem[i+2048] = INIT_08[i]; mem[i+2304] = INIT_09[i]; mem[i+2560] = INIT_0A[i]; mem[i+2816] = INIT_0B[i];
        mem[i+3072] = INIT_0C[i]; mem[i+3328] = INIT_0D[i]; mem[i+3584] = INIT_0E[i]; mem[i+3840] = INIT_0F[i];
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 2'b00; else if (WEA) begin mem[{ADDRA, 1'b0}] <= DIA[0]; mem[{ADDRA, 1'b1}] <= DIA[1]; DOA <= DIA; end else DOA <= {mem[{ADDRA, 1'b1}], mem[{ADDRA, 1'b0}]}; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 16'h0000; else if (WEB) begin mem[{ADDRB, 4'h0}] <= DIB[0]; mem[{ADDRB, 4'h1}] <= DIB[1]; mem[{ADDRB, 4'h2}] <= DIB[2]; mem[{ADDRB, 4'h3}] <= DIB[3]; mem[{ADDRB, 4'h4}] <= DIB[4]; mem[{ADDRB, 4'h5}] <= DIB[5]; mem[{ADDRB, 4'h6}] <= DIB[6]; mem[{ADDRB, 4'h7}] <= DIB[7]; mem[{ADDRB, 4'h8}] <= DIB[8]; mem[{ADDRB, 4'h9}] <= DIB[9]; mem[{ADDRB, 4'hA}] <= DIB[10]; mem[{ADDRB, 4'hB}] <= DIB[11]; mem[{ADDRB, 4'hC}] <= DIB[12]; mem[{ADDRB, 4'hD}] <= DIB[13]; mem[{ADDRB, 4'hE}] <= DIB[14]; mem[{ADDRB, 4'hF}] <= DIB[15]; DOB <= DIB; end else DOB <= {mem[{ADDRB, 4'hF}], mem[{ADDRB, 4'hE}], mem[{ADDRB, 4'hD}], mem[{ADDRB, 4'hC}], mem[{ADDRB, 4'hB}], mem[{ADDRB, 4'hA}], mem[{ADDRB, 4'h9}], mem[{ADDRB, 4'h8}], mem[{ADDRB, 4'h7}], mem[{ADDRB, 4'h6}], mem[{ADDRB, 4'h5}], mem[{ADDRB, 4'h4}], mem[{ADDRB, 4'h3}], mem[{ADDRB, 4'h2}], mem[{ADDRB, 4'h1}], mem[{ADDRB, 4'h0}]}; end
endmodule


// RAMB4_S4_Sx series (y >= 4): S4_S4, S4_S8, S4_S16
module RAMB4_S4_S4(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [9:0] ADDRA, ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [3:0] DIA, DIB;
    output reg [3:0] DOA, DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [3:0] mem [0:1023];
    integer i;
    
    initial for (i = 0; i < 64; i = i + 1) begin
        mem[i] = INIT_00[i*4 +: 4]; mem[i+64] = INIT_01[i*4 +: 4]; mem[i+128] = INIT_02[i*4 +: 4]; mem[i+192] = INIT_03[i*4 +: 4];
        mem[i+256] = INIT_04[i*4 +: 4]; mem[i+320] = INIT_05[i*4 +: 4]; mem[i+384] = INIT_06[i*4 +: 4]; mem[i+448] = INIT_07[i*4 +: 4];
        mem[i+512] = INIT_08[i*4 +: 4]; mem[i+576] = INIT_09[i*4 +: 4]; mem[i+640] = INIT_0A[i*4 +: 4]; mem[i+704] = INIT_0B[i*4 +: 4];
        mem[i+768] = INIT_0C[i*4 +: 4]; mem[i+832] = INIT_0D[i*4 +: 4]; mem[i+896] = INIT_0E[i*4 +: 4]; mem[i+960] = INIT_0F[i*4 +: 4];
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 4'b0000; else if (WEA) begin mem[ADDRA] <= DIA; DOA <= DIA; end else DOA <= mem[ADDRA]; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 4'b0000; else if (WEB) begin mem[ADDRB] <= DIB; DOB <= DIB; end else DOB <= mem[ADDRB]; end
endmodule

module RAMB4_S4_S8(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [9:0] ADDRA;
    input [8:0] ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [3:0] DIA;
    input [7:0] DIB;
    output reg [3:0] DOA;
    output reg [7:0] DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [0:0] mem [0:4095];
    integer i;
    
    initial for (i = 0; i < 256; i = i + 1) begin
        mem[i] = INIT_00[i]; mem[i+256] = INIT_01[i]; mem[i+512] = INIT_02[i]; mem[i+768] = INIT_03[i];
        mem[i+1024] = INIT_04[i]; mem[i+1280] = INIT_05[i]; mem[i+1536] = INIT_06[i]; mem[i+1792] = INIT_07[i];
        mem[i+2048] = INIT_08[i]; mem[i+2304] = INIT_09[i]; mem[i+2560] = INIT_0A[i]; mem[i+2816] = INIT_0B[i];
        mem[i+3072] = INIT_0C[i]; mem[i+3328] = INIT_0D[i]; mem[i+3584] = INIT_0E[i]; mem[i+3840] = INIT_0F[i];
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 4'b0000; else if (WEA) begin mem[{ADDRA, 2'b00}] <= DIA[0]; mem[{ADDRA, 2'b01}] <= DIA[1]; mem[{ADDRA, 2'b10}] <= DIA[2]; mem[{ADDRA, 2'b11}] <= DIA[3]; DOA <= DIA; end else DOA <= {mem[{ADDRA, 2'b11}], mem[{ADDRA, 2'b10}], mem[{ADDRA, 2'b01}], mem[{ADDRA, 2'b00}]}; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 8'h00; else if (WEB) begin mem[{ADDRB, 3'b000}] <= DIB[0]; mem[{ADDRB, 3'b001}] <= DIB[1]; mem[{ADDRB, 3'b010}] <= DIB[2]; mem[{ADDRB, 3'b011}] <= DIB[3]; mem[{ADDRB, 3'b100}] <= DIB[4]; mem[{ADDRB, 3'b101}] <= DIB[5]; mem[{ADDRB, 3'b110}] <= DIB[6]; mem[{ADDRB, 3'b111}] <= DIB[7]; DOB <= DIB; end else DOB <= {mem[{ADDRB, 3'b111}], mem[{ADDRB, 3'b110}], mem[{ADDRB, 3'b101}], mem[{ADDRB, 3'b100}], mem[{ADDRB, 3'b011}], mem[{ADDRB, 3'b010}], mem[{ADDRB, 3'b001}], mem[{ADDRB, 3'b000}]}; end
endmodule

module RAMB4_S4_S16(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [9:0] ADDRA;
    input [7:0] ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [3:0] DIA;
    input [15:0] DIB;
    output reg [3:0] DOA;
    output reg [15:0] DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [0:0] mem [0:4095];
    integer i;
    
    initial for (i = 0; i < 256; i = i + 1) begin
        mem[i] = INIT_00[i]; mem[i+256] = INIT_01[i]; mem[i+512] = INIT_02[i]; mem[i+768] = INIT_03[i];
        mem[i+1024] = INIT_04[i]; mem[i+1280] = INIT_05[i]; mem[i+1536] = INIT_06[i]; mem[i+1792] = INIT_07[i];
        mem[i+2048] = INIT_08[i]; mem[i+2304] = INIT_09[i]; mem[i+2560] = INIT_0A[i]; mem[i+2816] = INIT_0B[i];
        mem[i+3072] = INIT_0C[i]; mem[i+3328] = INIT_0D[i]; mem[i+3584] = INIT_0E[i]; mem[i+3840] = INIT_0F[i];
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 4'b0000; else if (WEA) begin mem[{ADDRA, 2'b00}] <= DIA[0]; mem[{ADDRA, 2'b01}] <= DIA[1]; mem[{ADDRA, 2'b10}] <= DIA[2]; mem[{ADDRA, 2'b11}] <= DIA[3]; DOA <= DIA; end else DOA <= {mem[{ADDRA, 2'b11}], mem[{ADDRA, 2'b10}], mem[{ADDRA, 2'b01}], mem[{ADDRA, 2'b00}]}; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 16'h0000; else if (WEB) begin mem[{ADDRB, 4'h0}] <= DIB[0]; mem[{ADDRB, 4'h1}] <= DIB[1]; mem[{ADDRB, 4'h2}] <= DIB[2]; mem[{ADDRB, 4'h3}] <= DIB[3]; mem[{ADDRB, 4'h4}] <= DIB[4]; mem[{ADDRB, 4'h5}] <= DIB[5]; mem[{ADDRB, 4'h6}] <= DIB[6]; mem[{ADDRB, 4'h7}] <= DIB[7]; mem[{ADDRB, 4'h8}] <= DIB[8]; mem[{ADDRB, 4'h9}] <= DIB[9]; mem[{ADDRB, 4'hA}] <= DIB[10]; mem[{ADDRB, 4'hB}] <= DIB[11]; mem[{ADDRB, 4'hC}] <= DIB[12]; mem[{ADDRB, 4'hD}] <= DIB[13]; mem[{ADDRB, 4'hE}] <= DIB[14]; mem[{ADDRB, 4'hF}] <= DIB[15]; DOB <= DIB; end else DOB <= {mem[{ADDRB, 4'hF}], mem[{ADDRB, 4'hE}], mem[{ADDRB, 4'hD}], mem[{ADDRB, 4'hC}], mem[{ADDRB, 4'hB}], mem[{ADDRB, 4'hA}], mem[{ADDRB, 4'h9}], mem[{ADDRB, 4'h8}], mem[{ADDRB, 4'h7}], mem[{ADDRB, 4'h6}], mem[{ADDRB, 4'h5}], mem[{ADDRB, 4'h4}], mem[{ADDRB, 4'h3}], mem[{ADDRB, 4'h2}], mem[{ADDRB, 4'h1}], mem[{ADDRB, 4'h0}]}; end
endmodule


// RAMB4_S8_Sx series (y >= 8): S8_S8, S8_S16
module RAMB4_S8_S8(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [8:0] ADDRA, ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [7:0] DIA, DIB;
    output reg [7:0] DOA, DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [7:0] mem [0:511];
    integer i;
    
    initial for (i = 0; i < 32; i = i + 1) begin
        mem[i] = INIT_00[i*8 +: 8]; mem[i+32] = INIT_01[i*8 +: 8]; mem[i+64] = INIT_02[i*8 +: 8]; mem[i+96] = INIT_03[i*8 +: 8];
        mem[i+128] = INIT_04[i*8 +: 8]; mem[i+160] = INIT_05[i*8 +: 8]; mem[i+192] = INIT_06[i*8 +: 8]; mem[i+224] = INIT_07[i*8 +: 8];
        mem[i+256] = INIT_08[i*8 +: 8]; mem[i+288] = INIT_09[i*8 +: 8]; mem[i+320] = INIT_0A[i*8 +: 8]; mem[i+352] = INIT_0B[i*8 +: 8];
        mem[i+384] = INIT_0C[i*8 +: 8]; mem[i+416] = INIT_0D[i*8 +: 8]; mem[i+448] = INIT_0E[i*8 +: 8]; mem[i+480] = INIT_0F[i*8 +: 8];
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 8'h00; else if (WEA) begin mem[ADDRA] <= DIA; DOA <= DIA; end else DOA <= mem[ADDRA]; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 8'h00; else if (WEB) begin mem[ADDRB] <= DIB; DOB <= DIB; end else DOB <= mem[ADDRB]; end
endmodule

module RAMB4_S8_S16(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [8:0] ADDRA;
    input [7:0] ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [7:0] DIA;
    input [15:0] DIB;
    output reg [7:0] DOA;
    output reg [15:0] DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [0:0] mem [0:4095];
    integer i;
    
    initial for (i = 0; i < 256; i = i + 1) begin
        mem[i] = INIT_00[i]; mem[i+256] = INIT_01[i]; mem[i+512] = INIT_02[i]; mem[i+768] = INIT_03[i];
        mem[i+1024] = INIT_04[i]; mem[i+1280] = INIT_05[i]; mem[i+1536] = INIT_06[i]; mem[i+1792] = INIT_07[i];
        mem[i+2048] = INIT_08[i]; mem[i+2304] = INIT_09[i]; mem[i+2560] = INIT_0A[i]; mem[i+2816] = INIT_0B[i];
        mem[i+3072] = INIT_0C[i]; mem[i+3328] = INIT_0D[i]; mem[i+3584] = INIT_0E[i]; mem[i+3840] = INIT_0F[i];
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 8'h00; else if (WEA) begin mem[{ADDRA, 3'b000}] <= DIA[0]; mem[{ADDRA, 3'b001}] <= DIA[1]; mem[{ADDRA, 3'b010}] <= DIA[2]; mem[{ADDRA, 3'b011}] <= DIA[3]; mem[{ADDRA, 3'b100}] <= DIA[4]; mem[{ADDRA, 3'b101}] <= DIA[5]; mem[{ADDRA, 3'b110}] <= DIA[6]; mem[{ADDRA, 3'b111}] <= DIA[7]; DOA <= DIA; end else DOA <= {mem[{ADDRA, 3'b111}], mem[{ADDRA, 3'b110}], mem[{ADDRA, 3'b101}], mem[{ADDRA, 3'b100}], mem[{ADDRA, 3'b011}], mem[{ADDRA, 3'b010}], mem[{ADDRA, 3'b001}], mem[{ADDRA, 3'b000}]}; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 16'h0000; else if (WEB) begin mem[{ADDRB, 4'h0}] <= DIB[0]; mem[{ADDRB, 4'h1}] <= DIB[1]; mem[{ADDRB, 4'h2}] <= DIB[2]; mem[{ADDRB, 4'h3}] <= DIB[3]; mem[{ADDRB, 4'h4}] <= DIB[4]; mem[{ADDRB, 4'h5}] <= DIB[5]; mem[{ADDRB, 4'h6}] <= DIB[6]; mem[{ADDRB, 4'h7}] <= DIB[7]; mem[{ADDRB, 4'h8}] <= DIB[8]; mem[{ADDRB, 4'h9}] <= DIB[9]; mem[{ADDRB, 4'hA}] <= DIB[10]; mem[{ADDRB, 4'hB}] <= DIB[11]; mem[{ADDRB, 4'hC}] <= DIB[12]; mem[{ADDRB, 4'hD}] <= DIB[13]; mem[{ADDRB, 4'hE}] <= DIB[14]; mem[{ADDRB, 4'hF}] <= DIB[15]; DOB <= DIB; end else DOB <= {mem[{ADDRB, 4'hF}], mem[{ADDRB, 4'hE}], mem[{ADDRB, 4'hD}], mem[{ADDRB, 4'hC}], mem[{ADDRB, 4'hB}], mem[{ADDRB, 4'hA}], mem[{ADDRB, 4'h9}], mem[{ADDRB, 4'h8}], mem[{ADDRB, 4'h7}], mem[{ADDRB, 4'h6}], mem[{ADDRB, 4'h5}], mem[{ADDRB, 4'h4}], mem[{ADDRB, 4'h3}], mem[{ADDRB, 4'h2}], mem[{ADDRB, 4'h1}], mem[{ADDRB, 4'h0}]}; end
endmodule


// RAMB4_S16_Sx series (y >= 16): S16_S16
module RAMB4_S16_S16(ADDRA, CLKA, RSTA, DIA, DOA, WEA, ENA, ADDRB, CLKB, RSTB, DIB, DOB, WEB, ENB);
    input [7:0] ADDRA, ADDRB;
    input CLKA, RSTA, WEA, ENA, CLKB, RSTB, WEB, ENB;
    input [15:0] DIA, DIB;
    output reg [15:0] DOA, DOB;
    
    parameter INIT_00 = 256'h0; parameter INIT_01 = 256'h0; parameter INIT_02 = 256'h0; parameter INIT_03 = 256'h0;
    parameter INIT_04 = 256'h0; parameter INIT_05 = 256'h0; parameter INIT_06 = 256'h0; parameter INIT_07 = 256'h0;
    parameter INIT_08 = 256'h0; parameter INIT_09 = 256'h0; parameter INIT_0A = 256'h0; parameter INIT_0B = 256'h0;
    parameter INIT_0C = 256'h0; parameter INIT_0D = 256'h0; parameter INIT_0E = 256'h0; parameter INIT_0F = 256'h0;
    
    reg [15:0] mem [0:255];
    integer i;
    
    initial for (i = 0; i < 16; i = i + 1) begin
        mem[i] = INIT_00[i*16 +: 16]; mem[i+16] = INIT_01[i*16 +: 16]; mem[i+32] = INIT_02[i*16 +: 16]; mem[i+48] = INIT_03[i*16 +: 16];
        mem[i+64] = INIT_04[i*16 +: 16]; mem[i+80] = INIT_05[i*16 +: 16]; mem[i+96] = INIT_06[i*16 +: 16]; mem[i+112] = INIT_07[i*16 +: 16];
        mem[i+128] = INIT_08[i*16 +: 16]; mem[i+144] = INIT_09[i*16 +: 16]; mem[i+160] = INIT_0A[i*16 +: 16]; mem[i+176] = INIT_0B[i*16 +: 16];
        mem[i+192] = INIT_0C[i*16 +: 16]; mem[i+208] = INIT_0D[i*16 +: 16]; mem[i+224] = INIT_0E[i*16 +: 16]; mem[i+240] = INIT_0F[i*16 +: 16];
    end
    
    always @(posedge CLKA) if (ENA) begin if (RSTA) DOA <= 16'h0000; else if (WEA) begin mem[ADDRA] <= DIA; DOA <= DIA; end else DOA <= mem[ADDRA]; end
    always @(posedge CLKB) if (ENB) begin if (RSTB) DOB <= 16'h0000; else if (WEB) begin mem[ADDRB] <= DIB; DOB <= DIB; end else DOB <= mem[ADDRB]; end
endmodule




/*===========================================================================
 * BLOCKRAM - Unified Block RAM for Pack/Route netlists
 * Uses generate-if to instantiate appropriate RAMB4_Sx or RAMB4_Sx_Sy
 * Supports both single-port and dual-port configurations
 *===========================================================================*/

module BLOCKRAM (
    CKA, AWE, AEN, RSTA,
    CKB, BWE, BEN, RSTB,
    ADDRA_0, ADDRA_1, ADDRA_2, ADDRA_3, ADDRA_4, ADDRA_5,
    ADDRA_6, ADDRA_7, ADDRA_8, ADDRA_9, ADDRA_10, ADDRA_11,
    ADDRB_0, ADDRB_1, ADDRB_2, ADDRB_3, ADDRB_4, ADDRB_5,
    ADDRB_6, ADDRB_7, ADDRB_8, ADDRB_9, ADDRB_10, ADDRB_11,
    DINA0, DINA1, DINA2, DINA3, DINA4, DINA5, DINA6, DINA7,
    DINA8, DINA9, DINA10, DINA11, DINA12, DINA13, DINA14, DINA15,
    DINB0, DINB1, DINB2, DINB3, DINB4, DINB5, DINB6, DINB7,
    DINB8, DINB9, DINB10, DINB11, DINB12, DINB13, DINB14, DINB15,
    DOUTA0, DOUTA1, DOUTA2, DOUTA3, DOUTA4, DOUTA5, DOUTA6, DOUTA7,
    DOUTA8, DOUTA9, DOUTA10, DOUTA11, DOUTA12, DOUTA13, DOUTA14, DOUTA15,
    DOUTB0, DOUTB1, DOUTB2, DOUTB3, DOUTB4, DOUTB5, DOUTB6, DOUTB7,
    DOUTB8, DOUTB9, DOUTB10, DOUTB11, DOUTB12, DOUTB13, DOUTB14, DOUTB15
);

    //========================================================================
    // Parameters - set via defparam from netlist (after preprocessing)
    //========================================================================
    parameter [255:0] init_00 = 256'h0;
    parameter [255:0] init_01 = 256'h0;
    parameter [255:0] init_02 = 256'h0;
    parameter [255:0] init_03 = 256'h0;
    parameter [255:0] init_04 = 256'h0;
    parameter [255:0] init_05 = 256'h0;
    parameter [255:0] init_06 = 256'h0;
    parameter [255:0] init_07 = 256'h0;
    parameter [255:0] init_08 = 256'h0;
    parameter [255:0] init_09 = 256'h0;
    parameter [255:0] init_0a = 256'h0;
    parameter [255:0] init_0b = 256'h0;
    parameter [255:0] init_0c = 256'h0;
    parameter [255:0] init_0d = 256'h0;
    parameter [255:0] init_0e = 256'h0;
    parameter [255:0] init_0f = 256'h0;
    
    parameter [79:0] porta_attr = "1024X4";
    parameter [79:0] portb_attr = "NONE";  // "NONE" for single-port
    
    // Mux configuration parameters (for compatibility with netlist)
    parameter [79:0] clkamux = "1";
    parameter [79:0] enamux = "ENA";
    parameter [79:0] rstamux = "RSTA";
    parameter [79:0] weamux = "WEA";
    parameter [79:0] clkbmux = "1";
    parameter [79:0] enbmux = "ENB";
    parameter [79:0] rstbmux = "RSTB";
    parameter [79:0] webmux = "WEB";
    
    //========================================================================
    // Port declarations
    //========================================================================
    input CKA, AWE, AEN, RSTA;
    input CKB, BWE, BEN, RSTB;
    input ADDRA_0, ADDRA_1, ADDRA_2, ADDRA_3, ADDRA_4, ADDRA_5;
    input ADDRA_6, ADDRA_7, ADDRA_8, ADDRA_9, ADDRA_10, ADDRA_11;
    input ADDRB_0, ADDRB_1, ADDRB_2, ADDRB_3, ADDRB_4, ADDRB_5;
    input ADDRB_6, ADDRB_7, ADDRB_8, ADDRB_9, ADDRB_10, ADDRB_11;
    input DINA0, DINA1, DINA2, DINA3, DINA4, DINA5, DINA6, DINA7;
    input DINA8, DINA9, DINA10, DINA11, DINA12, DINA13, DINA14, DINA15;
    input DINB0, DINB1, DINB2, DINB3, DINB4, DINB5, DINB6, DINB7;
    input DINB8, DINB9, DINB10, DINB11, DINB12, DINB13, DINB14, DINB15;
    output DOUTA0, DOUTA1, DOUTA2, DOUTA3, DOUTA4, DOUTA5, DOUTA6, DOUTA7;
    output DOUTA8, DOUTA9, DOUTA10, DOUTA11, DOUTA12, DOUTA13, DOUTA14, DOUTA15;
    output DOUTB0, DOUTB1, DOUTB2, DOUTB3, DOUTB4, DOUTB5, DOUTB6, DOUTB7;
    output DOUTB8, DOUTB9, DOUTB10, DOUTB11, DOUTB12, DOUTB13, DOUTB14, DOUTB15;

    //========================================================================
    // Internal signals
    //========================================================================
    wire [11:0] ADDRA = {ADDRA_11, ADDRA_10, ADDRA_9, ADDRA_8, ADDRA_7, ADDRA_6,
                         ADDRA_5, ADDRA_4, ADDRA_3, ADDRA_2, ADDRA_1, ADDRA_0};
    wire [11:0] ADDRB = {ADDRB_11, ADDRB_10, ADDRB_9, ADDRB_8, ADDRB_7, ADDRB_6,
                         ADDRB_5, ADDRB_4, ADDRB_3, ADDRB_2, ADDRB_1, ADDRB_0};
    wire [15:0] DINA = {DINA15, DINA14, DINA13, DINA12, DINA11, DINA10, DINA9, DINA8,
                        DINA7, DINA6, DINA5, DINA4, DINA3, DINA2, DINA1, DINA0};
    wire [15:0] DINB = {DINB15, DINB14, DINB13, DINB12, DINB11, DINB10, DINB9, DINB8,
                        DINB7, DINB6, DINB5, DINB4, DINB3, DINB2, DINB1, DINB0};
    
    wire [15:0] DOUTA, DOUTB;
    
    assign {DOUTA15, DOUTA14, DOUTA13, DOUTA12, DOUTA11, DOUTA10, DOUTA9, DOUTA8,
            DOUTA7, DOUTA6, DOUTA5, DOUTA4, DOUTA3, DOUTA2, DOUTA1, DOUTA0} = DOUTA;
    assign {DOUTB15, DOUTB14, DOUTB13, DOUTB12, DOUTB11, DOUTB10, DOUTB9, DOUTB8,
            DOUTB7, DOUTB6, DOUTB5, DOUTB4, DOUTB3, DOUTB2, DOUTB1, DOUTB0} = DOUTB;

    //========================================================================
    // Helper: Determine data width from config string
    //========================================================================
    function automatic integer get_data_width;
        input [79:0] config_str;
        begin
            if (config_str == "4096X1") get_data_width = 1;
            else if (config_str == "2048X2") get_data_width = 2;
            else if (config_str == "1024X4") get_data_width = 4;
            else if (config_str == "512X8") get_data_width = 8;
            else if (config_str == "256X16") get_data_width = 16;
            else get_data_width = 4; // default
        end
    endfunction

    //========================================================================
    // Address mapping for Pack netlist:
    // Pack tool maps address to upper bits of ADDRA, leaving lower bits (0,1) unused
    // This ensures data alignment when using partial width configurations
    //========================================================================
    // Address width by configuration:
    // - 4096X1: 12-bit (ADDRA[11:0])
    // - 2048X2: 11-bit (ADDRA[11:1] - 1-bit padding)
    // - 1024X4: 10-bit (ADDRA[11:2] - 2-bit padding)
    // - 512X8:  9-bit  (ADDRA[11:3] - 3-bit padding)
    // - 256X16: 8-bit  (ADDRA[11:4] - 4-bit padding)
    
    //========================================================================
    // Generate: Single-Port Configurations (portb_attr == "NONE")
    //========================================================================
    generate
        if (portb_attr == "NONE") begin : gen_single_port
            
            // 4096x1 - uses full 12-bit address
            if (porta_attr == "4096X1") begin : gen_s1
                RAMB4_S1 ramb4_inst (
                    .ADDR(ADDRA[11:0]), .CLK(CKA), .RST(RSTA),
                    .DI(DINA[0:0]), .DO(DOUTA[0:0]), .WE(AWE), .EN(AEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:1] = 15'b0;
                assign DOUTB = 16'b0;
            end
            
            // 2048x2 - uses ADDRA[11:1] (11-bit)
            else if (porta_attr == "2048X2") begin : gen_s2
                RAMB4_S2 ramb4_inst (
                    .ADDR(ADDRA[11:1]), .CLK(CKA), .RST(RSTA),
                    .DI(DINA[1:0]), .DO(DOUTA[1:0]), .WE(AWE), .EN(AEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:2] = 14'b0;
                assign DOUTB = 16'b0;
            end
            
            // 1024x4 (default) - uses ADDRA[11:2] (10-bit)
            else if (porta_attr == "1024X4" || porta_attr == "NONE") begin : gen_s4
                RAMB4_S4 ramb4_inst (
                    .ADDR(ADDRA[11:2]), .CLK(CKA), .RST(RSTA),
                    .DI(DINA[3:0]), .DO(DOUTA[3:0]), .WE(AWE), .EN(AEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:4] = 12'b0;
                assign DOUTB = 16'b0;
            end
            
            // 512x8 - uses ADDRA[11:3] (9-bit)
            else if (porta_attr == "512X8") begin : gen_s8
                RAMB4_S8 ramb4_inst (
                    .ADDR(ADDRA[11:3]), .CLK(CKA), .RST(RSTA),
                    .DI(DINA[7:0]), .DO(DOUTA[7:0]), .WE(AWE), .EN(AEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:8] = 8'b0;
                assign DOUTB = 16'b0;
            end
            
            // 256x16 - uses ADDRA[11:4] (8-bit)
            else if (porta_attr == "256X16") begin : gen_s16
                RAMB4_S16 ramb4_inst (
                    .ADDR(ADDRA[11:4]), .CLK(CKA), .RST(RSTA),
                    .DI(DINA[15:0]), .DO(DOUTA[15:0]), .WE(AWE), .EN(AEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTB = 16'b0;
            end
        end
        
        //========================================================================
        //========================================================================
        // Generate: Dual-Port Configurations (portb_attr != "NONE")
        // Supports both symmetric and asymmetric configurations
        // Constraint: Port B width >= Port A width (y >= x in RAMB4_Sx_Sy)
        // Address mapping follows same rule as single-port
        //========================================================================
        else begin : gen_dual_port
            
            // Helper function to get address MSB index for config
            function automatic integer get_addr_msb;
                input [79:0] config_str;
                begin
                    if (config_str == "4096X1") get_addr_msb = 11;
                    else if (config_str == "2048X2") get_addr_msb = 11;
                    else if (config_str == "1024X4") get_addr_msb = 11;
                    else if (config_str == "512X8") get_addr_msb = 11;
                    else if (config_str == "256X16") get_addr_msb = 11;
                    else get_addr_msb = 11;
                end
            endfunction
            
            function automatic integer get_addr_lsb;
                input [79:0] config_str;
                begin
                    if (config_str == "4096X1") get_addr_lsb = 0;
                    else if (config_str == "2048X2") get_addr_lsb = 1;
                    else if (config_str == "1024X4") get_addr_lsb = 2;
                    else if (config_str == "512X8") get_addr_lsb = 3;
                    else if (config_str == "256X16") get_addr_lsb = 4;
                    else get_addr_lsb = 2;
                end
            endfunction
            
            // S1_Sx series (Port A = 1-bit): S1_S1, S1_S2, S1_S4, S1_S8, S1_S16
            if (porta_attr == "4096X1" && portb_attr == "4096X1") begin : gen_s1_s1
                RAMB4_S1_S1 ramb4_inst (
                    .ADDRA(ADDRA[11:0]), .CLKA(CKA), .RSTA(RSTA),
                    .DIA(DINA[0:0]), .DOA(DOUTA[0:0]), .WEA(AWE), .ENA(AEN),
                    .ADDRB(ADDRB[11:0]), .CLKB(CKB), .RSTB(RSTB),
                    .DIB(DINB[0:0]), .DOB(DOUTB[0:0]), .WEB(BWE), .ENB(BEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:1] = 15'b0;
                assign DOUTB[15:1] = 15'b0;
            end
            else if (porta_attr == "4096X1" && portb_attr == "2048X2") begin : gen_s1_s2
                RAMB4_S1_S2 ramb4_inst (
                    .ADDRA(ADDRA[11:0]), .CLKA(CKA), .RSTA(RSTA),
                    .DIA(DINA[0:0]), .DOA(DOUTA[0:0]), .WEA(AWE), .ENA(AEN),
                    .ADDRB(ADDRB[11:1]), .CLKB(CKB), .RSTB(RSTB),
                    .DIB(DINB[1:0]), .DOB(DOUTB[1:0]), .WEB(BWE), .ENB(BEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:1] = 15'b0;
                assign DOUTB[15:2] = 14'b0;
            end
            else if (porta_attr == "4096X1" && portb_attr == "1024X4") begin : gen_s1_s4
                RAMB4_S1_S4 ramb4_inst (
                    .ADDRA(ADDRA[11:0]), .CLKA(CKA), .RSTA(RSTA),
                    .DIA(DINA[0:0]), .DOA(DOUTA[0:0]), .WEA(AWE), .ENA(AEN),
                    .ADDRB(ADDRB[11:2]), .CLKB(CKB), .RSTB(RSTB),
                    .DIB(DINB[3:0]), .DOB(DOUTB[3:0]), .WEB(BWE), .ENB(BEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:1] = 15'b0;
                assign DOUTB[15:4] = 12'b0;
            end
            else if (porta_attr == "4096X1" && portb_attr == "512X8") begin : gen_s1_s8
                RAMB4_S1_S8 ramb4_inst (
                    .ADDRA(ADDRA[11:0]), .CLKA(CKA), .RSTA(RSTA),
                    .DIA(DINA[0:0]), .DOA(DOUTA[0:0]), .WEA(AWE), .ENA(AEN),
                    .ADDRB(ADDRB[11:3]), .CLKB(CKB), .RSTB(RSTB),
                    .DIB(DINB[7:0]), .DOB(DOUTB[7:0]), .WEB(BWE), .ENB(BEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:1] = 15'b0;
                assign DOUTB[15:8] = 8'b0;
            end
            else if (porta_attr == "4096X1" && portb_attr == "256X16") begin : gen_s1_s16
                RAMB4_S1_S16 ramb4_inst (
                    .ADDRA(ADDRA[11:0]), .CLKA(CKA), .RSTA(RSTA),
                    .DIA(DINA[0:0]), .DOA(DOUTA[0:0]), .WEA(AWE), .ENA(AEN),
                    .ADDRB(ADDRB[11:4]), .CLKB(CKB), .RSTB(RSTB),
                    .DIB(DINB[15:0]), .DOB(DOUTB[15:0]), .WEB(BWE), .ENB(BEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:1] = 15'b0;
            end
            
            // S2_Sx series (Port A = 2-bit): S2_S2, S2_S4, S2_S8, S2_S16
            else if (porta_attr == "2048X2" && portb_attr == "2048X2") begin : gen_s2_s2
                RAMB4_S2_S2 ramb4_inst (
                    .ADDRA(ADDRA[11:1]), .CLKA(CKA), .RSTA(RSTA),
                    .DIA(DINA[1:0]), .DOA(DOUTA[1:0]), .WEA(AWE), .ENA(AEN),
                    .ADDRB(ADDRB[11:1]), .CLKB(CKB), .RSTB(RSTB),
                    .DIB(DINB[1:0]), .DOB(DOUTB[1:0]), .WEB(BWE), .ENB(BEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:2] = 14'b0;
                assign DOUTB[15:2] = 14'b0;
            end
            else if (porta_attr == "2048X2" && portb_attr == "1024X4") begin : gen_s2_s4
                RAMB4_S2_S4 ramb4_inst (
                    .ADDRA(ADDRA[11:1]), .CLKA(CKA), .RSTA(RSTA),
                    .DIA(DINA[1:0]), .DOA(DOUTA[1:0]), .WEA(AWE), .ENA(AEN),
                    .ADDRB(ADDRB[11:2]), .CLKB(CKB), .RSTB(RSTB),
                    .DIB(DINB[3:0]), .DOB(DOUTB[3:0]), .WEB(BWE), .ENB(BEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:2] = 14'b0;
                assign DOUTB[15:4] = 12'b0;
            end
            
            // S4_Sx series (Port A = 4-bit): S4_S4, S4_S8, S4_S16
            else if (porta_attr == "1024X4" && portb_attr == "1024X4") begin : gen_s4_s4
                RAMB4_S4_S4 ramb4_inst (
                    .ADDRA(ADDRA[11:2]), .CLKA(CKA), .RSTA(RSTA),
                    .DIA(DINA[3:0]), .DOA(DOUTA[3:0]), .WEA(AWE), .ENA(AEN),
                    .ADDRB(ADDRB[11:2]), .CLKB(CKB), .RSTB(RSTB),
                    .DIB(DINB[3:0]), .DOB(DOUTB[3:0]), .WEB(BWE), .ENB(BEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:4] = 12'b0;
                assign DOUTB[15:4] = 12'b0;
            end
            else if (porta_attr == "1024X4" && portb_attr == "512X8") begin : gen_s4_s8
                RAMB4_S4_S8 ramb4_inst (
                    .ADDRA(ADDRA[11:2]), .CLKA(CKA), .RSTA(RSTA),
                    .DIA(DINA[3:0]), .DOA(DOUTA[3:0]), .WEA(AWE), .ENA(AEN),
                    .ADDRB(ADDRB[11:3]), .CLKB(CKB), .RSTB(RSTB),
                    .DIB(DINB[7:0]), .DOB(DOUTB[7:0]), .WEB(BWE), .ENB(BEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:4] = 12'b0;
                assign DOUTB[15:8] = 8'b0;
            end
            else if (porta_attr == "1024X4" && portb_attr == "256X16") begin : gen_s4_s16
                RAMB4_S4_S16 ramb4_inst (
                    .ADDRA(ADDRA[11:2]), .CLKA(CKA), .RSTA(RSTA),
                    .DIA(DINA[3:0]), .DOA(DOUTA[3:0]), .WEA(AWE), .ENA(AEN),
                    .ADDRB(ADDRB[11:4]), .CLKB(CKB), .RSTB(RSTB),
                    .DIB(DINB[15:0]), .DOB(DOUTB[15:0]), .WEB(BWE), .ENB(BEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:4] = 12'b0;
            end
            
            // S8_Sx series (Port A = 8-bit): S8_S8, S8_S16
            else if (porta_attr == "512X8" && portb_attr == "512X8") begin : gen_s8_s8
                RAMB4_S8_S8 ramb4_inst (
                    .ADDRA(ADDRA[11:3]), .CLKA(CKA), .RSTA(RSTA),
                    .DIA(DINA[7:0]), .DOA(DOUTA[7:0]), .WEA(AWE), .ENA(AEN),
                    .ADDRB(ADDRB[11:3]), .CLKB(CKB), .RSTB(RSTB),
                    .DIB(DINB[7:0]), .DOB(DOUTB[7:0]), .WEB(BWE), .ENB(BEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:8] = 8'b0;
                assign DOUTB[15:8] = 8'b0;
            end
            else if (porta_attr == "512X8" && portb_attr == "256X16") begin : gen_s8_s16
                RAMB4_S8_S16 ramb4_inst (
                    .ADDRA(ADDRA[11:3]), .CLKA(CKA), .RSTA(RSTA),
                    .DIA(DINA[7:0]), .DOA(DOUTA[7:0]), .WEA(AWE), .ENA(AEN),
                    .ADDRB(ADDRB[11:4]), .CLKB(CKB), .RSTB(RSTB),
                    .DIB(DINB[15:0]), .DOB(DOUTB[15:0]), .WEB(BWE), .ENB(BEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:8] = 8'b0;
            end
            
            // S16_S16 (Port A = 16-bit, Port B = 16-bit)
            else if (porta_attr == "256X16" && portb_attr == "256X16") begin : gen_s16_s16
                RAMB4_S16_S16 ramb4_inst (
                    .ADDRA(ADDRA[11:4]), .CLKA(CKA), .RSTA(RSTA),
                    .DIA(DINA[15:0]), .DOA(DOUTA[15:0]), .WEA(AWE), .ENA(AEN),
                    .ADDRB(ADDRB[11:4]), .CLKB(CKB), .RSTB(RSTB),
                    .DIB(DINB[15:0]), .DOB(DOUTB[15:0]), .WEB(BWE), .ENB(BEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
            end
            
            // Default: S4_S4 (most common dual-port configuration)
            else begin : gen_default_dual
                RAMB4_S4_S4 ramb4_inst (
                    .ADDRA(ADDRA[11:2]), .CLKA(CKA), .RSTA(RSTA),
                    .DIA(DINA[3:0]), .DOA(DOUTA[3:0]), .WEA(AWE), .ENA(AEN),
                    .ADDRB(ADDRB[11:2]), .CLKB(CKB), .RSTB(RSTB),
                    .DIB(DINB[3:0]), .DOB(DOUTB[3:0]), .WEB(BWE), .ENB(BEN)
                );
                defparam ramb4_inst.INIT_00 = init_00; defparam ramb4_inst.INIT_01 = init_01;
                defparam ramb4_inst.INIT_02 = init_02; defparam ramb4_inst.INIT_03 = init_03;
                defparam ramb4_inst.INIT_04 = init_04; defparam ramb4_inst.INIT_05 = init_05;
                defparam ramb4_inst.INIT_06 = init_06; defparam ramb4_inst.INIT_07 = init_07;
                defparam ramb4_inst.INIT_08 = init_08; defparam ramb4_inst.INIT_09 = init_09;
                defparam ramb4_inst.INIT_0A = init_0a; defparam ramb4_inst.INIT_0B = init_0b;
                defparam ramb4_inst.INIT_0C = init_0c; defparam ramb4_inst.INIT_0D = init_0d;
                defparam ramb4_inst.INIT_0E = init_0e; defparam ramb4_inst.INIT_0F = init_0f;
                assign DOUTA[15:4] = 12'b0;
                assign DOUTB[15:4] = 12'b0;
            end
        end
    endgenerate

endmodule

//============================================================================
// Clock Hint DFF (for dual-port RAM wrapper)
// Map tool recognizes DFF CK as clock but not RAMB4_Sx_Sy CLKA/CLKB.
// This module is instantiated in dual-port wrappers with (* keep *)
// to ensure Map inserts CLKBUF for the clk input.
//============================================================================
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
