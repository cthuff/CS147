// Name: prj_definition.v
// Module: 
// Input: 
// Output: 
//
// Notes: Common definitions
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 02, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
`timescale 1ns/10ps

`define SYS_CLK_PERIOD 10
`define SYS_CLK_HALF_PERIOD (`SYS_CLK_PERIOD/2)
`define DATA_WIDTH 32
`define DATA_INDEX_LIMIT (`DATA_WIDTH -1)
`define ALU_OPRN_WIDTH 6
`define ALU_OPRN_INDEX_LIMIT (`ALU_OPRN_WIDTH -1)
`define ADDRESS_WIDTH 26
`define ADDRESS_INDEX_LIMIT (`ADDRESS_WIDTH -1)
`define MEM_SIZE (2 ** `ADDRESS_WIDTH)
`define MEM_INDEX_LIMIT (`MEM_SIZE - 1)
`define NUM_OF_REG 32
`define REG_INDEX_LIMIT (`NUM_OF_REG -1)
`define REG_ADDR_INDEX_LIMIT 4

// definition for processor state
`define PROC_FETCH    3'h0
`define PROC_DECODE   3'h1
`define PROC_EXE      3'h2
`define PROC_MEM      3'h3
`define PROC_WB       3'h4

// define ISA parameters
`define INST_START_ADDR 32'h00001000
`define INIT_STACK_POINTER 32'h03ffffff
