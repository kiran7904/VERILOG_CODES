module siso (
    input  wire       clk,
    input  wire       rst,
    input  wire       serial_in,
    output wire       serial_out
);

reg [3:0] shift_reg;

always @(posedge clk or posedge rst) begin
    if (rst)
        shift_reg <= 4'b0;
    else
        shift_reg <= {shift_reg[2:0], serial_in};
end

assign serial_out = shift_reg[3];

endmodule
module sipo (
    input  wire       clk,
    input  wire       rst,
    input  wire       serial_in,
    output reg [3:0]  parallel_out
);

always @(posedge clk or posedge rst) begin
    if (rst)
        parallel_out <= 4'b0;
    else
        parallel_out <= {parallel_out[2:0], serial_in};
end

endmodule
module piso (
    input  wire       clk,
    input  wire       rst,
    input  wire       load,
    input  wire [3:0] parallel_in,
    output wire       serial_out
);

reg [3:0] shift_reg;

always @(posedge clk or posedge rst) begin

    if (rst)
        shift_reg <= 4'b0;

    else if (load)
        shift_reg <= parallel_in;

    else
        shift_reg <= {shift_reg[2:0], 1'b0};

end

assign serial_out = shift_reg[3];

endmodule
module piso (
    input  wire       clk,
    input  wire       rst,
    input  wire       load,
    input  wire [3:0] parallel_in,
    output wire       serial_out
);

reg [3:0] shift_reg;

always @(posedge clk or posedge rst) begin

    if (rst)
        shift_reg <= 4'b0;

    else if (load)
        shift_reg <= parallel_in;

    else
        shift_reg <= {shift_reg[2:0], 1'b0};

end

assign serial_out = shift_reg[3];

endmodule
always @(posedge clk) begin
    if (load)
        data_out <= data_in;
end
