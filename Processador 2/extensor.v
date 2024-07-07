
module extensor(in, out);
    input [15:0] in;
    output reg [15:0] out;

    always @* begin
        if (in[9] == 1)
            out = {6'b111111, in[9:0]};
        else out = {6'b000000, in[9:0]};
    end
endmodule