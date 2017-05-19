`timescale 1ns/1ps
module a_codeTest_tb;
	reg [25:0] p; 
	reg [31:0] b, d, c, r;
	wire q1, q2;
	initial begin
		p='b1111;
		b={6'b000000,p};
		#5 golden(p, 'b0000001111);
		#5;
	end

	task golden; input result, expected; begin
		$write("Exp:%032b and Act:%032B", expected, result);
		if (result===expected) begin			
			$write("[PASSED]");
		end else begin
			$write("[FAILED]");
		end 
		$write("\n");
		$write("Ran code TB\n");
	end
	endtask
endmodule 
