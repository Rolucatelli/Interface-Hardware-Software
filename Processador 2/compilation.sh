
#!/bin/bash

echo "Compilando e executando o simulador do processador..."
echo ""
iverilog -o processor testbench.v -l processor.v counter.v mux4x2.v ula.v registrador.v pc.v memoria.v bancoReg.v mux8x3.v extensor.v
echo ""
echo "Compilação concluída!"
echo ""
vvp processor
echo ""
echo "Simulação concluída!"
echo "Executando GTKWave..."
gtkwave testbench.vcd