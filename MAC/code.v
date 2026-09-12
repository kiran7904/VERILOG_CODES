module mac(output reg[31:0]acc=32'b0,input clk,rst_n,input [3:0]a,b);
  always@(posedge clk)begin
    if(!rst_n)
      acc<=32'b0;
    else
      acc<=acc+a*b;
  end
endmodule
module tb;
  reg clk, rst_n;
  reg [3:0] a, b;
  wire [31:0] acc;

  mac m1(acc, clk, rst_n, a, b);

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $dumpfile("mac_tb.vcd");
    $dumpvars(0, tb);

    rst_n = 0;
    a = 0; b = 0;
    #4 rst_n = 1;

    #6 a = 4'b0011; b = 4'b0101;   // 3 × 5
    #10 a = 4'b1111; b = 4'b0001;  // 15 × 1
    #10 a = 4'b1010; b = 4'b0010;  // 10 × 2
    #10 a = 4'b0111; b = 4'b0111;  // 7 × 7

    #20 $finish;
  end
endmodule
