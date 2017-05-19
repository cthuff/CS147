// Name: proj_2_tb.v
// Module: DA_VINCI_TB
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
module MEM_64MB_TB;
// Storage list
reg [`ADDRESS_INDEX_LIMIT:0] ADDR;
// reset
reg READ, WRITE, RST;
// data register
reg [`DATA_INDEX_LIMIT:0] DATA_REG;
integer i; // index for memory operation
integer no_of_test, no_of_pass;
integer load_data;

// wire lists
wire  CLK;
wire [`DATA_INDEX_LIMIT:0] DATA;

assign DATA = ((READ===1'b0)&&(WRITE===1'b1))?DATA_REG:{`DATA_WIDTH{1'bz} };

// Clock generator instance
CLK_GENERATOR clk_gen_inst(.CLK(CLK));

// 64MB memory instance
defparam mem_inst.mem_init_file = "mem_content_01.dat";
MEMORY_64MB mem_inst(.DATA(DATA), .ADDR(ADDR), .READ(READ), 
                     .WRITE(WRITE), .CLK(CLK), .RST(RST));

initial
begin
RST=1'b1;
READ=1'b0;
WRITE=1'b0;
DATA_REG = {`DATA_WIDTH{1'b0} };
no_of_test = 0;
no_of_pass = 0;
load_data = 'h00414020;

// Start the operation
#10    RST=1'b0;
#10    RST=1'b1;
// Write cycle
for(i=1;i<10; i = i + 1)
begin
#10     DATA_REG=i; READ=1'b0; WRITE=1'b1; ADDR = i;
end

// Read Cycle
#10   READ=1'b0; WRITE=1'b0;
#5    no_of_test = no_of_test + 1;
      if (DATA !== {`DATA_WIDTH{1'bz}})
        $write("[TEST] Read %1b, Write %1b, expecting 32'hzzzzzzzz, got %8h [FAILED]\n", READ, WRITE, DATA);
      else 
	no_of_pass  = no_of_pass + 1;

// test of write data
for(i=0;i<10; i = i + 1)
begin
#5      READ=1'b1; WRITE=1'b0; ADDR = i;
#5      no_of_test = no_of_test + 1;
        if (DATA !== i)
	    $write("[TEST] Read %1b, Write %1b, expecting %8h, got %8h [FAILED]\n", READ, WRITE, i, DATA);
        else 
	    no_of_pass  = no_of_pass + 1;

end

// test for the initialize data
for(i='h001000; i<'h001010; i = i + 1)
begin
#5      READ=1'b1; WRITE=1'b0; ADDR = i;
#5      no_of_test = no_of_test + 1;
        if (DATA !== load_data)
            $write("[TEST] Read %1b, Write %1b, Addr %7h, expecting %8h, got %8h [FAILED]\n", 
                                                            READ, WRITE, ADDR, load_data, DATA);
        else 
            no_of_pass  = no_of_pass + 1;
        load_data = load_data + 1;
end
#10    READ=1'b0; WRITE=1'b0; // No op

#10 $write("\n");
    $write("\tTotal number of tests %d\n", no_of_test);
    $write("\tTotal number of pass  %d\n", no_of_pass);
    $write("\n");
    $writememh("mem_dump_01.dat", mem_inst.sram_32x64m, 'h0000000, 'h000000f);
    $writememh("mem_dump_02.dat", mem_inst.sram_32x64m, 'h0001000, 'h000100f);
    $stop;

end
endmodule

