`timescale 1ns/1ps
module half_adder_tb;
	reg A, B;
	wire Y, C;
	half_adder ha_inst_1(.sum(Y), .carry(C), .operand1(A), .operand2(B));
	initial begin
		A=0; B=0;
		#5 A=0; B=1;
		#5 A=1; B=0;
		#5 A=1; B=1;
		#5;
	end
endmodule 