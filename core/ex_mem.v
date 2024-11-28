`include "../define.v"

module ex_mem (
input clk,
input rst_n,
input [31:0] alu_out_i,
input B_result_i,
input [6:0] opcode_i,
input [2:0] funct3_i,
input [6:0] funct7_i,
input [4:0] rd_i,
input [31:0] rs2_data_i,
output reg [31:0] alu_out_o,
output reg B_result_o,
output reg [6:0] opcode_o,
output reg [2:0] funct3_o,
output reg [6:0] funct7_o,
output reg [4:0] rd_o,
output reg [31:0] rs2_data_o
);

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        alu_out_o <= 0;
        B_result_o <= 0;
        opcode_o <= `opcode_nop;
        funct3_o <= `funct3_nop;
        funct7_o <= `funct7_nop;
        rd_o <= 0;
        rs2_data_o <= 0;
    end else begin
        alu_out_o <= alu_out_i;
        B_result_o <= B_result_i;
        opcode_o <= opcode_i;
        funct3_o <= funct3_i;
        funct7_o <= funct7_i;
        rs2_data_o <= rs2_data_i;
    end
end

endmodule