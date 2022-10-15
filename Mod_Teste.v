`default_nettype none //Comando para desabilitar declaração automática de wires
module Mod_Teste (
//Clocks
input CLOCK_27, CLOCK_50,
//Chaves e Botoes
input [3:0] KEY,
input [17:0] SW,
//Displays de 7 seg e LEDs
output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
output [8:0] LEDG,
output [17:0] LEDR,
//Serial
output UART_TXD,
input UART_RXD,
inout [7:0] LCD_DATA,
output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
//GPIO
inout [35:0] GPIO_0, GPIO_1
);
assign GPIO_1 = 36'hzzzzzzzzz;
assign GPIO_0 = 36'hzzzzzzzzz;
assign LCD_ON = 1'b1;
assign LCD_BLON = 1'b1;
wire [7:0] w_d0x0, w_d0x1, w_d0x2, w_d0x3, w_d0x4, w_d0x5,
w_d1x0, w_d1x1, w_d1x2, w_d1x3, w_d1x4, w_d1x5;
LCD_TEST MyLCD (
.iCLK ( CLOCK_50 ),
.iRST_N ( KEY[0] ),
.d0x0(w_d0x0),.d0x1(w_d0x1),.d0x2(w_d0x2),.d0x3(w_d0x3),.d0x4(w_d0x4),.d0x5(w_d0x5),
.d1x0(w_d1x0),.d1x1(w_d1x1),.d1x2(w_d1x2),.d1x3(w_d1x3),.d1x4(w_d1x4),.d1x5(w_d1x5),
.LCD_DATA( LCD_DATA ),
.LCD_RW ( LCD_RW ),
.LCD_EN ( LCD_EN ),
.LCD_RS ( LCD_RS )
);

//---------- modifique a partir daqui --------


wire w_PCSrc, w_Jump, w_Branch, w_Z, CLK, w_ULASrc, w_RegWrite, w_RegDst, w_MemtoReg, w_MemWrite, w_We;
wire [2:0]w_ULAControl, w_wa3;
wire [7:0]w_PCp1, w_m1, w_nPC, w_PCBranch, w_PC, w_rd1SrcA, w_rd2, w_SrcB, w_ULAResultWd3, w_wd3, w_RData, saida_and, w_DataIn, w_DataOut, w_RegData;
wire [31:0]w_Inst;
assign LEDG[0] = CLK;
assign LEDR[0] = w_Jump;
assign LEDR[6:4] = w_ULAControl;
assign LEDR[7] = w_ULASrc;
assign LEDR[8] = w_RegDst;
assign LEDR[9] = w_RegWrite;
assign w_d0x4 = w_PC;
assign LEDR[1] = w_MemtoReg;
assign LEDR[2] = w_MemWrite;
assign LEDG[7] = w_Z;
assign LEDR[3] = w_Branch;
assign w_d1x4 = w_DataOut;
assign LEDG[1] = w_DataOut;
assign w_DataIn = SW[7:0];


clock_divisor(.CLK_entrada(CLOCK_50), .CLK_saida(CLK));

PC (.clk(CLK), .PCin(w_nPC), .PCout(w_PC));

somador1 som1(.A(w_PC), .B(1'b1), .C(w_PCp1));

//InstructionMemory(.A(w_PC), .RD(w_Inst));

Registerfile(.clk(CLK),.we3(w_RegWrite),.wa3(w_wa3),.ra1(w_Inst[25:21]),.ra2(w_Inst[20:16]),.wd3(w_wd3),.rd1(w_rd1SrcA),.rd2(w_rd2), .S0(w_d0x0), .S1(w_d0x1), .S2(w_d0x2), .S3(w_d0x3), .S4(w_d1x0),
.S5(w_d1x1), .S6(w_d1x2), .S7(w_d1x3));

Mux2_1 muxULA(.entrada1(w_Inst[7:0]),.entrada2(w_rd2),.ch(w_ULASrc),.saida(w_SrcB));

Mux2_1 muxWR(.entrada1(w_Inst[15:11]),.entrada2(w_Inst[20:16]),.ch(w_RegDst),.saida(w_wa3));

ControlUnit(.OP(w_Inst[31:26]), .Funct(w_Inst[5:0]), .Jump(w_Jump), .MemtoReg(w_MemtoReg), .MemWrite(w_MemWrite), .Branch(w_Branch), .ULASrc(w_ULASrc), .RegDst(w_RegDst), .RegWrite(w_RegWrite), .ULAControl(w_ULAControl[2:0]));

ULA(.SrcA(w_rd1SrcA),.SrcB(w_SrcB),.ULAControl(w_ULAControl[2:0]),.ULAResult(w_ULAResultWd3),.FlagZ(w_Z));

// Módulos Sprint 6

RamDataMem ( .address(w_ULAResultWd3), .clock(CLOCK_50), .data(w_rd2), .wren(w_We), .q(w_RData));
RomInstMem ( .address(w_PC), .clock(CLOCK_50), .q(w_Inst));
Mux2_1 MuxDDest(.entrada1(w_RegData), .entrada2(w_ULAResultWd3),.ch(w_MemtoReg),.saida(w_wd3));

//Módulos Sprint 7

Mux2_1 MuxPCSrc( .entrada1(w_PCBranch), .entrada2(w_PCp1), .ch(saida_and), .saida(w_m1));
Mux2_1 MuxJump( .entrada1(w_Inst[7:0]), .entrada2(w_m1), .ch(w_Jump), .saida(w_nPC));
Module_AND and1( .ent1(w_Branch), .ent2(w_Z), .saida(saida_and));
somador1 som2( .A(w_PCp1), .B(w_Inst[7:0]), .C(w_PCBranch));

//Módulos Sprint 8

Parallel_IN(.MemData(w_RData), .Address(w_ULAResultWd3), .DataIn(w_DataIn), .RegData(w_RegData));
Parallel_OUT (.Address(w_ULAResultWd3), .we(w_MemWrite), .RegData(w_rd2), .DataOut(w_DataOut), .wren(w_We), .clk(CLK));
endmodule



























