# 基于RISC-V32I基础指令集开发的五级流水线单发射处理器

该项目目前还是个半成品，目前已经验证了addi指令。但是还无法解决数据冲突，需要添加旁路。此外该处理器暂不支持跳转指令

## 该项目的文件层次如下：

> define.v定义了一些宏，例如opcode，用于代替rtl中的操作码
>
> core文件下是处理器的rtl代码，顶层文件是cpu_top.v  
>> - ifu.v是取指单元 
>> - idu.v是译码单元 
>> - exu.v是执行单元
>> - memu.v是访存单元
>> - wbu.v是写回单元
>> - regs.v是寄存器组
>> - Inst_mem.v是指令ram
>> - Data_mem.v是数据ram
>> - 其余例如if_id.v的模块是两级流水线之间的寄存器
>>
> tb文件夹下为testbench  
> asm文件夹下为一个简易的汇编器，asm.txt为输入的汇编语言，output.txt为生产的机器码，可以直接输入到指令ram中  

