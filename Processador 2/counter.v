


module counter (clock, clear, out);

	input clock, clear;
	output reg [1:0] out;

	initial #2 out = 2'b00;
	
	always @(posedge clock) begin
	
		if(clear == 1)
			out <= 2'b00;
		else
			out <= out + 1'b1;
	end

endmodule