`timescale 1ns/1ps
module a_left_shift_tb;
	reg [31:0] operand;
	reg [4:0] shift;
	wire [31:0] result;
	left_shifter ls(.result(result), .operand(operand), .shift(shift));
	initial begin
		#5;
		#5 operand='b1; shift='b1;
		#5 golden(result,'b10, operand, shift);
		#5 operand='b10000000000000000000000000000000; shift='b1;
		#5 golden(result, 'b100000000000000000000000000000000, operand, shift);
		#5 operand='b10; shift='b10;
		#5 golden(result,'b1000, operand, shift);
		#5 operand='b100; shift='b10;
		#5 golden(result,'b10000, operand, shift);
		#5 operand='b100; shift='b11;
		#5 golden(result,'b100000, operand, shift);
		#5 operand='b11000; shift='b11;
		#5 golden(result,'b11000000, operand, shift);
		#5 operand='b10000000000000000000000000000000; shift='b1;
		#5 golden(result,'b100000000000000000000000000000000, operand, shift);
		#5 operand='b1; shift='b101;
		#5 golden(result,'b100000, operand, shift);
		#5 operand='b10000000000000000000000000000000; shift='b1;
		#5 golden(result,'b100000000000000000000000000000000, operand, shift);
		#5 operand='b10; shift='b10000;
		#5 golden(result,'b100000000000000000, operand, shift);
		#5 operand='b100; shift='b10;
		#5 golden(result,'b10000, operand, shift);
		#5 operand='b100; shift='b11;
		#5 golden(result,'b100000, operand, shift);
		#5 operand='b11111111111111000; shift='b10000;
		#5 golden(result,'b111111111111110000000000000000000, operand, shift);
		#5 operand='b11111111111111111111111111111111 ; shift='b1;
		#5 golden(result,'b11111111111111111111111111111110, operand, shift);
		#5 operand='b11111111111111111111111111111111; shift='b10;
		#5 golden(result,'b11111111111111111111111111111100, operand, shift);
		#5 operand='b11111111111111111111111111111111; shift='b11111;
		#5 golden(result,'b10000000000000000000000000000000, operand, shift);
		#5 operand='b10000000000000000000000000000000; shift='b11111;
		#5 golden(result,'b0, operand, shift);
		#5 operand='b10000000000000000000000000000000; shift='b1;
		#5 golden(result,'b0, operand, shift);
	end

	task golden;
		input [31:0] calculated;
		input [31:0] expected;
		input [31:0] operand;
		input [5:0] shift;
		begin
			if (calculated==expected) begin
				$write("[PASSED]");
			end else begin
			$write("%d << %d = %d got %d", operand, shift, expected, calculated);
				$write("[FAILED]");
			end 
			$write("\n");
		end
	endtask
endmodule 