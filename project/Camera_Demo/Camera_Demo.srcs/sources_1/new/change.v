`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/28 16:16:57
// Design Name: 
// Module Name: change
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


module change(
    input i_clk_100MHz,
    input i_clk_1kHz,
    input [23:0] i_rgb_data,
    input i_rgb_hsync,
    input i_rgb_vsync,
    input i_rgb_vde,
    input [10:0] i_set_x,
    input [9:0] i_set_y,
    input i_clk_pixel,
    input i_key,
    output reg[23:0] o_rgb_data,
    output o_rgb_hsync,
    output o_rgb_vsync,
    output o_rgb_vde,
    output o_clk_pixel,
    output o_green_led,
    output reg [23:0] o_led_rgb_data
    );


    assign o_clk_pixel = i_clk_pixel;
    assign o_rgb_vde = i_rgb_vde;
    assign o_rgb_vsync = i_rgb_vsync;
    assign o_rgb_hsync = i_rgb_hsync;

    reg  [23:0] temp_rgb_data [48:0];
    wire [8:0]  hsv_h_out;
    wire [23:0] rgb_data_avg;
    wire [23:0] rgb_data_out;
    wire i_key_stable;

    Key_0 key_0(.clk_1kHz(i_clk_1kHz),.rst(1),.key_in(i_key),.key_out(i_key_stable));
    
    // 在屏幕中间显示一个小红点
    always @(*) begin
        if ( i_set_x >= 636 && i_set_x < 643) begin
            if (i_set_y >= 356 && i_set_y < 363) begin
                o_rgb_data = 24'hff_00_00;
                temp_rgb_data[ (i_set_y - 356) * 7 + (i_set_x - 636)] = i_rgb_data;
                end
            else 
                o_rgb_data = i_rgb_data;
        end 
        else o_rgb_data = i_rgb_data;
    end

    assign  rgb_data_avg = (temp_rgb_data[0] + temp_rgb_data[1] + temp_rgb_data[2] + temp_rgb_data[3] + temp_rgb_data[4] + 
                           temp_rgb_data[5] + temp_rgb_data[6] + temp_rgb_data[7] + temp_rgb_data[8] + temp_rgb_data[9] + 
                           temp_rgb_data[10] + temp_rgb_data[11] + temp_rgb_data[12] + temp_rgb_data[13] + temp_rgb_data[14] +
                           temp_rgb_data[15] + temp_rgb_data[16] + temp_rgb_data[17] + temp_rgb_data[18] + temp_rgb_data[19] +
                           temp_rgb_data[20] + temp_rgb_data[21] + temp_rgb_data[22] + temp_rgb_data[23] + temp_rgb_data[24] +
                           temp_rgb_data[25] + temp_rgb_data[26] + temp_rgb_data[27] + temp_rgb_data[28] + temp_rgb_data[29] +
                           temp_rgb_data[30] + temp_rgb_data[31] + temp_rgb_data[32] + temp_rgb_data[33] + temp_rgb_data[34] +
                           temp_rgb_data[35] + temp_rgb_data[36] + temp_rgb_data[37] + temp_rgb_data[38] + temp_rgb_data[39] +
                           temp_rgb_data[40] + temp_rgb_data[41] + temp_rgb_data[42] + temp_rgb_data[43] + temp_rgb_data[44] +
                           temp_rgb_data[45] + temp_rgb_data[46] + temp_rgb_data[47] + temp_rgb_data[48])/49;
                       
                
    RGB2HSV RGB2HSV_0(.clk(i_clk_100MHz),.rst(1), .RGB_Data_R(rgb_data_avg[23:16]), .RGB_Data_G(rgb_data_avg[15:8]), .RGB_Data_B(rgb_data_avg[7:0]), .HSV_H(hsv_h_out), .HSV_S(), .HSV_V(), .Delay_Num() );
    HSV_list HSV_list_0(.HSV_H(hsv_h_out), .RGB_data(rgb_data_out));
    
    // 状�?�切�?
    reg status = 0;
    always @(negedge i_key_stable) begin
        status <= ~status;
        if (status) begin
            o_led_rgb_data <= rgb_data_out;
        end else begin
            o_led_rgb_data <= 24'h00_00_00;
        end
    end
    
    assign  o_green_led = status;

    
endmodule
