"""Conversor ASM->binario"""
import tkinter as tk
from tkinter import filedialog, messagebox

# Mapeo completo según tu arquitectura
inst_map = {
    # Formato: OPCODE (6b) | rs (5b) | rt (5b) | rd (5b) | shamt (5b) | funct (6b)
    "ADD": {"opcode": "000000", "funct": "100000", "type": "R"},
    "SUB": {"opcode": "000000", "funct": "100010", "type": "R"},
    "SLT": {"opcode": "000000", "funct": "101010", "type": "R"},
    "SW":  {"opcode": "101011", "type": "I"}  # Ejemplo de tipo I
}

def convert_asm_to_bin(asm_line):
    parts = asm_line.strip().split()
    if not parts:
        return None
    
    inst = parts[0].upper()
    if inst not in inst_map:
        return None
    
    # Procesamiento según tipo de instrucción
    if inst_map[inst]["type"] == "R":
        # Formato: opcode rs rt rd shamt funct
        rs = f"{int(parts[2][1:]):05b}"  # $num -> num -> 5b
        rt = f"{int(parts[3][1:]):05b}"
        rd = f"{int(parts[1][1:]):05b}"
        shamt = "00000"  # No usado
        return f"{inst_map[inst]['opcode']}{rs}{rt}{rd}{shamt}{inst_map[inst]['funct']}"
    else:  # Tipo I
        # Implementar para SW/LW si es necesario
        pass

def convert_file():
    input_file = entry_path.get()
    if not input_file:
        messagebox.showwarning("Error", "Seleccione un archivo primero")
        return
    
    try:
        with open(input_file) as f:
            lines = f.readlines()
        
        binary_lines = []
        for line in lines:
            binary = convert_asm_to_bin(line)
            if binary:
                binary_lines.append(binary)
        
        output_file = filedialog.asksaveasfilename(
            defaultextension=".mem",
            filetypes=[("Memory files", "*.mem"), ("All files", "*.*")]
        )
        
        if output_file:
            with open(output_file, "w") as f:
                f.write("\n".join(binary_lines))
            messagebox.showinfo("Éxito", f"Archivo convertido:\n{output_file}")
    
    except Exception as e:
        messagebox.showerror("Error", f"Error en conversión:\n{str(e)}")

def seleccionar_archivo():
    ruta = filedialog.askopenfilename(
        filetypes=[("Archivos ASM", "*.asm"), ("Todos los archivos", "*.*")]
    )
    if ruta:
        entry_path.delete(0, tk.END)
        entry_path.insert(0, ruta)
        try:
            with open(ruta, "r") as f:
                contenido = f.read()
                text_area.delete("1.0", tk.END)
                text_area.insert(tk.END, contenido)
        except Exception as e:
            messagebox.showerror("Error", f"No se pudo leer el archivo:\n{str(e)}")

root = tk.Tk()
root.title("Conversor ASM a Binario - ")

tk.Label(root, text="Archivo ASM:").pack(pady=5)
entry_path = tk.Entry(root, width=50)
entry_path.pack(padx=10, pady=5)
tk.Button(root, text="Seleccionar", command=lambda: seleccionar_archivo()).pack(pady=5)
tk.Button(root, text="Convertir", command=convert_file).pack(pady=10)

text_area = tk.Text(root, height=15, width=60)
text_area.pack(padx=10, pady=5)

root.mainloop()
