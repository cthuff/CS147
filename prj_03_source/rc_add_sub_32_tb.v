`timescale 1ns/1ps
module a_rc_add_sub_32_tb;
	reg [31:0] operand1, operand2;
	reg subtractNotAdd;
	wire [31:0] result;
	wire carryOut;
	rc_add_sub_32 rc1(.result(result), .carryOut(carryOut),
		.operand1(operand1), .operand2(operand2), .subtractNotAdd(subtractNotAdd));
	initial begin
		#5 operand1 = 0; operand2 = 0; subtractNotAdd = 0; 
		#5 $write("\nOp1:%d Op2:%d sNa:%d \n\t= result:%d carryOut:%d\n", operand1, operand2, subtractNotAdd, result, carryOut);
		#5 operand1 = 0; operand2 = 0; subtractNotAdd = 1; 
		#5 $write("\nOp1:%d Op2:%d sNa:%d \n\t= result:%d carryOut:%d\n", operand1, operand2, subtractNotAdd, result, carryOut);
		#5 operand1 = 5; operand2 = 2; subtractNotAdd = 0; 
		#5 $write("\nOp1:%d Op2:%d sNa:%d \n\t= result:%d carryOut:%d\n", operand1, operand2, subtractNotAdd, result, carryOut);
		#5 operand1 = 5; operand2 = 2; subtractNotAdd = 1; 
		#5 $write("\nOp1:%d Op2:%d sNa:%d \n\t= result:%d carryOut:%d\n", operand1, operand2, subtractNotAdd, result, carryOut);
		#5 operand1 = 2; operand2 = 5; subtractNotAdd = 0; 
		#5 $write("\nOp1:%d Op2:%d sNa:%d \n\t= result:%d carryOut:%d\n", operand1, operand2, subtractNotAdd, result, carryOut);
		#5 operand1 = 2; operand2 = 5; subtractNotAdd = 1; 
		#5 $write("\nOp1:%d Op2:%d sNa:%d \n\t= result:%d carryOut:%d\n", operand1, operand2, subtractNotAdd, result, carryOut);
		#5 operand1 = 100; operand2 = 1000; subtractNotAdd = 0; 
		#5 $write("\nOp1:%d Op2:%d sNa:%d \n\t= result:%d carryOut:%d\n", operand1, operand2, subtractNotAdd, result, carryOut);
		#5 operand1 = 100; operand2 = 1000; subtractNotAdd = 1; 
		#5 $write("\nOp1:%d Op2:%d sNa:%d \n\t= result:%d carryOut:%d\n", operand1, operand2, subtractNotAdd, result, carryOut);
		#5 operand1 = 2147483647; operand2 = 2147483647; subtractNotAdd = 1; 
		#5 $write("\nOp1:%d Op2:%d sNa:%d \n\t= result:%d carryOut:%d\n", operand1, operand2, subtractNotAdd, result, carryOut);
		#5 operand1 = 2147483647; operand2 = 5; subtractNotAdd = 1; 
		#5 $write("\nOp1:%d Op2:%d sNa:%d \n\t= result:%d carryOut:%d\n", operand1, operand2, subtractNotAdd, result, carryOut);
	end
endmodule 
