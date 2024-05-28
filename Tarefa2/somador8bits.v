



module somador8bits (a, b, cin, s, cout);
	
	input [7:0] a, b;
	input cin;
	output [7:0] s;
	output cout;
	
	wire w1, w2, w3, w4, w5, w6, w7;
	
	somadorUnico s1 (.a(a[0]), .b(b[0]), .cin(cin), .s(s[0]), .cout(w1));
	somadorUnico s2 (.a(a[1]), .b(b[1]), .cin(w1), .s(s[1]), .cout(w2));
	somadorUnico s3 (.a(a[2]), .b(b[2]), .cin(w2), .s(s[2]), .cout(w3));
	somadorUnico s4 (.a(a[3]), .b(b[3]), .cin(w3), .s(s[3]), .cout(w4));
	somadorUnico s5 (.a(a[4]), .b(b[4]), .cin(w4), .s(s[4]), .cout(w5));
	somadorUnico s6 (.a(a[5]), .b(b[5]), .cin(w5), .s(s[5]), .cout(w6));
	somadorUnico s7 (.a(a[6]), .b(b[6]), .cin(w6), .s(s[6]), .cout(w7));
	somadorUnico s8 (.a(a[7]), .b(b[7]), .cin(w7), .s(s[7]), .cout(cout));


endmodule