


module processor (clock, iin, resetn, bus);

	// Instrução
	input [15:0] iin;
	// Clock e reset
	input resetn, clock;
	// Barramento de saída
	output reg [15:0] bus;

	// Algumas instruções que serão utilizadas
	parameter LDI = 3'b101;
	parameter OUT = 3'b100;
	parameter REP = 3'b111;
	
	// Fios que representam as saídas dos registradores, Multiplexador e ULA
	wire [15:0] outMulti, outR0, outR1, outR2, outR3, outR4, outR5, outR6, outR7, outRA, outRR, outULA;
	// Registradores que controlão a escrita nos registradores, o multiplexador e o contador
	reg r0e, r1e, r2e, r3e, r4e, r5e, r6e, r7e, rAe, rRe, immeSelect, rSelect, clearCont;
	// Fio que representa o contador
	wire [1:0] cont;
	// Registradores que representam o opcode e o operando
	reg [2:0] opcode, op;
	
	// Instanciação dos Registradores do Banco de Registradores
	registrador re0 (.in(outMulti), .enable(r0e), .clock(clock), .out(outR0));
	registrador re1 (.in(outMulti), .enable(r1e), .clock(clock), .out(outR1));
	registrador re2 (.in(outMulti), .enable(r2e), .clock(clock), .out(outR2));
	registrador re3 (.in(outMulti), .enable(r3e), .clock(clock), .out(outR3));
	registrador re4 (.in(outMulti), .enable(r4e), .clock(clock), .out(outR4));
	registrador re5 (.in(outMulti), .enable(r5e), .clock(clock), .out(outR5));
	registrador re6 (.in(outMulti), .enable(r6e), .clock(clock), .out(outR6));
	registrador re7 (.in(outMulti), .enable(r7e), .clock(clock), .out(outR7));
	
	// Instanciação dos Registradores A e R da ULA
	registrador reA (.in(outMulti), .enable(rAe), .clock(clock), .out(outRA));
	registrador reR (.in(outULA), .enable(rRe), .clock(clock), .out(outRR));
	
	// Instanciação da ULA
	ula u1 (.rA(outRA), .b(outMulti), .opSelect(opcode), .rG(outULA));
	
	// Instanciação do Contador
	counter c1 (.clock(clock), .clear(clearCont), .out(cont));
	
	// Instanciação do Multiplexador
	multiplexador m1 (.i0(outR0), .i1(outR1), .i2(outR2), .i3(outR3), .i4(outR4), .i5(outR5), .i6(outR6), .i7(outR7), .iR(outRR), 
						.imediato(iin[9:0]), .rSelect(rSelect), .immeSelect(immeSelect), .select(op), .out(outMulti));
						
	// Inicialização do Contador
	initial begin
		# 0 clearCont = 1;
	end

	
	always @(cont, resetn) begin
		case (cont)
			// Quando o contador for 00
			2'b00: begin
				// Reseta o clearCont
				clearCont = resetn;
				// Desativa a escrita nos registradores
				r0e = 0;
				r1e = 0;
				r2e = 0;
				r3e = 0;
				r4e = 0;
				r5e = 0;
				r6e = 0;
				r7e = 0;
				// Desativa as chaves do Multiplexador
				rSelect = 0;
				immeSelect = 0;
				// Define o opcode e o operador
				opcode = iin[15:13];
				op = iin[12:10];
			end
			// Quando o contador for 01
			2'b01: begin
				// Ativa a escrita no registrador A
				rAe = 1;
			end
			// Quando o contador for 10
			2'b10: begin
				// Desativa a escrita no registrador A
				rAe = 0;
				// Se a intrução for LDI, ativa a seleção do imediato e a escrita no registrador R
				if (opcode == LDI) begin 
					immeSelect = 1;
					rRe = 1;
				end
				// Se a instrução for ADD, SUB ou NAN, define o segundo operador e ativa a escrita no registrador R
				else if (opcode[2] == 0) 
					begin 
						op = iin[09:07]; 
						rRe = 1; 
					end
				// Se a instrução for REP, define o segundo operador
				else if (opcode == REP) op = iin[09:07];
			end
			// Quando o contador for 11
			2'b11: begin
				// Desativa a escrita no registrador R
				rRe = 0;
				// Configura o Multiplexador para passar o Registrador R para o barramento
				rSelect = 1;
				// Ativa a escrita no registrador de acordo com o operador
				case (iin[12:10])
					3'b000: r0e = 1;
					3'b001: r1e = 1;
					3'b010: r2e = 1;
					3'b011: r3e = 1;
					3'b100: r4e = 1;
					3'b101: r5e = 1;
					3'b110: r6e = 1;
					3'b111: r7e = 1;
				endcase
				// Se a instrução for OUT, configura o barramento para passar a saída da ULA
				if (opcode == OUT) bus = outMulti;
				// Reseta o contador
				clearCont = 1;
			end
		endcase
	end
endmodule