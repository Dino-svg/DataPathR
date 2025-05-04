module Unidad_control(
    input wire [5:0] OPcode,
    output reg [5:0] salida_control
);

// Bit 5: RegWrite (1 para Tipo R)
// Bits 4-2: ALUop (010 para Tipo R)
// Bit 1: MemToWrite (0 para Tipo R)
// Bit 0: MemToReg (1 para Tipo R, resultado de ALU)
always @(*) begin
    case (OPcode)
        6'b000000: salida_control = 6'b1_010_0_1;  // Instrucciones Tipo R
        default:   salida_control = 6'b0_000_0_0;  // Default seguro
    endcase
end

endmodule



