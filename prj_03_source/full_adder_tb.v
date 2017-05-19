`timescale 1ns/1ps
module a_full_adder_tb;
	reg operand1, operand2, carryIn;
	wire sum, carryOut;
	full_adder fa1(sum, carryOut,
		operand1, operand2, carryIn);
	initial begin
		operand1=0; operand2=0; carryIn=0;
		#5 operand1=1; operand2=0; carryIn=0;
		#5 operand1=0; operand2=1; carryIn=0;
		#5 operand1=1; operand2=1; carryIn=0;
		#5 operand1=0; operand2=0; carryIn=1;
		#5 operand1=1; operand2=0; carryIn=1;
		#5 operand1=0; operand2=1; carryIn=1;
		#5 operand1=1; operand2=1; carryIn=1;
		#5;
	end
endmodule 
