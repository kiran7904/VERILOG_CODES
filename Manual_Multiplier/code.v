module mul(output [7:0]product,input [3:0]a,b);
  wire [7:0]p[0:3];
  assign p[0]=b[0]?{4'b0000,a}:8'b0;
  assign p[1]=b[1]?{4'b0000,a<<1}:8'b0;
  assign p[2]=b[2]?{4'b0000,a<<2}:8'b0;
  assign p[3]=b[3]?{4'b0000,a<<3}:8'b0;
  assign product=p[0]+p[1]+p[2]+p[3];
endmodule
module tb;
  wire [7:0] product;
  reg [3:0] a, b;

  mul m1(product, a, b);

  initial begin
    $dumpfile("mul_tb.vcd");
    $dumpvars(0, tb);

    a = 4'b0011; b = 4'b0101; #5;
    a = 4'b1111; b = 4'b0010; #5;
    a = 4'b1010; b = 4'b1010; #5;
    a = 4'b0111; b = 4'b0111; #5;
    a = 4'b0001; b = 4'b1111; #5;
    a = 4'b1111; b = 4'b1111; #5;

    $finish;
  end
endmodule
