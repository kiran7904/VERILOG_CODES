module ha(output s,cy,input a,b);
  assign {cy,s}=a+b;
endmodule
module fa(output sum,carry,input a,b,cin);
  wire [2:0]x;
  ha h1(x[1],x[0],a,b);
  ha h2(sum,x[2],x[1],cin);
  assign carry=x[2]+x[1];
endmodule
module tb;
  wire s,cy;
  reg a,b,cin;
  fa f1(s,cy,a,b,cin);
  initial begin
    {a,b,cin}=3'b101;
    #5{a,b,cin}=3'b010;
    #10 $finish;
  end
endmodule
