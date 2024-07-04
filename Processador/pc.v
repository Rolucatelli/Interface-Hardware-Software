


module pc(mem, cont, jmp, ic)
    input [63:0] [15:0] mem;
    input [1:0] cont;
    input [5:0] jmp;
    output [5:0] ic;
    
    initial ic = 0;

    always @(cont) begin
        if (cont == 0)
        ic = ic + 1;
        if (jmp != 0)
        ic = ic + jmp;
    end
endmodule