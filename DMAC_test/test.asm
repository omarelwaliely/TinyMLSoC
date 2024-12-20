
test.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <start>:
   0:	4081                	li	ra,0
   2:	20002117          	auipc	sp,0x20002
   6:	ffe10113          	add	sp,sp,-2 # 20002000 <_stack>
   a:	4181                	li	gp,0
   c:	4201                	li	tp,0
   e:	4281                	li	t0,0
  10:	4301                	li	t1,0
  12:	4381                	li	t2,0
  14:	4401                	li	s0,0
  16:	4481                	li	s1,0
  18:	4501                	li	a0,0
  1a:	4581                	li	a1,0
  1c:	4601                	li	a2,0
  1e:	4681                	li	a3,0
  20:	4701                	li	a4,0
  22:	4781                	li	a5,0
  24:	4801                	li	a6,0
  26:	4881                	li	a7,0
  28:	4901                	li	s2,0
  2a:	4981                	li	s3,0
  2c:	4a01                	li	s4,0
  2e:	4a81                	li	s5,0
  30:	4b01                	li	s6,0
  32:	4b81                	li	s7,0
  34:	4c01                	li	s8,0
  36:	4c81                	li	s9,0
  38:	4d01                	li	s10,0
  3a:	4d81                	li	s11,0
  3c:	4e01                	li	t3,0
  3e:	4e81                	li	t4,0
  40:	4f01                	li	t5,0
  42:	4f81                	li	t6,0
  44:	00000517          	auipc	a0,0x0
  48:	2cc50513          	add	a0,a0,716 # 310 <_sidata>
  4c:	20000597          	auipc	a1,0x20000
  50:	fb458593          	add	a1,a1,-76 # 20000000 <uart_data>
  54:	20000617          	auipc	a2,0x20000
  58:	fe060613          	add	a2,a2,-32 # 20000034 <flag>
  5c:	00c5d863          	bge	a1,a2,6c <end_init_data>

00000060 <loop_init_data>:
  60:	4114                	lw	a3,0(a0)
  62:	c194                	sw	a3,0(a1)
  64:	0511                	add	a0,a0,4
  66:	0591                	add	a1,a1,4
  68:	fec5cce3          	blt	a1,a2,60 <loop_init_data>

0000006c <end_init_data>:
  6c:	20000517          	auipc	a0,0x20000
  70:	fc850513          	add	a0,a0,-56 # 20000034 <flag>
  74:	80418593          	add	a1,gp,-2044 # 20000038 <_ebss>
  78:	00b55763          	bge	a0,a1,86 <end_init_bss>

0000007c <loop_init_bss>:
  7c:	00052023          	sw	zero,0(a0)
  80:	0511                	add	a0,a0,4
  82:	feb54de3          	blt	a0,a1,7c <loop_init_bss>

00000086 <end_init_bss>:
  86:	2aed                	jal	280 <main>

00000088 <loop>:
  88:	a001                	j	88 <loop>

0000008a <enable_IRQ>:
  8a:	40000793          	li	a5,1024
  8e:	30579073          	csrw	mtvec,a5
  92:	30046073          	csrs	mstatus,8
  96:	30446073          	csrs	mie,8
  9a:	8082                	ret

0000009c <return_m>:
  9c:	30200073          	mret
  a0:	8082                	ret

000000a2 <delay>:
  a2:	00151793          	sll	a5,a0,0x1
  a6:	97aa                	add	a5,a5,a0
  a8:	0792                	sll	a5,a5,0x4
  aa:	20000737          	lui	a4,0x20000
  ae:	8f89                	sub	a5,a5,a0
  b0:	01072683          	lw	a3,16(a4) # 20000010 <LOAD_VALUE>
  b4:	078e                	sll	a5,a5,0x3
  b6:	20000737          	lui	a4,0x20000
  ba:	01472703          	lw	a4,20(a4) # 20000014 <TIMER_STATUS>
  be:	8f89                	sub	a5,a5,a0
  c0:	0792                	sll	a5,a5,0x4
  c2:	c29c                	sw	a5,0(a3)
  c4:	4785                	li	a5,1
  c6:	c31c                	sw	a5,0(a4)
  c8:	431c                	lw	a5,0(a4)
  ca:	1007f793          	and	a5,a5,256
  ce:	dfed                	beqz	a5,c8 <delay+0x26>
  d0:	8082                	ret

000000d2 <uart_init>:
  d2:	200007b7          	lui	a5,0x20000
  d6:	0087a703          	lw	a4,8(a5) # 20000008 <uart_bauddiv>
  da:	200007b7          	lui	a5,0x20000
  de:	00c7a783          	lw	a5,12(a5) # 2000000c <uart_ctrl>
  e2:	c308                	sw	a0,0(a4)
  e4:	4705                	li	a4,1
  e6:	c398                	sw	a4,0(a5)
  e8:	8082                	ret

