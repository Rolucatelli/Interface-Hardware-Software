
module bancoReg(in, out, key, w, clock);
    input [15:0] in;
    input [2:0] key;
    input w, clock;
    output [15:0] out;

    wire [15:0] outR0, outR1, outR2, outR3, outR4, outR5, outR6, outR7;
    reg r0e, r1e, r2e, r3e, r4e, r5e, r6e, r7e;

    mux8x3 mOut (.i0(outR0), .i1(outR1), .i2(outR2), .i3(outR3), .i4(outR4), .i5(outR5), .i6(outR6), .i7(outR7), .key(key), .out(out));

    registrador re0 (.in(in), .enable(r0e), .out(outR0), .clock(clock));
	registrador re1 (.in(in), .enable(r1e), .out(outR1), .clock(clock));
	registrador re2 (.in(in), .enable(r2e), .out(outR2), .clock(clock));
	registrador re3 (.in(in), .enable(r3e), .out(outR3), .clock(clock));
	registrador re4 (.in(in), .enable(r4e), .out(outR4), .clock(clock));
	registrador re5 (.in(in), .enable(r5e), .out(outR5), .clock(clock));
	registrador re6 (.in(in), .enable(r6e), .out(outR6), .clock(clock));
	registrador re7 (.in(in), .enable(r7e), .out(outR7), .clock(clock));

    initial begin
        r0e = 0;
        r1e = 0;
        r2e = 0;
        r3e = 0;
        r4e = 0;
        r5e = 0;
        r6e = 0;
        r7e = 0;
    end

    always @* begin
        r0e = 0;
        r1e = 0;
        r2e = 0;
        r3e = 0;
        r4e = 0;
        r5e = 0;
        r6e = 0;
        r7e = 0;
        if (w == 1) begin
            case (key)
                3'b000: r0e = 1;
                3'b001: r1e = 1;
                3'b010: r2e = 1;
                3'b011: r3e = 1;
                3'b100: r4e = 1;
                3'b101: r5e = 1;
                3'b110: r6e = 1;
                3'b111: r7e = 1;
            endcase 
        end
    end

endmodule