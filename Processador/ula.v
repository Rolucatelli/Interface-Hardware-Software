


module ula (rA, b, opSelect, rG);

	// Váriáveis que representam as entradas da ULA
	input [15:0] rA, b;
	input [2:0] opSelect;
	// Váriável que representa o registrador de saída da ULA
	output reg [15:0] rG;
	
	parameter REP = 3'b111;
	parameter LDI = 3'b101;
	parameter ADD = 3'b000;
	parameter SUB = 3'b001;
	parameter NAN = 3'b010;
	parameter OUT = 3'b100;
	
	always @* begin
		// Caso o opcode seja ADD, SUB ou NAN, a ULA realiza a operação de acordo com o opcode
		case (opSelect)
			ADD: rG = rA + b;
			SUB: rG = rA - b;
			NAN: rG = ~(rA & b);
			// Caso o opcode seja REP, LDI ou OUT, a ULA passa o valor de rA para rG
			default: rG = rA;
		endcase
	
	end

endmodule