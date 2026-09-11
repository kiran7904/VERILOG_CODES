module decoder #(parameter IN=4)(output reg [IN-1:0]y,input [$clog2(IN)-1:0]in);
  always@(*)begin
    case(in)
      2'b00:y=4'b0001;
      2'b01:y=4'b0010;
      2'b10:y=4'b0100;
      2'b11:y=4'b1000;
    endcase
  end
endmodule
module tb;
  localparam IN=4;
  wire [IN-1:0]y;
  reg [$clog2(IN)-1:0] in;
  decoder #(IN) d1(y,in);
  initial begin 
    in=2'b00;
    #5 in=2'b11;
    $dumpfile("1.vcd");
    $dumpvars(0,tb);
    #10 $finish();
  end
endmodule
    
