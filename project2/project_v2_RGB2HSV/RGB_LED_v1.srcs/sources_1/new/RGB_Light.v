`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 14:02:01
// Design Name: 
// Module Name: RGB_Light
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


module RGB_Light(
    input wire [2:0]color_num,
    input wire LED1,
    input clk,
    input clk_10MHz,
    input rst,
    output RGB_LED_IO,
    output reg Light_Ok
    );
    
    reg [7:0]R_In1;
    reg [7:0]G_In1;
    reg [7:0]B_In1;
    reg [7:0]R_In2;
    reg [7:0]G_In2;
    reg [7:0]B_In2;
    wire Light;
    reg [5:0]Period_100mSecond=10; 
    reg [10:0]Light_Num=1000; 
    
    initial
    begin
        R_In1=0;
        G_In1=0;
        B_In1=0;
        R_In2=0;
        G_In2=0;
        B_In2=0;
    end
    
    always @(posedge clk or negedge rst)
            begin
                if (!rst)
                    begin
                        R_In1<=0;
                        G_In1<=0;
                        B_In1<=0;
                        R_In2<=0;
                        G_In2<=0;
                        B_In2<=0;
                    end
                else if(!LED1)
                    begin
                        R_In1<=0;
                        G_In1<=0;
                        B_In1<=0;
                        R_In2<=0;
                        G_In2<=0;
                        B_In2<=0;
                    end
                else
                    case (color_num)
                        //white
                        3'd1:
                            begin
                                R_In1<=255;
                                G_In1<=255;
                                B_In1<=255;
                                R_In2<=255;
                                G_In2<=255;
                                B_In2<=255;
                            end
                        //red
                        3'd2:
                            begin
                                R_In1<=255;
                                G_In1<=0;
                                B_In1<=0;
                                R_In2<=255;
                                G_In2<=0;
                                B_In2<=0;
                            end
                        //yellow
                        3'd3:
                            begin
                                R_In1<=255;
                                G_In1<=255;
                                B_In1<=0;
                                R_In2<=255;
                                G_In2<=255;
                                B_In2<=0;
                            end
                        //green
                        3'd4:
                            begin
                                R_In1<=0;
                                G_In1<=255;
                                B_In1<=0;
                                R_In2<=0;
                                G_In2<=255;
                                B_In2<=0;
                            end
                        //blue
                        3'd5:
                            begin
                                R_In1<=0;
                                G_In1<=0;
                                B_In1<=255;
                                R_In2<=0;
                                G_In2<=0;
                                B_In2<=255;
                            end
                        //default
                        default:
                            begin
                                R_In1<=0;
                                G_In1<=0;
                                B_In1<=0;
                                R_In2<=0;
                                G_In2<=0;
                                B_In2<=0;
                            end
                    endcase
            end
        
    //RGB_LED instance
    RGB_LED_control RGB_LED_Task0(
           .clk_100MHz(clk),
           .clk_10MHz(clk_10MHz),
           .Period_100mSecond(Period_100mSecond),
           .R_In(R_In1),
           .G_In(G_In1),
           .B_In(B_In1),
           .Light_Num(Light_Num),
           .Rst(rst),
           .RGB_LED_IO(RGB_LED_IO),
           .Light_Ok(Light)
           );
        
endmodule
