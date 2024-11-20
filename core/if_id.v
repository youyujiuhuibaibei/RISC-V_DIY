`include "../define.v"

module if_id (
input clk,
input rst_n,
input [31:0] Inst_i,
output [31:0] Inst_o
);

reg [31:0] Inst_r;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        Inst_r <= 0;
    end
    else begin
        Inst_r <= Inst_i;
    end
end

assign Inst_o = Inst_r;

endmodule