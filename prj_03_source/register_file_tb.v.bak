// Name: proj_2_tb.v
// Module: RF_TB
// 
//
// Monitors:  DATA : Data to be written at address ADDR
//            ADDR : Address of the memory location to be accessed
//            READ : Read signal
//            WRITE: Write signal
//
// Input:   DATA : Data read out in the read operation
//          CLK  : Clock signal
//          RST  : Reset signal
//
// Notes: - Testbench for MEMORY_64MB memory system
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"
module a_RF_TB;
// Storage list
reg [`REG_ADDR_INDEX_LIMIT:0] ADDR_W;
reg [`REG_ADDR_INDEX_LIMIT:0] ADDR_R1;
reg [`REG_ADDR_INDEX_LIMIT:0] ADDR_R2;
// reset
reg READ, WRITE, RST;
// data register
reg [`DATA_INDEX_LIMIT:0] DATA_REG;
integer i; // index for memory operation
integer no_of_test, no_of_pass;
integer load_data;

// wire lists
wire  CLK;
wire [`DATA_INDEX_LIMIT:0] DATA_R1;
wire [`DATA_INDEX_LIMIT:0] DATA_R2;

// Clock generator instance
CLK_GENERATOR clk_gen_inst(.CLK(CLK));

// 64MB memory instance
REGISTER_FILE_32x32 ref_32x32_inst(.DATA_R1(DATA_R1), .DATA_R2(DATA_R2), .ADDR_R1(ADDR_R1), 
                                   .ADDR_R2(ADDR_R2), .DATA_W(DATA_REG), .ADDR_W(ADDR_W), 
                                   .READ(READ), .WRITE(WRITE), .CLK(CLK), .RST(RST));

initial
begin
	RST=1'b1;
	READ=1'b0;
	WRITE=1'b0;
	DATA_REG = {`DATA_WIDTH{1'b0} };
	ADDR_R1 = {`DATA_WIDTH{1'b0} };
	ADDR_R2 = {`DATA_WIDTH{1'b0} };

	ADDR_W=1'b1;
	READ=0;
	WRITE=0;
	DATA_REG=1;

	no_of_test = 0;
	no_of_pass = 0;

	// Start the operation
	#10    RST=1'b0;
	#10    RST=1'b1;
	// Write cycle
	for(i=0;i<31; i = i + 1)
	begin
		#10     DATA_REG=i; READ=1'b0; WRITE=1'b1; ADDR_W=i;
	end
	#5 
	#5 
	#5 READ=1'b0; WRITE=1'b0;
	#5 
	// test of write data
	for(i=0;i<31; i = i + 1) begin
		#5      READ=1'b1; WRITE=1'b0; ADDR_R1 = i; ADDR_R2 = i;
		#5      no_of_test = no_of_test + 1;
	        if (DATA_R1 !== i)
		    $write("[TEST @ %0dns] Read %1b, Write %1b, expecting %8h, got %8h [FAILED]\n", $time, READ, WRITE, i, DATA_R1);
	        else 
		    no_of_pass  = no_of_pass + 1;
	end


	#5    READ=1'b0; WRITE=1'b0; // No op

	#10 $write("\n");
	    $write("\tTotal number of tests %d\n", no_of_test);
	    $write("\tTotal number of pass  %d\n", no_of_pass);
	    $write("\n");
	    $stop;

	end
endmodule
