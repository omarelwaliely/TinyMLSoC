CROSS=riscv64-unknown-elf-
CFLAGS=-march=rv32i -mabi=ilp32 -ffreestanding -nostdlib -O2 -Wall 
LFLAGS=-Wl,--build-id=none,-Bstatic,-T,link.ld,--strip-debug
VFILES=Hazard2_SoC.f
TBFILES=Hazard2_SoC_tb.v

# Rule for simulation using iverilog

sim: test.vvp
	vvp test.vvp

simhex: 
	iverilog -f $(VFILES) -o test.vvp $(TBFILES)
	vvp test.vvp

# Compile Verilog files and testbench into a vvp file for simulation
test.vvp: $(VFILES) $(TBFILES) test.hex
	iverilog -f $(VFILES) -o test.vvp $(TBFILES)

# Generate test.hex file from test.elf
test.hex: test.elf
	$(CROSS)objdump -D test.elf > test.asm
	$(CROSS)objcopy --verilog-data-width=4 -O verilog test.elf test.hex

# Compile the C code into a RISC-V ELF executable
test.elf: link.ld crt.s test.c
	$(CROSS)gcc $(CFLAGS) $(LFLAGS) -o test.elf crt.s test.c

# A pseudo target to ensure hex files are generated before simulation
hex: test.hex

# Default target to build everything
all: sim

# Clean up generated files
clean:
	rm -f *.elf *.hex *.vvp *.asm *.o


runass: 
	$(CROSS)as -o test.o test.s
	$(CROSS)objcopy --verilog-data-width=4 -O verilog test.elf test.hex
	iverilog -f $(VFILES) -o test.vvp $(TBFILES)
	vvp test.vvp

runfpga: yosysfpga routing icepacking prog


yosysfpga: 
	yosys -p "synth_ice40 -top Hazard2_SoC -json Hazard2_SoC.json" Hazard2_SoC.v hazard2_cpu.v Hazard2.v ahbl_splitter.v ahbl_gpio_splitter.v ahbl_ram.v ahbl_rom.v ahbl_gpio.v lightcontrol.v

routing:
	nextpnr-ice40 --up5k  --package sg48 --json Hazard2_SoC.json --asc Hazard2_SoC.asc --pcf  SoC.pcf --pcf-allow-unconstrained

icepacking:
	icepack Hazard2_SoC.asc Hazard2_SoC.bin

prog:
	sudo iceprog Hazard2_SoC.bin