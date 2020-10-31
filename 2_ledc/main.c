/*
    描述： main.c 函数，业务逻辑执行的地方
    Version:1.0   date:2020-10-30
    Version:1.1    date:2020-10-31 确定了进入C的makefile格式 0X87800000
    Author:yanzong
*/

#include "main.h"

//使能CLK
void clk_enable(void)
{
    CCM_CCGR0 = 0xffffffff;
    CCM_CCGR1 = 0xffffffff;
    CCM_CCGR2 = 0xffffffff;
    CCM_CCGR3 = 0xffffffff;
    CCM_CCGR4 = 0xffffffff;
    CCM_CCGR5 = 0xffffffff;
    CCM_CCGR6 = 0xffffffff;
}

void led_init(void)
{
    /* 1、初始化 IO 复用, 复用为 GPIO1_IO03 */
    SW_MUX_GPIO1_IO03 = 0x5;

/* 2、配置 GPIO1_IO03 的 IO 属性
    *bit 16:0 HYS 关闭
    *bit [15:14]: 00 默认下拉
    *bit [13]: 0 kepper 功能
    *bit [12]: 1 pull/keeper 使能
    *bit [11]: 0 关闭开路输出
    *bit [7:6]: 10 速度 100Mhz
    *bit [5:3]: 110 R0/6 驱动能力
    *bit [0]: 0 低转换率
*/
    SW_PAD_GPIO1_IO03 = 0X10B0;

    /* 3、初始化 GPIO, GPIO1_IO03 设置为输出 */
    GPIO1_GDIR = 0X8;

    /* 4、设置 GPIO1_IO03 输出低电平，打开 LED0 */
    GPIO1_DR = 0X0;

}

void led_on(void)
{
    /*
    将 GPIO1_DR 的 bit3 清零
    */
    GPIO1_DR &= ~(1<<3);
}

void led_off(void)
{
    /*
    将 GPIO1_DR 的 bit3 置 1
    */
    GPIO1_DR |= (1<<3);
}


void delay_short(volatile unsigned int n)
{
    while(n--){}
}

void delay(volatile unsigned int n)
{
    while(n--){
        delay_short(0x7ff);
    }
}

int main(void)
{
    clk_enable(); /* 使能所有的时钟 */
    led_init(); /* 初始化 led */
    while(1) {
        led_on(); /* 打开 LED */
        delay(500); /* 延时大约 500ms */

        led_off(); /* 关闭 LED */
        delay(500); /* 延时大约 500ms */
    }

    return 0;
}

