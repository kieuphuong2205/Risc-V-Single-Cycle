`timescale 1ns / 1ps
module PC_Target(
		 input wire [31:0]  a,b,
		 output wire [31:0] c
		 );

   assign c= a + b;

endmodule
