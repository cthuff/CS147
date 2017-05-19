// Name: logic.v
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
// 64-bit two's complement
module twosComplement64(result, operand);
	input [63:0] operand;
	output [63:0] result;
	wire [63:0] notwire;
	wire notNeeded;
	reg add = 0;
	reg [63:0] uno = 64'b1;
	genvar i;
	for (i=0; i<64; i=i+1) begin : logic_loop
		not not1(notwire[i], operand[i]);
	end
	rc_add_sub_64 rc(result, notNeeded, notwire, uno, add);
endmodule
// 32-bit two's complement
module twosComplement(result, operand);
	input [31:0] operand;
	output [31:0] result;
	wire [31:0] notwire;
	wire notNeeded;
	reg add = 0;
	reg [31:0] uno = 32'b1;
	genvar i;
	for (i=0; i<32; i=i+1) begin : logic_loop
		not not1(notwire[i], operand[i]);
	end
	rc_add_sub_32 rc(result, notNeeded, notwire, uno, add);
endmodule
//32-bit buffer
module buf32(result, operand);
	input [31:0] operand;
	output [31:0] result;
	genvar i;
	for (i=0; i<32; i=i+1) begin : logic_loop
		buf nb(result[i], operand[i]);
	end
endmodule
//Nand 
module nand3(r, x, y, z);
	input x, y, z;
	output r;
	wire b [1:0];
	and a(b[0], x, y);
	and a2(b[1], b[0], z);
	not n(r, b[1]);
endmodule

//Flip-Flop 
module bitFlipFlop(q1, q2, p, d, clock, reset);
	input p, d, clock, reset;
	output q1, q2;
	wire bundle[9:0];
	wire notD, notClock, dOut1, dOut2;

	//d-latch
	not n1(notD, d);

	nand a1(bundle[2], d, clock);
	nand a2(bundle[3], notD, clock);

	nand3 a3(dOut1, p, bundle[2], dOut2);
	nand3 a4(dOut2, dOut1, bundle[3], reset);

	//sr-latch
	not n2(notClock, clock);

	nand a5(bundle[6], dOut1, notClock);
	nand a6(bundle[7], notClock, dOut2);

	nand3 a7(bundle[8], p, bundle[6], bundle[9]);
	nand3 a8(bundle[9], bundle[8], bundle[7], reset);

	buf b1(q1, bundle[8]);
	buf b2(q2, bundle[9]);
endmodule

module bit_regesterB(q1, q2, prts, d, l, clk, rst);
	input prts, d, l, clk, rst;
	output q1, q2;
	reg storage = 0;
	buf(q1, storage);
	always @ (posedge clk) begin
		if(rst===0) begin
			storage = 0;
		end else if (l===1) begin
			storage = d;
		end
	end
endmodule

module bit_regester(q1, q2, prts, d, l, clk, rst);
	input prts, d, l, clk, rst;
	output q1, q2;
	wire muxOut;
	wire flopOut;	
	mux m(muxOut, flopOut, d, l);

	bitFlipFlop b(flopOut, q2, prts, muxOut, clk, rst);
	buf(q1, flopOut);
endmodule
// 2x4 Line decoder
module lineDecoder2to4(d, b);
	input [1:0] b;
	output [3:0] d;
	wire [1:0] bundle;
	not n0(bundle[0], b[0]);
	not n1(bundle[1], b[1]);
	and a0(d[0], bundle[0], bundle[1]);
	and a1(d[1], bundle[1], b[0]);
	and a2(d[2], b[1], bundle[0]);
	and a3(d[3], b[1], b[0]);
endmodule
// 3x8 Line decoder
module lineDecoder3to8(d, b);
	input [2:0] b;
	output [7:0] d;
	wire [4:0] bundle;

	lineDecoder2to4 l(bundle[3:0], b[1:0]);

	not n0(bundle[4], b[2]);

	genvar i;
	for (i=0; i<4; i=i+1) begin : logic_loop
		and a1(d[i], bundle[i], bundle[4]);
		and a2(d[i+4], bundle[i], b[2]);
	end
endmodule
// 4x16 Line decoder
module lineDecoder4to16(d, b);
	input [3:0] b;
	output [15:0] d;
	wire [8:0] bundle;

	lineDecoder3to8 l(bundle[7:0], b[2:0]);

	not n0(bundle[8], b[3]);

	genvar i;
	for (i=0; i<8; i=i+1) begin : logic_loop
		and a1(d[i], bundle[i], bundle[8]);
		and a2(d[i+8], bundle[i], b[3]);
	end
