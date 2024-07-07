

module multiplexador (i0, i1, i2, i3, i4, i5, i6, i7, iR, imediato, rSelect, immeSelect, select, out);
	
	// Variáveis que representam os registradores
	input [15:0] i0, i1, i2, i3, i4, i5, i6, i7, iR;
	// Variável que representa o imediato
	input [9:0] imediato;
	// Variável que representa o registrador selecionado
	input [2:0] select;
	// Variáveis que representam a seleção do Registrador R e do imediato
	input rSelect, immeSelect;
	// Variável que representa a saída do multiplexador
	output reg [15:0] out;
	
	always @* begin
		// Se immeselect for 1, a saída do multiplexador é o imediato
		if (immeSelect == 1) out = imediato;
		// Se rSelect for 1, a saída do multiplexador é o registrador R
		else if (rSelect == 1) out = iR;
		// Senão, a saída do multiplexador é um dos registradores de acordo com a seleçãow
		else case (select)
			3'b000: out = i0;
			3'b001: out = i1;
			3'b010: out = i2;
			3'b011: out = i3;
			3'b100: out = i4;
			3'b101: out = i5;
			3'b110: out = i6;
			3'b111: out = i7;
		endcase
	end
endmodule