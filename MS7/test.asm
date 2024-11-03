
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
  84:	25850513          	add	a0,a0,600 # 2d8 <_sidata>
  88:	20000597          	auipc	a1,0x20000
  8c:	f7858593          	add	a1,a1,-136 # 20000000 <uart_data>
  90:	20000617          	auipc	a2,0x20000
  94:	f9460613          	add	a2,a2,-108 # 20000024 <_ebss>
  98:	00c5dc63          	bge	a1,a2,b0 <end_init_data>

0000009c <loop_init_data>:
  9c:	00052683          	lw	a3,0(a0)
  a0:	00d5a023          	sw	a3,0(a1)
  a4:	00450513          	add	a0,a0,4
  a8:	00458593          	add	a1,a1,4
  ac:	fec5c8e3          	blt	a1,a2,9c <loop_init_data>

000000b0 <end_init_data>:
  b0:	20000517          	auipc	a0,0x20000
  b4:	f7450513          	add	a0,a0,-140 # 20000024 <_ebss>
  b8:	20000597          	auipc	a1,0x20000
  bc:	f6c58593          	add	a1,a1,-148 # 20000024 <_ebss>
  c0:	00b55863          	bge	a0,a1,d0 <end_init_bss>

000000c4 <loop_init_bss>:
  c4:	00052023          	sw	zero,0(a0)
  c8:	00450513          	add	a0,a0,4
  cc:	feb54ce3          	blt	a0,a1,c4 <loop_init_bss>

000000d0 <end_init_bss>:
  d0:	178000ef          	jal	248 <main>

000000d4 <loop>:
  d4:	0000006f          	j	d4 <loop>

000000d8 <delay>:
  d8:	000017b7          	lui	a5,0x1
  dc:	77078793          	add	a5,a5,1904 # 1770 <_sidata+0x1498>
  e0:	02f50533          	mul	a0,a0,a5
  e4:	200007b7          	lui	a5,0x20000
  e8:	0107a783          	lw	a5,16(a5) # 20000010 <LOAD_VALUE>
  ec:	20000737          	lui	a4,0x20000
  f0:	01472703          	lw	a4,20(a4) # 20000014 <TIMER_STATUS>
  f4:	00a7a023          	sw	a0,0(a5)
  f8:	00100793          	li	a5,1
  fc:	00f72023          	sw	a5,0(a4)
 100:	00072783          	lw	a5,0(a4)
 104:	1007f793          	and	a5,a5,256
 108:	fe078ce3          	beqz	a5,100 <delay+0x28>
 10c:	00008067          	ret

00000110 <uart_init>:
 110:	200007b7          	lui	a5,0x20000
 114:	0087a703          	lw	a4,8(a5) # 20000008 <uart_bauddiv>
 118:	200007b7          	lui	a5,0x20000
 11c:	00c7a783          	lw	a5,12(a5) # 2000000c <uart_ctrl>
 120:	00a72023          	sw	a0,0(a4)
 124:	00100713          	li	a4,1
 128:	00e7a023          	sw	a4,0(a5)
 12c:	00008067          	ret

00000130 <uart_putc>:
 130:	200007b7          	lui	a5,0x20000
 134:	0047a703          	lw	a4,4(a5) # 20000004 <uart_status>
 138:	00072783          	lw	a5,0(a4)
 13c:	fe078ee3          	beqz	a5,138 <uart_putc+0x8>
 140:	200007b7          	lui	a5,0x20000
 144:	0007a783          	lw	a5,0(a5) # 20000000 <uart_data>
 148:	20000737          	lui	a4,0x20000
 14c:	00c72703          	lw	a4,12(a4) # 2000000c <uart_ctrl>
 150:	00a7a023          	sw	a0,0(a5)
 154:	00072783          	lw	a5,0(a4)
 158:	0027e793          	or	a5,a5,2
 15c:	00f72023          	sw	a5,0(a4)
 160:	00008067          	ret

00000164 <uart_puts>:
 164:	00054603          	lbu	a2,0(a0)
 168:	04060263          	beqz	a2,1ac <uart_puts+0x48>
 16c:	200007b7          	lui	a5,0x20000
 170:	0047a703          	lw	a4,4(a5) # 20000004 <uart_status>
 174:	200007b7          	lui	a5,0x20000
 178:	0007a803          	lw	a6,0(a5) # 20000000 <uart_data>
 17c:	200007b7          	lui	a5,0x20000
 180:	00c7a583          	lw	a1,12(a5) # 2000000c <uart_ctrl>
 184:	00150693          	add	a3,a0,1
 188:	00072783          	lw	a5,0(a4)
 18c:	fe078ee3          	beqz	a5,188 <uart_puts+0x24>
 190:	00c82023          	sw	a2,0(a6)
 194:	0005a783          	lw	a5,0(a1)
 198:	00168693          	add	a3,a3,1
 19c:	0027e793          	or	a5,a5,2
 1a0:	00f5a023          	sw	a5,0(a1)
 1a4:	fff6c603          	lbu	a2,-1(a3)
 1a8:	fe0610e3          	bnez	a2,188 <uart_puts+0x24>
 1ac:	00008067          	ret

