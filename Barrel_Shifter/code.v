module barrel_shifter (
    input  wire [7:0] data,
    input  wire [2:0] shift,
    output wire [7:0] result
);

assign result = data << shift;

endmodule
