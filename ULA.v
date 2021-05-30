module ULA(value_1, value_2, H, ula_result);

  input [15:0] value_1, value_2;
  output reg [15:0] ula_result;
  input H;

	always @ (value_1 or value_2 or H) begin
		if (H == 1)
      ula_result = value_1 * value_2;
    else
      ula_result = value_1 + value_2;
	end

endmodule