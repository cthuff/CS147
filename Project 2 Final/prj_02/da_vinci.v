// Name: da_vinci.v
// Module: DA_VINCI
// 
// Outputs are for testbench observations only
//
// Output:  DATA : Data to be written at address ADDR
//          ADDR : Address of the memory location to be accessed
//          READ : Read signal
//          WRITE: Write signal
//
// Input:   DATA : Data read out in the read operation
//          CLK  : Clock signal
//          RST  : Reset signal
//
// Notes: - 32 bit bareminimum computer system DA_VINCI_v1.0 implementing cs147sec05 instruction set
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"
module DA_VINCI (DATA, ADDR, READ, WRITE, CLK, RST);
// Parameter for the memory initialization file name
parameter mem_init_file = "mem_content_01.dat";
// output list
output [`ADDRESS_INDEX_LIMIT:0] ADDR;
output READ, WRITE;
// input list
input  CLK, RST;
// inout list
inout [`DATA_INDEX_LIMIT:0] DATA;

// Instance section
// Processor instance
PROC_CS147_SEC05 processor_inst(.DATA(DATA),   .ADDR(ADDR), .READ(READ), 
                                .WRITE(WRITE), .CLK(CLK),   .RST(RST));
// memory instance
defparam memory_inst.mem_init_file = mem_init_file;
MEMORY_64MB memory_inst(.DATA(DATA), .READ(READ), .WRITE(WRITE), 
                         .ADDR(ADDR), .CLK(CLK),   .RST(RST));
endmodule;