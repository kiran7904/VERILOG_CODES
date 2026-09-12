module ram(output reg[7:0]out=8'b0,input clk,rst,input [7:0]in,input we,input [1:0]addr);
  reg [7:0]mem[0:4];
  always@(posedge clk)begin
    if(rst)
      out<=8'b0;
    else
      if(we)
        mem[addr]<=in;
      else
        out<=mem[addr];
  end
endmodule
        
        
module tb;
  wire [7:0]out;
  reg we;
  reg [7:0]in;
  reg clk,rst;
  reg [1:0]addr;
  ram r1(out,clk,rst,in,we,addr);
  initial clk=0;
  always #5 clk=~clk;
  initial begin
    $dumpfile("1.vcd");
    $dumpvars(0,tb);
    rst=0;we=0;in=0;addr=2'b00;
    #4 in=8'hA6;we=1;addr=01;
    #4 we=0;
    #10 $finish;
  end
endmodule
    
    
