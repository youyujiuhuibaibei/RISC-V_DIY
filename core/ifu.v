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
wire [31:0] PC_next;


always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        PC <= 0;
    end
    else begin
         PC <= PC_next;
        //PC <= PC + 4;
    end
end

assign PC_next = PC + 4;
// always @(posedge clk or negedge rst_n) begin
//     if(~rst_n)begin
//         PC_next <= 0;
//     end
//     else begin
//         PC_next <= PC + 4;
//     end
// end

//与指令缓存连接

assign Inst_addr = PC;
assign PC_out = PC;
assign Inst_out = Inst_in;

endmodule