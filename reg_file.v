`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2023 10:15:06 AM
// Design Name: 
// Module Name: reg_file
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


module reg_file(
input wire clk, we3, rst,
input wire [4:0] A1, A2, A3,
input wire [31:0] WD3,
output [31:0] RD1, RD2
    );
    reg [31:0] registers [31:0];
    assign RD1 = (~rst) ? 32'h00000000 : registers[A1];
    assign RD2 = (~rst) ? 32'h00000000 : registers[A2];
    
    always @(posedge clk)
        begin
            if (we3)
            begin
            registers[A3] = WD3;
            end
        end
endmodule
