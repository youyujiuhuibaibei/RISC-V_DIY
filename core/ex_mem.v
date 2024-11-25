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
output reg [31:0] alu_out_o,
output reg B_result_o,
output reg [6:0] opcode_o,
output reg [2:0] funct3_o,
output reg [6:0] funct7_o,
output reg [4:0] rd_o
);

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        alu_out_o <= 0;
        B_result_o <= 0;
        opcode_o <= 0;
        funct3_o <= 0;
        funct7_o <= 0;
        rd_o <= 0;
    end else begin
        alu_out_o <= alu_out_i;
        B_result_o <= B_result_i;
        opcode_o <= opcode_i;
        funct3_o <= funct3_i;
        funct7_o <= funct7_i;
    end
end

endmodule