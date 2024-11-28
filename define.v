//指令分类
//type_R
`define opcode_R        7'b0110011//0x33

`define funct3_add      3'h0 //f3一样
`define funct3_sub      3'h0 //
`define funct3_xor      3'h4
`define funct3_or       3'h6
`define funct3_and      3'h7
`define funct3_sll      3'h1
`define funct3_srl      3'h5 //
`define funct3_sra      3'h5 //
`define funct3_slt      3'h2
`define funct3_sltu     3'h3

`define funct7_add      7'h00
`define funct7_sub      7'h20    //
`define funct7_xor      7'h00
`define funct7_or       7'h00
`define funct7_and      7'h00
`define funct7_sll      7'h00
`define funct7_srl      7'h00
`define funct7_sra      7'h20    //
`define funct7_slt      7'h00
`define funct7_sltu     7'h00

// `define ALUopcode_add   0x0
// `define ALUopcode_sub   0x1
// `define ALUopcode_xor   0x2
// `define ALUopcode_or    0x3
// `define ALUopcode_and   0x4
// `define ALUopcode_sll   0x5
// `define ALUopcode_srl   0x6
// `define ALUopcode_sra   0x7
// `define ALUopcode_slt   0x8
// `define ALUopcode_sltu  0x9


//type_I
`define opcode_I_lg     7'b0010011//0x13

`define funct3_addi     3'h0
`define funct3_xori     3'h4
`define funct3_ori      3'h6
`define funct3_andi     3'h7
`define funct3_slli     3'h1
`define funct3_srli     3'h5
`define funct3_srai     3'h5
`define funct3_slti     3'h2
`define funct3_sltiu    3'h3

// `define ALUopcode_addi  0xa
// `define ALUopcode_xori  0xb
// `define ALUopcode_ori   0xc
// `define ALUopcode_andi  0xd
// `define ALUopcode_slli  0xe
// `define ALUopcode_srli  0xf
// `define ALUopcode_srai  0x10
// `define ALUopcode_slti  0x11
// `define ALUopcode_sltui 0x12

`define opcode_I_ld     7'b0000011//0x03

`define funct3_lb       3'h0
`define funct3_lh       3'h1
`define funct3_lw       3'h2
`define funct3_lbu      3'h4
`define funct3_lhu      3'h5

// `define ALUopcode_lb       0x13
// `define ALUopcode_lh       0x14
// `define ALUopcode_lw       0x15
// `define ALUopcode_lbu      0x16
// `define ALUopcode_lhu      0x17

//type_S
`define opcode_S        7'b0100011//0x23

`define funct3_sb       3'h0
`define funct3_sh       3'h1
`define funct3_sw       3'h2

// `define ALUopcode_sb       0x18
// `define ALUopcode_sh       0x19
// `define ALUopcode_sw       0x20

//type_B
`define opcode_B        7'b1100011//0x63

`define funct3_beq      3'h0
`define funct3_bne      3'h1
`define funct3_blt      3'h4
`define funct3_bge      3'h5
`define funct3_bltu     3'h6
`define funct3_bgeu     3'h7

// `define ALUopcode_beq      0x2a
// `define ALUopcode_bne      0x2b
// `define ALUopcode_blt      0x2c
// `define ALUopcode_bge      0x2d
// `define ALUopcode_bltu     0x2e
// `define ALUopcode_bgeu     0x2f

//type_U
`define opcode_U_lui    7'b0110111//0x37

//`define ALUopcode_U_lui     0x30

`define opcode_U_auipc  7'b0010111//0x17

//`define ALUopcode_U_auipc     0x31

//type_J
`define opcode_J_jal    7'b1101111//0x6f

//`define ALUopcode_J_jal     0x32

`define opcode_J_jalr   7'b1100111//0x67


//`define ALUopcode_J_jalr     0x33

`define nop             32'b000000000000_00000_000_00000_0010011
`define opcode_nop      7'b0010011
`define funct3_nop      3'b000
`define funct7_nop      7'b0000000
