

module testbench (cout);

	output reg [15:0] cout;
	reg clock = 0;
	reg [15:0] iin;
	reg resetn = 1;
	
	wire [15:0] bus;
	
	always #1 clock = !clock;
	
	initial $dumpfile("testbench.vcd");
	initial $dumpvars(0, testbench);

	processor p(clock, iin, resetn, bus);
	
	initial begin
		# 0 resetn = 1'b0;
//		# 8 iin = 16'b1010000000011100;
//		# 8 iin = 16'b1010010000001010;
//		# 8 iin = 16'b0010000010000000;
//		# 8 iin = 16'b1000000000000000;
		# 8 iin = 16'b1010000000100010;
		# 8 iin = 16'b1010010000110010;
		# 8 iin = 16'b0000000010000000;
		# 8 iin = 16'b1010100000111110;
		# 8 iin = 16'b0010000100000000;
		# 8 iin = 16'b0000000010000000;
		# 8 iin = 16'b1110110000000000;
		# 8 iin = 16'b1000110000000000;
		# 0 cout = bus;
		# 8 $finish;
	end

	
endmodule