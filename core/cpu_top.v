`include "../define.v"

module cpu_top (
    input clk,
    input rst_n
);

wire [31:0] PC;
wire [31:0] Inst_in;
wire [31:0] Inst_out;

ifu u_ifu(
    .clk       (clk       ),
    .rst_n     (rst_n     ),
    .Inst_addr (PC        ),
    .Inst_in   (Inst_in   ),
    .Inst_out  (Inst_out  )
);

Inst_mem u_Inst_mem(
    .clk   (clk   ),
    .rst_n (rst_n ),
    .addr  (PC    ),
    .Inst  (Inst_in  )
);


endmodule