



module somador16bits (a, b, cin, s, cout);
	
	input [15:0] a, b;
	input cin;
	output [15:0] s;
	output cout;
	
	
	assign {cout,s} = a + b + cin;
	


endmodule