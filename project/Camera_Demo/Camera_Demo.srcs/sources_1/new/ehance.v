`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 19:13:28
// Design Name: 
// Module Name: ehance
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


module ehance(
    input [23:0] i_rgb_data,
    output [23:0] o_rgb_data
    );
    wire [7:0] MAX = i_rgb_data[23:16] >= (i_rgb_data[15:8] >= i_rgb_data[7:0] ? i_rgb_data[15:8] : i_rgb_data[7:0]) ? i_rgb_data[23:16] : (i_rgb_data[15:8] >= i_rgb_data[7:0] ? i_rgb_data[15:8] : i_rgb_data[7:0]);
    assign o_rgb_data = { (i_rgb_data[23:16] == MAX) ? {i_rgb_data[23:16] << 1,1}:i_rgb_data[23:16],
                           (i_rgb_data[15:8] == MAX) ? {i_rgb_data[15:8] << 1,1}:i_rgb_data[15:8],
                           (i_rgb_data[7:0] == MAX) ? {i_rgb_data[7:0] << 1,0}:i_rgb_data[7:0] };
endmodule
