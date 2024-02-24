##======================================================================
## Project   : Design Compiler script for FPGA Software Group
## File Name : Run_dc.tcl
## Author    : Chen Zhihui
## Email     : 082052009@fudan.edu.cn
## Function  : DC scripts 
## Modify    :
##======================================================================

set SRC_HOME      "~/src"
set LIB_HOME      "Your_Lib_Path"
set LIBRARY_NAME  "fde_dc"
#set WIRELOAD_NAME "ForQA"

#=======================================================================
# Library Define
#=======================================================================

set search_path " . \
				  $LIB_HOME \
          $SRC_HOME"
                  
set target_library " $LIB_HOME/$LIBRARY_NAME.db"

set link_library " * $LIB_HOME/$LIBRARY_NAME.db" 

##======================================================================
## Source file definition
##======================================================================

set DesignName YourDesignName

##======================================================================
## Read source file
##======================================================================

read_file -format verilog ./src/$DesignName.v

current_design $DesignName
link

#=======================================================================
# Set Compile Option
#=======================================================================

uniquify
link

ungroup -flatten -all
compile -map_effort medium -ungroup_all
ungroup -flatten -all

#=======================================================================
# Compile
#=======================================================================

compile_ultra -inc

#=======================================================================
# Save Database
#=======================================================================

write -f verilog -hier -output ./netlist/${DesignName}_gate.v

#=======================================================================
# Generate Reports
#========================================================================

#report_qor > ./report/$DesignName.qor
#report_constraints > ./report/$DesignName.con
#report_timing -trans -in -attr -nets > ./report/$DesignName.timing
#report_power > ./report/$DesignName.power
