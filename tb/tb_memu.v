`include "../define.v"
`include "../core/ifu.v"
`include "../core/Inst_mem.v"
`include "../core/if_id.v"
`include "../core/idu.v"
`include "../core/id_ex.v"
`include "../core/regs.v"
`include "../core/exu.v"
`include "../core/ex_mem.v"
`include "../core/memu.v"
`include "../core/mem_wb.v"

module tb_memu ();

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
wire [31:0] rs1_data_i;
wire [31:0] rs2_data_i;
wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;
wire [31:0] imm_ext;
wire [31:0] rs1_data_o;
wire [31:0] rs2_data_o;
wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;
wire [4:0] rd_2_ex;
wire [31:0] imm_ext_2_ex;
wire [31:0] rs1_data_2_ex ;
wire [31:0] rs2_data_2_ex ;
wire [6:0] opcode_2_ex   ;
wire [2:0] funct3_2_ex   ;
wire [6:0] funct7_2_ex   ;
wire [31:0] PC_out;
wire [31:0] PC_2_id;
wire [31:0] PC_2_ex;
wire [31:0] alu_out;
wire B_result;
wire [6:0] opcode_o_ex;
wire [2:0] funct3_o_ex;
wire [6:0] funct7_o_ex;
wire [4:0] rd_o_ex;
wire [31:0] rs2_data_o_ex;
wire [31:0] alu_out_2_mem  ;
wire B_result_2_mem ;
wire [6:0] opcode_2_mem   ;
wire [2:0] funct3_2_mem   ;
wire [6:0] funct7_2_mem   ;
wire [4:0] rd_2_mem       ;
wire [31:0] rs2_data_2_mem ;
wire [31:0] Data_addr ;
wire [31:0] Data_in   ;
wire [31:0] Data_out  ;
wire we        ;
wire wa        ;
wire [31:0] load_out  ;
wire [31:0] alu_out_mem ;
wire [6:0] opcode_o_mem  ;
wire [2:0] funct3_o_mem  ;
wire [6:0] funct7_o_mem  ;
wire [4:0] rd_o_mem      ;
wire [31:0] alu_out_2_wb  ;
wire [6:0] opcode_2_wb   ;
wire [2:0] funct3_2_wb   ;
wire [6:0] funct7_2_wb   ;
wire [31:0] load_out_2_wb ;
wire [4:0] rd_2_wb       ;


assign addr_sel = wr_en ? addr : Inst_addr; 

ifu u_ifu(
    .clk       (clk       ),
    .rst_n     (rst_n_cpu     ),
    .Inst_addr (Inst_addr ),
    .Inst_in   (Inst_o   ),
    .Inst_out  (Inst_out  ),
    .PC_out     (PC_out)
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
    .Inst_o (Inst_2_id ),
    .PC_i   (PC_out),
    .PC_o(PC_2_id)
);

idu u_idu(
    .Inst       (Inst_2_id       ),
    .rs1_data_i (rs1_data_i ),
    .rs2_data_i (rs2_data_i ),
    .rd         (rd         ),
    .rs1        (rs1        ),
    .rs2        (rs2        ),
    .imm_ext    (imm_ext    ),
    .rs1_data_o (rs1_data_o ),
    .rs2_data_o (rs2_data_o ),
    .opcode     (opcode     ),
    .funct3     (funct3     ),
    .funct7     (funct7     )
);

regs u_regs(
    .clk      (clk      ),
    .rst_n    (rst_n    ),
    .rs1      (rs1      ),
    .rs2      (rs2      ),
    .rd       (       ),
    .wr_en    (0    ),
    .rs1_data (rs1_data_i ),
    .rs2_data (rs2_data_i ),
    .rd_data  (rd_data  )
);

id_ex u_id_ex(
    .clk        (clk        ),
    .rst_n      (rst_n_cpu      ),
    .rd_i       (rd       ),
    .imm_ext_i  (imm_ext  ),
    .rs1_data_i (rs1_data_o ),
    .rs2_data_i (rs2_data_o ),
    .opcode_i   (opcode   ),
    .funct3_i   (funct3   ),
    .funct7_i   (funct7   ),
    .PC_i       (PC_2_id),
    .rd_o       (rd_2_ex       ),
    .imm_ext_o  (imm_ext_2_ex  ),
    .rs1_data_o (rs1_data_2_ex ),
    .rs2_data_o (rs2_data_2_ex ),
    .opcode_o   (opcode_2_ex   ),
    .funct3_o   (funct3_2_ex   ),
    .funct7_o   (funct7_2_ex   ),
    .PC_o       (PC_2_ex)
);

exu u_exu(
    .rd         (rd_2_ex         ),
    .imm_ext    (imm_ext_2_ex    ),
    // .rs1_data   (rs1_data_2_ex   ),
    // .rs2_data   (rs2_data_2_ex   ),
    .rs1_data   (32'h20   ),
    .rs2_data   (32'h20   ),
    .opcode     (opcode_2_ex     ),
    .funct3     (funct3_2_ex     ),
    .funct7     (funct7_2_ex     ),
    .PC         (PC_2_ex         ),
    .alu_out    (alu_out    ),
    .B_result   (B_result   ),
    .opcode_o   (opcode_o_ex   ),
    .funct3_o   (funct3_o_ex   ),
    .funct7_o   (funct7_o_ex   ),
    .rd_o       (rd_o_ex       ),
    .rs2_data_o (rs2_data_o_ex )
);

ex_mem u_ex_mem(
    .clk        (clk        ),
    .rst_n      (rst_n_cpu      ),
    .alu_out_i  (alu_out  ),
    .B_result_i (B_result ),
    .opcode_i   (opcode_o_ex   ),
    .funct3_i   (funct3_o_ex   ),
    .funct7_i   (funct7_o_ex   ),
    .rd_i       (rd_o_ex       ),
    .rs2_data_i (rs2_data_o_ex ),
    .alu_out_o  (alu_out_2_mem  ),
    .B_result_o (B_result_2_mem ),
    .opcode_o   (opcode_2_mem   ),
    .funct3_o   (funct3_2_mem   ),
    .funct7_o   (funct7_2_mem   ),
    .rd_o       (rd_2_mem       ),
    .rs2_data_o (rs2_data_2_mem )
);

memu u_memu(
    .alu_out   (alu_out_2_mem   ),
    .B_result  (B_result_2_mem  ),
    .opcode    (opcode_2_mem    ),
    .funct3    (funct3_2_mem    ),
    .funct7    (funct7_2_mem    ),
    .rd        (rd_2_mem        ),
    .rs2_data  (rs2_data_2_mem  ),
    .Data_addr (Data_addr ),
    .Data_in   (Data_in   ),
    .Data_out  (Data_out  ),
    .we        (we        ),
    .wa        (wa        ),
    .load_out  (load_out  ),
    .alu_out_o (alu_out_mem ),
    .opcode_o  (opcode_o_mem  ),
    .funct3_o  (funct3_o_mem  ),
    .funct7_o  (funct7_o_mem  ),
    .rd_o      (rd_o_mem      )
);

Data_mem u_Data_mem(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .Data_i (Data_in ),
    .addr   (Data_addr   ),
    .we     (we     ),
    .wa     (wa     ),
    .Data_o (Data_out )
);


mem_wb u_mem_wb(
    .clk        (clk        ),
    .rst_n      (rst_n_cpu      ),
    .alu_out_i  (alu_out_mem  ),
    .opcode_i   (opcode_o_mem   ),
    .funct3_i   (funct3_o_mem   ),
    .funct7_i   (funct7_o_mem   ),
    .load_out_i (load_out ),
    .rd_i       (rd_o_mem       ),
    .alu_out_o  (alu_out_2_wb  ),
    .opcode_o   (opcode_2_wb   ),
    .funct3_o   (funct3_2_wb   ),
    .funct7_o   (funct7_2_wb   ),
    .load_out_o (load_out_2_wb ),
    .rd_o       (rd_2_wb       )
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
