

module registrador(in, enable, clock, out);

	input [15:0] in;
	input enable, clock;
	output reg [15:0] out;
	
	initial out = 16'b0000000000000000;
	
	always @(negedge clock) begin
		if (enable == 1) out = in;
	end

endmodule