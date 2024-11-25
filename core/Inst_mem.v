`include "../define.v"

module Inst_mem (
input clk,
input rst_n,
input [31:0] addr,
input [31:0] Inst_i,
output [31:0] Inst_o,
input wr_en
);

reg [7:0] inst_mem [0:1023];
reg [31:0] Inst_r;
integer i;

//异步读出
assign Inst_o = {inst_mem[addr+3],inst_mem[addr+2],inst_mem[addr+1],inst_mem[addr]};

//同步写入
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        for(i=0;i<1023;i=i+1)begin
            inst_mem[i] <= 0;
        end
    end
    else if(wr_en) begin
        inst_mem[addr] <= Inst_i[7:0];
        inst_mem[addr+1] <= Inst_i[15:8];
        inst_mem[addr+2] <= Inst_i[23:16];
        inst_mem[addr+3] <= Inst_i[31:24];
    end
end

endmodule