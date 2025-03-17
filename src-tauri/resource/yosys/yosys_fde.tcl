yosys -import

set lut 4
set infiles ""
set arg_state flag
foreach arg $argv {
	switch $arg_state {
		flag {
			switch -- $arg {
				-l	{ set arg_state lib }
				-m	{ set arg_state map }
				-c	{ set arg_state cell }
				-o	{ set arg_state out }
				-i	{ set arg_state in  }
				-k	{ set arg_state lut }
				-v	{ set arg_state sim }
			}
		}
		lib {
			set lib $arg
			set arg_state flag
		}
		map {
			set maplib $arg
			set arg_state flag
		}
		cell {
			set cellmap $arg
			set arg_state flag
		}
		out {
			set outfile $arg
			set arg_state flag
		}
		in {
			lappend infiles $arg
			set arg_state flag
		}
		lut {
			set lut $arg
			set arg_state flag
		}
		sim {
			set sim $arg
			set arg_state flag
		}
	}
}

read_verilog -lib $lib
foreach infile $infiles {
	read_verilog $infile
}

hierarchy -auto-top
procs; flatten
synth -run coarse
opt -fast; opt -full
techmap -map $maplib; opt
wreduce
dffsr2dff; dff2dffe
techmap -D NO_LUT -map $cellmap; opt
techmap -map $maplib; opt
dffinit -ff DFFNHQ Q INIT -ff DFFHQ Q INIT -ff EDFFHQ Q INIT -ff DFFRHQ Q INIT -ff DFFSHQ Q INIT -ff DFFNRHQ Q INIT -ff DFFNSHQ Q INIT
wreduce; clean
check

if {[info exists sim]} {
	write_verilog -noattr $sim
}

abc -lut $lut; opt
wreduce; clean
stat
techmap -map $cellmap; opt
wreduce; clean
stat
write_edif $outfile
check