000000ea <uart_putc>:
  ea:	200007b7          	lui	a5,0x20000
  ee:	0047a703          	lw	a4,4(a5) # 20000004 <uart_status>
  f2:	431c                	lw	a5,0(a4)
  f4:	dffd                	beqz	a5,f2 <uart_putc+0x8>
  f6:	200007b7          	lui	a5,0x20000
  fa:	0007a783          	lw	a5,0(a5) # 20000000 <uart_data>
  fe:	20000737          	lui	a4,0x20000
 102:	00c72703          	lw	a4,12(a4) # 2000000c <uart_ctrl>
 106:	c388                	sw	a0,0(a5)
 108:	431c                	lw	a5,0(a4)
 10a:	0027e793          	or	a5,a5,2
 10e:	c31c                	sw	a5,0(a4)
 110:	8082                	ret

00000112 <uart_puts>:
 112:	00054603          	lbu	a2,0(a0)
 116:	ca1d                	beqz	a2,14c <uart_puts+0x3a>
 118:	200007b7          	lui	a5,0x20000
 11c:	0047a703          	lw	a4,4(a5) # 20000004 <uart_status>
 120:	200007b7          	lui	a5,0x20000
 124:	0007a803          	lw	a6,0(a5) # 20000000 <uart_data>
 128:	200007b7          	lui	a5,0x20000
 12c:	00c7a583          	lw	a1,12(a5) # 2000000c <uart_ctrl>
 130:	00150693          	add	a3,a0,1
 134:	431c                	lw	a5,0(a4)
 136:	dffd                	beqz	a5,134 <uart_puts+0x22>
 138:	00c82023          	sw	a2,0(a6)
 13c:	419c                	lw	a5,0(a1)
 13e:	0685                	add	a3,a3,1
 140:	0027e793          	or	a5,a5,2
 144:	c19c                	sw	a5,0(a1)
 146:	fff6c603          	lbu	a2,-1(a3)
 14a:	f66d                	bnez	a2,134 <uart_puts+0x22>
 14c:	8082                	ret

0000014e <uart_puts_hex>:
 14e:	01c55793          	srl	a5,a0,0x1c
 152:	4725                	li	a4,9
 154:	1141                	add	sp,sp,-16
 156:	03778693          	add	a3,a5,55
 15a:	00f74463          	blt	a4,a5,162 <uart_puts_hex+0x14>
 15e:	03078693          	add	a3,a5,48
 162:	41855793          	sra	a5,a0,0x18
 166:	00f7f713          	and	a4,a5,15
 16a:	4625                	li	a2,9
 16c:	03070813          	add	a6,a4,48
 170:	00e65463          	bge	a2,a4,178 <uart_puts_hex+0x2a>
 174:	03770813          	add	a6,a4,55
 178:	41455793          	sra	a5,a0,0x14
 17c:	00f7f713          	and	a4,a5,15
 180:	4625                	li	a2,9
 182:	03070e13          	add	t3,a4,48
 186:	00e65463          	bge	a2,a4,18e <uart_puts_hex+0x40>
 18a:	03770e13          	add	t3,a4,55
 18e:	41055793          	sra	a5,a0,0x10
 192:	00f7f713          	and	a4,a5,15
 196:	4625                	li	a2,9
 198:	03070f13          	add	t5,a4,48
 19c:	00e65463          	bge	a2,a4,1a4 <uart_puts_hex+0x56>
 1a0:	03770f13          	add	t5,a4,55
 1a4:	40c55793          	sra	a5,a0,0xc
 1a8:	00f7f713          	and	a4,a5,15
 1ac:	4625                	li	a2,9
 1ae:	03070e93          	add	t4,a4,48
 1b2:	00e65463          	bge	a2,a4,1ba <uart_puts_hex+0x6c>
 1b6:	03770e93          	add	t4,a4,55
 1ba:	40855793          	sra	a5,a0,0x8
 1be:	00f7f713          	and	a4,a5,15
 1c2:	4625                	li	a2,9
 1c4:	03070313          	add	t1,a4,48
 1c8:	00e65463          	bge	a2,a4,1d0 <uart_puts_hex+0x82>
 1cc:	03770313          	add	t1,a4,55
 1d0:	40455793          	sra	a5,a0,0x4
 1d4:	00f7f713          	and	a4,a5,15
 1d8:	4625                	li	a2,9
 1da:	03070893          	add	a7,a4,48
 1de:	00e65463          	bge	a2,a4,1e6 <uart_puts_hex+0x98>
 1e2:	03770893          	add	a7,a4,55
 1e6:	00f57793          	and	a5,a0,15
 1ea:	4725                	li	a4,9
 1ec:	03778613          	add	a2,a5,55
 1f0:	00f74463          	blt	a4,a5,1f8 <uart_puts_hex+0xaa>
 1f4:	03078613          	add	a2,a5,48
 1f8:	200005b7          	lui	a1,0x20000
 1fc:	0005a503          	lw	a0,0(a1) # 20000000 <uart_data>
 200:	20000737          	lui	a4,0x20000
 204:	200005b7          	lui	a1,0x20000
 208:	6785                	lui	a5,0x1
 20a:	00472703          	lw	a4,4(a4) # 20000004 <uart_status>
 20e:	00c5a583          	lw	a1,12(a1) # 2000000c <uart_ctrl>
 212:	a0d78793          	add	a5,a5,-1523 # a0d <_sidata+0x6fd>
 216:	00c105a3          	sb	a2,11(sp)
 21a:	00d10223          	sb	a3,4(sp)
 21e:	010102a3          	sb	a6,5(sp)
 222:	01c10323          	sb	t3,6(sp)
 226:	01e103a3          	sb	t5,7(sp)
 22a:	01d10423          	sb	t4,8(sp)
 22e:	006104a3          	sb	t1,9(sp)
 232:	01110523          	sb	a7,10(sp)
 236:	00f11623          	sh	a5,12(sp)
 23a:	00010723          	sb	zero,14(sp)
 23e:	00510613          	add	a2,sp,5
 242:	431c                	lw	a5,0(a4)
 244:	dffd                	beqz	a5,242 <uart_puts_hex+0xf4>
 246:	c114                	sw	a3,0(a0)
 248:	419c                	lw	a5,0(a1)
 24a:	00064683          	lbu	a3,0(a2)
 24e:	0605                	add	a2,a2,1
 250:	0027e793          	or	a5,a5,2
 254:	c19c                	sw	a5,0(a1)
 256:	f6f5                	bnez	a3,242 <uart_puts_hex+0xf4>
 258:	0141                	add	sp,sp,16
 25a:	8082                	ret

