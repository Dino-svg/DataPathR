module BR(
	input  wire[4:0]adrsReadA,
	input  wire[4:0]adrsReadB,
	input  wire[4:0]adrsWrite,
	input  wire RegEn,
	input  wire[31:0] write,
	output reg [31:0] readA,
	output reg [31:0] readB
);

reg [31:0]BR_in[0:31];

always@(*)
	begin
	readA = BR_in[adrsReadA];
	readB = BR_in[adrsReadB];
	
	if(RegEn)
	begin
		BR_in[adrsWrite] = write;
	end
	
end
endmodule
