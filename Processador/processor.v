


module processor (clock, iin, resetn, bus);
	input [15:0] iin;
	input resetn, clock;
	output reg [15:0] bus;

	parameter LDI = 3'b101;
	parameter OUT = 3'b100;
	
	wire [15:0] outMulti, outR0, outR1, outR2, outR3, outR4, outR5, outR6, outR7, outRA, outRR, outULA;
	reg r0e, r1e, r2e, r3e, r4e, r5e, r6e, r7e, rAe, rRe, immeSelect, rSelect, clearCont;
	wire [1:0] cont;
	
	reg [2:0] opcode, op;
	
	registrador re0 (.in(outMulti), .enable(r0e), .clock(clock), .out(outR0));
	registrador re1 (.in(outMulti), .enable(r1e), .clock(clock), .out(outR1));
	registrador re2 (.in(outMulti), .enable(r2e), .clock(clock), .out(outR2));
	registrador re3 (.in(outMulti), .enable(r3e), .clock(clock), .out(outR3));
	registrador re4 (.in(outMulti), .enable(r4e), .clock(clock), .out(outR4));
	registrador re5 (.in(outMulti), .enable(r5e), .clock(clock), .out(outR5));
	registrador re6 (.in(outMulti), .enable(r6e), .clock(clock), .out(outR6));
	registrador re7 (.in(outMulti), .enable(r7e), .clock(clock), .out(outR7));
	
	registrador reA (.in(outMulti), .enable(rAe), .clock(clock), .out(outRA));
	registrador reR (.in(outULA), .enable(rRe), .clock(clock), .out(outRR));
	
	ula u1 (.rA(outRA), .b(outMulti), .opSelect(opcode), .rG(outULA));
	
	counter c1 (.clock(clock), .clear(clearCont), .out(cont));
	
	multiplexador m1 (.i0(outR0), .i1(outR1), .i2(outR2), .i3(outR3), .i4(outR4), .i5(outR5), .i6(outR6), .i7(outR7), .iR(outRR), 
						.imediato(iin[09:00]), .rSelect(rSelect), .immeSelect(immeSelect), .select(op), .out(outMulti));
						
	initial begin
		# 0 clearCont = 1;
		# 1 clearCont = 0;
	end

	
	always @(cont, resetn) begin
		case (cont)
			2'b00: begin
				clearCont = 1;
				r0e = 0;
				r1e = 0;
				r2e = 0;
				r3e = 0;
				r4e = 0;
				r5e = 0;
				r6e = 0;
				r7e = 0;
				opcode = iin[15:13];
			end
			2'b01: begin
				op = iin[13:10];
				rAe = 1;
			end
			2'b10: begin
				rAe = 0;
				if (opcode == LDI) immeSelect = 1;
				else if (opcode[2] == 0) op = iin[09:07];
				rRe = 1;
			end
			2'b11: begin
				rRe = 0;
				immeSelect = 0;
				op = iin[13:10];
				if (opcode == OUT) bus = outMulti;
				else case (op)
					3'b000: r0e = 1;
					3'b001: r1e = 1;
					3'b010: r2e = 1;
					3'b011: r3e = 1;
					3'b100: r4e = 1;
					3'b101: r5e = 1;
					3'b110: r6e = 1;
					3'b111: r7e = 1;
				endcase
				clearCont = 0;
			end
		endcase
	end
	
	
	
	
	
//	wire [1:0] cont;
//	wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, rA, rR, A, B, R;
//	
//	reg [2:0] opcode;
//	reg [2:0] op, op2;
//	reg [15:0] direct;
//	reg e0, e1, e2, e3, e4, e5, e6, e7, eA, eR, enable;
//	
//	initial begin
////		direct = ZERO;
////		r0 = ZERO;
////		r1 = ZERO;
////		r2 = ZERO;
////		r3 = ZERO;
////		r4 = ZERO;
////		r5 = ZERO;
////		r6 = ZERO;
////		r7 = ZERO;
//		e0 = 1'b0;
//		e1 = 1'b0;
//		e2 = 1'b0;
//		e3 = 1'b0;
//		e4 = 1'b0;
//		e5 = 1'b0;
//		e6 = 1'b0;
//		e7 = 1'b0;
//		eA = 1'b0;
//		eR = 1'b0;
//	end
//	
//	registrador re0 (.in(rR), .enable(e0), .clock(clock), .out(r0));
//	registrador re1 (.in(rR), .enable(e1), .clock(clock), .out(r1));
//	registrador re2 (.in(rR), .enable(e2), .clock(clock), .out(r2));
//	registrador re3 (.in(rR), .enable(e3), .clock(clock), .out(r3));
//	registrador re4 (.in(rR), .enable(e4), .clock(clock), .out(r4));
//	registrador re5 (.in(rR), .enable(e5), .clock(clock), .out(r5));
//	registrador re6 (.in(rR), .enable(e6), .clock(clock), .out(r6));
//	registrador re7 (.in(rR), .enable(e7), .clock(clock), .out(r7));
//	registrador reA (.in(A), .enable(eA), .clock(clock), .out(rA));
//	registrador reR (.in(R), .enable(eR), .clock(clock), .out(rR));
//	
//	counter c1 (.clock(clock), .clear(resetn), .out(cont));
//	
//	multiplexador m1 (.i0(r0), .i1(r1), .i2(r2), .i3(r3), .i4(r4), .i5(r5), .i6(r6), .i7(r7), .select(op), .out(A));
//	multiplexador m2 (.i0(r0), .i1(r1), .i2(r2), .i3(r3), .i4(r4), .i5(r5), .i6(r6), .i7(r7), .select(op), .out(B));
//	
//	ula u1 (.rA(rA), .b(B), .opSelect(opcode), .rG(R));
//	
//	demultiplexador d1 (.in(enable), .select(op1), .o0(e0), .o1(e1), .o2(e2), .o3(e3), .o4(e4), .o5(e5), .o6(e6), .o7(e7));
//	
//	always @(cont) begin
//		case (cont)
//			2'b00: begin 
//				enable = 1'b0;
//				opcode = iin[15:13];
//			end
//			2'b01: begin 
//				op = iin[12:10];
//				eA = 1'b1;
//			end
//			2'b10: begin 
//				if (opcode[2] == 0) op = iin[9:7];
//				else if (opcode == LDI) direct = iin[9:0];
//			end
//			2'b11: begin 
//				if (opcode == OUT) bus = rR;
//				else begin 
//					enable = 1'b1;
//				end
//			end
//		endcase
//	end
	
endmodule