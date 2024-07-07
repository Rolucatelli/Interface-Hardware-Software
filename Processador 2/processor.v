


module processor (clock, bus, exit);
	input clock;
	output reg [15:0] bus;
	output reg exit;

	parameter ADD = 3'b000; // Instrução de soma
	parameter SUB = 3'b001; // Instrução de subtração
	parameter NAN = 3'b010; // Instrução de NAND
	parameter HLT = 3'b011; // Instrução de halt
	parameter OUT = 3'b100; // Instrução de output
	parameter LDI = 3'b101; // Instrução de load imediato
	parameter BNE = 3'b110; // Instrução de jump
	parameter REP = 3'b111; // Instrução de substituição

	wire [15:0] outMulti, outBReg, outRR, outRA, outUla, outEx, outMem;
	wire [5:0] progCounter;
	wire [1:0] outCont;


	reg [5:0] jmp;
	reg [2:0] regSelect;
	reg [1:0] muxSelect; // 00 = BReg, 01 = Reg R, 10 = imediato
	reg w, rRe, rAe, clearCont;



	bancoReg b1 (.in(outMulti), .out(outBReg), .key(regSelect), .w(w), .clock(clock));

	extensor ex(.in(outMem), .out(outEx));

	mux4x2 m1 (.i0(outBReg), .i1(outRR), .i2(outEx), .i3(16'b0000000000000000), .key(muxSelect), .out(outMulti));

	registrador rR(.in(outUla), .enable(rRe), .out(outRR), .clock(clock));
	registrador rA(.in(outMulti), .enable(rAe), .out(outRA), .clock(clock));

	ula u1 (.rA(outRA), .b(outMulti), .opSelect(outMem[15:13]), .rG(outUla));

	counter c1 (.clock(clock), .clear(clearCont), .out(outCont));

	pc p1 (.cont(outCont), .jmp(jmp), .pc(progCounter));

	memoria mem1 (.pc(progCounter), .out(outMem));

	initial begin
		exit = 0;
		clearCont = 1;
		jmp = 0;
	end

	always @(clock) begin
		case (outCont)
			2'b00: begin
				// Desabilita a escrita nos registradores e reseta o multiplexador
				jmp = 0;
				w = 0;
				rAe = 0;
				rRe = 0;
				muxSelect = 0;
				clearCont = 0;
				// Descobre o primeiro operando
				regSelect = outMem[12:10]; // O banco de registradores seleciona o registrador que será lido
			end
			2'b01: begin
				// Ativa o registrador A para receber o primeiro operando
				rAe = 1;
				if (outMem[15:13] == REP) regSelect = outMem[9:7]; // Se a instrução for repetição, o primeiro operando é o registrador selecionado
				else if (outMem[15:13] == LDI) muxSelect = 2'b10; // Se a instrução for load imediato, o segundo operando é o imediato
			end
			2'b10: begin
				// Desativa o registrador A e ativa o registrador R para receber o resultado da ULA
				rAe = 0;
				rRe = 1;
				// Se a instrução for ADD, SUB ou NAN, o segundo operando é o registrador selecionado
				if (outMem[15:13] == ADD || outMem[15:13] == SUB || outMem[15:13] == NAN) begin
					regSelect = outMem[9:7];
					muxSelect = 0;
				end
			end
			2'b11: begin
				// Desativa o registrador R e seleciona ele como saída do multiplexador
				rRe = 0;
				muxSelect = 2'b01;
				// Se a instrução for BNE e o resultado da ULA for 0, o jump é ativado
				if (outMem[15:13] == BNE && outRR == 0) begin
					muxSelect = 2'b10;
					jmp = outMulti[5:0];
				end
				// Se a instrução for OUT, o barramento é atualizado
				else if (outMem[15:13] == OUT) bus = outMulti;
				else if (outMem[15:13] == HLT) exit = 1;
				// Caso contrário, escrevemos no registrador selecionado
				else begin
					regSelect = outMem[12:10];
					w = 1;
				end
				// Reseta o contador
				clearCont = 1;
			end
		endcase
	end
endmodule