`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2023 08:54:33 PM
// Design Name: 
// Module Name: single_cycle_top
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

//`include "prpgram_counter.v"
//`include "instr_mem.v"
//`include "reg_file.v"
//`include "sign_extend.v"
//`include "alu.v"
//`include "controlUnitTop.v"
//`include "data_mem.v"
//`include "PC_Adder.v"
//`include "mux.v"


module single_cycle_top(
input clk, rst
    );
    
    wire PC_out;  //  o/p of program counter
    wire [31:0] instr;   // o/p of the instr memory 
    wire we;            // control signal to write data in data mem
    wire [31:0] alu_out;        // output of the ALU
    wire [31:0] RD2_out, RD1_out, RD2_out_from_mux;         // o/p of the reg file for the 2nd read register
    wire [31:0] read_data, result;
    //wire regWrite;                   //control signal to write data in the registers of temp register (special purpose registers)
    
    wire [31:0] PCPlus4;
    //assign PCPlus4 = PC_out + 4;
    
    wire [31:0] immExt;
    wire [2:0] ALUControl;
    
    wire [1:0] aluOp;
    wire [6:0] op, funct7;
    wire [2:0] funct3;
    reg [2:0] aluControl;
    wire zero;
            //input wire [6:0] op,
    wire regWrite, aluSrc, memWrite, resultSrc, branch; 
    wire [1:0] immSrc;//, aluOp
    
    
    ALU alu (
        .A(RD1_out),
        .B(RD2_out_from_mux),
        .Result(alu_out),
        .ALUControl(ALUControl)                //,OverFlow,Carry,Zero,Negative
    );
    
    data_mem data_mem (
        .clk(clk),
        .rst(rst),
        .we(memWrite),
        .A(alu_out),
        .WD(RD2_out),
        .RD(read_data)
    );
    
    program_counter program_counter (
         .clk(clk),
         .rst(rst),
         .PC_Next(PCPlus4),
         .PC(PC_out)
        );
    
    instr_mem instr_mem (
        .rst(rst),
        .A(PC_out),
        .RD(instr)
    );
    
//    program_counter program_counter (
//        .clk(clk),
//        .rst(rst),
//        .PC_Next(PCPlus4),
//        .PC(PC_out)
//    );
    
    
    reg_file reg_file (
        .clk(clk),
        .we3(regWrite),
        .rst(rst),
        .A1(instr[19:15]),
        .A2(instr[24:20]),
        .A3(instr[11:7]),
        .WD3(result),
        .RD1(RD1_out),
        .RD2(RD2_out)
    );
    
    mux mux_bw_reg_alu (
    .a(RD2_out),
    .b(immExt),
    .sel(aluSrc),
    .mux_out(RD2_out_from_mux)
    );
    
    
    //wire [1:0] immSrc;
    sign_extended sign (
        .in(instr[31:7]),
        .immSrc(immSrc[0]),
        .immExt(immExt)
    );
    
    mux mux_afer_data_mem (
    .a(alu_out),
    .b(read_data),
    .c(resultSrc),
    .mux_out(result)
    );
    
    PC_Adder PC_Adder(
        .a(PC_out),
        .b(32'd4),
        .c(PCPlus4)
        );
        
    
        
    controlUnitTop control (
    .aluOp(aluOp),
    .op(op),
    .funct7(funct7),
    .aluControl(aluControl),
    .zero(zero),
    .regWrite(regWrite),
    .aluSrc(aluSrc),
    .memWrite(memWrite), 
    .resultSrc(resultSrc), 
    .branch(branch),
    .immSrc(immSrc)
    );
endmodule
