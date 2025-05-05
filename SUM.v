module SUM( 
    input [31:0]addrs,
    output reg [31:0]addrsOut
);

always @(*) begin
    assign addrsOut= 4 + addrs;
end
endmodule
