`timescale 1ns / 1ps


//`include "PC.v"
//`include "Instruction_Memory.v"
//`include "Register_File.v"
//`include "Extend.v"
//`include "ALU.v"
//`include "Control_Unit_Top.v"
//`include "Data_Memory.v"
///`include "PC_Target.v"
//`include "Mux.v"

module RISCV_Single_Cycle(clk,rst_n);

    input clk,rst_n;

    wire [31:0] PC_Top,RD_Instr,RD1_Top,Imm_Ext_Top,ALUResult,ReadData,PCPlus4,RD2_Top,SrcB,Result;
    wire RegWrite,MemWrite,ALUSrc,;
    wire [1:0]ImmSrc,ResultSrc;
    wire [3:0]ALUControl_Top;
 
    PC PC(
        .clk(clk),
        .reset(rst),
        .PC(PC_Top),
        .PCNext(PCPlus4)
    );

    PC_Target PC_Adder(
                    .a(PC_Top),
                    .b(32'd4),
                    .c(PCPlus4)
    );
    
    Instruction_Memory Instruction_Memory(
                            .rst(rst),
                            .A(PC_Top),
                            .RD(RD_Instr)
    );

    Register_File Register_File(
                            .clk(clk),
                            .rst(rst),
                            .WE3(RegWrite),
                            .WD3(Result),
                            .RA1(RD_Instr[19:15]),
                            .RA2(RD_Instr[24:20]),
                            .WA3(RD_Instr[11:7]),
                            .RD1(RD1_Top),
                            .RD2(RD2_Top)
    );

    Extend Sign_Extend(
                        //.Instr(RD_Instr),
                        .Instr(RD_Instr[24:0]),
                        //.ImmSrc(ImmSrc[0]),
                        .ImmSrc(ImmSrc),    
                        .ImmExt(Imm_Ext_Top)
    );

    Mux Mux_Register_to_ALU(
                            .a(RD2_Top),
                            .b(Imm_Ext_Top),
                            .s(ALUSrc),
                            .c(SrcB)
    );

    ALU ALU(
            .A(RD1_Top),
            .B(SrcB),
            .Result(ALUResult),
            .ALUControl(ALUControl_Top),
            .Zero()
    );

    Control_Unit Control_Unit_Top(
                            .Op(RD_Instr[6:0]),
                            .RegWrite(RegWrite),
                            .ImmSrc(ImmSrc),
                            .ALUSrc(ALUSrc),
                            .MemWrite(MemWrite),
                            .ResultSrc(ResultSrc),
                            //.Branch(),
                            .funct3(RD_Instr[14:12]),
                             .funct7(RD_Instr[31:25]),
                            .ALUControl(ALUControl_Top)
    );

    Data_Memory Data_Memory(
                        .clk(clk),
                        .WE(MemWrite),
                        .WD(RD2_Top),
                        .A(ALUResult),
                        .RD(ReadData)
    );

    Mux Mux_DataMemory_to_Register(
                            .a(ALUResult),
                            .b(ReadData),
                            .s(ResultSrc),
                            .c(Result)
    );

endmodule
