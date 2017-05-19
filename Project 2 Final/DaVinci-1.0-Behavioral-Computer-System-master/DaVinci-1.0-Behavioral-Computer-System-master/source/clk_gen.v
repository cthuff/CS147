// Name: clk_gen.v
// Module: CLK_GENERATOR
//
// Output: CLK - output clock with period `SYS_CLK_FREQ
//
// Notes: Clock generator. The clock frequency is defined in the project definition file.
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"
module CLK_GENERATOR(CLK);
// output list;
output CLK;

// storage for clock value
reg CLK;

initial
begin
CLK = 1'b1;
end
// For ever perform the following task.
always
begin
#`SYS_CLK_HALF_PERIOD CLK <= ~CLK;
end
endmodule;
