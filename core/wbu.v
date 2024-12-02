`include "../define.v"

module wbu (
input [31:0] alu_out,
input [6:0] opcode,
input [2:0] funct3,
input [6:0] funct7,
input [31:0] load_out,
input [4:0] rd_i,
output [4:0] rd_o,//与寄存器组相连
output wr_en,//与寄存器组相连
output [31:0] rd_data//与寄存器组相连

);

//reg [31:0] rd_data_r;
reg wr_en_r;
reg [31:0] rd_data_r;

assign rd_data = rd_data_r;
assign rd_o = rd_i;
assign wr_en = wr_en_r;

always @(*) begin
    if (opcode==`opcode_R || opcode==`opcode_I_lg || opcode==`opcode_I_ld || opcode==`opcode_U_lui || opcode==`opcode_U_auipc || opcode==`opcode_J_jal || opcode==`opcode_J_jalr) begin
        wr_en_r <= 1;//以上类型指令需要写回寄存器
    end else begin
        wr_en_r <= 0;
    end
end

//判断写回的数据是来自alu的计算结果还是load型指令加载的值
always @(*) begin
    if(opcode==`opcode_I_ld)begin
        rd_data_r <= load_out;
    end else begin
        rd_data_r <= alu_out;
    end
end

endmodule