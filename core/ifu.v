`include "../define.v"

module ifu (
input clk,
input rst_n,
output [31:0] Inst_addr,//与指令ram连接
input [31:0] Inst_in,//与指令ram连接
output [31:0] Inst_out//输出取到的指令
);

reg [31:0] PC;//程序计数器

//每个时钟周期PC+4
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        PC <= 0;
    end
    else begin
       #1 PC <= PC + 4;//延后1ns，保证读取的PC地址是增加之前的
    end
end

//与指令缓存连接

assign Inst_addr = PC;

assign Inst_out = Inst_in;

endmodule