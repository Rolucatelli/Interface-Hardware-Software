transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Processador {C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Processador/processor.v}
vlog -vlog01compat -work work +incdir+C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Processador {C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Processador/multiplexador.v}
vlog -vlog01compat -work work +incdir+C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Processador {C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Processador/ula.v}
vlog -vlog01compat -work work +incdir+C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Processador {C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Processador/counter.v}
vlog -vlog01compat -work work +incdir+C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Processador {C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Processador/registrador.v}
vlog -vlog01compat -work work +incdir+C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Processador {C:/Users/Rodrigo/Documents/GitHub/Interface-Hardware-Software/Processador/testbench.v}

