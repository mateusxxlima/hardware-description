module MUX (sel, a, b, c, d, mux_out);

  input [1:0] sel;
  input [15:0] a, b, c, d;
  output reg [15:0] mux_out;

  always @(a or b or c or d or sel) begin
    case(sel)
      2'b00: mux_out = a;
      2'b01: mux_out = b;
      2'b10: mux_out = c;
      2'b11: mux_out = d;
    endcase
  end
endmodule