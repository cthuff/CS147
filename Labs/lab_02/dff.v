// Name: dff.v
// Module: DFF
// Input: CLK - clock
//        D - data
//        RST - reset
//       
// Output: Q - hold value of D at positive clock edge
//
// Notes: Simple D flipflop
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 07, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
module DFF(Q, D, CLK, RST);
// input list
input D, CLK, RST;
// output list
output Q;

reg Q;
// Whenever RST change or at -ve edge of clock
always @ (posedge RST or negedge CLK)
begin
    if (RST)
       Q = 1'b0;
    else
       Q = D;
end

endmodule
