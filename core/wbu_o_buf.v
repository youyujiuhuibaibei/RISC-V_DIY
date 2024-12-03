`include "../define.v"

module wbu_o_buf (
input clk,
input rst_n,
input [4:0] rd_i,
input [31:0] rd_data_i,
output reg [4:0] rd_o,
output reg [31:0] rd_data_o
);

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rd_o <= 0;
        rd_data_o <= 0;
    end else begin
        rd_o <= rd_i;
        rd_data_o <= rd_data_i;
    end
end

endmodule