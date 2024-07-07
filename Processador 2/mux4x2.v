

module mux4x2(i0, i1, i2, i3, key, out);

    input [15:0] i0, i1, i2, i3;
	input [1:0] key;
	output reg [15:0] out;

    always @* begin
        case (key)
            3'b00: out = i0;
            3'b01: out = i1;
            3'b10: out = i2;
            3'b11: out = i3;
        endcase
    end
endmodule