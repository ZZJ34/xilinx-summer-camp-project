`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 14:02:51
// Design Name: 
// Module Name: SystemTop
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


module SystemTop(
    input i_clk,
    input i_rst,
    input i_clk_rx_data_n,
    input i_clk_rx_data_p,
    input [1:0]i_rx_data_n,
    input [1:0]i_rx_data_p,
    input i_data_n,
    input i_data_p,
    input key,      // key for control     
    inout i_camera_iic_sda,
    output o_camera_iic_scl,
    output o_camera_gpio,
    output TMDS_Tx_Clk_N,
    output TMDS_Tx_Clk_P,
    output [2:0]TMDS_Tx_Data_N,
    output [2:0]TMDS_Tx_Data_P,
    output LED1,
    output LED2,
    output RGB_LED_IO
    );
    //时钟信号
    wire clk_100MHz_system;
    wire clk_200MHz;
    wire clk_10MHz;
    //HDMI信号
    wire [23:0]rgb_data_src;
    wire rgb_hsync_src;
    wire rgb_vsync_src;
    wire rgb_vde_src;
    wire clk_pixel;
    wire clk_serial;
    
    //系统时钟
    clk_wiz_0 clk_out_100_200(.clk_out1(clk_100MHz_system),.clk_out2(clk_200MHz),.clk_out3(clk_10MHz),.clk_in1(i_clk));
    
    //HDMI驱动
    rgb2dvi_0 Mini_HDMI_Driver(
      .TMDS_Clk_p(TMDS_Tx_Clk_P),     // output wire TMDS_Clk_p
      .TMDS_Clk_n(TMDS_Tx_Clk_N),     // output wire TMDS_Clk_n
      .TMDS_Data_p(TMDS_Tx_Data_P),      // output wire [2 : 0] TMDS_Data_p
      .TMDS_Data_n(TMDS_Tx_Data_N),      // output wire [2 : 0] TMDS_Data_n
      .aRst_n(i_rst),                   // input wire aRst_n
      .vid_pData(rgb_data_src),         // input wire [23 : 0] vid_pData
      .vid_pVDE(rgb_vde_src),           // input wire vid_pVDE
      .vid_pHSync(rgb_hsync_src),       // input wire vid_pHSync
      .vid_pVSync(rgb_vsync_src),       // input wire vid_pVSync
      .PixelClk(clk_pixel)
    );
    
    //图像MIPI信号转RGB
    wire [10:0]set_x;
    wire [9:0]set_y;
    Driver_MIPI MIPI_Trans_Driver(
        .i_clk_200MHz(clk_200MHz),
        .i_clk_rx_data_n(i_clk_rx_data_n),
        .i_clk_rx_data_p(i_clk_rx_data_p),
        .i_rx_data_n(i_rx_data_n),
        .i_rx_data_p(i_rx_data_p),
        .i_data_n(i_data_n),
        .i_data_p(i_data_p),
        .o_camera_gpio(o_camera_gpio),
        .o_rgb_data(rgb_data_src),
        .o_rgb_hsync(rgb_hsync_src),
        .o_rgb_vsync(rgb_vsync_src),
        .o_rgb_vde(rgb_vde_src),
        .o_set_x(set_x),
        .o_set_y(set_y),
        .o_clk_pixel(clk_pixel)
    );
    
    //RGB convert to HSV
    wire Data_R=rgb_data_src[23:16];
    wire Data_B=rgb_data_src[15:8];
    wire Data_G=rgb_data_src[7:0];
//    wire [10:0]o_x;
//    wire [9:0]o_y;
//    wire [8:0]HSV_H;
//    wire [7:0]HSV_S;
//    wire [7:0]HSV_V;
//    RGB2HSV RGB2HSV_0(
//        .clk_Image_Process(clk_100MHz_system),
//        .Rst(i_rst),
//        .RGB_Data_R(Data_R), 
//        .RGB_Data_G(Data_G), 
//        .RGB_Data_B(Data_B), 
//        .i_set_x(set_x),
//        .i_set_y(set_y),
//        .HSV_H(HSV_H),                   //0-360
//        .HSV_S(HSV_S), 
//        .HSV_V(HSV_V), 
//        .o_set_x(o_x),
//        .o_set_y(o_y),
//        .Delay_Num() 
//    );
    
    //recognition
    wire [2:0]color_num;
    Color_Rec_RGB color_judge_HSV(
        .clk_100MHz(clk_100MHz_system),
        .R(Data_R),
        .G(Data_G),
        .B(Data_B),
        .key_in(key),
        .rst(i_rst),
        .set_x(set_x),
        .set_y(set_y),
        .color_num(color_num),
        .LED1(LED1),        //start rec
        .LED2(LED2)         
    );
    
    //RGB_Light
    RGB_Light RGB_Light0(
        .color_num(color_num),
        .LED1(LED1),
        .clk(clk_100MHz_system),
        .clk_10MHz(clk_10MHz),
        .rst(i_rst),
        .RGB_LED_IO(RGB_LED_IO),
        .Light_Ok()
    );
    
    //摄像头IIC的SDA线的三态节点
    wire camera_iic_sda_i;
    wire camera_iic_sda_o;
    wire camera_iic_sda_t;
    
    //Tri-state gate
    IOBUF Camera_IIC_SDA_IOBUF
       (.I(camera_iic_sda_o),
        .IO(i_camera_iic_sda),
        .O(camera_iic_sda_i),
        .T(~camera_iic_sda_t));
    
    //摄像头IIC驱动信号
    wire iic_busy;
    wire iic_mode;
    wire [7:0]slave_addr;
    wire [7:0]reg_addr_h;
    wire [7:0]reg_addr_l;
    wire [7:0]data_w;
    wire [7:0]data_r;
    wire iic_write;
    wire iic_read;
    wire ov5647_ack;
    
    //摄像头驱动
    OV5647_Init MIPI_Camera_Driver(
        .i_clk(clk_100MHz_system),
        .i_rst(i_rst),
        .i_iic_busy(iic_busy),
        .o_iic_mode(iic_mode),          
        .o_slave_addr(slave_addr),    
        .o_reg_addr_h(reg_addr_h),   
        .o_reg_addr_l(reg_addr_l),   
        .o_data_w(data_w),      
        .o_iic_write(iic_write),
        .o_ack(ov5647_ack)                 
    );
    
    //摄像头IIC驱动
    Driver_IIC MIPI_Camera_IIC(
        .i_clk(clk_100MHz_system),
        .i_rst(i_rst),
        .i_iic_sda(camera_iic_sda_i),
        .i_iic_write(iic_write),                //IIC写信号,上升沿有效
        .i_iic_read(iic_read),                  //IIC读信号,上升沿有效
        .i_iic_mode(iic_mode),                  //IIC模式,1代表双地址位,0代表单地址位,低位地址有效
        .i_slave_addr(slave_addr),              //IIC从机地址
        .i_reg_addr_h(reg_addr_h),              //寄存器地址,高8位
        .i_reg_addr_l(reg_addr_l),              //寄存器地址,低8位
        .i_data_w(data_w),                      //需要传输的数据
        .o_data_r(data_r),                      //IIC读到的数据
        .o_iic_busy(iic_busy),                  //IIC忙信号,在工作时忙,低电平忙
        .o_iic_scl(o_camera_iic_scl),           //IIC时钟线
        .o_sda_dir(camera_iic_sda_t),           //IIC数据线方向,1代表输出
        .o_iic_sda(camera_iic_sda_o)            //IIC数据线
    );
    
endmodule

