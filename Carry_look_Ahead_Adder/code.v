module cla(output [3:0]s,output cy,input [3:0]a,b,input cin);
  wire [3:0]p,g,c;
  genvar i;
  assign p=a^b;
  assign g=a&b;
  assign c[0]=(p[0]&cin)|g[0];
  generate 
    for(i=1;i<4;i++)begin
      assign c[i]=(p[i]&c[i-1])|g[i];
    end
  endgenerate
  assign s[0] = p[0] ^ cin;
  assign s[1] = p[1] ^ c[0];
  assign s[2] = p[2] ^ c[1];
  assign s[3] = p[3] ^ c[2];
  assign cy=c[3];
endmodule
module tb;
  wire [3:0] s;
  wire cy;
  reg [3:0] a, b;
  reg cin;
  cla c1(s, cy, a, b, cin);

  initial begin
    $dumpfile("cla_tb.vcd");
    $dumpvars(0, tb);

    a = 4'b0000; b = 4'b0000; cin = 0; #5; 
    a = 4'b0101; b = 4'b0011; cin = 0; #5;  
    a = 4'b1111; b = 4'b0001; cin = 0; #5;  
    a = 4'b1010; b = 4'b1010; cin = 1; #5;  
    a = 4'b0111; b = 4'b0111; cin = 0; #5;  

    $finish;
  end
endmodule
