

module somadorUnico (a, b, cin, s, cout);
	input a,b,cin;
	output s, cout;
	
	wire w1, w2, w3;
	
	xor xor1(w1,a,b);
	xor xor2(s,w1,cin);
	and and1(w2, w1, cin);
	and and2(w3, a, b);
	or or1 (cout, w2, w3);
	
	
endmodule