

module multiplexador (i0, i1, i2, i3, i4, i5, i6, i7, iR, imediato, rSelect, immeSelect, select, out);
	
	input [15:0] i0, i1, i2, i3, i4, i5, i6, i7, iR, imediato;
	input [2:0]select;
	input rSelect, immeSelect;
	output reg [15:0] out;
	
	always @* begin
		casex ({immeSelect, rSelect, select})
			5'b1xxxx: out = imediato;
			5'b01xxx: out = iR;
			5'b00000: out = i0;
			5'b00001: out = i1;
			5'b00010: out = i2;
			5'b00011: out = i3;
			5'b00100: out = i4;
			5'b00101: out = i5;
			5'b00110: out = i6;
			5'b00111: out = i7;
		endcase
	end
endmodule