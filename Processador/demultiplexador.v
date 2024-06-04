

module demultiplexador (in, select, o0, o1, o2, o3, o4, o5, o6, o7);
	input in;
	input [2:0] select;
	output reg o0, o1, o2, o3, o4, o5, o6, o7;
	
	always @* begin
		case (select)
			3'b000: o0 = in;
			3'b001: o1 = in;
			3'b010: o2 = in;
			3'b011: o3 = in;
			3'b100: o4 = in;
			3'b101: o5 = in;
			3'b110: o6 = in;
			3'b111: o7 = in;
		endcase
	end

endmodule