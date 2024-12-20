CROSS=riscv64-unknown-elf-
CFLAGS=-march=rv32ic_zicsr -mabi=ilp32 -ffreestanding -nostdlib -O3 -Wall 
LFLAGS=-Wl,--build-id=none,-Bstatic,-T,link.ld,--strip-debug
VFILES=FRV_SoC.f
TBFILES=FRV_SoC_tb.v


# Rule for simulation using iverilog

sim: test.vvp
	vvp test.vvp

sim_testing: 
	iverilog -f $(VFILES) -o test.vvp $(TBFILES) 
	vvp test.vvp
	gtkwave test.vcd

# Compile Verilog files and testbench into a vvp file for simulation
test.vvp: $(VFILES) $(TBFILES) test.hex
	iverilog -f $(VFILES) -o test.vvp $(TBFILES)


# Generate test.hex file from test.elf
test.hex: test.elf
	$(CROSS)objdump -D test.elf > test.asm
	$(CROSS)objcopy --verilog-data-width=4 -O verilog test.elf test.hex


test2.hex: test2.elf
	$(CROSS)objdump -D test2.elf > test2.asm
	$(CROSS)objcopy --verilog-data-width=4 -O verilog test2.elf test2.hex
	

# Compile the C code into a RISC-V ELF executable
test.elf: link.ld crt.s test.c
	$(CROSS)gcc $(CFLAGS) $(LFLAGS) -o test.elf crt.s test.c

test2.elf: link.ld crt.s test2.c
	$(CROSS)gcc $(CFLAGS) $(LFLAGS) -o test2.elf crt.s test2.c

# A pseudo target to ensure hex files are generated before simulation
hex: test.hex

hex2: test2.hex

# Default target to build everything
all: sim

# Clean up generated files
clean:
	rm -f $(filter-out i2s_test.hex, $(wildcard *.elf *.hex *.vvp *.asm *.o))


runass: 
	$(CROSS)as -o test.o test.s
	$(CROSS)objcopy --verilog-data-width=4 -O verilog test.elf test.hex
	iverilog -f $(VFILES) -o test.vvp $(TBFILES)
	vvp test.vvp

runfpga: yosysfpga routing icepacking prog


yosysfpga: 
	yosys -p "synth_ice40 -top top -json top.json" top.v Hazard2_SoC.v hazard2_cpu.v Hazard2.v FRV_AHBL.v FRV_SoC.v FemtoRV32.v ahbl_splitter.v ahbl_splitter_cross.v ahbl_gpio_splitter.v ahbl_ram.v ahbl_rom.v ahbl_gpio.v uart_tx.v serial_terminal.v ahbl_uart_tx.v upcounter.v ahbl_timer.v apb.v apb_slave.v apb2ahbl.v apb_gpio.v FIFO.v i2s.v i2s_test.v ahbl_i2s.v ahbl_crossbar.v ahbl_arbiter.v onehot_mux.v onehot_priority.v

routing:
	nextpnr-ice40 --up5k  --package sg48 --json top.json --asc top.asc --pcf  SoC.pcf --pcf-allow-unconstrained

icepacking:
	icepack top.asc top.bin

prog:
	iceprog top.bin
