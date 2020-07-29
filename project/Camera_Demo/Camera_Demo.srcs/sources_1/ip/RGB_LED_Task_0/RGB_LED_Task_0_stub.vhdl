-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Mon Jul 27 18:39:04 2020
-- Host        : LAPTOP-CH7L8TQ9 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/xilinx/xilinx-summer-camp-project/project/Camera_Demo/Camera_Demo.srcs/sources_1/ip/RGB_LED_Task_0/RGB_LED_Task_0_stub.vhdl
-- Design      : RGB_LED_Task_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7s15ftgb196-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RGB_LED_Task_0 is
  Port ( 
    clk_100MHz : in STD_LOGIC;
    clk_10MHz : in STD_LOGIC;
    Period_100mSecond : in STD_LOGIC_VECTOR ( 5 downto 0 );
    R_In : in STD_LOGIC_VECTOR ( 7 downto 0 );
    G_In : in STD_LOGIC_VECTOR ( 7 downto 0 );
    B_In : in STD_LOGIC_VECTOR ( 7 downto 0 );
    Light_Num : in STD_LOGIC_VECTOR ( 10 downto 0 );
    Rst : in STD_LOGIC;
    RGB_LED_IO : out STD_LOGIC;
    Light_Ok : out STD_LOGIC
  );

end RGB_LED_Task_0;

architecture stub of RGB_LED_Task_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_100MHz,clk_10MHz,Period_100mSecond[5:0],R_In[7:0],G_In[7:0],B_In[7:0],Light_Num[10:0],Rst,RGB_LED_IO,Light_Ok";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "RGB_LED_Task,Vivado 2018.2";
begin
end;
