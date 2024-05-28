transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Tarefa2 {C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Tarefa2/somadorUnico.v}
vlog -vlog01compat -work work +incdir+C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Tarefa2 {C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Tarefa2/somador8bits.v}

