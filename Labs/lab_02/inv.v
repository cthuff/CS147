// Name: inv.v
// Module: INVERTER
// Input: IN - input
//  
// Output: OUT - output
//
// Notes: Simple inverter
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 07, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
module INVERTER (OUT, IN);
// list of inputs
input IN;
// list of outputs
output OUT;

assign OUT = ~IN;

endmodule
