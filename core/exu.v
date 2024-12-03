`include "../define.v"

module exu (
input [4:0] rd,
input [31:0] imm_ext,
input [31:0] rs1_data,
input [31:0] rs2_data,
input [6:0] opcode,
input [2:0] funct3,
input [6:0] funct7,
input [31:0] PC,
input [4:0] rs1,
input [4:0] rs2,
input [4:0] rd_ex_mem,
input [31:0] rd_data_ex_mem,
input [4:0] rd_mem_wb,
input [31:0] rd_data_mem_wb,
input [4:0] rd_wbbuf,
input [31:0] rd_data_wbbuf,
output [31:0] alu_out,
output B_result,
output [6:0] opcode_o,
output [2:0] funct3_o,
output [6:0] funct7_o,
output [4:0] rd_o,
output [31:0] rs2_data_o
);

wire [31:0] alu_add;
wire [31:0] alu_sub;
wire [31:0] alu_xor;
wire [31:0] alu_or;
wire [31:0] alu_and;
wire [31:0] alu_sll;
wire [31:0] alu_srl;
wire [31:0] alu_sra;
wire [31:0] alu_slt;
wire [31:0] alu_sltu;

wire [31:0] alu_addi;
wire [31:0] alu_xori;
wire [31:0] alu_ori;
wire [31:0] alu_andi;
wire [31:0] alu_slli;
wire [31:0] alu_srli;
wire [31:0] alu_srai;
wire [31:0] alu_slti;
wire [31:0] alu_sltiu;

wire [31:0] alu_lb;
wire [31:0] alu_lh;
wire [31:0] alu_lw;
wire [31:0] alu_lbu;
wire [31:0] alu_lhu;

wire [31:0] alu_sb;
wire [31:0] alu_sh;
wire [31:0] alu_sw;

wire [31:0] alu_B;
wire [31:0] alu_eq;
wire [31:0] alu_comp;
wire [31:0] alu_comp_u;

wire [31:0] alu_lui;
wire [31:0] alu_auipc;

wire [31:0] alu_jal;
wire [31:0] alu_jalr;

reg [31:0] alu_r;
reg B_result_r;

reg [31:0] op_1;//操作数1
reg [31:0] op_2;//操作数2
// reg [31:0] op_3;//操作数3，用于分支跳转

assign alu_out = alu_r;
assign B_result = B_result_r;

assign opcode_o = opcode;
assign funct3_o = funct3;
assign funct7_o = funct7;
assign rd_o = rd;
//assign rs2_data_o = rs2_data;
assign rs2_data_o = op_2;



//rs1_data的旁路判决
always @(*) begin
    if(rs1==rd_ex_mem)begin
        op_1 <= rd_data_ex_mem;
    end else if(rs1==rd_data_mem_wb)begin
        op_1 <= rd_data_mem_wb;
    end else if(rs1==rd_wbbuf)begin
        op_1 <= rd_data_wbbuf;
    end else begin
        op_1 <= rs1_data;
    end
end

//rs2_data的旁路判决
always @(*) begin
    if(rs2==rd_ex_mem)begin
        op_2 <= rd_data_ex_mem;
    end else if(rs2==rd_data_mem_wb)begin
        op_2 <= rd_data_mem_wb;
    end else if(rs2==rd_wbbuf)begin
        op_2 <= rd_data_wbbuf;
    end else begin
        op_2 <= rs2_data;
    end
end

//                  A           L           U                  //////////////////////////////////////////////////////////////////////////
//type_R
assign alu_add = op_1 + op_2;
assign alu_sub = op_1 - op_2;
assign alu_xor = op_1 ^ op_2;
assign alu_or = op_1 | op_2;
assign alu_and = op_1 & op_2;
assign alu_sll = op_1 << op_2[4:0];
assign alu_srl = op_1 >> op_2[4:0];
assign alu_sra = (op_1 >> op_2[4:0]) | ({32{op_1[31]}} & (~(32'hFFFFFFFF >> op_2[4:0])));//msb_extend
assign alu_slt = (op_1[31] != op_2[31]) ? op_1[31] : (op_1 < op_2);
assign alu_sltu = (op_1 < op_2) ? 1 : 0;

//type_I
assign alu_addi = op_1 + imm_ext;
assign alu_xori = op_1 ^ imm_ext;
assign alu_ori = op_1 | imm_ext;
assign alu_andi = op_1 & imm_ext;
assign alu_slli = op_1 << imm_ext[4:0];
assign alu_srli = op_1 >> imm_ext[4:0];
assign alu_srai = (op_1 >> imm_ext[4:0]) | ({32{op_1[31]}} & (~(32'hFFFFFFFF >> imm_ext[4:0])));//msb_extend
assign alu_slti = (op_1[31] != imm_ext[31]) ? op_1[31] : (op_1 < imm_ext);
assign alu_sltiu = (op_1 < imm_ext) ? 1 : 0;

assign alu_lb = op_1 + imm_ext;
assign alu_lh = op_1 + imm_ext;
assign alu_lw = op_1 + imm_ext;
assign alu_lbu = op_1 + imm_ext;
assign alu_lhu = op_1 + imm_ext;

//type_S
assign alu_sb = op_1 + imm_ext;
assign alu_sh = op_1 + imm_ext;
assign alu_sw = op_1 + imm_ext;

//type_B
assign alu_eq = (op_1 == op_2) ? 1 : 0;//alu相等判决
assign alu_comp = (op_1[31] != imm_ext[31]) ? op_1[31] : (op_1 < imm_ext);//有符号比较，小于输出1，大于输出0
assign alu_comp_u = (op_1 < imm_ext) ? 1 : 0;//无符号比较，小于输出1，大于输出0
assign alu_B = PC + (imm_ext << 2);

//type_U
assign alu_lui = imm_ext << 12;
assign alu_auipc = PC + (imm_ext << 12);

//type_J
assign alu_jal = PC + (imm_ext << 2);
assign alu_jalr = PC + op_1 + (imm_ext << 2);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//                   ALUop                     ///////////////////////////////////////////////////////////////////////////////////////////////
//判断使用哪一个ALU结果
always @(*) begin
    case (opcode)
        `opcode_R:begin//R型指令
            case (funct3)
                `funct3_add:begin
                    case (funct7)
                        `funct7_add: alu_r <= alu_add;
                        `funct7_sub: alu_r <= alu_sub;
                        default: alu_r <= alu_add;
                    endcase
                end 
                `funct3_xor: alu_r <= alu_xor;
                `funct3_or: alu_r <= alu_or;
                `funct3_and: alu_r <= alu_and;
                `funct3_sll: alu_r <= alu_sll;
                `funct3_srl:begin
                    case (funct7)
                        `funct7_srl: alu_r <= alu_srl;
                        `funct7_sra: alu_r <= alu_sra;
                        default: alu_r <= alu_srl;
                    endcase
                end
                `funct3_slt: alu_r <= alu_slt;
                `funct3_sltu: alu_r <= alu_sltu;
                default: alu_r <= 0;
            endcase
        end 
        `opcode_I_lg:begin//I型算术逻辑指令
            case (funct3)
                `funct3_addi: alu_r <= alu_addi;
                `funct3_xori: alu_r <= alu_xori; 
                `funct3_ori: alu_r <= alu_ori;
                `funct3_andi: alu_r <= alu_andi; 
                `funct3_slli: alu_r <= alu_slli;
                `funct3_srli: alu_r <= alu_srli; 
                `funct3_srai: alu_r <= alu_srai;
                `funct3_slti: alu_r <= alu_slti; 
                `funct3_sltiu: alu_r <= alu_sltiu;
                default: alu_r <= alu_addi;
            endcase
        end 
        `opcode_I_ld:begin//load指令
            case (funct3)
                `funct3_lb: alu_r <= alu_lb;
                `funct3_lh: alu_r <= alu_lh;
                `funct3_lw: alu_r <= alu_lw;
                `funct3_lbu: alu_r <= alu_lbu;
                `funct3_lhu: alu_r <= alu_lhu;
                default: alu_r <= alu_lb;
            endcase
        end 
        `opcode_S:begin//S型指令
            case (funct3)
                `funct3_sb: alu_r <= alu_sb;
                `funct3_sh: alu_r <= alu_sh;
                `funct3_sw: alu_r <= alu_sw;
                default: alu_r <= alu_sb;
            endcase
        end 
        `opcode_B:begin//B型指令
            case (funct3)
                `funct3_beq: alu_r <= alu_B;
                `funct3_beq: alu_r <= alu_B;
                `funct3_beq: alu_r <= alu_B;
                `funct3_beq: alu_r <= alu_B;
                `funct3_beq: alu_r <= alu_B;
                `funct3_beq: alu_r <= alu_B;
                default: alu_r <= alu_B;
            endcase
        end 
        `opcode_U_lui:begin
            alu_r <= alu_lui;
        end 
        `opcode_U_auipc:begin
            alu_r <= alu_auipc;
        end 
        `opcode_J_jal:begin
            alu_r <= alu_jal;
        end 
        `opcode_J_jalr:begin
            alu_r <= alu_jalr;
        end 
        default: alu_r <= alu_add;
    endcase
end
///////////////////////////////////////////////////////////////////////////////////////////////////////////

//分支跳转判决输出
always @(*) begin
    if (opcode==`opcode_B) begin
        case (funct3)
            `funct3_beq: B_result_r <= alu_eq;
            `funct3_bne: B_result_r <= ~alu_eq;
            `funct3_blt: B_result_r <= alu_comp;
            `funct3_bge: B_result_r <= ~alu_comp;
            `funct3_bltu: B_result_r <= alu_comp_u;
            `funct3_bgeu: B_result_r <= ~alu_comp_u;
            default: B_result_r <= 0;//1跳转，0不跳转
        endcase
    end else begin
        B_result_r <= 0;//1跳转，0不跳转
    end
end


endmodule