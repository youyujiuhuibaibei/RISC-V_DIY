`include "../core/cpu_top.v"

module tb_core();

reg clk;
reg rst_n;
reg rst_n_mem;

reg [31:0] Inst_addr_load;
reg [31:0] Inst_load;
reg load_en;
reg [31:0] Inst_file [0:255];
integer i;

cpu_top u_cpu_top(
    .clk            (clk            ),
    .rst_n          (rst_n          ),
    .rst_n_mem      (rst_n_mem      ),
    .Inst_addr_load (Inst_addr_load ),
    .Inst_load      (Inst_load      ),
    .load_en        (load_en        )
);

initial begin
    clk = 1;
    rst_n = 0;
    rst_n_mem = 0;
    load_en = 0;
    Inst_addr_load = 0;
    Inst_load = 0;
    for (i = 0; i < 256; i = i + 1) begin
            Inst_file[i] = 32'b0;
        end
    //$readmemh("D:/work/diycore/tb/Inst_file.txt",Inst_file);
    $readmemh("D:/work/diycore/tb/test_load.txt",Inst_file);
    #20
    rst_n_mem = 1;
    //#5
    for(i=0;i<256;i=i+1)begin
        #10
        Inst_addr_load = i*4;
        load_en = 1;
        Inst_load = Inst_file[i];
    end
    load_en = 0;
    #20
    rst_n = 1;//处理器解除复位
end

always #5 clk = ~clk;

endmodule