/*
    描述： _start 函数，程序从此函数开始执行，此函数主要功能是设置 C
    Version:1.0   date:2020-10-30
    Author:yanzong
*/
.global _start /* 全局标号 */
_start:

/* 进入 SVC 模式 */
    MRS R0, CPSR            @将特殊功能寄存器（程序状态寄存器）的值装载到通用寄存器R0中
    BIC R0, R0, #0x1f       /* (BIC:位清除)将 r0 的低 5 位清零，也就是 CPSR 的 M0~M4 */
    ORR R0, R0, #0x13       /* (ORR:按位或)r0 或上 0x13,0001 0011 表示使用 SVC(超级监管者13) 模式 */
    MSR CPSR,R0             @将R0还给CPSR
    LDR SP, =0x80200000     /* 设置栈指针 */
    B main                  @梦开始的地方


