`include "../define.v"

module cpu_top (
    input clk,
    input rst_n,
    input rst_n_mem,
    input [31:0] Inst_addr_load,
    input [31:0] Inst_load,
    input load_en
);

wire [31:0] Inst_addr;
wire [31:0] Inst_addr_sel;
wire [31:0] Inst_mem2ifu;
wire [31:0] Inst_ifu2if_id;
wire [31:0] PC_ifu2if_id;
wire [31:0] PC_if_id2id_ex;
wire [31:0] Inst_if_id2idu;
wire [31:0] rs1_data_regs2idu;
wire [31:0] rs2_data_regs2idu;
wire [4:0] rd_idu2id_ex;
wire [4:0] rs1_idu2regs;
wire [4:0] rs2_idu2regs;
wire [31:0] imm_ext_idu2id_ex;
wire [31:0] rs1_data_idu2id_ex;
wire [31:0] rs2_data_idu2id_ex;
wire [6:0] opcode_idu2id_ex;
wire [3:0] funct3_idu2id_ex;
wire [6:0] funct7_idu2id_ex;
wire [4:0] rd_wbu2regs;
wire wr_en_wbu2regs;
wire [31:0] rd_data_wbu2regs;
wire [4:0] rd_id_ex2exu;
wire [31:0] imm_ext_id_ex2exu;
wire [31:0] rs1_data_id_ex2exu;
wire [31:0] rs2_data_id_ex2exu ;
wire [6:0] opcode_id_ex2exu   ;
wire [2:0] funct3_id_ex2exu   ;
wire [6:0] funct7_id_ex2exu   ;
wire [31:0] PC_id_ex2exu       ;
wire [31:0] alu_out_exu2ex_mem    ;
wire B_result_exu2ex_mem   ;
wire [6:0] opcode_exu2ex_mem   ;
wire [2:0] funct3_exu2ex_mem   ;
wire [6:0] funct7_exu2ex_mem   ;
wire [4:0] rd_exu2ex_mem       ;
wire [31:0] rs2_data_exu2ex_mem ;
wire [31:0] alu_out_ex_mem2memu  ;
wire B_result_ex_mem2memu ;
wire [6:0] opcode_ex_mem2memu   ;
wire [2:0] funct3_ex_mem2memu   ;
wire [6:0] funct7_ex_mem2memu   ;
wire [4:0] rd_ex_mem2memu       ;
wire [31:0] rs2_data_ex_mem2memu ;
wire [31:0] Data_addr_memu2Data_mem ;
wire [31:0] Data_in_Data_mem2memu   ;
wire [31:0] Data_out_memu2Data_mem  ;
wire we_memu2Data_mem        ;
wire [1:0] wa_memu2Data_mem        ;
wire [31:0] load_out_memu2mem_wb  ;
wire [31:0] alu_out_memu2mem_wb ;
wire [6:0] opcode_memu2mem_wb  ;
wire [2:0] funct3_memu2mem_wb  ;
wire [6:0] funct7_memu2mem_wb  ;
wire [4:0] rd_memu2mem_wb      ;
wire [31:0] alu_out_mem_wb2wbu  ;
wire [6:0] opcode_mem_wb2wbu   ;
wire [2:0] funct3_mem_wb2wbu   ;
wire [6:0] funct7_mem_wb2wbu   ;
wire [31:0] load_out_mem_wb2wbu ;
wire [4:0] rd_mem_wb2wbu       ;

assign Inst_addr_sel = load_en ? Inst_addr_load : Inst_addr;//用load_en来决定是从外部加载指令还是从ram中取指令到cpu

Inst_mem u_Inst_mem(
    .clk    (clk    ),
    .rst_n  (rst_n_mem  ),
    .addr   (Inst_addr   ),
    .Inst_i (Inst_load ),//指令只会从外部写入
    .Inst_o (Inst_mem2ifu ),//ifu-->Inst_mem
    .wr_en  (load_en  )
);

ifu u_ifu(
    .clk       (clk       ),
    .rst_n     (rst_n     ),
    .Inst_addr (Inst_addr ),
    .Inst_in   (Inst_mem2ifu   ),//ifu-->Inst_mem
    .Inst_out  (Inst_ifu2if_id  ),//ifu-->if_id
    .PC_out    (PC_ifu2if_id    )//ifu-->if_id
);

if_id u_if_id(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .Inst_i (Inst_ifu2if_id ),
    .PC_i   (PC_ifu2if_id   ),
    .PC_o   (PC_if_id2id_ex   ),
    .Inst_o (Inst_if_id2idu )
);

idu u_idu(
    .Inst       (Inst_if_id2idu       ),
    .rs1_data_i (rs1_data_regs2idu ),
    .rs2_data_i (rs2_data_regs2idu ),
    .rd         (rd_idu2id_ex         ),
    .rs1        (rs1_idu2regs        ),
    .rs2        (rs2_idu2regs        ),
    .imm_ext    (imm_ext_idu2id_ex    ),
    .rs1_data_o (rs1_data_idu2id_ex ),
    .rs2_data_o (rs2_data_idu2id_ex ),
    .opcode     (opcode_idu2id_ex     ),
    .funct3     (funct3_idu2id_ex     ),
    .funct7     (funct7_idu2id_ex     )
);

regs u_regs(
    .clk      (clk      ),
    .rst_n    (rst_n    ),
    .rs1      (rs1_idu2regs      ),
    .rs2      (rs2_idu2regs      ),
    .rd       (rd_wbu2regs       ),
    .wr_en    (wr_en_wbu2regs    ),
    .rs1_data (rs1_data_regs2idu ),
    .rs2_data (rs2_data_regs2idu ),
    .rd_data  (rd_data_wbu2regs  )
);

id_ex u_id_ex(
    .clk        (clk        ),
    .rst_n      (rst_n      ),
    .rd_i       (rd_idu2id_ex       ),
    .imm_ext_i  (imm_ext_idu2id_ex  ),
    .rs1_data_i (rs1_data_idu2id_ex ),
    .rs2_data_i (rs2_data_idu2id_ex ),
    .opcode_i   (opcode_idu2id_ex   ),
    .funct3_i   (funct3_idu2id_ex   ),
    .funct7_i   (funct7_idu2id_ex   ),
    .PC_i       (PC_if_id2id_ex       ),
    .rd_o       (rd_id_ex2exu       ),
    .imm_ext_o  (imm_ext_id_ex2exu  ),
    .rs1_data_o (rs1_data_id_ex2exu ),
    .rs2_data_o (rs2_data_id_ex2exu ),
    .opcode_o   (opcode_id_ex2exu   ),
    .funct3_o   (funct3_id_ex2exu   ),
    .funct7_o   (funct7_id_ex2exu   ),
    .PC_o       (PC_id_ex2exu       )
);

exu u_exu(
    .rd         (rd_id_ex2exu         ),
    .imm_ext    (imm_ext_id_ex2exu    ),
    .rs1_data   (rs1_data_id_ex2exu   ),
    .rs2_data   (rs2_data_id_ex2exu   ),
    .opcode     (opcode_id_ex2exu     ),
    .funct3     (funct3_id_ex2exu     ),
    .funct7     (funct7_id_ex2exu     ),
    .PC         (PC_id_ex2exu         ),
    .alu_out    (alu_out_exu2ex_mem    ),
    .B_result   (B_result_exu2ex_mem   ),
    .opcode_o   (opcode_exu2ex_mem   ),
    .funct3_o   (funct3_exu2ex_mem   ),
    .funct7_o   (funct7_exu2ex_mem   ),
    .rd_o       (rd_exu2ex_mem       ),
    .rs2_data_o (rs2_data_exu2ex_mem )
);

ex_mem u_ex_mem(
    .clk        (clk        ),
    .rst_n      (rst_n      ),
    .alu_out_i  (alu_out_exu2ex_mem  ),
    .B_result_i (B_result_exu2ex_mem ),
    .opcode_i   (opcode_exu2ex_mem   ),
    .funct3_i   (funct3_exu2ex_mem   ),
    .funct7_i   (funct7_exu2ex_mem   ),
    .rd_i       (rd_exu2ex_mem       ),
    .rs2_data_i (rs2_data_exu2ex_mem ),
    .alu_out_o  (alu_out_ex_mem2memu  ),
    .B_result_o (B_result_ex_mem2memu ),
    .opcode_o   (opcode_ex_mem2memu   ),
    .funct3_o   (funct3_ex_mem2memu   ),
    .funct7_o   (funct7_ex_mem2memu   ),
    .rd_o       (rd_ex_mem2memu       ),
    .rs2_data_o (rs2_data_ex_mem2memu )
);

memu u_memu(
    .alu_out   (alu_out_ex_mem2memu   ),
    .B_result  (B_result_ex_mem2memu  ),
    .opcode    (opcode_ex_mem2memu    ),
    .funct3    (funct3_ex_mem2memu    ),
    .funct7    (funct7_ex_mem2memu    ),
    .rd        (rd_ex_mem2memu        ),
    .rs2_data  (rs2_data_ex_mem2memu  ),
    .Data_addr (Data_addr_memu2Data_mem ),
    .Data_in   (Data_in_Data_mem2memu   ),
    .Data_out  (Data_out_memu2Data_mem  ),
    .we        (we_memu2Data_mem        ),
    .wa        (wa_memu2Data_mem        ),
    .load_out  (load_out_memu2mem_wb  ),
    .alu_out_o (alu_out_memu2mem_wb ),
    .opcode_o  (opcode_memu2mem_wb  ),
    .funct3_o  (funct3_memu2mem_wb  ),
    .funct7_o  (funct7_memu2mem_wb  ),
    .rd_o      (rd_memu2mem_wb      )
);

Data_mem u_Data_mem(
    .clk    (clk    ),
    .rst_n  (rst_n_mem  ),
    .Data_i (Data_out_memu2Data_mem ),
    .addr   (Data_addr_memu2Data_mem   ),
    .we     (we_memu2Data_mem     ),
    .wa     (wa_memu2Data_mem     ),
    .Data_o (Data_in_Data_mem2memu )
);

mem_wb u_mem_wb(
    .clk        (clk        ),
    .rst_n      (rst_n      ),
    .alu_out_i  (alu_out_memu2mem_wb  ),
    .opcode_i   (opcode_memu2mem_wb   ),
    .funct3_i   (funct3_memu2mem_wb   ),
    .funct7_i   (funct7_memu2mem_wb   ),
    .load_out_i (load_out_memu2mem_wb ),
    .rd_i       (rd_memu2mem_wb       ),
    .alu_out_o  (alu_out_mem_wb2wbu  ),
    .opcode_o   (opcode_mem_wb2wbu   ),
    .funct3_o   (funct3_mem_wb2wbu   ),
    .funct7_o   (funct7_mem_wb2wbu   ),
    .load_out_o (load_out_mem_wb2wbu ),
    .rd_o       (rd_mem_wb2wbu       )
);

wbu u_wbu(
    .alu_out  (alu_out_mem_wb2wbu  ),
    .opcode   (opcode_mem_wb2wbu   ),
    .funct3   (funct3_mem_wb2wbu   ),
    .funct7   (funct7_mem_wb2wbu   ),
    .load_out (load_out_mem_wb2wbu ),
    .rd_i     (rd_mem_wb2wbu     ),
    .rd_o     (rd_wbu2regs     ),
    .wr_en    (wr_en_wbu2regs    ),
    .rd_data  (rd_data_wbu2regs  )
);


endmodule