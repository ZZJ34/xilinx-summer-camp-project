`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 17:56:59
// Design Name: 
// Module Name: Color_Rec_RGB
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


module Color_Rec_RGB(
    input clk_100MHz,
    input [7:0]R,
    input [7:0]G,
    input [7:0]B,
    input key_in,
    input rst,
    input [10:0]set_x,
    input [9:0]set_y,
    output reg [2:0]color_num,
    output reg LED1,        //start rec
    output reg LED2         //finish rec
    );
    
    //°´¼ü·À¶¶
    reg [30:0]Clk_Divide_1kHz=100000/2;         //Frequency division period 
    wire clk_1kHz;
    wire key_out;
    Clk_Division_0 Clk_Division_1kHz_2(.clk_100MHz(clk_100MHz),.clk_mode(Clk_Divide_1kHz),.clk_out(clk_1kHz));
    Key_0 Key1(
        .clk_1kHz(clk_1kHz),
        .key_in(key_in),
        .key_out(key_out),
        .rst(rst)
    );
    
    //image process part
    parameter black=0;
    parameter white=1;
    parameter red=2;
    parameter yellow=3;
    parameter green=4;
    parameter blue=5;
    
    
    localparam H_pixel=1280;
    localparam V_pixel=720;
    //localparam thresh=1000;        //number of pixels satisfies
    
    localparam x_min=480;
    localparam x_max=800;
    localparam y_min=270;
    localparam y_max=450;
    
    integer R_ave;
    integer G_ave;
    integer B_ave;
    integer p_cnt=0;
    //recognition mode switch
    reg [1:0]key_reg=2'b11;
    always @(posedge clk_100MHz or negedge rst)
        begin
            if (!rst)
                key_reg<=2'b11;
            else
                key_reg<={key_reg[0],key_out};
        end
        
    always @(posedge clk_100MHz or negedge rst)
        begin
            if (!rst)
                LED1<=0;
            else if (key_reg==2'b10)
                LED1<=~LED1;
            else
                LED1<=LED1;
        end
    
    //image process
    always @(*)
        begin
            if(!rst)
                begin
                    color_num<=0;
                    R_ave=0;
                    G_ave=0;
                    B_ave=0;
                    p_cnt=0;
                    LED2<=0;
                end
            else if (!LED1)
                begin
                    color_num<=0;
                    R_ave=0;
                    G_ave=0;
                    B_ave=0;
                    p_cnt=0;
                    LED2<=0;
                end
            //ROI starts
            else if (set_x==x_min && set_y==y_min)
                begin
                    LED2<=0;
                    R_ave=R;
                    G_ave=G;
                    B_ave=B;
                    p_cnt=1;
                end
            //in ROI
            else if (set_x>x_min && set_x<x_max && set_y>y_min && set_y<y_max)                
                begin
                    R_ave=R_ave+R;
                    G_ave=G_ave+G;
                    B_ave=B_ave+B;
                    p_cnt=p_cnt+1;
                end
            //ROI ends
            else if (set_x==x_max && set_y==y_max)
                begin
                    
//                    if (R_ave==0 && G_ave==0 && B_ave==0)
//                        color_num<=red;
//                    else
//                        color_num<=black;
                   //judge
                    if (R_ave>(150*p_cnt))
                        begin
                            if (G_ave>(150*p_cnt))
                                begin
                                    if (B_ave>(150*p_cnt))
                                        color_num<=white;
                                    else
                                        color_num<=yellow;
                                end
                            else
                                begin
                                    if (B_ave>(150*p_cnt))
                                        color_num<=black;
                                    else
                                        color_num<=red;
                                end
                        end
                    else
                        begin
                            if (G_ave>(150*p_cnt))
                                begin
                                    if (B_ave>(150*p_cnt))
                                        color_num<=black;
                                    else
                                        color_num<=green;
                                end
                            else
                                begin
                                    if (B_ave>(150*p_cnt))
                                        color_num<=blue;
                                    else
                                        color_num<=black;
                                end
                        end
                    LED2<=1;
                end    
            
            //other area+default
            else
                begin
                    color_num<=color_num;
                    LED2<=LED2;
                end
        end
    
endmodule
