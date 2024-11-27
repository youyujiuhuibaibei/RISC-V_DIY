`include "../define.v"

module idu (
input [31:0] Inst,
input [31:0] rs1_data_i,
input [31:0] rs2_data_i,
output [4:0] rd,
output [4:0] rs1,
output [4:0] rs2,
output [31:0] imm_ext,
output [31:0] rs1_data_o,
output [31:0] rs2_data_o,
output [6:0] opcode,
output [2:0] funct3,
output [6:0] funct7
);



wire [31:0] imm_ext_I;
wire [31:0] imm_ext_S;
wire [31:0] imm_ext_B;
wire [31:0] imm_ext_U;
wire [31:0] imm_ext_J;

// reg [4:0] rs1_r;
// reg [4:0] rs2_r;
// reg [4:0] rd_r;
reg [31:0] imm_ext_r;
reg [5:0] ALUop_r;

assign opcode = Inst[6:0];
assign funct3 = Inst[11:7];
assign funct7 = Inst[31:25];

//获取rs1,rs2,rd
assign rd = Inst[11:7];
assign rs1 = Inst[19:15];
assign rs2 = Inst[24:20];

assign imm_ext_I = {{20{Inst[31]}},Inst[31:20]};
assign imm_ext_S = {{20{Inst[31]}},Inst[31:25],Inst[11:7]};
assign imm_ext_B = {{19{Inst[31]}},Inst[7],Inst[30:25],Inst[11:8],1'b0};
assign imm_ext_U = {Inst[31:12],12'b0};
assign imm_ext_J = {{12{Inst[20]}},Inst[19:12],Inst[20],Inst[30:21],1'b0};

assign imm_ext = imm_ext_r;

//获取imm_ext_r
always @(*) begin
    case (opcode)
        `opcode_R: begin//type_R
            imm_ext_r <= 0;
        end
        `opcode_I_lg: begin//type_I_lg，立即数逻辑运算
            imm_ext_r <= imm_ext_I;
        end
        `opcode_I_ld: begin//type_I_ld，load类指令
            imm_ext_r <= imm_ext_I;
        end
        `opcode_S: begin//type_S，store类指令
            imm_ext_r <= imm_ext_S;
        end
        `opcode_B: begin//type_B，分支跳转类指令
            imm_ext_r <= imm_ext_B;
        end
        `opcode_U_lui: begin//type_U_lui
            imm_ext_r <= imm_ext_U;
        end
        `opcode_U_auipc: begin//type_U_auipc
            imm_ext_r <= imm_ext_U;
        end
        `opcode_J_jal: begin//type_J_jal，无条件跳转+立即数寻址
            imm_ext_r <= imm_ext_J;
        end
        `opcode_J_jalr: begin//type_J_jalr，无条件跳转+寄存器寻址
            imm_ext_r <= imm_ext_J;
        end
        default: imm_ext_r <= 0;
    endcase
end

//从regs获取rs1_data与rs2_data
assign rs1_data_o = rs1_data_i;
assign rs2_data_o = rs2_data_i;

endmodule