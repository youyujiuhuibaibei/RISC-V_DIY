`include "../define.v"

module memu (
input [31:0] alu_out,
input B_result,
input [6:0] opcode,
input [2:0] funct3,
input [6:0] funct7,
input [4:0] rd,
input [31:0] rs2_data,
output [31:0] Data_addr,//与数据ram连接
input [31:0] Data_in,//与数据ram连接
output [31:0] Data_out,//与数据ram连接
output we,//写使能，与数据ram连接
output [1:0] wa,//用于区分写入的字节是几个byte，与数据ram相连
output [31:0] load_out,//输出取到的数据
output [31:0] alu_out_o,
output [6:0] opcode_o,
output [2:0] funct3_o,
output [6:0] funct7_o,
output [4:0] rd_o
);

reg [31:0] load_out_r;
reg we_r;
reg [1:0] wa_r;

assign Data_addr = alu_out;
assign load_out = load_out_r;
assign alu_out_o = alu_out;
assign opcode_o = opcode;
assign funct3_o = funct3;
assign funct7_o = funct7;
assign rd_o = rd;

//load指令
always @(*) begin
    if(opcode==`opcode_I_ld)begin
        case (funct3)
            `funct3_lb:begin
                load_out_r <= {{24{Data_in[7]}},Data_in[7:0]};
            end 
            `funct3_lh:begin
                load_out_r <= {{16{Data_in[15]}},Data_in[15:0]};
            end 
            `funct3_lw:begin
                load_out_r <= Data_in;
            end 
            `funct3_lbu:begin
                load_out_r <= {{24'b0},Data_in[7:0]};
            end 
            `funct3_lhu:begin
                load_out_r <= {{16'b0},Data_in[15:0]};
            end 
            default: load_out_r <= Data_in;
        endcase
    end
end

//store指令
assign Data_out = rs2_data;

always @(*) begin
    if (opcode==`opcode_S) begin
        we_r <= 1;
        case (funct3)
            `funct3_sb:wa_r <= 0;
            `funct3_sh:wa_r <= 1;
            `funct3_sw:wa_r <= 2;
            default: wa_r <= 2;
        endcase
    end else
        we_r <= 0;
end

endmodule