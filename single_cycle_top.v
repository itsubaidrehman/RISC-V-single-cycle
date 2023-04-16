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


module single_cycle_top(
input clk, rst
    );
    
    wire PC_out;  //  o/p of program counter
    wire [31:0] instr;   // o/p of the instr memory 
    wire we;            // control signal to write data in data mem
    wire [31:0] alu_out;        // output of the ALU
    wire [31:0] RD2_out, RD1_out;         // o/p of the reg file for the 2nd read register
    wire [31:0] read_out;
    wire we3;                   //control signal to write data in the registers of temp register (special purpose registers)
    
    wire [31:0] PCPlus4;
    //assign PCPlus4 = PC_out + 4;
    
    wire [31:0] immExt;
    wire [2:0] ALUControl;
    
    
    ALU alu (
        .A(RD1_out),
        .B(immExt),
        .Result(alu_out),
        .ALUControl(ALUControl)                //,OverFlow,Carry,Zero,Negative
    );
    
    data_mem data_mem (
        .clk(clk),
        .rst(rst),
        .we(we),
        .A(alu_out),
        .WD(RD2_out),
        .RD(read_out)
    );
    
    instr_mem instr_mem (
        .rst(rst),
        .A(PC_out),
        .RD(instr)
    );
    
    program_counter program_counter (
        .clk(clk),
        .rst(rst),
        .PC_Next(PCPlus4),
        .PC(PC_out)
    );
    
    
    reg_file reg_file (
        .clk(clk),
        .we3(we3),
        .rst(rst),
        .A1(instr[19:15]),
        .A2(instr[24:20]),
        .A3(instr[11:7]),
        .WD3(read_out),
        .RD1(RD1_out),
        .RD2(RD2_out)
    );
    
    wire [1:0] immSrc;
    sign_extended sign (
        .in(instr[31:7]),
        .immSrc(immSrc[0]),
        .immExt(immExt)
    );
    
    PC_Adder PC_Adder(
        .a(PC_out),
        .b(32'd4),
        .c(PCPlus4)
        );
endmodule
