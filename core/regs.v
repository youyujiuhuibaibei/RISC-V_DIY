`include "../define.v"

module regs (
input clk,
input rst_n,
input [4:0] rs1,
input [4:0] rs2,
input [4:0] rd,
input wr_en,
output [31:0] rs1_data,
output [31:0] rs2_data,
output [31:0] rd_data
);

    // 寄存器组定义：32个32位寄存器
    reg [31:0] registers [31:0];
    integer i;
    // 读数据：异步读取
    assign rs1_data = registers[rs1];
    assign rs2_data = registers[rs2];

    // 写数据：同步写入
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // 异步复位：将所有寄存器清零
            
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else if (wr_en && rd != 5'b0) begin
            // 写操作：当 wr_en 为高且目标寄存器不是 x0 时
            registers[rd] <= rd_data;
        end
    end

endmodule