endmodule

// 5x32 Line decoder
module lineDecoder5to32(d, b);
	input [4:0] b;
	output [31:0] d;
	wire [16:0] bundle;

	lineDecoder4to16 l(bundle[15:0], b[3:0]);

	not n0(bundle[16], b[4]);

	genvar i;
	for (i=0; i<16; i=i+1) begin : logic_loop
		and a1(d[i], bundle[i], bundle[16]);
		and a2(d[i+16], bundle[i], b[4]);
	end
endmodule

module logic(result, operand);
	input [63:0] operand;
	output [63:0] result;
	wire [63:0] notwire;
	wire notNeeded;
	reg add = 0;
	reg [63:0] uno = 32'b1;

	genvar i;
	for (i=0; i<63; i=i+1)
	begin : logic_loop
		not not1(notwire[i], operand[i]);
	end
	
	rc_add_sub_32 rc(.result(result), .carryOut(notNeeded),
		.operand1(notwire), .operand2(uno), .subtractNotAdd(add));

endmodule
//32-bir nor
module nor32(result, operand1, operand2);
	input [31:0] operand1, operand2;
	output [31:0] result;
	genvar i;
	generate
		for (i=0; i<32; i=i+1)
		begin : nor32_loop
			nor nor1(result[i], operand1[i], operand2[i]);
		end
	endgenerate
endmodule

//32-bit and
module and32(result, operand1, operand2);
	input [31:0] operand1, operand2;
	output [31:0] result;
	genvar i;
	generate
		for (i=0; i<32; i=i+1)
		begin : and32_loop
			and a1(result[i], operand1[i], operand2[i]);
		end
	endgenerate
endmodule

//32-bit inverter
module inv32(result, operand);
	input [31:0] operand;
	output [31:0] result;
	genvar i;
	generate
		for (i=0; i<32; i=i+1)
		begin : inv32_loop
			not not1(result[i], operand[i]);
		end
	endgenerate
endmodule

//1-bit or
module or31x1(result, operand);
	input [31:0] operand;
	wire [29:0] orWire;//2 less than op
	output result;
	or o0(orWire[0], operand[0], operand[1]);
	or o1(orWire[1], orWire[0], operand[2]);
	or o2(orWire[2], orWire[1], operand[3]);
	or o3(orWire[3], orWire[2], operand[4]);
	or o4(orWire[4], orWire[3], operand[5]);
	or o5(orWire[5], orWire[4], operand[6]);
	or o6(orWire[6], orWire[5], operand[7]);	or o7(orWire[7], orWire[6], operand[8]);
	or o8(orWire[8], orWire[7], operand[9]);
	or o9(orWire[9], orWire[8], operand[10]);
	or o10(orWire[10], orWire[9], operand[11]);
	or o11(orWire[11], orWire[10], operand[12]);
	or o12(orWire[12], orWire[11], operand[13]);
	or o13(orWire[13], orWire[12], operand[14]);
	or o14(orWire[14], orWire[13], operand[15]);
	or o15(orWire[15], orWire[14], operand[16]);
	or o16(orWire[16], orWire[15], operand[17]);
	or o17(orWire[17], orWire[16], operand[18]);
	or o18(orWire[18], orWire[17], operand[19]);
	or o19(orWire[19], orWire[18], operand[20]);
	or o20(orWire[20], orWire[19], operand[21]);
	or o21(orWire[21], orWire[20], operand[22]);
	or o22(orWire[22], orWire[21], operand[23]);
	or o23(orWire[23], orWire[22], operand[24]);
	or o24(orWire[24], orWire[23], operand[25]);
	or o25(orWire[25], orWire[24], operand[26]);
	or o26(orWire[26], orWire[25], operand[27]);
	or o27(orWire[27], orWire[26], operand[28]);
	or o28(orWire[28], orWire[27], operand[29]);
	or o29(orWire[29], orWire[28], operand[30]);
	or o30(result, orWire[29], operand[31]);
endmodule

//32-bit or
module or32(result, operand1, operand2);
	input [31:0] operand1, operand2;
	output [31:0] result;
	wire [31:0] norWire;
	nor32 n1(norWire, operand1, operand2);
	inv32 i1(result, norWire);
endmodule
