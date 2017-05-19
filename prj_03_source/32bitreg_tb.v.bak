`timescale 1ns/1ps
module a_32bitRegester_tb;
	wire q;
	reg c, l, r;
	reg [31:0] d;

	bit32_regester b(q, c, l, d, r);

	initial begin
		#5 d='h00000000; r='b1; l='b0;
		#5 c='b0; 
		#5 c='b1;
		#5 golden(q, 'h00000000, l, d, r);
		#5;
		#5 d='h00000001; r='b0; l='b1;
		#5 c='b0; 
		#5 c='b1;
		#5 golden(q, 'h00000001, l, d, r);
		#5;
		#5 d='h00000111; r='b0; l='b0;
		#5 c='b0; 
		#5 c='b1;
		#5 golden(q, 'h00000001, l, d, r);
		#5;

	end
	task golden; input result, expected, l, d, r; begin
			$write("d:%d r:%d l:%d so Exp-q:%d and Act-q:%d ", d, r, l, expected, result);
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