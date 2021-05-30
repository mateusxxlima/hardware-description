`include "MUX.v"
`include "ULA.v"
`include "REGST.v"

module OPERATIVE (
  input [15:0] A,
  input [15:0] B,
  input [15:0] C,
  input [15:0] _X,
  input clk,
  input load_x,
  input load_s,
  input load_h,
  input wire H,
  input [1:0] sel_m0,
  input [1:0] sel_m1,
  input [1:0] sel_m2,
  output [15:0] result
);

  wire [15:0] out_reg_x, out_reg_s, out_reg_h;
  wire [15:0] mux_out_m0, mux_out_m1, mux_out_m2;
  wire [15:0] ula_result;
  assign result = out_reg_s;

  REGST regst_X (_X, out_reg_x, clk, load_x);
  REGST regst_S (ula_result, out_reg_s, clk, load_s);
  REGST regst_H (ula_result, out_reg_h, clk, load_h);

  ULA ula (mux_out_m1, mux_out_m2, H, ula_result);

  MUX mux_m0 (sel_m0, mux_out_m0, A, B, C, mux_out_m0);
  MUX mux_1 (sel_m1, mux_out_m0, out_reg_x, out_reg_s, out_reg_h, mux_out_m1);
  MUX mux_2 (sel_m2, out_reg_x, mux_out_m0, out_reg_s, out_reg_h, mux_out_m2);

endmodule