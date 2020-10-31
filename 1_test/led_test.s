/*
    点亮LED汇编程序
    Author:yanzong
    Version:1.0 Date:2020-10-30 点灯
    Version:1.1 Date:2020-10-31 基本条件判断实现点灯
    Describe:none
 */

.global _start

_start:
    /*
        1、开时钟
    */
    ldr r0,=0X020c4068      @0x020c4068 CCM里的CCGR0的地址
    ldr r1,=0Xffffffff      @0xffffffff  全部使能
    str r1,[r0]             @将r1的数据装载到r0这个地址里

    ldr r0,=0X020C406C      @0X020C406C CCM里的CCGR1的地址
    str r1,[r0]             @将r1的数据装载到r0这个地址里

    ldr r0, =0X020C4070     /* 寄存器 CCGR2 */
    str r1, [r0]

    ldr r0, =0X020C4074     /* 寄存器 CCGR3 */
    str r1, [r0]

    ldr r0, =0X020C4078     /* 寄存器 CCGR4 */
    str r1, [r0]

    ldr r0, =0X020C407C     /* 寄存器 CCGR5 */
    str r1, [r0]

    ldr r0, =0X020C4080     /* 寄存器 CCGR6 */
    str r1, [r0]

    /*
        2、设置复用
    */
    ldr r0,=0X020E0068      @将寄存器  SW_MUX_GPIO1_IO03_BASE 加载到 r0 中
    ldr r1,=0x05            @设置寄存器SW_MUX_GPIO1_IO03_BASE 的 MUX_MODE 为 ALE5 GPIO模式 
    str r1,[r0]             @赋值
    /* 
        3、配置GPIO1_IO3 的 IO 属性
            bit [16]:0 HYS（输入滤波） 关闭-----0
            bit [15-14]:00 下拉----------------0
            bit [13]:0 状态保持 1：上下拉-------0
            bit [12]:0 禁止上下拉保持 1：使能---1
            bit [11]:0 关闭开路输出------------0
            bit [7-6]:10 速度 100mhz----------10
            bit [5-3]:110 R0/6 驱动能力-------110
            bit [0]: 0 高低电平摆率-------------0
    */
    ldr r0,=0X020e02f4      @寄存器 SW_PAD_GPIO1_IO03_BASE
    ldr r1,=0X10B0          @0001 0000 1011 0000    根据上述配置
    str r1,[r0]             @赋值

    /* 
        4、设置 GPIO1_IO03 为输出 
    */
    ldr r0,=0X0209C004      @寄存器GPIO1_GDIR方向寄存器 （0输入or1输出）
    ldr r1,=0X8             @0000 0000 0000 1000  bit3 输出
    str r1,[r0]             @赋值

    /*
        5、打开LED
        设置GPIO1_IO03为低电平
     */
    ldr r0,=0X0209C000     @寄存器GPIO1_DR 地址
    ldr r1,=0X00000008     @0 低电平
    str r1,[r0]            @赋值
    ldr r2,=0xfffff        @赋值延时
    ldr r3,=0x7ffff        @medi
    ldr r4,=0x0            @low


led_on:
    ldr r1,=0x0            @开灯
    str r1,[r0]            @赋值
    b loop
led_off:
    ldr r2,=0xfffff        @赋值延时
    ldr r1,=0x8            @关灯
    str r1,[r0]            @赋值
    b loop
/*
    死循环，相当于while(1);
 */
loop:
    str r1,[r0]            @赋值
    
    sub r2,#0x1            @r2-1(带借位)
    
    cmp r2,r3               @比较
    BEQ led_on

    cmp r2,r4            @LED_off
    BEQ led_off




    b loop

