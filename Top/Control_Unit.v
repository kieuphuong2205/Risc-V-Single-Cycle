`timescale 1ns / 1ps

module Control_Unit(
		    input wire [6:0]  Op,
		    input wire [2:0]  funct3,
		    //input wire	      funct7, Zero, // function 7 is the 5th bit
		    input wire [6:0] funct7,
	            input wire Zero, 
		    output wire [1:0] ResultSrc,
		    output wire	      MemWrite, PCSrc, ALUSrc, RegWrite,Jump,
		    output wire [1:0] ImmSrc,
		    output wire [3:0] ALUControl
		    );

   wire [1:0]			      ALUop;
   wire				      Branch;
   
   Main_Decoder Main_Decoder(
  			     .op(Op),
			     .ResultSrc(ResultSrc),
			     .MemWrite(MemWrite),
			     .Branch(Branch),
  			     .ALUSrc(ALUSrc),
			     .RegWrite(RegWrite),
  			     .Jump(Jump),
			     .ImmSrc(ImmSrc),
			     .ALUop(ALUop) );
   
   ALU_Decoder ALU_Decoder(
  			   .opb5(Op[5]),
			   .funct3(funct3),
			   .funct7b5(funct7),
			   .ALUOp(ALUop),
			   .ALUControl(ALUControl) );
   
   //for branches beq, bne, blt, bge, bltu, bgeu
   //make modifications later - get sign from ALU, make conditions for all branches  
  
   assign PCSrc = Branch & Zero | Jump;
    
   
endmodule
