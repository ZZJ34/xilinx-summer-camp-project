-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Wed Jul 29 09:50:10 2020
-- Host        : LAPTOP-CH7L8TQ9 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/xilinx/xilinx-summer-camp-project/project/Camera_Demo/Camera_Demo.srcs/sources_1/ip/Key_0/Key_0_stub.vhdl
-- Design      : Key_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7s15ftgb196-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Key_0 is
  Port ( 
    clk_1kHz : in STD_LOGIC;
    rst : in STD_LOGIC;
    key_in : in STD_LOGIC;
    key_out : out STD_LOGIC
  );

end Key_0;

architecture stub of Key_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_1kHz,rst,key_in,key_out";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "Key,Vivado 2018.2";
begin
end;
