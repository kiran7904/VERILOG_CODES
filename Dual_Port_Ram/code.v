module ram(output reg[7:0]out1=8'b0,output reg[7:0]out2=8'b0,input clk,rst,input [7:0]in1,input we1,input [1:0]addr1,input [7:0]in2,input we2,input [1:0]addr2);
  reg [7:0]mem[0:3];
  always@(posedge clk)begin
    if(rst)
      out1<=8'b0;
    else
      if(we1)
        mem[addr1]<=in1;
      else
        out1<=mem[addr1];
  end
  always@(posedge clk)begin
    if(rst)
      out2<=8'b0;
    else
      if(we2)
        mem[addr2]<=in2;
      else
        out2<=mem[addr2];
  end
endmodule
        
        
module tb;

    reg clk;
    reg rst;

    reg [7:0] in1;
    reg we1;
    reg [1:0] addr1;
    wire [7:0] out1;

    reg [7:0] in2;
    reg we2;
    reg [1:0] addr2;
    wire [7:0] out2;


    // DUT
    ram r1 (
        .out1(out1),
        .out2(out2),
        .clk(clk),
        .rst(rst),

        .in1(in1),
        .we1(we1),
        .addr1(addr1),

        .in2(in2),
        .we2(we2),
        .addr2(addr2)
    );
    initial clk = 0;
    always #5 clk = ~clk;


    initial begin

        $dumpfile("ram.vcd");
        $dumpvars(0, tb);
        rst   = 1;
        we1   = 0;
        we2   = 0;
        in1   = 0;
        in2   = 0;
        addr1 = 0;
        addr2 = 0;

        // -------------------------
        // RESET
        // -------------------------
        #10;
        rst = 0;

        we1   = 1;
        addr1 = 2'b00;
        in1   = 8'hAA;

        #10;
        we1   = 0;

        we2   = 1;
        addr2 = 2'b01;
        in2   = 8'hBB;

        #10;


        // -------------------------
        // TEST 3
        // Port 1 reads address 0
        // Expected out1 = AA
        // -------------------------
        we2   = 0;

        addr1 = 2'b00;

        #10;
        addr2 = 2'b01;

        #10;
        we1   = 1;
        addr1 = 2'b10;
        in1   = 8'hCC;

        we2   = 1;
        addr2 = 2'b11;
        in2   = 8'hDD;

        #10;


        // -------------------------
        // TEST 6
        // Both ports read
        // different addresses
        // -------------------------
        we1   = 0;
        addr1 = 2'b10;

        we2   = 0;
        addr2 = 2'b11;

        #10;
        we1   = 1;
        addr1 = 2'b00;
        in1   = 8'h11;

        we2   = 1;
        addr2 = 2'b00;
        in2   = 8'h22;

        #10;
        we1   = 0;
        we2   = 0;

        addr1 = 2'b00;

        #10;

        $finish;

    end

endmodule
