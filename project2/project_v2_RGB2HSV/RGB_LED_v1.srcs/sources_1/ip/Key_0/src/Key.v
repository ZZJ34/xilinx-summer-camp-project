`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/22 13:36:09
// Design Name: 
// Module Name: Key
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


module Key(
    input wire clk_1kHz,
    input wire rst,
    input wire key_in,
    output reg key_out
    );

    parameter TIME_20MS = 20;       // just for test

    reg key_cnt;
    reg [20:0] cnt;

    always @(posedge clk_1kHz or negedge rst) 
    begin
        if(!rst)
            key_cnt<=0;
        else if(key_cnt == 0 && key_out != key_in)
            key_cnt <= 1;
        else if(cnt == TIME_20MS - 1)
            key_cnt <= 0;
    end

    always @(posedge clk_1kHz or negedge rst) 
    begin
        if(!rst)
            cnt<=0;
        else if(key_cnt)
            cnt <= cnt + 1'b1;
        else
            cnt <= 0;
    end

    always @(posedge clk_1kHz or negedge rst) 
    begin
        if(!rst)
            key_out <= 1;
        else if(key_cnt == 0 && key_out != key_in)
            key_out <= key_in;
    end
    
endmodule
