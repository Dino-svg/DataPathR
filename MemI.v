module memoryInst(
    input [31:0]addrs,   
    output reg [31:0]instruction
);
 
reg [7:0]memory[999:0];

initial begin  
$readmemb("datos.txt", memory);  
end  

always @(*) begin
    instruction[31:24] = memory[addrs];
    instruction[23:16] = memory[addrs+1];
    instruction[15:8]  = memory[addrs+2];
    instruction[7:0]   = memory[addrs+3];
end

endmodule