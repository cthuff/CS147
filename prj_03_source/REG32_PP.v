// 32-bit register with preset pattern
module REG32_PP(Q, D, LOAD, CLK, RESET);
	parameter PATTERN = 32'h00000000;
	output [31:0] Q;

	input CLK, LOAD;
	input [31:0] D;
	input RESET;

	wire [31:0] Q1;
	genvar i;
	generate 
	for(i=0; i<32; i=i+1) begin : reg32_gen_loop
		if (PATTERN[i] == 0) begin
			
			bit_regester reg_inst(Q[i], Q1[i], 1'b1, D[i], LOAD, CLK, RESET); 
		end else 
		begin
			bit_regester reg_inst(Q[i], Q1[i], RESET, D[i], LOAD, CLK, 1'b1);
		end
	end 
	endgenerate

endmodule

//------------------------------------------------------------------------------------------------------------------------------------------------
module a_REG32_SP_TB;
	reg [31:0] D;

	reg C, nR, L;

	wire [31:0] Q;

	defparam sp_inst.PATTERN=32'h03ffffff;
	REG32_PP sp_inst(.Q(Q), .D(D), .LOAD(L), .CLK(C), .RESET(nR));

	initial begin
		C=1'b0; D=32'ha5a5a5a5; L=1'b0; nR=1'b0;

		#10 nR=1'b1;
		#10 D=32'h00000000;
		#10 L=1'b1; 
		#15 D=32'ha5a5a5a5;
		#20 D=32'h5a5a5a5a;
		#10 L=1'b0; 
		#10 D=32'ha5a5a5a5;

		#20 $stop;
	end

	always begin
		#5 C = ~C;
	end

endmodule

//------------------------------------------------------------------------------------------------------------------------------------------------
module a_REG32_PC_TB;
	reg [31:0] D;

	reg C, nR, L;

	wire [31:0] Q;
	

	REG32_PP pc_inst(.Q(Q), .D(D), .LOAD(L), .CLK(C), .RESET(nR));
	defparam pc_inst.PATTERN=32'h00001000;

	initial begin
		C=1'b0; D=32'ha5a5a5a5; L=1'b0; nR=1'b0;

		#10 nR=1'b1;
		#10 D=32'h00000000;
		#10 L=1'b1; 
		#15 D=32'ha5a5a5a5;
		#20 D=32'h5a5a5a5a;
		#10 L=1'b0; 
		#10 D=32'ha5a5a5a5;

		#20 $stop;
	end

	always begin
		#5 C = ~C;
	end

endmodule