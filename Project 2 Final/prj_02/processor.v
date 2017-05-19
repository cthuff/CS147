// Name: processor.v
// Module: PROC_CS147_SEC05
// Output:  DATA : Data to be written at address ADDR
//          ADDR : Address of the memory location to be accessed
//          READ : Read signal
//          WRITE: Write signal
//
// Input:   DATA : Data read out in the read operation
//          CLK  : Clock signal
//          RST  : Reset signal
//
// Notes: - 32 bit processor implementing cs147sec05 instruction set
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//  1.1     Oct 19, 2014        Kaushik Patra   kpatra@sjsu.edu         Fixed the RF connection
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"
module PROC_CS147_SEC05(DATA, ADDR, READ, WRITE, CLK, RST);
// output list
output [`ADDRESS_INDEX_LIMIT:0] ADDR;
output READ, WRITE;
// input list
input  CLK, RST;
// inout list
inout [`DATA_INDEX_LIMIT:0] DATA;

// net section
wire [`DATA_INDEX_LIMIT:0] rf_data_w, rf_data_r1, rf_data_r2, alu_op1, alu_op2, alu_result;
wire [`ADDRESS_INDEX_LIMIT:0] rf_addr_w,  rf_addr_r1, rf_addr_r2;
wire [`ALU_OPRN_INDEX_LIMIT:0] alu_oprn;
wire rf_read, rf_write;
wire zero;

// instantiation section
// Control unit
CONTROL_UNIT cu_inst (.MEM_DATA(DATA),        .RF_DATA_W(rf_data_w),   .RF_ADDR_W(rf_addr_w),   .RF_ADDR_R1(rf_addr_r1), 
                      .RF_ADDR_R2(rf_addr_r2), .RF_READ(rf_read),       .RF_WRITE(rf_write),     .ALU_OP1(alu_op1), 
                      .ALU_OP2(alu_op2),      .ALU_OPRN(alu_oprn),     .MEM_ADDR(ADDR),          .MEM_READ(READ), 
                      .MEM_WRITE(WRITE),      .RF_DATA_R1(rf_data_r1), .RF_DATA_R2(rf_data_r2), .ALU_RESULT(alu_result), 
                      .ZERO(zero),            .CLK(CLK),               .RST(RST));
// register file
REGISTER_FILE_32x32 rf_inst (.DATA_R1(rf_data_r1), .DATA_R2(rf_data_r2), .ADDR_R1(rf_addr_r1), .ADDR_R2(rf_addr_r2), 
                             .DATA_W(rf_data_w),   .ADDR_W(rf_addr_w),   .READ(rf_read),      .WRITE(rf_write), 
                             .CLK(CLK),            .RST(RST));
// alu
ALU alu_inst (.OUT(alu_result), .ZERO(zero), .OP1(alu_op1), .OP2(alu_op2), .OPRN(alu_oprn));

endmodule;