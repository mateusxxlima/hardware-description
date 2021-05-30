module REGST (inp, out, clk, load);

  input [15:0] inp;
  output reg [15:0] out;
  input clk, load;
  
  always @(posedge clk) begin
    if (load == 1)
      out <= inp;
  end

endmodule