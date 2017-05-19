`timescale 1ns/1ps
module a_bitRegester_tb;
	reg p, d, c, r, l;
	wire q1, q2;
	bit_regester b(q1, q2, p, d, l, c, r);
	initial begin
		p = 'b1;
		#5 l='b1;
		#5 d='b1; r='b1;
		#5 c='b1; 
		#5 c='b0;
		#5 
		#5 golden(q1, 'b1, l, d, r);

	end

	task golden; input result, expected, l, d, r; begin
		$write("l:%d d:%d r:%d= Exp-q:%d and Act-q:%d", l, p, r, expected, result);
		if (result==expected) begin			
			$write("[PASSED]");
		end else begin
			$write("[FAILED]");
		end 
		$write("\n");
		$write("Ran bitReg TB\n");
	end
	endtask
endmodule 
`timescale 1ns/1ps
module a_bitRegesterB_tb;
	reg p, d, c, r, l;
	wire q1, q2;
	bit_regester b(q1, q2, p, d, l, c, r);
	initial begin
		p = 'b1;
		#5 l='b0;
		#5 d='b1; r='b0;
		#5 c='b1; 
		#5 c='b0;
		#5 golden(q1, 'b0, l, d, r);

		#5 l='b1;
		#5 d='b1; r='b1;
		#5 c='b1; 
		#5 c='b0;
		#5 golden(q1, 'b1, l, d, r);

		#5 l='b0;
		#5 d='b0; r='b1;
		#5 c='b1; 
		#5 c='b0;
		#5 golden(q1, 'b1, l, d, r);

	end

	task golden; input result, expected, l, d, r; begin
		$write("l:%d d:%d r:%d= Exp-q:%d and Act-q:%d", l, p, r, expected, result);
		if (result==expected) begin			
			$write("[PASSED]");
		end else begin
			$write("[FAILED]");
		end 
		$write("\n");
		$write("Ran bitReg TB\n");
	end
	endtask
endmodule 
