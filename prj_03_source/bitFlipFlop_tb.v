`timescale 1ns/1ps
module a_bitFlipFlop_tb;
	reg p, d, c, r;
	wire q1, q2;
	bitFlipFlop b(q1, q2, p, d, c, r);
	initial begin

		#5 d='b0; p='b0; r='b1;
		#5 c='b0; 
		#5 c='b1;
		#5 golden(q1, 'b1, c, d, p, r);
		#5;
		#5 d='b1; p='b0; r='b1;
		#5 c='b0; 
		#5 c='b1;
		#5 golden(q1, 'b1, c, d, p, r);
		#5;
		#5 d='b0; p='b1; r='b0;
		#5 c='b0; 
		#5 c='b1;
		#5 golden(q1, 'b0, c, d, p, r);
		#5;
		#5 d='b1; p='b1; r='b0;
		#5 c='b0; 
		#5 c='b1;
		#5 golden(q1, 'b0, c, d, p, r);
		#5;
	end

	task golden; input result, expected, c, d, p, r; begin
		$write("d:%d p:%d r:%d= Exp-q:%d and Act-q:%d", d, p, r, expected, result);
		if (result===expected) begin			
			$write("[PASSED]");
		end else begin
			$write("[FAILED]");
		end 
		$write("\n");
		$write("Ran bitFlipFlop TB\n");
	end
	endtask
endmodule 