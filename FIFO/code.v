module fifo(output reg[7:0]out,output full,empty,input clk,rst,input [7:0]in,input wr_en,rd_en);
  reg [7:0]mem[0:3];
  reg [1:0]wptr,rdptr;
  reg [2:0]count;
  assign full=(count==3'd4)?1:0;
  assign empty=(count==3'd0)?1:0;
  always @(posedge clk) begin
    if (rst) begin
        out   <= 0;
        wptr  <= 0;
        rdptr <= 0;
        count <= 0;
    end
    else begin

        if (wr_en && !full) begin
            mem[wptr] <= in;
            wptr <= wptr + 1;
        end

        if (rd_en && !empty) begin
            out <= mem[rdptr];
            rdptr <= rdptr + 1;
        end

        case ({wr_en && !full, rd_en && !empty})
            2'b10: count <= count + 1;
            2'b01: count <= count - 1;
            default: count <= count;
        endcase

    end
end
endmodule
      
      
      
    
        
module tb;

reg clk, rst;
reg [7:0] in;
reg wr_en, rd_en;

wire [7:0] out;
wire full, empty;

fifo dut(
    .out(out),
    .full(full),
    .empty(empty),
    .clk(clk),
    .rst(rst),
    .in(in),
    .wr_en(wr_en),
    .rd_en(rd_en)
);

initial clk = 0;
always #5 clk = ~clk;

initial begin

    $dumpfile("fifo.vcd");
    $dumpvars(0, tb);

    rst = 1;
    in = 0;
    wr_en = 0;
    rd_en = 0;

    #10 rst = 0;

    #2;
    wr_en = 1;
    in = 8'hAA;

    #10;
    in = 8'hBB;

    #10;
    in = 8'hCC;

    #10;
    in = 8'hDD;

    #10;
    wr_en = 0;

    #10;
    rd_en = 1;

    #10;
    #10;
    #10;

    rd_en = 0;

    #10;

    $finish;

end

endmodule
