// Name: mult.v
// Module: MULT32 , MULT32_U
//
// Output: HI: 32 higher bits
//         LO: 32 lower bits
//         
//
// Input: A : 32-bit input
//        B : 32-bit input
//
// Notes: 32-bit multiplication
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

//Unsigned Multiplication
module mult_32Bit_Unsigned(resultHigh, resultLow, multiplicand, multiplier);
	//input list	
	input [31:0] multiplicand, multiplier;
	//output list
	output [31:0] resultHigh, resultLow;

	wire cOut [31:0];
	wire [31:0] op2Wire [31:0];

	and32 an(op2Wire[0], multiplicand, {32{multiplier[0]}});
	buf b2(cOut[0], 1'b0);
	buf b(resultLow[0], op2Wire[0][0]);

	genvar j;
	generate
		for (j=1; j<32; j=j+1) begin : loop_
			wire [31:0] op1Wire;
			and32 an(op1Wire, multiplicand, {32{multiplier[j]}});
			rc_add_sub_32 ad(op2Wire[j], cOut[j], op1Wire, {cOut[j-1],{op2Wire[j-1][31:1]}}, 1'b0);
			buf b(resultLow[j], op2Wire[j][0]);
		end
	endgenerate
	buf32 b4(resultHigh, {cOut[31],{op2Wire[31][31:1]}});
endmodule
//Signed Multiplication 
module mult(resultHigh, resultLow, multiplicand, multiplier);
	//input list
	input [31:0] multiplicand, multiplier;
	//output list
	output [31:0] resultHigh, resultLow;
	wire [31:0] bundle [3:0];
	wire [63:0] unsignedWire, twosOutm, muxOut;
	wire xorGate;

	xor o(xorGate, multiplicand[31], multiplier[31]);

	twosComplement t1(bundle[0], multiplicand);
	mux32_2x1 m1(bundle[1], multiplicand, bundle[0], multiplicand[31]);

	twosComplement t2(bundle[2], multiplier);
	mux32_2x1 m2(bundle[3], multiplier, bundle[2], multiplier[31]);

	mult_32Bit_Unsigned mul(unsignedWire[63:32], unsignedWire[31:0], bundle[1], bundle[3]);

	twosComplement64 t3(twosOutm, unsignedWire);
	mux64_2x1 m3(muxOut, unsignedWire, twosOutm, xorGate);

	buf32 b1(resultLow, muxOut[31:0]);
	buf32 b2(resultHigh, muxOut[63:32]);
endmodule
