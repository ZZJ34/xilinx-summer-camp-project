`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 12:30:32
// Design Name: 
// Module Name: RGB_LED_control
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


module RGB_LED_control(
   input clk_100MHz,
   input clk_10MHz,
   input [5:0]Period_100mSecond,
   input [7:0]R_In,
   input [7:0]G_In,
   input [7:0]B_In,
   input [10:0]Light_Num,
   input Rst,
   output RGB_LED_IO,
   output reg Light_Ok
   );
   
   //Output
   reg [7:0]R_Out=0;
   reg [7:0]G_Out=0;
   reg [7:0]B_Out=0;

   
   //ʵ����SK6805����
   Driver_SK6805 Driver_SK6805_0(.R_In1(R_Out),.G_In1(G_Out),.B_In1(B_Out),.R_In2(R_Out),.G_In2(G_Out),.B_In2(B_Out),.clk_10MHz(clk_10MHz),.Rst(Rst),.LED_IO(RGB_LED_IO));
   


    always@(posedge clk_100MHz or negedge Rst)
        begin
            if(!Rst)
                begin
                    R_Out<=0;
                    G_Out<=0;
                    B_Out<=0;
                end
            else
                begin
                    R_Out<=R_In;
                    G_Out<=G_In;
                    B_Out<=B_In;
                end    
        end
   
endmodule
