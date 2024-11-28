`include "../define.v"

module if_id (
input clk,
input rst_n,
input [31:0] Inst_i,
input [31:0] PC_i,
output reg [31:0] PC_o,
output [31:0] Inst_o
);

reg [31:0] Inst_r;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin//复位时，将指令复位为nop
        Inst_r <= `nop;
    end
    else begin
        Inst_r <= Inst_i;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        PC_o <= 0;
    end
    else begin
        PC_o <= PC_i;
    end
end

assign Inst_o = Inst_r;

endmodule