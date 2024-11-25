`include "../define.v"
`include "../core/ifu.v"
`include "../core/Inst_mem.v"
`include "../core/if_id.v"

module tb_ifu ();

reg clk;
reg rst_n;
reg rst_n_cpu;
reg [31:0] addr;
wire [31:0] Inst_addr;
reg [31:0] Inst_i;
wire [31:0] Inst_o;
wire [31:0] Inst_in;
wire [31:0] Inst_out;
wire [31:0] Inst_2_id;
reg wr_en;
wire [31:0] addr_sel;
integer i;
reg [31:0] Inst_file [0:255];

assign addr_sel = wr_en ? addr : Inst_addr; 

ifu u_ifu(
    .clk       (clk       ),
    .rst_n     (rst_n_cpu     ),
    .Inst_addr (Inst_addr ),
    .Inst_in   (Inst_o   ),
    .Inst_out  (Inst_out  )
);

Inst_mem u_Inst_mem(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .addr   (addr_sel   ),
    .Inst_i (Inst_i ),
    .Inst_o (Inst_o ),
    .wr_en  (wr_en  )
);

if_id u_if_id(
    .clk    (clk    ),
    .rst_n  (rst_n_cpu  ),
    .Inst_i (Inst_out ),
    .Inst_o (Inst_2_id )
);


initial begin
    clk = 1;
    rst_n = 0;
    rst_n_cpu = 0;
    for (i = 0; i < 256; i = i + 1) begin
            Inst_file[i] = 32'b0;
        end
    $readmemh("D:/work/diycore/tb/Inst_file.txt",Inst_file);
    //$readmemh("D:/work/diycore/tb/test.txt",Inst_file);
    #20
    rst_n = 1;
    //#5
    for(i=0;i<256;i=i+1)begin
        #10
        addr = i*4;
        wr_en = 1;
        Inst_i = Inst_file[i];
    end
    wr_en = 0;
    #20
    rst_n_cpu = 1;//处理器解除复位
end

always #5 clk = ~clk;

endmodule
