module unsigned_adder (
    input  wire [7:0] a,
    input  wire [7:0] b,
    output wire [7:0] sum,
    output wire       overflow
);

assign {overflow, sum} = a + b;

endmodule
