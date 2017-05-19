// Name: barrel_shifter.v
// Module: SHIFT32_L , SHIFT32_R, SHIFT32
//
// Notes: 32-bit barrel shifter
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

// 32-bit shift amount shifter
module barrel_shifter(result, operand, shift, leftNotRight);
	input [31:0] operand;
	input [31:0] shift;
	input leftNotRight;
	output [31:0] result;
	wire [31:0] shiftOut0, shiftOut1, muxOut;
	wire orResult;

	right_shifter rs(.result(shiftOut0), .operand(operand), .shift(shift[4:0]));
	left_shifter ls(.result(shiftOut1), .operand(operand), .shift(shift[4:0]));

	mux32_2x1 m(.result(muxOut), .operand1(shiftOut0), 
		.operand2(shiftOut1), .control(leftNotRight));

	or31x1 or1(orResult, {5'b0,{shift[31:5]}});

	mux32_2x1 m1(.result(result), .operand1(muxOut), 
		.operand2(0), .control(orResult));
endmodule

//Left Shift
module left_shifter(result, operand, shift);
	input [31:0] operand;
	input [4:0] shift;
	output [31:0] result;
	wire mOut [3:0][31:0];

	genvar i, m, j, k;
	generate
		for (i=0; i<=31; i=i+1)
		begin : input_mux_gen_loop_
			if(i>0) begin
				mux m1(.result(mOut[0][i]), .operand1(operand[i]), .operand2(operand[i-1]), .control(shift[0]));
			end else begin
				mux m2(.result(mOut[0][i]), .operand1(operand[i]), .operand2(1'b0), .control(shift[0]));
			end
		end
		for (m=0; m<3; m=m+1)
		begin : inner_col_mux_gen_loop_
			for (k=0; k<=31; k=k+1)
			begin : inner_mux_gen_loop_
				if(k>=2**(m+1)) begin
					mux m3(.result(mOut[m+1][k]), .operand1(mOut[m][k]), .operand2(mOut[m][k-2**(m+1)]), .control(shift[m+1]));
				end else begin
					mux m4(.result(mOut[m+1][k]), .operand1(mOut[m][k]), .operand2(1'b0), .control(shift[m+1]));
				end
			end
		end
		for (j=0; j<=31; j=j+1)
		begin : result_mux_gen_loop_
			if(j>16) begin
				mux m5(.result(result[j]), .operand1(mOut[3][j]), .operand2(mOut[3][j-16]), .control(shift[4]));
			end else begin
				mux m6(.result(result[j]), .operand1(mOut[3][j]), .operand2(1'b0), .control(shift[4]));
			end
		end
	endgenerate
endmodule

//Right Shift
module right_shifter(result, operand, shift);
	input [31:0] operand;
	input [4:0] shift;
	output [31:0] result;
	wire mOut [3:0][31:0];

	genvar i, m, j, k;
	generate
		for (i=0; i<=31; i=i+1)
		begin : input_mux_gen_loop_
			if(i<31) begin
				mux m1(.result(mOut[0][i]), .operand1(operand[i]), .operand2(operand[i+1]), .control(shift[0]));
			end else begin
				mux m2(.result(mOut[0][i]), .operand1(operand[i]), .operand2(1'b0), .control(shift[0]));
			end
		end
		for (m=0; m<3; m=m+1)
		begin : inner_col_mux_gen_loop_
			for (k=0; k<=31; k=k+1)
			begin : inner_mux_gen_loop_
				if(k<32-2**(m+1)) begin
					mux m3(.result(mOut[m+1][k]), .operand1(mOut[m][k]), .operand2(mOut[m][k+2**(m+1)]), .control(shift[m+1]));
				end else begin
					mux m4(.result(mOut[m+1][k]), .operand1(mOut[m][k]), .operand2(1'b0), .control(shift[m+1]));
				end
			end
		end
		for (j=0; j<=31; j=j+1)
		begin : result_mux_gen_loop_
			if(j<16) begin
				mux m5(.result(result[j]), .operand1(mOut[3][j]), .operand2(mOut[3][j+16]), .control(shift[4]));
			end else begin
				mux m6(.result(result[j]), .operand1(mOut[3][j]), .operand2(1'b0), .control(shift[4]));
			end
		end
	endgenerate
endmodule