0000025c <reverse_bits>:
 25c:	862a                	mv	a2,a0
 25e:	4701                	li	a4,0
 260:	4501                	li	a0,0
 262:	487d                	li	a6,31
 264:	02000593          	li	a1,32
 268:	00e657b3          	srl	a5,a2,a4
 26c:	40e806b3          	sub	a3,a6,a4
 270:	8b85                	and	a5,a5,1
 272:	00d797b3          	sll	a5,a5,a3
 276:	0705                	add	a4,a4,1
 278:	8d5d                	or	a0,a0,a5
 27a:	feb717e3          	bne	a4,a1,268 <reverse_bits+0xc>
 27e:	8082                	ret

00000280 <main>:
 280:	1141                	add	sp,sp,-16
 282:	40000793          	li	a5,1024
 286:	30579073          	csrw	mtvec,a5
 28a:	30046073          	csrs	mstatus,8
 28e:	30446073          	csrs	mie,8
 292:	47a5                	li	a5,9
 294:	c43e                	sw	a5,8(sp)
 296:	200007b7          	lui	a5,0x20000
 29a:	0287a703          	lw	a4,40(a5) # 20000028 <i2s_en>
 29e:	46a2                	lw	a3,8(sp)
 2a0:	200007b7          	lui	a5,0x20000
 2a4:	0087a783          	lw	a5,8(a5) # 20000008 <uart_bauddiv>
 2a8:	20000637          	lui	a2,0x20000
 2ac:	00c62583          	lw	a1,12(a2) # 2000000c <uart_ctrl>
 2b0:	c314                	sw	a3,0(a4)
 2b2:	20000737          	lui	a4,0x20000
 2b6:	03072503          	lw	a0,48(a4) # 20000030 <gpio_data_A>
 2ba:	27100713          	li	a4,625
 2be:	c398                	sw	a4,0(a5)
 2c0:	200007b7          	lui	a5,0x20000
 2c4:	0247a603          	lw	a2,36(a5) # 20000024 <i2s_done>
 2c8:	200007b7          	lui	a5,0x20000
 2cc:	0207a303          	lw	t1,32(a5) # 20000020 <i2s_data>
 2d0:	200007b7          	lui	a5,0x20000
 2d4:	0047a683          	lw	a3,4(a5) # 20000004 <uart_status>
 2d8:	200007b7          	lui	a5,0x20000
 2dc:	0007a883          	lw	a7,0(a5) # 20000000 <uart_data>
 2e0:	4785                	li	a5,1
 2e2:	c19c                	sw	a5,0(a1)
 2e4:	478d                	li	a5,3
 2e6:	c11c                	sw	a5,0(a0)
 2e8:	470d                	li	a4,3
 2ea:	06700813          	li	a6,103
 2ee:	421c                	lw	a5,0(a2)
 2f0:	fee79fe3          	bne	a5,a4,2ee <main+0x6e>
 2f4:	00032783          	lw	a5,0(t1)
 2f8:	c63e                	sw	a5,12(sp)
 2fa:	47b2                	lw	a5,12(sp)
 2fc:	c11c                	sw	a5,0(a0)
 2fe:	429c                	lw	a5,0(a3)
 300:	dffd                	beqz	a5,2fe <main+0x7e>
 302:	0108a023          	sw	a6,0(a7)
 306:	419c                	lw	a5,0(a1)
 308:	0027e793          	or	a5,a5,2
 30c:	c19c                	sw	a5,0(a1)
 30e:	b7c5                	j	2ee <main+0x6e>

