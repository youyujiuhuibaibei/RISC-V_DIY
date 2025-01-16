# riscv_assembler.py

def parse_register(reg):
    """解析寄存器名，返回其编号"""
    if reg.startswith("x") and reg[1:].isdigit():
        return int(reg[1:])
    else:
        raise ValueError(f"Invalid register name: {reg}")

def imm_to_bin(imm, bits):
    """将立即数转换为指定位数的二进制，支持符号扩展"""
    if imm < 0:
        imm = (1 << bits) + imm  # 符号扩展
    return f"{imm:0{bits}b}"[-bits:]

def assemble_line(line):
    """将一行汇编指令转换为机器码"""
    parts = line.strip().split()
    if not parts:
        return None  # 空行
    inst = parts[0]
    opcode_map = {
        # R 型指令
        "add": ("0110011", "000", "0000000"),
        "sub": ("0110011", "000", "0100000"),
        "xor": ("0110011", "100", "0000000"),
        "or": ("0110011", "110", "0000000"),
        "and": ("0110011", "111", "0000000"),
        "sll": ("0110011", "001", "0000000"),
        "srl": ("0110011", "101", "0000000"),
        "sra": ("0110011", "101", "0100000"),
        "slt": ("0110011", "010", "0000000"),
        "sltu": ("0110011", "011", "0000000"),
        # I 型指令
        "addi": ("0010011", "000"),
        "xori": ("0010011", "100"),
        "ori": ("0010011", "110"),
        "andi": ("0010011", "111"),
        "slti": ("0010011", "010"),
        "sltiu": ("0010011", "011"),
        "lb": ("0000011", "000"),
        "lh": ("0000011", "001"),
        "lw": ("0000011", "010"),
        "lbu": ("0000011", "100"),
        "lhu": ("0000011", "101"),
        "jalr": ("1100111", "000"),
        # S 型指令
        "sb": ("0100011", "000"),
        "sh": ("0100011", "001"),
        "sw": ("0100011", "010"),
        # B 型指令
        "beq": ("1100011", "000"),
        "bne": ("1100011", "001"),
        "blt": ("1100011", "100"),
        "bge": ("1100011", "101"),
        "bltu": ("1100011", "110"),
        "bgeu": ("1100011", "111"),
        # U 型指令
        "lui": ("0110111",),
        "auipc": ("0010111",),
        # J 型指令
        "jal": ("1101111",),
        # 特殊指令
        "nop": ("0010011", "000"),  # 相当于 addi x0, x0, 0
    }

    if inst in ["add", "sub", "xor", "or", "and", "sll", "srl", "sra", "slt", "sltu"]:  # R 型指令
        opcode, funct3, funct7 = opcode_map[inst]
        rd = parse_register(parts[1])
        rs1 = parse_register(parts[2])
        rs2 = parse_register(parts[3])
        return f"{funct7}{rs2:05b}{rs1:05b}{funct3}{rd:05b}{opcode}"

    elif inst in ["addi", "xori", "ori", "andi", "slti", "sltiu", "lb", "lh", "lw", "lbu", "lhu", "jalr"]:  # I 型指令
        opcode, funct3 = opcode_map[inst]
        rd = parse_register(parts[1])
        rs1 = parse_register(parts[2])
        imm = int(parts[3], 0)
        return f"{imm_to_bin(imm, 12)}{rs1:05b}{funct3}{rd:05b}{opcode}"

    elif inst in ["sb", "sh", "sw"]:  # S 型指令
        opcode, funct3 = opcode_map[inst]
        rs2 = parse_register(parts[1])
        rs1 = parse_register(parts[2])
        imm = int(parts[3], 0)
        imm_11_5 = imm_to_bin(imm, 12)[:7]
        imm_4_0 = imm_to_bin(imm, 12)[-5:]
        return f"{imm_11_5}{rs2:05b}{rs1:05b}{funct3}{imm_4_0}{opcode}"

    elif inst in ["beq", "bne", "blt", "bge", "bltu", "bgeu"]:  # B 型指令
        opcode, funct3 = opcode_map[inst]
        rs1 = parse_register(parts[1])
        rs2 = parse_register(parts[2])
        imm = int(parts[3], 0)
        imm_bin = imm_to_bin(imm, 13)
        imm_12 = imm_bin[0]
        imm_10_5 = imm_bin[1:7]
        imm_4_1 = imm_bin[7:11]
        imm_11 = imm_bin[11]
        return f"{imm_12}{imm_10_5}{rs2:05b}{rs1:05b}{funct3}{imm_4_1}{imm_11}{opcode}"

    elif inst in ["lui", "auipc"]:  # U 型指令
        opcode = opcode_map[inst][0]
        rd = parse_register(parts[1])
        imm = int(parts[2], 0)
        return f"{imm_to_bin(imm, 20)}{rd:05b}{opcode}"

    elif inst == "jal":  # J 型指令
        opcode = opcode_map[inst][0]
        rd = parse_register(parts[1])
        imm = int(parts[2], 0)
        imm_bin = imm_to_bin(imm, 21)
        imm_20 = imm_bin[0]
        imm_10_1 = imm_bin[10:20]
        imm_11 = imm_bin[9]
        imm_19_12 = imm_bin[1:9]
        return f"{imm_20}{imm_10_1}{imm_11}{imm_19_12}{rd:05b}{opcode}"

    elif inst == "nop":  # 特殊指令
        return "00000000000000000000000000010011"  # addi x0, x0, 0

    else:
        raise ValueError(f"Unsupported instruction: {inst}")

def assemble_file(input_file, output_file):
    """读取汇编代码文件并转换为机器码"""
    with open(input_file, "r") as asm_file, open(output_file, "w") as output:
        for line in asm_file:
            line = line.strip()
            if not line or line.startswith("#"):  # 跳过空行和注释
                continue
            try:
                machine_code = assemble_line(line)
                if machine_code:
                    output.write(f"{int(machine_code, 2):08x}\n")  # 转为十六进制
            except Exception as e:
                print(f"Error processing line: {line}\n{e}")

if __name__ == "__main__":
    input_file = "asm.txt"
    output_file = "output.txt"
    assemble_file(input_file, output_file)
    print(f"Assembly converted to machine code and saved to {output_file}")
