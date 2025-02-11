// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Fri Jul 31 22:26:06 2020
// Host        : DESKTOP-628HQFE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/16331/Documents/GitHub_Projects/xilinx-summer-camp-project/project2/project_v2_RGB2HSV/RGB_LED_v1.srcs/sources_1/ip/RAM_Line/RAM_Line_stub.v
// Design      : RAM_Line
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7s15ftgb196-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *)
module RAM_Line(clka, wea, addra, dina, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[10:0],dina[7:0],clkb,addrb[10:0],doutb[7:0]" */;
  input clka;
  input [0:0]wea;
  input [10:0]addra;
  input [7:0]dina;
  input clkb;
  input [10:0]addrb;
  output [7:0]doutb;
endmodule
