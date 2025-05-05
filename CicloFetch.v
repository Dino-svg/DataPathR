`timescale 1ns/1ns

module Fetch(
  input clkF, 
  output reg [31:0]instructionF
  );

  wire [31:0] In_Wire, Out_Wire;
  wire [31:0] inst_Wire;

  SUM add(.addrs(Out_Wire), .addrsOut(In_Wire));
  PC pc(.dataIn(In_Wire), .clk(clkF), .dataOut(Out_Wire));
  memoryInst memI(.addrs(Out_Wire), .instruction(inst_Wire)); 
 
  assign instructionF = inst_Wire;

endmodule


module Fetch_TB();

  reg  clk_tb;
  wire [31:0]instruction_tb;
  
  Fetch CF(
    .clkF(clk_tb), 
    .instructionF(instruction_tb)
    );
  
  initial begin
	  
  clk_tb = 0;
	#10
	clk_tb = ~clk_tb;
	#10
	clk_tb = ~clk_tb;
	#10
	clk_tb = ~clk_tb;
	#10
	clk_tb = ~clk_tb;
	#10
	clk_tb = ~clk_tb;
	#10
	clk_tb = ~clk_tb;
	
  end

endmodule


