`include "../define.v"

module Data_mem (
input clk,
input rst_n,
input [31:0] Data_i,
input [31:0] addr,
input we,
input [1:0] wa,
output [31:0] Data_o
);

reg [7:0] data_mem [1023:0];
integer i;

//异步读取
assign Data_o = data_mem[addr];


//同步写入
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin//复位清零
        for(i=0;i<1023;i=i+1)begin
            data_mem[i] <= 0;
        end
    end else if(we) begin
        case (wa)
            2'd0: data_mem[addr] <= Data_i[7:0];
            2'd1:begin
                data_mem[addr] <= Data_i[7:0];
                data_mem[addr+1] <= Data_i[15:8];
            end
            2'd2:begin
                data_mem[addr] <= Data_i[7:0];
                data_mem[addr+1] <= Data_i[15:8];
                data_mem[addr+2] <= Data_i[23:16];
                data_mem[addr+3] <= Data_i[31:24];
            end
            default: data_mem[addr] <= Data_i[7:0];
        endcase
        
    end
end


endmodule