000001b0 <uart_puts_hex>:
 1b0:	ff010113          	add	sp,sp,-16
 1b4:	00410693          	add	a3,sp,4
 1b8:	01c00713          	li	a4,28
 1bc:	00900893          	li	a7,9
 1c0:	ffc00813          	li	a6,-4
 1c4:	00e557b3          	srl	a5,a0,a4
 1c8:	00f7f593          	and	a1,a5,15
 1cc:	ffc70713          	add	a4,a4,-4
 1d0:	03758613          	add	a2,a1,55
 1d4:	00b8e463          	bltu	a7,a1,1dc <uart_puts_hex+0x2c>
 1d8:	03058613          	add	a2,a1,48
 1dc:	00c68023          	sb	a2,0(a3)
 1e0:	00168693          	add	a3,a3,1
 1e4:	ff0710e3          	bne	a4,a6,1c4 <uart_puts_hex+0x14>
 1e8:	000017b7          	lui	a5,0x1
 1ec:	00414683          	lbu	a3,4(sp)
 1f0:	a0d78793          	add	a5,a5,-1523 # a0d <_sidata+0x735>
 1f4:	00f11623          	sh	a5,12(sp)
 1f8:	00010723          	sb	zero,14(sp)
 1fc:	04068263          	beqz	a3,240 <uart_puts_hex+0x90>
 200:	200007b7          	lui	a5,0x20000
 204:	0047a703          	lw	a4,4(a5) # 20000004 <uart_status>
 208:	200007b7          	lui	a5,0x20000
 20c:	0007a503          	lw	a0,0(a5) # 20000000 <uart_data>
 210:	200007b7          	lui	a5,0x20000
 214:	00c7a583          	lw	a1,12(a5) # 2000000c <uart_ctrl>
 218:	00510613          	add	a2,sp,5
 21c:	00072783          	lw	a5,0(a4)
 220:	fe078ee3          	beqz	a5,21c <uart_puts_hex+0x6c>
 224:	00d52023          	sw	a3,0(a0)
 228:	0005a783          	lw	a5,0(a1)
 22c:	00064683          	lbu	a3,0(a2)
 230:	00160613          	add	a2,a2,1
 234:	0027e793          	or	a5,a5,2
 238:	00f5a023          	sw	a5,0(a1)
 23c:	fe0690e3          	bnez	a3,21c <uart_puts_hex+0x6c>
 240:	01010113          	add	sp,sp,16
 244:	00008067          	ret

00000248 <main>:
 248:	200007b7          	lui	a5,0x20000
 24c:	01c7a683          	lw	a3,28(a5) # 2000001c <gpio_oe_A>
 250:	fe010113          	add	sp,sp,-32
 254:	200007b7          	lui	a5,0x20000
 258:	0087a703          	lw	a4,8(a5) # 20000008 <uart_bauddiv>
 25c:	00812c23          	sw	s0,24(sp)
 260:	00912a23          	sw	s1,20(sp)
 264:	01212823          	sw	s2,16(sp)
 268:	01312623          	sw	s3,12(sp)
 26c:	01412423          	sw	s4,8(sp)
 270:	00112e23          	sw	ra,28(sp)
 274:	200007b7          	lui	a5,0x20000
 278:	fff00613          	li	a2,-1
 27c:	00c7a783          	lw	a5,12(a5) # 2000000c <uart_ctrl>
 280:	00c6a023          	sw	a2,0(a3)
 284:	200006b7          	lui	a3,0x20000
 288:	0106aa03          	lw	s4,16(a3) # 20000010 <LOAD_VALUE>
 28c:	200006b7          	lui	a3,0x20000
 290:	0146a403          	lw	s0,20(a3) # 20000014 <TIMER_STATUS>
 294:	27100693          	li	a3,625
 298:	00d72023          	sw	a3,0(a4)
 29c:	00092937          	lui	s2,0x92
 2a0:	00100713          	li	a4,1
 2a4:	00e7a023          	sw	a4,0(a5)
 2a8:	00000493          	li	s1,0
 2ac:	7c090913          	add	s2,s2,1984 # 927c0 <_sidata+0x924e8>
 2b0:	00100993          	li	s3,1
 2b4:	00148493          	add	s1,s1,1
 2b8:	00048513          	mv	a0,s1
 2bc:	ef5ff0ef          	jal	1b0 <uart_puts_hex>
 2c0:	012a2023          	sw	s2,0(s4)
 2c4:	01342023          	sw	s3,0(s0)
 2c8:	00042783          	lw	a5,0(s0)
 2cc:	1007f793          	and	a5,a5,256
 2d0:	fe078ce3          	beqz	a5,2c8 <main+0x80>
 2d4:	fe1ff06f          	j	2b4 <main+0x6c>

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

20000010 <LOAD_VALUE>:
20000010:	0004                	.insn	2, 0x0004
20000012:	4300                	.insn	2, 0x4300

20000014 <TIMER_STATUS>:
20000014:	0000                	.insn	2, 0x
20000016:	4300                	.insn	2, 0x4300

20000018 <i2s_data>:
20000018:	0000                	.insn	2, 0x
2000001a:	4400                	.insn	2, 0x4400

2000001c <gpio_oe_A>:
2000001c:	0004                	.insn	2, 0x0004
2000001e:	4000                	.insn	2, 0x4000

20000020 <gpio_data_A>:
20000020:	0000                	.insn	2, 0x
20000022:	4000                	.insn	2, 0x4000

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
