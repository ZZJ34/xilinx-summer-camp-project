# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "TIME_20MS" -parent ${Page_0}


}

proc update_PARAM_VALUE.TIME_20MS { PARAM_VALUE.TIME_20MS } {
	# Procedure called to update TIME_20MS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TIME_20MS { PARAM_VALUE.TIME_20MS } {
	# Procedure called to validate TIME_20MS
	return true
}


proc update_MODELPARAM_VALUE.TIME_20MS { MODELPARAM_VALUE.TIME_20MS PARAM_VALUE.TIME_20MS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TIME_20MS}] ${MODELPARAM_VALUE.TIME_20MS}
}

