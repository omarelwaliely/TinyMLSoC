
test.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <start>:
   0:	00000093          	li	ra,0
   4:	20002117          	auipc	sp,0x20002
   8:	ffc10113          	add	sp,sp,-4 # 20002000 <_stack>
   c:	00000193          	li	gp,0
  10:	00000213          	li	tp,0
  14:	00000293          	li	t0,0
  18:	00000313          	li	t1,0
  1c:	00000393          	li	t2,0
  20:	00000413          	li	s0,0
  24:	00000493          	li	s1,0
  28:	00000513          	li	a0,0
  2c:	00000593          	li	a1,0
  30:	00000613          	li	a2,0
  34:	00000693          	li	a3,0
  38:	00000713          	li	a4,0
  3c:	00000793          	li	a5,0
  40:	00000813          	li	a6,0
  44:	00000893          	li	a7,0
  48:	00000913          	li	s2,0
  4c:	00000993          	li	s3,0
  50:	00000a13          	li	s4,0
  54:	00000a93          	li	s5,0
  58:	00000b13          	li	s6,0
  5c:	00000b93          	li	s7,0
  60:	00000c13          	li	s8,0
  64:	00000c93          	li	s9,0
  68:	00000d13          	li	s10,0
  6c:	00000d93          	li	s11,0
  70:	00000e13          	li	t3,0
  74:	00000e93          	li	t4,0
  78:	00000f13          	li	t5,0
  7c:	00000f93          	li	t6,0
  80:	00000517          	auipc	a0,0x0
  84:	17c50513          	add	a0,a0,380 # 1fc <_sidata>
  88:	20000597          	auipc	a1,0x20000
  8c:	f7858593          	add	a1,a1,-136 # 20000000 <uart_data>
  90:	20000617          	auipc	a2,0x20000
  94:	f8860613          	add	a2,a2,-120 # 20000018 <_ebss>
  98:	00c5dc63          	bge	a1,a2,b0 <end_init_data>

0000009c <loop_init_data>:
  9c:	00052683          	lw	a3,0(a0)
  a0:	00d5a023          	sw	a3,0(a1)
  a4:	00450513          	add	a0,a0,4
  a8:	00458593          	add	a1,a1,4
  ac:	fec5c8e3          	blt	a1,a2,9c <loop_init_data>

000000b0 <end_init_data>:
  b0:	20000517          	auipc	a0,0x20000
  b4:	f6850513          	add	a0,a0,-152 # 20000018 <_ebss>
  b8:	20000597          	auipc	a1,0x20000
  bc:	f6058593          	add	a1,a1,-160 # 20000018 <_ebss>
  c0:	00b55863          	bge	a0,a1,d0 <end_init_bss>

000000c4 <loop_init_bss>:
  c4:	00052023          	sw	zero,0(a0)
  c8:	00450513          	add	a0,a0,4
  cc:	feb54ce3          	blt	a0,a1,c4 <loop_init_bss>

000000d0 <end_init_bss>:
  d0:	0a8000ef          	jal	178 <main>

000000d4 <loop>:
  d4:	0000006f          	j	d4 <loop>

000000d8 <uart_init>:
  d8:	200007b7          	lui	a5,0x20000
  dc:	0087a703          	lw	a4,8(a5) # 20000008 <uart_bauddiv>
  e0:	200007b7          	lui	a5,0x20000
  e4:	00c7a783          	lw	a5,12(a5) # 2000000c <uart_ctrl>
  e8:	00a72023          	sw	a0,0(a4)
  ec:	00100713          	li	a4,1
  f0:	00e7a023          	sw	a4,0(a5)
  f4:	00008067          	ret

000000f8 <uart_putc>:
  f8:	200007b7          	lui	a5,0x20000
  fc:	0047a703          	lw	a4,4(a5) # 20000004 <uart_status>
 100:	00072783          	lw	a5,0(a4)
 104:	fe078ee3          	beqz	a5,100 <uart_putc+0x8>
 108:	200007b7          	lui	a5,0x20000
 10c:	0007a783          	lw	a5,0(a5) # 20000000 <uart_data>
 110:	20000737          	lui	a4,0x20000
 114:	00c72703          	lw	a4,12(a4) # 2000000c <uart_ctrl>
 118:	00a7a023          	sw	a0,0(a5)
 11c:	00072783          	lw	a5,0(a4)
 120:	0027e793          	or	a5,a5,2
 124:	00f72023          	sw	a5,0(a4)
 128:	00008067          	ret

