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

`define ALUopcode_add   0x0
`define ALUopcode_sub   0x1
`define ALUopcode_xor   0x2
`define ALUopcode_or    0x3
`define ALUopcode_and   0x4
`define ALUopcode_sll   0x5
`define ALUopcode_srl   0x6
`define ALUopcode_sra   0x7
`define ALUopcode_slt   0x8
`define ALUopcode_sltu  0x9


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

`define ALUopcode_addi  0xa
`define ALUopcode_xori  0xb
`define ALUopcode_ori   0xc
`define ALUopcode_andi  0xd
`define ALUopcode_slli  0xe
`define ALUopcode_srli  0xf
`define ALUopcode_srai  0x10
`define ALUopcode_slti  0x11
`define ALUopcode_sltui 0x12

`define opcode_I_ld     0000011

`define funct3_lb       0x0
`define funct3_lh       0x1
`define funct3_lw       0x2
`define funct3_lbu      0x4
`define funct3_lhu      0x5

`define ALUopcode_lb       0x13
`define ALUopcode_lh       0x14
`define ALUopcode_lw       0x15
`define ALUopcode_lbu      0x16
`define ALUopcode_lhu      0x17

//type_S
`define opcode_S        0100011

`define funct3_sb       0x0
`define funct3_sh       0x1
`define funct3_sw       0x2

`define ALUopcode_sb       0x18
`define ALUopcode_sh       0x19
`define ALUopcode_sw       0x20

//type_B
`define opcode_B        1100011

`define funct3_beq      0x0
`define funct3_bne      0x1
`define funct3_blt      0x4
`define funct3_bge      0x5
`define funct3_bltu     0x6
`define funct3_bgeu     0x7

`define ALUopcode_beq      0x2a
`define ALUopcode_bne      0x2b
`define ALUopcode_blt      0x2c
`define ALUopcode_bge      0x2d
`define ALUopcode_bltu     0x2e
`define ALUopcode_bgeu     0x2f

//type_U
`define opcode_U_lui    0110111

`define ALUopcode_U_lui     0x30

`define opcode_U_auipc  0010111

`define ALUopcode_U_auipc     0x31

//type_J
`define opcode_J_jal    1101111

`define ALUopcode_J_jal     0x32

`define opcode_J_jalr   1100111


`define ALUopcode_J_jalr     0x33