-makelib xcelium_lib/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../ipstatic/hdl/phy_clock_system.vhd" \
  "../../../ipstatic/hdl/line_if.vhd" \
  "../../../ipstatic/hdl/csi2_d_phy_rx.vhd" \
  "../../../../RGB_LED_v1.srcs/sources_1/ip/csi2_d_phy_rx_0/sim/csi2_d_phy_rx_0.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

