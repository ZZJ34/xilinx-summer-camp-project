// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "Clk_Division,Vivado 2018.3" *)
module Clk_Division_0(clk_100MHz, clk_mode, clk_out);
  input clk_100MHz;
  input [30:0]clk_mode;
  output clk_out;
endmodule
