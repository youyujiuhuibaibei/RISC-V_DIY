`include "../define.v"

module Inst_mem (
input clk,
input rst_n,
input [31:0] addr,
output [31:0] Inst
);

reg [7:0] data_mem [1023:0];
reg [31:0] Inst_r;
integer i;
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        for(i=0;i<1023;i=i+1)begin
            data_mem[i] <= 0;
        end
    end
    else begin
        Inst_r[7:0] <= data_mem[addr];
        Inst_r[15:8] <= data_mem[addr+1];
        Inst_r[23:16] <= data_mem[addr+2];
        Inst_r[31:24] <= data_mem[addr+3];
    end
end

assign Inst = Inst_r;

endmodule