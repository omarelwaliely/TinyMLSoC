General Notes

Github repo: YosysHQ/oss-cad-suite-build

Chip - ice40ulp

Yosys -- readmemh

Flash - GD25Q32

To run verilog files: `iverilog file_name.v`

UART - TX 8N1
UART -- 1 start bit (0) -- 8 bits data -- 1/2 stop bits (1)
Baud rate -- bits/sec or symbols/sec

Ex: Baud rate = 9600 bits/sec --> time to transfer 1 bit = 1/9600 = 104microsec
If freq = 12MHz --> T = 1/12M = 83.33msec
12M/9600 = 1250 = No of clk cycles needed to transfer to one bit
use a down counter that starts from 1250 and when 0 is reached reload.

