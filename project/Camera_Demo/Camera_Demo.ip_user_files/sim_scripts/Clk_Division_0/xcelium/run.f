-makelib xcelium_lib/xil_defaultlib -sv \
  "F:/xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "F:/xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "F:/xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../Camera_Demo.srcs/sources_1/ip/Clk_Division_0/sim/Clk_Division.v" \
  "../../../../Camera_Demo.srcs/sources_1/ip/Clk_Division_0/sim/Clk_Division_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

