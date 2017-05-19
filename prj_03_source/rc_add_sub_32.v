// Name: rc_add_sub_32.v
// Module: RC_ADD_SUB_32
//
// Output: Y : Output 32-bit
//         CO : Carry Out
//         
//
// Input: A : 32-bit input
//        B : 32-bit input
//        SnA : if SnA=0 it is add, subtraction otherwise
//
// Notes: 32-bit adder / subtractor implementaiton.
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

//32-bit Rupple Carrier Adder/Subtractor
module rc_add_sub_32(result, carryOut, operand1, operand2, subtractNotAdd);
	input [31:0] operand1, operand2;
	input subtractNotAdd;
	output [31:0] result;
	output carryOut;
	
	wire [31:0] xorProduct;
	wire [31:0] wireNext;

	genvar i;
	generate
		for (i=0; i<32; i=i+1) begin : rc_add_sub_32_loop
			xor xor_inst(xorProduct[i], subtractNotAdd, operand2[i]);
			if(i!=0 && i!=31) begin
				full_adder fa(result[i], wireNext[i],
					operand1[i], xorProduct[i], wireNext[i-1]);
			end else if(i==0) begin
				full_adder fa(result[i], wireNext[i],
					operand1[i], xorProduct[i], subtractNotAdd);
			end else if(i==31) begin
				full_adder fa(result[i], carryOut,
					operand1[i], xorProduct[i], wireNext[i-1]);
			end
		end
	endgenerate
endmodule
//64-bit Ripple Carrier Adder/Subtractor
module rc_add_sub_64(r, c, o, p, sNa);
	input [63:0] o, p;
	input sNa;
	output [63:0] r;
	output c;
	
	wire [63:0] xorProduct, wireNext;

	genvar i;
	generate
		for (i=0; i<64; i=i+1) begin : rc_add_sub_64_loop
			xor xor_inst(xorProduct[i], sNa, p[i]);
			if(i!=0 && i!=63) begin
				full_adder fa(r[i], wireNext[i], o[i], xorProduct[i], wireNext[i-1]);
			end else if(i==0) begin
				full_adder fa(r[i], wireNext[i], o[i], xorProduct[i], sNa);
			end else if(i==63) begin
				full_adder fa(r[i], c, o[i], xorProduct[i], wireNext[i-1]);
			end
		end
	endgenerate
endmodule

//Fuller Adder
module full_adder(s, co, o, p, ci);
	input o, p, ci;
	output s, co;

	wire HA1sum, HA1carry, HA2carry;

	half_adder h1(HA1sum, HA1carry, o, p);
	half_adder h2(s, HA2carry, HA1sum, ci);

	or orI(co, HA1carry, HA2carry);
endmodule
//Half Adder
module half_adder(s, c, o, p);
	input o, p;
	output s, c;
	xor i(s, o, p);
	and j(c, o, p);
endmodule
