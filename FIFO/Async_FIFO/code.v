module async_fifo (
    input  wire       wr_clk,
    input  wire       rd_clk,
    input  wire       rst,

    input  wire [7:0] data_in,
    input  wire       wr_en,
    output wire       full,

    output reg  [7:0] data_out,
    input  wire       rd_en,
    output wire       empty
);

reg [7:0] mem [0:3];

reg [2:0] wr_ptr;
reg [2:0] rd_ptr;

reg [2:0] wr_gray;
reg [2:0] rd_gray;

reg [2:0] rd_gray_sync1;
reg [2:0] rd_gray_sync2;

reg [2:0] wr_gray_sync1;
reg [2:0] wr_gray_sync2;

assign empty = (rd_gray == wr_gray_sync2);

assign full = (wr_gray == {~rd_gray_sync2[2:1],
                            rd_gray_sync2[0]});


always @(posedge wr_clk) begin

    if (rst) begin
        wr_ptr        <= 0;
        wr_gray       <= 0;
        rd_gray_sync1 <= 0;
        rd_gray_sync2 <= 0;
    end

    else begin

        rd_gray_sync1 <= rd_gray;
        rd_gray_sync2 <= rd_gray_sync1;

        if (wr_en && !full) begin
            mem[wr_ptr[1:0]] <= data_in;
            wr_ptr <= wr_ptr + 1'b1;
            wr_gray <= (wr_ptr + 1'b1) ^
                       ((wr_ptr + 1'b1) >> 1);
        end

    end

end


always @(posedge rd_clk) begin

    if (rst) begin
        rd_ptr        <= 0;
        rd_gray       <= 0;
        wr_gray_sync1 <= 0;
        wr_gray_sync2 <= 0;
        data_out      <= 0;
    end

    else begin

        wr_gray_sync1 <= wr_gray;
        wr_gray_sync2 <= wr_gray_sync1;

        if (rd_en && !empty) begin
            data_out <= mem[rd_ptr[1:0]];
            rd_ptr <= rd_ptr + 1'b1;
            rd_gray <= (rd_ptr + 1'b1) ^
                       ((rd_ptr + 1'b1) >> 1);
        end

    end

end

endmodule
