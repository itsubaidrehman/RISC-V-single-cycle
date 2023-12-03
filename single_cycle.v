`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2023 12:37:10 AM
// Design Name: 
// Module Name: single_cycle
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//`include "programCounter.v"
//`include "instrMem.v"
//`include "regFile.v"
//`include "signExtend.v"
//`include "alu1.v"
//`include "controlUnit.v"
//`include "dataMem.v"
//`include "pcAdder.v"
//`include "mux.v"

module single_cycle (input clk, rst);
  
  wire [31:0] PC_Next, PC, PCPlus4, instr, immExt, srcA, srcB, aluResult, readData;
  wire [1:0] aluOp;    
  wire [6:0] op, funct7;       
  wire [2:0] funct3;
  wire [2:0] aluControl;     
  wire zero;
  //input wire [6:0] op,
  wire regWrite, aluSrc, memWrite, resultSrc, branch; 
  wire [1:0] immSrc;//, aluOp
  
  
  controlUnit cu (
    //.aluOp(),
    .op(instr[6:0]), 
    .funct7(),       //instr[6:0]
    .funct3(instr[14:12]),
    .aluControl(aluControl),
    //.zero(),
    //input wire [6:0] op,
    .regWrite(regWrite),    //regWrite
    .aluSrc(),      //aluSrc
    .memWrite(),     //memWrite
    .resultSrc(),       //resultSrc
    .branch(), 
    .immSrc(immSrc)//, aluOp   immSrc
  );
  
  
  programCounter pc (
    .clk(clk),
    .rst(rst),
    .PC_Next(PCPlus4),    //PC_Next
    .PC(PC)
  );
  
  instrMem instrmem (
    .rst(rst),
    .A(PC),
    .RD(instr)    //instr
  );
  
  pcAdder adder4 (
    .PC(PC),
    .b(32'd4),
    .PCPlus4(PCPlus4)
  );
  
  regFile registers (
    .clk(clk), 
    .we3(regWrite),    //regWrite
    .rst(rst),
    .A1(instr[19:15]), 
    .A2(), 
    .A3(instr[11:7]),   //instr[11:7]
    .WD3(readData),    //readData
    .RD1(srcA),    //srcA
    .RD2()
  );
  
  signExtend sign (
    .instr(instr[31:7]),
    .immSrc(immSrc),
    .immExt(immExt)     //immExt
  );
  
  
  alu1 alu (
    .A(srcA),
    .B(immExt),    //srcB
    .Result(aluResult),
    .ALUControl(aluControl),
    .OverFlow(),
    .Carry(),
    .Zero(),
    .Negative()
  );
  
  
  dataMem mem (
    .clk(clk), 
    .we(), 
    .rst(rst),
    .A(aluResult), 
    .WD(),
    .RD(readData)
  );
  
endmodule
  
  

