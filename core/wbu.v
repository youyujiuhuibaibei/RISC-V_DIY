`include "../define.v"

module wbu (
input [31:0] alu_out,
input [6:0] opcode,
input [2:0] funct3,
input [6:0] funct7,
input [31:0] load_out,
input [4:0] rd_i,
output [4:0] rd_o,
output wr_en,
output [31:0] rd_data

);

//reg [31:0] rd_data_r;
reg wr_en_r;

assign rd_data = alu_out;
assign rd_o = rd_i;
assign wr_en = wr_en_r;

always @(*) begin
    if (opcode==`opcode_R || opcode==`opcode_I_lg || opcode==`opcode_I_ld || opcode==`opcode_U_lui || opcode==`opcode_U_auipc || opcode==`opcode_J_jal || opcode==`opcode_J_jalr) begin
        wr_en_r <= 1;
    end else begin
        wr_en_r <= 0;
    end
end

endmodule