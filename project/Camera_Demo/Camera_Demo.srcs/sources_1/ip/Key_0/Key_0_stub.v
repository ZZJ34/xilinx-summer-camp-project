// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Wed Jul 29 09:50:10 2020
// Host        : LAPTOP-CH7L8TQ9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/xilinx/xilinx-summer-camp-project/project/Camera_Demo/Camera_Demo.srcs/sources_1/ip/Key_0/Key_0_stub.v
// Design      : Key_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7s15ftgb196-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "Key,Vivado 2018.2" *)
module Key_0(clk_1kHz, rst, key_in, key_out)
/* synthesis syn_black_box black_box_pad_pin="clk_1kHz,rst,key_in,key_out" */;
  input clk_1kHz;
  input rst;
  input key_in;
  output key_out;
endmodule
