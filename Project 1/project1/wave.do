onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /prj_01_tb/total_test
add wave -noupdate -radix unsigned /prj_01_tb/pass_test
add wave -noupdate -radix unsigned /prj_01_tb/oprn_reg
add wave -noupdate -radix unsigned /prj_01_tb/op1_reg
add wave -noupdate -radix unsigned /prj_01_tb/op2_reg
add wave -noupdate -radix unsigned /prj_01_tb/r_net
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {900 ps}
