`include "../define.v"

module id_ex (
input clk,
input rst_n,
input [4:0] rd_i,
input [31:0] imm_ext_i,
input [31:0] rs1_data_i,
input [31:0] rs2_data_i,
input [6:0] opcode_i,
input [2:0] funct3_i,
input [6:0] funct7_i,
input [31:0] PC_i,
input [4:0] rs1_i,
input [4:0] rs2_i,
output reg [4:0] rd_o,
output reg [31:0] imm_ext_o,
output reg [31:0] rs1_data_o,
output reg [31:0] rs2_data_o,
output reg [6:0] opcode_o,
output reg [2:0] funct3_o,
output reg [6:0] funct7_o,
output reg [31:0] PC_o,
output reg [4:0] rs1_o,
output reg [4:0] rs2_o
);

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rd_o <= 0;
        imm_ext_o <= 0;
        rs1_data_o <= 0;
        rs2_data_o <= 0;
        opcode_o <= `opcode_nop;
        funct3_o <= `funct3_nop;
        funct7_o <= `funct7_nop;
        PC_o <= 0;
        rs1_o <= 0;
        rs2_o <= 0;
    end else begin
        rd_o <= rd_i;
        imm_ext_o <= imm_ext_i;
        rs1_data_o <= rs1_data_i;
        rs2_data_o <= rs2_data_i;
        opcode_o <= opcode_i;
        funct3_o <= funct3_i;
        funct7_o <= funct7_i;
        PC_o <= PC_i;
        rs1_o <= rs1_i;
        rs2_o <= rs2_i;
    end
end

endmodule
