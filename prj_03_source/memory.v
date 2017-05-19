// Name: memory.v
// Module: MEMORY_64MB
// Input:  DATA : Data to be written at address ADDR
//         ADDR : Address of the memory location to be accessed
//         READ : Read signal
//         WRITE: Write signal
//         CLK  : Clock signal
//         RST  : Reset signal
// Output: DATA : Data read out in the read operation
//
// Notes: - 32 bit word accessible 64MB memory.
//        - Reset is done at -ve edge of the RST signal
//        - Rest of the operation is done at the +ve edge of the CLK signal
//        - Read operation is done if READ=1 and WRITE=0
//        - Write operation is done if WRITE=1 and READ=0
//        - X is the value at DATA if both READ and WRITE are 0 or 1
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"
module MEMORY_WRAPPER(DATA_OUT, DATA_IN, READ, WRITE, ADDR, CLK, RST);
	
	parameter mem_init_file = "mem_content_01.dat";
	// output list
	output [`DATA_INDEX_LIMIT:0] DATA_OUT;
	//input list
	input [`DATA_INDEX_LIMIT:0] DATA_IN;
	input READ, WRITE, CLK, RST;
	input [`ADDRESS_INDEX_LIMIT:0] ADDR;

	reg  [`DATA_INDEX_LIMIT:0] DATA_OUT;
	wire [`DATA_INDEX_LIMIT:0] DATA;

	assign DATA = ((READ===1'b0)&&(WRITE===1'b1))?DATA_IN:{`DATA_WIDTH{1'bz} };

	defparam memory_inst.mem_init_file = mem_init_file;
	MEMORY_64MB memory_inst(.DATA(DATA), .READ(READ), .WRITE(WRITE), 
		.ADDR(ADDR), .CLK(CLK),   .RST(RST));

	initial begin
		DATA_OUT = 32'h00000000;
	end

	always @(negedge RST) begin
		if (RST === 1'b0)
			DATA_OUT = 32'h00000000;
	end


	always @(DATA) begin
	if ((READ===1'b1)&&(WRITE===1'b0))
		DATA_OUT=DATA;
	end

endmodule

module MEMORY_64MB(DATA_OUT, DATA_IN, READ, WRITE, ADDR, CLK, RST);
	
	parameter mem_init_file = "mem_content_01.dat";
	// input ports
	input READ, WRITE, CLK, RST;
	input [`ADDRESS_INDEX_LIMIT:0] ADDR;
	// inout ports
	input [`DATA_INDEX_LIMIT:0] DATA_IN;
	output [`DATA_INDEX_LIMIT:0] DATA_OUT;

	
	reg [`DATA_INDEX_LIMIT:0] sram_32x64m [0:`MEM_INDEX_LIMIT]; 
	integer i; 

	reg [`DATA_INDEX_LIMIT:0] data_ret; 

	assign DATA_OUT = ((READ===1'b1)&&(WRITE===1'b0))?data_ret:{`DATA_WIDTH{1'bz} };

	always @ (negedge RST or posedge CLK) begin
	if (RST === 1'b0) begin
		for(i=0;i<=`MEM_INDEX_LIMIT; i = i +1)
			sram_32x64m[i] = { `DATA_WIDTH{1'b0} };
		$readmemh(mem_init_file, sram_32x64m);
	end else begin
		if ((READ===1'b1)&&(WRITE===1'b0)) 
			data_ret =  sram_32x64m[ADDR];
		else if ((READ===1'b0)&&(WRITE===1'b1)) 
			sram_32x64m[ADDR] = DATA_IN;
		end
	end
endmodule
module SYSTEM_IMPLEMENTATION(CLK, RST);
	input CLK, RST;
	wire [31:0] DATA_OUT, DATA_IN;
	wire [25:0] ADDR;
	wire READ, WRITE;
	MEMORY_WRAPPER m(DATA_OUT, DATA_IN, READ, WRITE, ADDR, CLK, RST);
	PROC_CS147_SEC05(DATA_OUT, ADDR, DATA_IN, READ, WRITE, CLK, RST);
endmodule