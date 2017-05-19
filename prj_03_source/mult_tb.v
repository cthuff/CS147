`timescale 1ns/1ps
module a_mult_tb;
	reg [31:0] operand1;
	reg [31:0] operand2;
	wire [31:0] resultHigh;
	wire [31:0] resultLow;
	mult m(resultHigh, resultLow, operand1, operand2);
	initial begin
		#5;
		#5 operand1='b0; operand2='b0;
		#5 golden(resultHigh, resultLow,'b0, 'b0, operand1, operand2);
		#5;
		#5 operand1='b1; operand2='b0;
		#5 golden(resultHigh, resultLow,'b0, 'b0, operand1, operand2);
		#5;
		#5 operand1='b0; operand2='b1;
		#5 golden(resultHigh, resultLow,'b0, 'b0, operand1, operand2);
		#5;
		#5 operand1='b1; operand2='b1;
		#5 golden(resultHigh, resultLow,'b0, 'b1, operand1, operand2);
		#5;
		#5 operand1='b11; operand2='b1;
		#5 golden(resultHigh, resultLow,'b0, 'b11, operand1, operand2);
		#5;
		#5 operand1='b1111111111111111111111111111111; operand2='b1;
		#5 golden(resultHigh, resultLow,'b0, 'b1111111111111111111111111111111, operand1, operand2);
		#5;
		#5 operand1='hffffffff; operand2='b1;
		#5 golden(resultHigh, resultLow,'hffffffff, 'hffffffff, operand1, operand2);
		#5;
		#5 operand1='b10; operand2='b10;
		#5 golden(resultHigh, resultLow,'b0, 'b100, operand1, operand2);
		#5;
		#5 operand1='b11; operand2='b11;
		#5 golden(resultHigh, resultLow,'b0, 'b1001, operand1, operand2);
		#5;
	end

	task golden;
		input [31:0] calculatedHigh;
		input [31:0] calculatedLow;
		input [31:0] expectedHigh;
		input [31:0] expectedLow;
		input [31:0] operand1;
		input [31:0] operand2;
		begin
			if (calculatedLow==expectedLow&&calculatedHigh==expectedHigh) begin
				$write("[PASSED]");
			end else begin
					$write("%d * %d = %d,%d got %d,%d", operand1, operand2, expectedHigh, expectedLow, calculatedHigh, calculatedLow);
					$write("[FAILED]");
			end 
			$write("\n");
			$write("Run mult TB\n");
		end
	endtask
endmodule
