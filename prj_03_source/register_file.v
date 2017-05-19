/* Name: register_file.v
 Module: REGISTER_FILE_32x32
 Input:  DATA_W : Data to be written at address ADDR_W
         ADDR_W : Address of the memory location to be written
         ADDR_R1 : Address of the memory location to be read for DATA_R1
         ADDR_R2 : Address of the memory location to be read for DATA_R2
         READ    : Read signal
         WRITE   : Write signal
         CLK     : Clock signal
         RST     : Reset signal
 Output: DATA_R1 : Data at ADDR_R1 address
         DATA_R2 : Data at ADDR_R1 address

 Notes: - 32 bit word accessible dual read register file having 32 regsisters.
        - Reset is done at -ve edge of the RST signal
        - Rest of the operation is done at the +ve edge of the CLK signal
        - Read operation is done if READ=1 and WRITE=0
        - Write operation is done if WRITE=1 and READ=0
        - X is the value at DATA_R* if both READ and WRITE are 0 or 1

 Revision History:

 Version	Date		Who		email			note
------------------------------------------------------------------------------------------
  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
------------------------------------------------------------------------------------------*/
`include "prj_definition.v"
module REGISTER_FILE_32x32(DATA_R1, DATA_R2, ADDR_R1, ADDR_R2, 
                            DATA_W, ADDR_W, READ, WRITE, CLK, RST);

// input list
input READ, WRITE, CLK, RST;
input [`DATA_INDEX_LIMIT:0] DATA_W;
input [`REG_ADDR_INDEX_LIMIT:0] ADDR_R1, ADDR_R2, ADDR_W;

// output list
output [`DATA_INDEX_LIMIT:0] DATA_R1;
output [`DATA_INDEX_LIMIT:0] DATA_R2;

wire nRST;

	wire [31:0] decoderBundle, andBundle, reg1Bundle, reg2Bundle;
	wire [31:0] bigBundle [31:0];
	lineDecoder5to32 l(decoderBundle, ADDR_W);
	not n(nRST,RST);
	genvar i;
	for (i=0; i<32; i=i+1) begin : reg32_loop
		and a(andBundle[i], decoderBundle[i], WRITE);
		bit32_regester r(bigBundle[i], CLK, andBundle[i], DATA_W, nRST);
	end
	mux32_32x1 m1(reg1Bundle, bigBundle[0], bigBundle[1], bigBundle[2], bigBundle[3], 
		bigBundle[4],  bigBundle[5],  bigBundle[6],  bigBundle[7],  bigBundle[8],  
		bigBundle[9],  bigBundle[10], bigBundle[11], bigBundle[12], bigBundle[13], 
		bigBundle[14], bigBundle[15], bigBundle[16], bigBundle[17], bigBundle[18], 
		bigBundle[19], bigBundle[20], bigBundle[21], bigBundle[22], bigBundle[23], 
		bigBundle[24], bigBundle[25], bigBundle[26], bigBundle[27], bigBundle[28], 
		bigBundle[29], bigBundle[30], bigBundle[31], ADDR_R1);
	mux32_32x1 m2(reg2Bundle, bigBundle[0], bigBundle[1], bigBundle[2], bigBundle[3], 
		bigBundle[4],  bigBundle[5],  bigBundle[6],  bigBundle[7],  bigBundle[8], 
		bigBundle[9],  bigBundle[10], bigBundle[11], bigBundle[12], bigBundle[13], 
		bigBundle[14], bigBundle[15], bigBundle[16], bigBundle[17], bigBundle[18], 
		bigBundle[19], bigBundle[20], bigBundle[21], bigBundle[22], bigBundle[23], 
		bigBundle[24], bigBundle[25], bigBundle[26], bigBundle[27], bigBundle[28], 
		bigBundle[29], bigBundle[30], bigBundle[31], ADDR_R2);
	mux32_2x1 m3(DATA_R1, 32'bZ, reg1Bundle, READ);
	mux32_2x1 m4(DATA_R2, 32'bZ, reg2Bundle, READ);
endmodule
/**
*
*/
module bit32_regester(q, clk, load, d, reset);
	input clk, load, reset;
	input [31:0] d;
	output [31:0] q;
	wire q2;
	wire notR;
	
	genvar i;
	generate
		for (i=0; i<32; i=i+1) begin : bitreg_gen_loop
			//not n(notR, reset);
			bit_regesterB r(q[i], q2, 1'b1, d[i], load, clk, notR);
		end
	endgenerate
endmodule

