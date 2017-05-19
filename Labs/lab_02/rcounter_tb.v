`timescale 1ns/10ps
// Name: rcounter_tb.v
// Module: RIPPLE_COUNTER_TB
//
// Notes: Simple ripple counter testbench
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 07, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
module RIPPLE_COUNTER_TB;

reg tb_clk, tb_rst;
wire [3:0] tb_q;

RIPPLE_COUNTER rcounter(.Q(tb_q), .CLK(tb_clk), .RST(tb_rst));

initial
begin
tb_clk = 1'b0;
tb_rst = 1'b1;

#15 	tb_rst = 1'b0;
#80 	tb_rst = 1'b1;
#20 	tb_rst = 1'b0;
#320 	tb_rst = 1'b1;
#50  	$stop;
end

always
begin
#5 tb_clk = ~tb_clk;
end

endmodule
