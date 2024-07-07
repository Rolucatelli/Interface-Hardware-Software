
module pc(cont, jmp, pc);

    input [1:0] cont;
    input [5:0] jmp;
    output reg [5:0] pc;
    
    initial pc = -1;

    always @(cont) begin
        if (cont == 2'b00 && jmp == 0) pc = pc + 1;
        else pc = pc + jmp;
    end
endmodule