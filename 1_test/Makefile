led.bin:led_test.s
	arm-linux-gnueabihf-gcc -g -c led_test.s -o led.o
	#arm-linux-gnueabihf-ld -Ttext 0X90000000 led.o -o led.elf
	#内部储存启动
	arm-linux-gnueabihf-ld -Ttext 0X87800000 led.o -o led.elf
	#SD卡
	arm-linux-gnueabihf-objcopy -O binary -S -g led.elf led.bin
	arm-linux-gnueabihf-objdump -D led.elf > led.dis
clean:
	rm -rf *.o led.bin led.elf led.dis

