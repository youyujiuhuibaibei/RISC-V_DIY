`include "../define.v"

module mem_wb (
input clk,
input rst_n,
input [31:0] alu_out_i,
input [6:0] opcode_i,
input [2:0] funct3_i,
input [6:0] funct7_i,
input [31:0] load_out_i,
input [4:0] rd_i,
output reg [31:0] alu_out_o,
output reg [6:0] opcode_o,
output reg [2:0] funct3_o,
output reg [6:0] funct7_o,
output reg [31:0] load_out_o,
output reg [4:0] rd_o
);

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        alu_out_o <= 0;
        opcode_o <= `opcode_nop;
        funct3_o <= `funct3_nop;
        funct7_o <= `funct7_nop;
        load_out_o <= 0;
        rd_o <= 0;
    end else begin
        alu_out_o <= alu_out_i;
        opcode_o <= opcode_i;
        funct3_o <= funct3_i;
        funct7_o <= funct7_i;
        load_out_o <= load_out_i;
        rd_o <= rd_i;
    end
end

endmodule