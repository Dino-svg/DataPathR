module BR(
    input clk,                 
    input [4:0] adrsReadA,
    input [4:0] adrsReadB,
    input [4:0] adrsWrite,
    input RegEn,
    input [31:0] write,
    output reg [31:0] readA,
    output reg [31:0] readB
);

reg [31:0] BR_in[0:31];

// Lectura asíncrona
always @(*) begin
    readA = BR_in[adrsReadA];
    readB = BR_in[adrsReadB];
end

// Escritura síncrona
always @(posedge clk) begin
    if (RegEn) begin
        BR_in[adrsWrite] <= write;
    end
end

endmodule
