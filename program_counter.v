`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2023 10:09:48 AM
// Design Name: 
// Module Name: program_counter
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


module program_counter(
input wire clk, rst,
input [31:0] PC_Next,
output reg [31:0] PC
    );
    //reg [31:0] pc_register;
    always @(posedge clk)
        begin
            if (!rst)
            PC <= 0;
            else
            PC <= PC_Next;
        end
    
    
endmodule
