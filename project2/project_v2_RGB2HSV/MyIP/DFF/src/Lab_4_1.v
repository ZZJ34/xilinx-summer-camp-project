`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/20 22:00:07
// Design Name: 
// Module Name: Lab_4_1
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


module Lab_4_1(
    input clk,
    input d,
    output reg q=0,
    output reg qb=1
    );
    
    always@(posedge clk)
        begin 
            q<=d;
            qb<=~d;
        end
endmodule
