


module processor (clock, mem, resetn, bus);
	input [63:0] [15:0] mem;
	input resetn, clock;
	output reg [15:0] bus;

	parameter LDI = 3'b101;
	parameter OUT = 3'b100;
	parameter REP = 3'b111;
	parameter BNE = 3'b110;
	
	wire [15:0] outMulti, outR0, outR1, outR2, outR3, outR4, outR5, outR6, outR7, outRA, outRR, outULA;
	reg r0e, r1e, r2e, r3e, r4e, r5e, r6e, r7e, rAe, rRe, immeSelect, rSelect, clearCont;
	wire [1:0] cont;
	wire [5:0] jmp, ic;
	// reg [5:0] ic;
	
	
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

	pc p1 (.mem(mem), .cont(cont), .ic(ic), .jmp(jmp));
	
	multiplexador m1 (.i0(outR0), .i1(outR1), .i2(outR2), .i3(outR3), .i4(outR4), .i5(outR5), .i6(outR6), .i7(outR7), .iR(outRR), 
						.imediato(mem[ic][9:0]), .rSelect(rSelect), .immeSelect(immeSelect), .select(op), .out(outMulti));
						
	initial begin
		# 0 clearCont = 1;
		jmp = 0;
	end

	
	always @(cont, resetn) begin
		case (cont)
			2'b00: begin
				jmp = 0;
				clearCont = resetn;
				r0e = 0;
				r1e = 0;
				r2e = 0;
				r3e = 0;
				r4e = 0;
				r5e = 0;
				r6e = 0;
				r7e = 0;
				rSelect = 0;
				immeSelect = 0;
				opcode = mem[ic][15:13];
				op = mem[ic][12:10];
			end
			2'b01: begin
				rAe = 1;
			end
			2'b10: begin
				rAe = 0;
				if (opcode == LDI) begin 
					immeSelect = 1;
					rRe = 1;
				end
				else if (opcode[2] == 0) 
					begin 
						op = mem[ic][09:07]; 
						rRe = 1; 
					end
				else if (opcode == REP) op = mem[ic][09:07];
			end
			2'b11: begin
				rRe = 0;
				rSelect = 1;
				if (opcode == BNE) begin
					if (outMulti == 0) jmp = mem[ic][9:0];
				end
				case (mem[ic][12:10])
					3'b000: r0e = 1;
					3'b001: r1e = 1;
					3'b010: r2e = 1;
					3'b011: r3e = 1;
					3'b100: r4e = 1;
					3'b101: r5e = 1;
					3'b110: r6e = 1;
					3'b111: r7e = 1;
				endcase
				if (opcode == OUT) bus = outMulti;
				clearCont = 1;
			end
		endcase
	end
endmodule