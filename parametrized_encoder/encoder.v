module encoder #(parameter IN=4)(output reg [$clog2(IN)-1:0]y,input [IN-1:0]in);
  always@(*)begin
    case(in)
      4'b0001:y=2'b00;
      4'b0010:y=2'b01;
      4'b0100:y=2'b10;
      4'b1000:y=2'b11;
    endcase
  end
endmodule
module tb;
  localparam IN=4;
  wire [$clog2(IN)-1:0]y;
  reg [IN-1:0] in;
  encoder #(IN) e1(y,in);
  initial begin 
    in=4'b0001;
    #5 in=4'b1111;
    $dumpfile("1.vcd");
    $dumpvars(0,tb);
    #10 $finish();
  end
endmodule
    
