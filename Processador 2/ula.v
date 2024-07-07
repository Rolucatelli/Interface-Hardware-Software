


module ula (rA, b, opSelect, rG);

	input [15:0] rA, b;
	input [2:0] opSelect;
	output reg [15:0] rG;
	
	parameter REP = 3'b111;
	parameter LDI = 3'b101;
	parameter ADD = 3'b000;
	parameter SUB = 3'b001;
	parameter NAN = 3'b010;
	parameter OUT = 3'b100;
	
	always @* begin
	
		case (opSelect)
			ADD: rG = rA + b;
			SUB: rG = rA - b;
			NAN: rG = ~(rA & b);
			default: rG = rA;
		endcase
	
	end

endmodule