`timescale 1ns/1ns

module DPTR(
	input clk,
	input wire [31:0] instruccion, 
    output wire [31:0] resultadoALU
);


wire [31:0] r1;				//Dato escritura BR y salida multiplexor
wire [5:0]  out_control;	//Salida de la unidad de control, se separa en varios bits.
wire [31:0] r2;				//Salida de Read Data 1 y entrada de OP1 de la ALU
wire [31:0] r3;				//Salida de Read Data 2, entrada de OP2 de la ALU y dato escritura de memoria.
wire [2:0]  r4;				//Salida de ALU control y entrada de ALUop
wire [31:0] r5;			    //Direccion de memoria de datos, entrada 2 de mux y salida de ALU
wire [31:0] r6;				//Dato entrada 2 demux y salida 1 buffer 1
wire [31:0] r7;				//Dato entrada 1 demux y dato de lectura.


BR 	inst_BR(.clk(clk), .adrsReadA(instruccion[25:21]), .adrsReadB(instruccion[20:16]), .adrsWrite(instruccion[15:11]), .RegEn(out_control[5]), .write(r1), .readA(r2), .readB(r3));
DataMem inst_memoria(.address(r5), .MemToWrite(out_control[1]), .dataWrite(r3), .dataRead(r7));
ALU  inst_ALU(.A(r2), .B(r3), .Sel(r4), .R(r5));
multiplexor inst_mux(.A_mux(r7), .B_mux(r5), .mux_sel(out_control[0]), .salida_mux(r1));
Unidad_control inst_control(.OPcode(instruccion[31:26]), .salida_control(out_control));
ALU_control	inst_AluControl(.op(instruccion[5:0]), .Op_in(out_control[4:2]), .Op_out(r4));

assign resultadoALU = r5;

endmodule
