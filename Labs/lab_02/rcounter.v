// Name: rcounter.v
// Module: RIPPLE_COUNTER
// Input: CLK - clock
//        RST - reset
//       
// Output: Q - 4-bit counting
//
// Notes: Simple ripple counter
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 07, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
module RIPPLE_COUNTER(Q, CLK, RST);
// input list
input CLK, RST;
// output list
output [3:0] Q;

TFF	tff0(.Q(Q[0]), .CLK(CLK), .RST(RST));
TFF	tff1(.Q(Q[1]), .CLK(Q[0]), .RST(RST));
TFF	tff2(.Q(Q[2]), .CLK(Q[1]), .RST(RST));
TFF	tff3(.Q(Q[3]), .CLK(Q[2]), .RST(RST));

endmodule
