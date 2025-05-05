`timescale 1ns/1ns

module MIPS_Top(
    input wire clk,
    output wire [31:0] resultadoFinal  // Monitorizar $20
);

wire [31:0] instruccionActual;

// Etapa Fetch
Fetch fetchStage (
    .clkF(clk),
    .instructionF(instruccionActual)
);

// Etapa DataPath
DPTR DataPathTipoR (
    .clk(clk),
    .instruccion(instruccionActual),
    .resultadoALU(resultadoFinal)  // Conectado a $20
);

endmodule

module MIPS_Top_TB();

reg clk;
wire [31:0] resultado;

MIPS_Top dut(.clk(clk), .resultadoFinal(resultado));

// Generación de reloj (10ns periodo)
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Verificación de resultados
initial begin
    #60;  // Esperar ejecución de Sub $20 $15 $9 ($20 = 999 - 100 = 899)
    if (resultado == 32'd899) begin
        $display("✅ $20 = %d (Correcto)", resultado);
    end else begin
        $display("❌ $20 = %d (Debería ser 899)", resultado);
    end
    #40;  // Esperar Add $15 $5 $15 ($15 = 20 + 999 = 1019)
    $display("$15 = %d", dut.DataPathTipoR.inst_BR.BR_in[15]);
    $finish;
end

endmodule