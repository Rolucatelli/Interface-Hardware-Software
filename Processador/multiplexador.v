

module multiplexador (i0, i1, i2, i3, i4, i5, i6, i7, iR, imediato, rSelect, immeSelect, select, out);
	
	input [15:0] i0, i1, i2, i3, i4, i5, i6, i7, iR;
	input [9:0] imediato;
	input [2:0]select;
	input rSelect, immeSelect;
	output reg [15:0] out;
	
	always @* begin
		if (immeSelect == 1) out = imediato;
		else if (rSelect == 1) out = iR;
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