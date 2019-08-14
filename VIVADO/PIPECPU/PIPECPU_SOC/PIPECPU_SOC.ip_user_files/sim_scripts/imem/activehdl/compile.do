vlib work
vlib activehdl

vlib activehdl/dist_mem_gen_v8_0_11
vlib activehdl/xil_defaultlib

vmap dist_mem_gen_v8_0_11 activehdl/dist_mem_gen_v8_0_11
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work dist_mem_gen_v8_0_11  -v2k5 \
"../../../ipstatic/simulation/dist_mem_gen_v8_0.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../PIPECPU_SOC.srcs/sources_1/ip/imem/sim/imem.v" \


vlog -work xil_defaultlib \
"glbl.v"

