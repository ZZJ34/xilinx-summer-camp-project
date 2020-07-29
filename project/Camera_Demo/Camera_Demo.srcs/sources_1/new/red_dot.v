`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 16:10:05
// Design Name: 
// Module Name: red_dot
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


module red_dot(
    input [23:0] rgb_data_in,
    input [10:0] set_x,
    input [9:0]  set_y,
    output [23:0] rgb_data_out
    );
    assign  rgb_data_out = ( set_x >= 11'd0 && set_x < 11'd160) ? 24'hff_ff_00 : rgb_data_in;
endmodule
