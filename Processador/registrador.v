

module registrador(in, enable, clock, out);

	input [15:0] in;
	input enable, clock;
	output reg [15:0] out;
	
	// Inicializa o registrador com 0
	initial out = 16'b0000000000000000;
	
	// Sempre que o clock cair e o registrador estiver disposto a escrita, o registrador recebe o valor de in
	always @(negedge clock) begin
		if (enable == 1) out = in;
	end
endmodule