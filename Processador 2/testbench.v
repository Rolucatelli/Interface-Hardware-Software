

module testbench (cout);

	output reg [15:0] cout;
	reg clock = 1;
	reg [15:0] iin;
	wire exit;
	
	wire [15:0] bus;
	
	always #1 clock = !clock;
	
	initial $dumpfile("testbench.vcd");
	initial $dumpvars(0, testbench);

	processor p(clock, bus, exit);
	
	initial begin
		cout = bus;
	end

	always @* begin
		if (exit == 1) $finish;
	end
endmodule