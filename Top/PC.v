`timescale 1ns / 1ps

module PC (	
		input wire 	   clk,reset,
		input wire [31:0]  PCNext,
		output wire [31:0] PC );
   
		reg [31:0] PCReg;

   always@(posedge clk or posedge reset)
     begin
	if (reset) 
		PCReg <= 0;
	else 
		PCReg <= PCNext;
     end	

   assign PC = PCReg;

endmodule
