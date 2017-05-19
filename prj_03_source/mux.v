// Name: mux.v
// Module: 
// Input: 
// Output: 
//
// Notes: Common definitions
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 02, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
// 32-bit mux
module mux(result, operand1, operand2, control);
	input operand1, operand2, control;
	output result;
	wire notwire, and1wire, and2wire;

	not not1(notwire, control);
	and and1(and1wire, operand1, notwire);
	and and2(and2wire, operand2, control);
	or or1(result, and1wire, and2wire);

endmodule
//26-bit 2x1 mux
module mux26_2x1(result, operand1, operand2, control);
	input [25:0] operand1, operand2;
	input control;

	output [25:0] result;

	genvar i; generate
		for (i=0; i<26; i=i+1)begin : mux5_2x1_gen_loop
			mux m(result[i], operand1[i], operand2[i], control);
		end
	endgenerate
endmodule
//5-bit 2x1 mux
module mux5_2x1(result, operand1, operand2, control);
	input [4:0] operand1, operand2;
	input control;

	output [4:0] result;

	genvar i; generate
		for (i=0; i<5; i=i+1)begin : mux5_2x1_gen_loop
			mux m(result[i], operand1[i], operand2[i], control);
		end
	endgenerate
endmodule
//32-bit 2x1 mux
module mux32_2x1(result, operand1, operand2, control);
	input [31:0] operand1, operand2;
	input control;

	output [31:0] result;

	genvar i; generate
		for (i=0; i<32; i=i+1)begin : mux_gen_loop
			mux m(result[i], operand1[i], operand2[i], control);
		end
	endgenerate
endmodule
//64-bit 2x1 mux
module mux64_2x1(result, operand1, operand2, control);
	input [63:0] operand1, operand2;
	input control;

	output [63:0] result;

	genvar i;
	generate
		for (i=0; i<64; i=i+1)
		begin : mux_gen_loop
			mux m(result[i], operand1[i], operand2[i], control);
		end
	endgenerate
endmodule
//32-bit 4x1 mux
module mux32_4x1(result, operand1, operand2, operand3, operand4, control);
	input [31:0] operand1, operand2, operand3, operand4;
	input [1:0] control;

	output [31:0] result;

	wire [31:0] mux1Wire, mux2Wire;

	mux32_2x1 m1(.result(mux1Wire), .operand1(operand1), .operand2(operand2), .control(control[0]));
	mux32_2x1 m2(.result(mux2Wire), .operand1(operand3), .operand2(operand4), .control(control[0]));
	mux32_2x1 m3(.result(result), .operand1(mux1Wire), .operand2(mux2Wire), .control(control[1]));

endmodule
// 32-bit 8x1 mux
module mux32_8x1(result, operand1, operand2, operand3, operand4, 
	operand5, operand6, operand7, operand8, control);
	input [31:0] operand1, operand2, operand3, operand4, operand5, operand6, operand7, operand8;
	input [2:0] control;

	output [31:0] result;

	wire [31:0] mux1Wire, mux2Wire;

	mux32_4x1 m1(mux1Wire, operand1, operand2, operand3, operand4, control[1:0]);
	mux32_4x1 m2(mux2Wire, operand5, operand6, operand7, operand8, control[1:0]);
	mux32_2x1 m3(result, mux1Wire, mux2Wire, control[2]);

endmodule
// 32-bit 16x1 mux
module mux32_16x1(result, operand1, operand2, operand3, operand4, 
	operand5, operand6, operand7, operand8,
	operand9, operand10, operand11, operand12, 
	operand13, operand14, operand15, operand16, control);

	input [31:0] operand1, operand2, operand3, operand4, 
	operand5, operand6, operand7, operand8, 
	operand9, operand10, operand11, operand12, 
	operand13, operand14, operand15, operand16;
	input [3:0] control;

	output [31:0] result;

	wire [31:0] mux1Wire, mux2Wire;

	mux32_8x1 m1(.result(mux1Wire), .operand1(operand1), .operand2(operand2), .operand3(operand3), 
		.operand4(operand4), .operand5(operand5), .operand6(operand6), .operand7(operand7), 
		.operand8(operand8), .control(control[2:0]));
	mux32_8x1 m2(.result(mux2Wire), .operand1(operand9), .operand2(operand10), .operand3(operand11), 
		.operand4(operand12), .operand5(operand13), .operand6(operand14), .operand7(operand15), 
		.operand8(operand16), .control(control[2:0]));
	mux32_2x1 m3(.result(result), .operand1(mux1Wire), .operand2(mux2Wire), .control(control[3]));
endmodule

//32-bit 32x1 mux
module mux32_32x1(result, d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, 
	d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31, control);

	input [31:0] d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, 
	d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31;

	input [4:0] control;

	output [31:0] result;

	wire [31:0] mux1Wire, mux2Wire;

	mux32_16x1 m1(mux1Wire, d0, d1, d2, d3, d4, d5, d6, d7, 
		d8, d9, d10, d11, d12, d13, d14, d15, control[3:0]);

	mux32_16x1 m2(mux2Wire, d16, d17, d18, d19, d20, d21, d22, d23, 
		d24, d25, d26, d27, d28, d29, d30, d31, control[3:0]);

	mux32_2x1 m3(result, mux1Wire, mux2Wire, control[4]);
endmodule
