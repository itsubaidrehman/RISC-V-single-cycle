`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2023 10:07:21 AM
// Design Name: 
// Module Name: instr_mem
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


module instr_mem(
input wire rst,
input wire [31:0] A,
output [31:0] RD
    );
    reg [31:0] instr_mem_reg [1023:0];
    assign RD = (~rst) ? {32{1'b0}} : instr_mem_reg[A[31:2]];  // not instr_mem_reg[A] ??
endmodule
