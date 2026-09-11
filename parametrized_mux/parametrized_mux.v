module mux #(parameter IN=4)(output y,input [IN-1:0]in,input [$clog2(IN)-1:0] sel);
  assign y=in[sel];
endmodule
module tb;
  localparam IN=4;
  reg [IN-1:0]in;
  reg [$clog2(IN)-1:0] sel;
  wire y;
  mux #(IN) m1(y,in,sel);
  initial begin 
    in=4'b0000;sel=0;
    #5 in=4'b1101;sel=1;
    $dumpfile("1.vcd");
    $dumpvars(0,tb);
    #10 $finish();
  end
endmodule
    