Disassembly of section .data:

20000000 <uart_data>:
20000000:	000c                	.insn	2, 0x000c
20000002:	8000                	.insn	2, 0x8000

20000004 <uart_status>:
20000004:	0008                	.insn	2, 0x0008
20000006:	8000                	.insn	2, 0x8000

20000008 <uart_bauddiv>:
20000008:	0004                	.insn	2, 0x0004
2000000a:	8000                	.insn	2, 0x8000

2000000c <uart_ctrl>:
2000000c:	0000                	unimp
2000000e:	8000                	.insn	2, 0x8000

20000010 <LOAD_VALUE>:
20000010:	0004                	.insn	2, 0x0004
20000012:	4300                	lw	s0,0(a4)

20000014 <TIMER_STATUS>:
20000014:	0000                	unimp
20000016:	4300                	lw	s0,0(a4)

20000018 <i2s_fifo_data>:
20000018:	0010                	.insn	2, 0x0010
2000001a:	4400                	lw	s0,8(s0)

2000001c <i2s_fifo_status>:
2000001c:	000c                	.insn	2, 0x000c
2000001e:	4400                	lw	s0,8(s0)

20000020 <i2s_data>:
20000020:	0008                	.insn	2, 0x0008
20000022:	4400                	lw	s0,8(s0)

20000024 <i2s_done>:
20000024:	0004                	.insn	2, 0x0004
20000026:	4400                	lw	s0,8(s0)

20000028 <i2s_en>:
20000028:	0000                	unimp
2000002a:	4400                	lw	s0,8(s0)

2000002c <gpio_oe_A>:
2000002c:	0004                	.insn	2, 0x0004
2000002e:	4000                	lw	s0,0(s0)

20000030 <gpio_data_A>:
20000030:	0000                	unimp
20000032:	4000                	lw	s0,0(s0)

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	2d41                	jal	690 <isr_handler+0x380>
   2:	0000                	unimp
   4:	7200                	.insn	2, 0x7200
   6:	7369                	lui	t1,0xffffa
   8:	01007663          	bgeu	zero,a6,14 <start+0x14>
   c:	00000023          	sb	zero,0(zero) # 0 <start>
  10:	1004                	add	s1,sp,32
  12:	7205                	lui	tp,0xfffe1
  14:	3376                	.insn	2, 0x3376
  16:	6932                	.insn	2, 0x6932
  18:	7032                	.insn	2, 0x7032
  1a:	5f31                	li	t5,-20
  1c:	30703263          	.insn	4, 0x30703263
  20:	7a5f 6369 7273      	.insn	6, 0x727363697a5f
  26:	7032                	.insn	2, 0x7032
  28:	0030                	add	a2,sp,8
  2a:	0108                	add	a0,sp,128
  2c:	0b0a                	sll	s6,s6,0x2

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	.insn	4, 0x3a434347
   4:	2820                	.insn	2, 0x2820
   6:	39386367          	.insn	4, 0x39386367
   a:	6431                	lui	s0,0xc
   c:	6438                	.insn	2, 0x6438
   e:	20293263          	.insn	4, 0x20293263
  12:	3331                	jal	fffffd1e <_stack+0xdfffdd1e>
  14:	322e                	.insn	2, 0x322e
  16:	302e                	.insn	2, 0x302e
	...

Disassembly of section .isr_handler_section:

00000310 <isr_handler>:
 310:	200007b7          	lui	a5,0x20000
 314:	4705                	li	a4,1
 316:	02e7aa23          	sw	a4,52(a5) # 20000034 <flag>
 31a:	30200073          	mret
 31e:	8082                	ret
