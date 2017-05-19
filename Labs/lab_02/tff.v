// Name: tff.v
// Module: TFF
// Input: CLK - clock
//        RST - reset
//       
// Output: Q - Toggling at each clock +ve edge
//
// Notes: Simple T flipflop
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 07, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
module TFF (Q, CLK, RST);
// list of input
input CLK, RST;
// list of output
output Q;

wire q_inv;

DFF dff_inst (.Q(Q), .D(q_inv), .CLK(CLK), .RST(RST));
INVERTER inv_inst(.OUT(q_inv), .IN(Q));

endmodule
