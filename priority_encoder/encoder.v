module encoder #(parameter IN=4)(output reg [$clog2(IN)-1:0]y,input [IN-1:0]in);
  always@(*)begin
    case(1'b1)
      in[0]:y=2'b00;
      in[1]:y=2'b01;
      in[2]:y=2'b10;
      in[3]:y=2'b11;
    endcase
  end
endmodule
