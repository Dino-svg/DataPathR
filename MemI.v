module memoryInst(
    input [31:0]addrs,   
    output reg [31:0]instruction
);
 
reg [7:0]memory[999:0];

initial begin  
$readmemb("datos.txt", memory); 
$display("[MemI] Instrucciones cargadas. Primera instrucción: %h", 
             {memory[0], memory[1], memory[2], memory[3]}); 
end  

always @(*) begin
    instruction[31:24] = memory[addrs];
    instruction[23:16] = memory[addrs+1];
    instruction[15:8]  = memory[addrs+2];
    instruction[7:0]   = memory[addrs+3];
end

endmodule
