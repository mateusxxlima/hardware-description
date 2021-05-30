`include "controller.v"
`include "operative.v"

module PROJECT (
	input clk,
	input reset,
	input [15:0] A,
  input [15:0] B,
  input [15:0] C,
  input [15:0] _X,
	output done,
	output [15:0] result
);

	wire load_x, load_s, load_h, H;
	wire [1:0] sel_m0, sel_m1, sel_m2;

	CONTROLLER controller(
		clk,
		reset,
		H,
		load_x,
		load_s,
		load_h,
		sel_m0,
		sel_m1,
		sel_m2,
		done
	);

	OPERATIVE operative(
		A,
		B,
		C,
		_X,
		clk,
		load_x,
		load_s,
		load_h,
		H,
		sel_m0,
		sel_m1,
		sel_m2,
		result
	);
	
endmodule