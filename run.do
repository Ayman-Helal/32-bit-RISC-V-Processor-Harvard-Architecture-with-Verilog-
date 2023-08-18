vlog *.v
vsim RISC

add wave -position insertpoint sim:/RISC/*
force -freeze sim:/RISC/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/RISC/rst 0 0
run
force -freeze sim:/RISC/rst St1 0
run
run
run
run
run
run
run
add wave -position insertpoint sim:/RISC/DPUR/romD/*