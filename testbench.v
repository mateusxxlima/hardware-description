`include "project.v"

module testbench;

	reg clk = 0, reset = 1;
	reg [15:0] A = 1, B = 2, C = 3, _X = 4;
	wire done;
	wire [15:0] result;

	PROJECT project (clk, reset, A, B, C, _X, done, result);

	always #1 begin
		clk = ~clk;
	end

	initial begin

		$dumpvars;
		#1;
		reset = 0;
		#13;
		$finish;
	end

endmodule