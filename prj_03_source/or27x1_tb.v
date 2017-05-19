`timescale 1ns/1ps
module a_or27x1_tb;
	wire re;
	reg [27:0] operand;

	or27x1 o1(re, operand);
	initial begin
		#5;
		#5 operand=0;
		#5 golden(re, 0, operand);
		#5 operand=1;
		#5 golden(re, 1, operand);
		#5 operand=2;
		#5 golden(re, 1, operand);
		#5 operand=4;
		#5 golden(re, 1, operand);
		#5 operand=8;
		#5 golden(re, 1, operand);
		#5 operand=16;
		#5 golden(re, 1, operand);
		#5 operand=32;
		#5 golden(re, 1, operand);
		#5 operand=64;
		#5 golden(re, 1, operand);
		#5 operand=128;
		#5 golden(re, 1, operand);
		#5 operand=256;
		#5 golden(re, 1, operand);
		#5 operand=512;
		#5 golden(re, 1, operand);
		#5 operand=1024;
		#5 golden(re, 1, operand);
		#5 operand=2048;
		#5 golden(re, 1, operand);
		#5 operand=4096;
		#5 golden(re, 1, operand);
		#5 operand=8192;
		#5 golden(re, 1, operand);
		#5 operand=16384;
		#5 golden(re, 1, operand);
		#5 operand=32768;
		#5 golden(re, 1, operand);
		#5 operand=65536;
		#5 golden(re, 1, operand);
		#5 operand=131072;
		#5 golden(re, 1, operand);
		#5 operand=262144;
		#5 golden(re, 1, operand);
		#5 operand=524288;
		#5 golden(re, 1, operand);
		#5 operand=1048576;
		#5 golden(re, 1, operand);
		#5 operand=2097152;
		#5 golden(re, 1, operand);
		#5 operand=4194304;
		#5 golden(re, 1, operand);
		#5 operand=8388608;
		#5 golden(re, 1, operand);
		#5 operand=16777216;
		#5 golden(re, 1, operand);
		#5 operand=33554432;
		#5 golden(re, 1, operand);
		#5 operand=67108864;
		#5 golden(re, 1, operand);
		#5 operand=134217728;
		#5 golden(re, 1, operand);
		#5 operand=268435456;
		#5 golden(re, 0, operand);
	end
	task golden;
		input calculated;
		input expected;
		input [27:0] operand;
		begin
			if (calculated==expected) begin
				$write("[PASSED]");
			end else begin
			$write("%d results in %d got %d", operand, expected, calculated);
				$write("[FAILED]");
			end 
			$write("\n");
		end
	endtask
endmodule 