0000012c <uart_puts>:
 12c:	00054603          	lbu	a2,0(a0)
 130:	04060263          	beqz	a2,174 <uart_puts+0x48>
 134:	200007b7          	lui	a5,0x20000
 138:	0047a703          	lw	a4,4(a5) # 20000004 <uart_status>
 13c:	200007b7          	lui	a5,0x20000
 140:	0007a803          	lw	a6,0(a5) # 20000000 <uart_data>
 144:	200007b7          	lui	a5,0x20000
 148:	00c7a583          	lw	a1,12(a5) # 2000000c <uart_ctrl>
 14c:	00150693          	add	a3,a0,1
 150:	00072783          	lw	a5,0(a4)
 154:	fe078ee3          	beqz	a5,150 <uart_puts+0x24>
 158:	00c82023          	sw	a2,0(a6)
 15c:	0005a783          	lw	a5,0(a1)
 160:	00168693          	add	a3,a3,1
 164:	0027e793          	or	a5,a5,2
 168:	00f5a023          	sw	a5,0(a1)
 16c:	fff6c603          	lbu	a2,-1(a3)
 170:	fe0610e3          	bnez	a2,150 <uart_puts+0x24>
 174:	00008067          	ret

00000178 <main>:
 178:	200007b7          	lui	a5,0x20000
 17c:	0107a703          	lw	a4,16(a5) # 20000010 <gpio_oe>
 180:	200006b7          	lui	a3,0x20000
 184:	200007b7          	lui	a5,0x20000
 188:	0087a783          	lw	a5,8(a5) # 20000008 <uart_bauddiv>
 18c:	00c6a583          	lw	a1,12(a3) # 2000000c <uart_ctrl>
 190:	fff00693          	li	a3,-1
 194:	00d72023          	sw	a3,0(a4)
 198:	200006b7          	lui	a3,0x20000
 19c:	0006a503          	lw	a0,0(a3) # 20000000 <uart_data>
 1a0:	20000737          	lui	a4,0x20000
 1a4:	27100693          	li	a3,625
 1a8:	00472703          	lw	a4,4(a4) # 20000004 <uart_status>
 1ac:	00d7a023          	sw	a3,0(a5)
 1b0:	00100793          	li	a5,1
 1b4:	00f5a023          	sw	a5,0(a1)
 1b8:	1ed00813          	li	a6,493
 1bc:	00080613          	mv	a2,a6
 1c0:	04800693          	li	a3,72
 1c4:	00072783          	lw	a5,0(a4)
 1c8:	fe078ee3          	beqz	a5,1c4 <main+0x4c>
 1cc:	00d52023          	sw	a3,0(a0)
 1d0:	0005a783          	lw	a5,0(a1)
 1d4:	00064683          	lbu	a3,0(a2)
 1d8:	00160613          	add	a2,a2,1
 1dc:	0027e793          	or	a5,a5,2
 1e0:	00f5a023          	sw	a5,0(a1)
 1e4:	fe0690e3          	bnez	a3,1c4 <main+0x4c>
 1e8:	fd5ff06f          	j	1bc <main+0x44>
 1ec:	6548                	.insn	2, 0x6548
 1ee:	6c6c                	.insn	2, 0x6c6c
 1f0:	6f57206f          	j	730e4 <_sidata+0x72ee8>
 1f4:	6c72                	.insn	2, 0x6c72
 1f6:	2164                	.insn	2, 0x2164
 1f8:	000a                	.insn	2, 0x000a
	...

Disassembly of section .data:

20000000 <uart_data>:
20000000:	000c                	.insn	2, 0x000c
20000002:	5000                	.insn	2, 0x5000

20000004 <uart_status>:
20000004:	0008                	.insn	2, 0x0008
20000006:	5000                	.insn	2, 0x5000

20000008 <uart_bauddiv>:
20000008:	0004                	.insn	2, 0x0004
2000000a:	5000                	.insn	2, 0x5000

2000000c <uart_ctrl>:
2000000c:	0000                	.insn	2, 0x
2000000e:	5000                	.insn	2, 0x5000

20000010 <gpio_oe>:
20000010:	0004                	.insn	2, 0x0004
20000012:	4000                	.insn	2, 0x4000

20000014 <gpio_data>:
20000014:	0000                	.insn	2, 0x
20000016:	4000                	.insn	2, 0x4000

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	2941                	.insn	2, 0x2941
   2:	0000                	.insn	2, 0x
   4:	7200                	.insn	2, 0x7200
   6:	7369                	.insn	2, 0x7369
   8:	01007663          	bgeu	zero,a6,14 <start+0x14>
   c:	001f 0000 1004      	.insn	6, 0x10040000001f
  12:	7205                	.insn	2, 0x7205
  14:	3376                	.insn	2, 0x3376
  16:	6932                	.insn	2, 0x6932
  18:	7032                	.insn	2, 0x7032
  1a:	5f31                	.insn	2, 0x5f31
  1c:	326d                	.insn	2, 0x326d
  1e:	3070                	.insn	2, 0x3070
  20:	7a5f 6d6d 6c75      	.insn	6, 0x6c756d6d7a5f
  26:	7031                	.insn	2, 0x7031
  28:	0030                	.insn	2, 0x0030

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	.insn	4, 0x3a434347
   4:	2820                	.insn	2, 0x2820
   6:	39386367          	.insn	4, 0x39386367
   a:	6431                	.insn	2, 0x6431
   c:	6438                	.insn	2, 0x6438
   e:	20293263          	.insn	4, 0x20293263
  12:	3331                	.insn	2, 0x3331
  14:	322e                	.insn	2, 0x322e
  16:	302e                	.insn	2, 0x302e
	...
