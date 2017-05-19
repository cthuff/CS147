/** Name: processor.v
* Module: PROC_CS147_SEC05
* Output:  DATA : Data to be written at address ADDR
*          ADDR : Address of the memory location to be accessed
*          READ : Read signal
*          WRITE: Write signal
*
* Input:   DATA : Data read out in the read operation
*          CLK  : Clock signal
*          RST  : Reset signal
*
* Notes: - 32 bit processor implementing cs147sec05 instruction set
*
* Revision History:
*
* Version	Date		Who		email			note
*------------------------------------------------------------------------------------------
*  1.0     Sep 10, 2014	       Kaushik Patra   kpatra@sjsu.edu	       Initial creation
*------------------------------------------------------------------------------------------*/
`include "prj_definition.v"
module PROC_CS147_SEC05(DATA_OUT, ADDR, DATA_IN, READ, WRITE, CLK, RST);
	// output list 
	output [`ADDRESS_INDEX_LIMIT:0] ADDR;
	output [`DATA_INDEX_LIMIT:0] DATA_OUT;
	output READ, WRITE;
	// input list
	input  CLK, RST;
	input [`DATA_INDEX_LIMIT:0] DATA_IN;


	// net section
	wire ZERO;
	wire [`CTRL_WIDTH_INDEX_LIMIT:0] CTRL;
	wire [`DATA_INDEX_LIMIT:0] INSTRUCTION;



	// instantiation section
	// Control unit      (CTRL, READ, WRITE, ZERO, INSTRUCTION, CLK, RST)
	CONTROL_UNIT cu_inst (CTRL, READ, WRITE, ZERO, INSTRUCTION, CLK, RST);

	// data path		 (DATA_OUT, ADDR, ZERO, INSTRUCTION, DATA_IN, CTRL, CLK, RST)
	DATA_PATH data_path_inst (DATA_OUT, ADDR, ZERO, INSTRUCTION, DATA_IN, CTRL, CLK, RST);

endmodule
