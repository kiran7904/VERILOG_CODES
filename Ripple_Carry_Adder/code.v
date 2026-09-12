module fa(output s,cy,input a,b,cin);
  assign {cy,s}=a+b+cin;
endmodule
module rca(output [3:0]s,output cy,input [3:0]a,b,input cin);
  wire [3:0]x;
  fa f1(s[0],x[0],a,b,cin);
  fa f2(s[1],x[1],a,b,x[0]);
  fa f3(s[2],x[2],a,b,x[1]);
  fa f4(s[0],x[3],a,b,x[2]);
  assign cy=x[0];
endmodule
  
module tb;
  wire [3:0]s;
  wire cy;
  reg [3:0]a,b;
  reg cin;
  rca r1(s,cy,a,b,cin);
  initial begin
    a=4'b0001;b=4'b0011;cin=1'b0;
    #5 a=4'b0110;b=4'b110;cin=1'b1;
    #10 $finish;
  end
endmodule
