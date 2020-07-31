`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/25 09:56:56
// Design Name: 
// Module Name: Camera_Demo
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


module Camera_Demo(
    // ��������
    input i_key,
    // ȫ��ʱ���ź� 100Mhz
    input i_clk,
    // FPGA��λ�ź�
    input i_rst,
    // MIPI����ͷ
    input i_clk_rx_data_n,
    input i_clk_rx_data_p,
    input [1:0]i_rx_data_n,
    input [1:0]i_rx_data_p,
    input i_data_n,
    input i_data_p,
    inout i_camera_iic_sda,
    output o_camera_iic_scl,
    output o_camera_gpio,
    // HDMI
    output TMDS_Tx_Clk_N,
    output TMDS_Tx_Clk_P,
    output [2:0]TMDS_Tx_Data_N,
    output [2:0]TMDS_Tx_Data_P,
    // green led
    output o_green_led,
    output o_RGB_LED
    );

    reg [5:0]Period_100mSecond=10; 
    reg [10:0]Light_Num=1000;
    reg [30:0]clk_mode=31'd100_000; 

    // ʱ���ź�
    wire clk_100MHz_system;
    wire clk_200MHz;
    wire clk_10Mhz;
    wire clk_1kHz;
    
    // HDMI�ź�
    wire [23:0]rgb_data_src;
    wire rgb_hsync_src;
    wire rgb_vsync_src;
    wire rgb_vde_src;
    wire clk_pixel;
    wire clk_serial;
    wire [10:0] set_x;
    wire [9:0] set_y;

    wire [23:0] o_rgb_data_src;
    wire o_rgb_hsync_src;
    wire o_rgb_vsync_src;
    wire o_rgb_vde_src;
    wire o_clk_pixel;
    
    wire [23:0] rgb_data;
    
    // ϵͳʱ�� 
    clk_wiz_0 clk_10(.clk_out1(clk_100MHz_system),.clk_out2(clk_200MHz),.clk_out3(clk_10MHz),.clk_in1(i_clk));
    Clk_Division_0 clk_11(.clk_100MHz(i_clk),.clk_mode(clk_mode),.clk_out(clk_1kHz));
    
    // HDMI����
    rgb2dvi_0 Mini_HDMI_Driver(
      .TMDS_Clk_p(TMDS_Tx_Clk_P),     // output wire TMDS_Clk_p
      .TMDS_Clk_n(TMDS_Tx_Clk_N),     // output wire TMDS_Clk_n
      .TMDS_Data_p(TMDS_Tx_Data_P),      // output wire [2 : 0] TMDS_Data_p
      .TMDS_Data_n(TMDS_Tx_Data_N),      // output wire [2 : 0] TMDS_Data_n
      .aRst_n(i_rst),                   // input wire aRst_n
      .vid_pData(o_rgb_data_src),         // input wire [23 : 0] vid_pData
      .vid_pVDE(o_rgb_vde_src),           // input wire vid_pVDE
      .vid_pHSync(o_rgb_hsync_src),       // input wire vid_pHSync
      .vid_pVSync(o_rgb_vsync_src),       // input wire vid_pVSync
      .PixelClk(o_clk_pixel)
    );
    
    //ͼ��MIPI�ź�תRGB
    Driver_MIPI MIPI_Trans_Driver(
        .i_clk_200MHz(clk_200MHz),
        // ����ͷ������
        .i_clk_rx_data_n(i_clk_rx_data_n),
        .i_clk_rx_data_p(i_clk_rx_data_p),
        .i_rx_data_n(i_rx_data_n),
        .i_rx_data_p(i_rx_data_p),
        .i_data_n(i_data_n),
        .i_data_p(i_data_p),
        // HDMI���
        .o_camera_gpio(o_camera_gpio),
        .o_rgb_data(rgb_data_src),
        .o_rgb_hsync(rgb_hsync_src),
        .o_rgb_vsync(rgb_vsync_src),
        .o_rgb_vde(rgb_vde_src),
        .o_set_x(set_x),
        .o_set_y(set_y),
        .o_clk_pixel(clk_pixel)
    );

    change change(
        .i_clk_100MHz(clk_100MHz_system),
        .i_clk_1kHz(clk_1kHz),
        .i_rgb_data(rgb_data_src),
        .i_rgb_hsync(rgb_hsync_src),
        .i_rgb_vsync(rgb_vsync_src),
        .i_rgb_vde(rgb_vde_src),
        .i_set_x(set_x),
        .i_set_y(set_y),
        .i_clk_pixel(clk_pixel),
        .i_key(i_key),
        .o_rgb_data(o_rgb_data_src),
        .o_rgb_hsync(o_rgb_hsync_src),
        .o_rgb_vsync(o_rgb_vsync_src),
        .o_rgb_vde(o_rgb_vde_src),
        .o_clk_pixel(o_clk_pixel),
        .o_green_led(o_green_led),
        .o_led_rgb_data(rgb_data)
    );


    RGB_LED_control RGB_LED_control_0( 
        .clk_100MHz(clk_100MHz_system), 
        .clk_10MHz(clk_10MHz), 
        .Period_100mSecond(Period_100mSecond), 
        .R_In(rgb_data[23:16]), 
        .G_In(rgb_data[15:8]), 
        .B_In(rgb_data[7:0]), 
        .Light_Num(Light_Num), 
        .Rst(i_rst), 
        .RGB_LED_IO(o_RGB_LED), 
        .Light_Ok() 
    );
    
    //����ͷIIC��SDA�ߵ���̬�ڵ�
    wire camera_iic_sda_i;
    wire camera_iic_sda_o;
    wire camera_iic_sda_t;
    
    //Tri-state gate
    IOBUF Camera_IIC_SDA_IOBUF
       (.I(camera_iic_sda_o),
        .IO(i_camera_iic_sda),
        .O(camera_iic_sda_i),
        .T(~camera_iic_sda_t));
    
    //����ͷIIC�����ź�
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
    
    //����ͷ����
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
    
    //����ͷIIC����
    Driver_IIC MIPI_Camera_IIC(
        .i_clk(clk_100MHz_system),
        .i_rst(i_rst),
        .i_iic_sda(camera_iic_sda_i),
        .i_iic_write(iic_write),                //IICд�ź�,��������Ч
        .i_iic_read(iic_read),                  //IIC���ź�,��������Ч
        .i_iic_mode(iic_mode),                  //IICģʽ,1����˫��ַλ,0��������ַλ,��λ��ַ��Ч
        .i_slave_addr(slave_addr),              //IIC�ӻ���ַ
        .i_reg_addr_h(reg_addr_h),              //�Ĵ�����ַ,��8λ
        .i_reg_addr_l(reg_addr_l),              //�Ĵ�����ַ,��8λ
        .i_data_w(data_w),                      //��Ҫ���������
        .o_data_r(data_r),                      //IIC����������
        .o_iic_busy(iic_busy),                  //IICæ�ź�,�ڹ���ʱæ,�͵�ƽæ
        .o_iic_scl(o_camera_iic_scl),           //IICʱ����
        .o_sda_dir(camera_iic_sda_t),           //IIC�����߷���,1�������
        .o_iic_sda(camera_iic_sda_o)            //IIC������
    );
    
endmodule
