*---------------------------------------
*-- Generated by SIMECT
*-- Generated on: 06-May-2011 13:32:13
*---------------------------------------

*Set language kind to VHDL'AMS
.VHDL SET KIND=AMS

* Compile the VHDL source into the work library
.VHDL COMPILE LIBRARY=WORK SOURCE=test_i_diff_i_diff.vhd

* Elaborate the VHDL top-level
.VHDL elaborate entity=Top_circuit unit=test 

* Perform generic TRAN analysis
.TRAN 1ns 20us 0s

* Settings
.H 1.000E-030s 1.000E-030s 10ns 250m 2
.TOLERANCE DEFAULT_TOLERANCE 1u
.TOLERANCE DEFAULT_CURRENT 2e-07
.TOLERANCE DEFAULT_VOLTAGE 1m
.METHOD TRAP