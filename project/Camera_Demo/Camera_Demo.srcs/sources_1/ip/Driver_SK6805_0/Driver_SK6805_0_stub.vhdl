-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Mon Jul 27 18:26:11 2020
-- Host        : LAPTOP-CH7L8TQ9 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/xilinx/xilinx-summer-camp-project/project/Camera_Demo/Camera_Demo.srcs/sources_1/ip/Driver_SK6805_0/Driver_SK6805_0_stub.vhdl
-- Design      : Driver_SK6805_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7s15ftgb196-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Driver_SK6805_0 is
  Port ( 
    R_In1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    G_In1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    B_In1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    R_In2 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    G_In2 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    B_In2 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    clk_10MHz : in STD_LOGIC;
    Rst : in STD_LOGIC;
    LED_IO : out STD_LOGIC
  );

end Driver_SK6805_0;

architecture stub of Driver_SK6805_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "R_In1[7:0],G_In1[7:0],B_In1[7:0],R_In2[7:0],G_In2[7:0],B_In2[7:0],clk_10MHz,Rst,LED_IO";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "Driver_SK6805,Vivado 2018.2";
begin
end;
