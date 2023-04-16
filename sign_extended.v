`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2023 08:29:17 PM
// Design Name: 
// Module Name: sign_extended
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


module sign_extended(
input wire [31:0] in,
input wire immSrc,
output wire [31:0] immExt
    );
    assign immExt = (immSrc == 1'b1) ? ({{20{in[31]}},in[31:25],in[11:7]}):
                                            {{20{in[31]}},in[31:20]};
endmodule
