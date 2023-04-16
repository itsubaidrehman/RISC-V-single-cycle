`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2023 10:15:26 AM
// Design Name: 
// Module Name: data_mem
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


module data_mem(
input wire clk, we, rst,
input wire [31:0] A, WD,
output reg [31:0] RD
    );
    reg [31:0] data_register [1023:0];
    always @(posedge clk)
    begin
    if (we)
    data_register[A] <= WD;
    else 
    RD <= (~rst) ? 32'h00000000 : data_register[A];
    end
    
    //if you want to read everytime then
    //assign RD = (~rst) ? 32'h00000000 : data_register[A];
endmodule
