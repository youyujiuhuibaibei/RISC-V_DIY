//指令分类
//type_R
`define opcode_R        0110011

`define funct3_add      0x0
`define funct3_sub      0x0
`define funct3_xor      0x4
`define funct3_or       0x6
`define funct3_and      0x7
`define funct3_sll      0x1
`define funct3_srl      0x5
`define funct3_sra      0x5
`define funct3_slt      0x2
`define funct3_sltu     0x3

`define funct7_add      0x00
`define funct7_sub      0x20
`define funct7_xor      0x00
`define funct7_or       0x00
`define funct7_and      0x00
`define funct7_sll      0x00
`define funct7_srl      0x00
`define funct7_sra      0x20
`define funct7_slt      0x00
`define funct7_sltu     0x00

//type_I
`define opcode_I_lg     0010011

`define funct3_addi     0x0
`define funct3_xori     0x4
`define funct3_ori      0x6
`define funct3_andi     0x7
`define funct3_slli     0x1
`define funct3_srli     0x5
`define funct3_srai     0x5
`define funct3_slti     0x2
`define funct3_sltiu    0x3

`define opcode_I_ld     0000011

`define funct3_lb       0x0
`define funct3_lh       0x1
`define funct3_lw       0x2
`define funct3_lbu      0x4
`define funct3_lhu      0x5

//type_S
`define opcode_S        0100011

`define funct3_sb       0x0
`define funct3_sh       0x1
`define funct3_sw       0x2

//typr_B
`define opcode_B        1100011

`define funct3_beq      0x0
`define funct3_bne      0x1
`define funct3_blt      0x4
`define funct3_bge      0x5
`define funct3_bltu     0x6
`define funct3_bgeu     0x7

//type_U
`define opcode_U_lui    0110111

`define opcode_U_auipc  0010111


//type_J
`define opcode_J_jal    1101111
`define opcode_J_jalr   1100111
