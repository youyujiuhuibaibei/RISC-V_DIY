`include "../define.v"

module ifu (
input clk,
input rst_n,
output [31:0] Inst_addr,//与指令ram连接
input [31:0] Inst_in,//与指令ram连接
output [31:0] Inst_out,//输出取到的指令
output [31:0] PC_out
);

reg [31:0] PC;//程序计数器
reg [31:0] PC_next;
wire [6:0] pre_opcode;
wire [31:0] PC_jal;
wire [31:0] imm_jal;

// always @(posedge clk or negedge rst_n) begin
//     if(~rst_n)begin
//         PC <= 0;
//     end
//     else begin
//          PC <= PC_next;
//         //PC <= PC + 4;
//     end
// end

//assign PC_next = PC + 4;
// always @(posedge clk or negedge rst_n) begin
//     if(~rst_n)begin
//         PC_next <= 0;
//     end
//     else begin
//         PC_next <= PC + 4;
//     end
// end

//预译码，针对jal指令
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        PC <= 0;
    end
    else begin
        if (pre_opcode==`opcode_J_jal) begin
            PC <= PC_jal;
        end else begin
            PC <= PC + 4;
        end
    end
end

assign pre_opcode = Inst_in[6:0];
assign Inst_addr = PC;
assign PC_out = PC;
assign Inst_out = Inst_in;
assign imm_jal = {{12{Inst_in[31]}},Inst_in[19:12],Inst_in[20],Inst_in[30:21],1'b0};
assign PC_jal = PC + imm_jal ;

endmodule