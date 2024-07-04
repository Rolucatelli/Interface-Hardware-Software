

module testbench (cout);

	output reg [15:0] cout;
	reg clock = 0;
	reg [15:0] iin;
	reg resetn = 1;
	
	wire [15:0] bus;
	reg [63:0] [15:0] mem;
	
	always #1 clock = !clock;
	
	initial $dumpfile("testbench.vcd");
	initial $dumpvars(0, testbench);

	processor p(clock, mem, resetn, bus);
	
	initial begin
		# 1 resetn = 1'b0;
//		# 8 iin = 16'b1010000000011100;
//		# 8 iin = 16'b1010010000001010;
//		# 8 iin = 16'b0010000010000000;
//		# 8 iin = 16'b1000000000000000;
		mem[0] = 16'b1010000000100010;
		mem[1] = 16'b1010010000110010;
		mem[2] = 16'b0000000010000000;
		mem[3] = 16'b1010100000111110;
		mem[4] = 16'b0010000100000000;
		mem[5] = 16'b0000000010000000;
		mem[6] = 16'b1110110000000000;
		mem[7] = 16'b1000110000000000;
		
		cout = bus;
		# 8 $finish;
	end

	
endmodule