`timescale 1ns/1ps
module a_logic_tb;
	reg [31:0] operand;
	wire [31:0] result;
	logic l1(.result(result), .operand(operand));
	initial begin
		operand=32'b0;

		#5 operand=32'b1;
		#5 operand=32'b10;
		#5 operand=32'b11;
		#5;
	end
endmodule 

