
test.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <start>:
   0:	4081                	li	ra,0
   2:	20002117          	auipc	sp,0x20002
   6:	ffe10113          	addi	sp,sp,-2 # 20002000 <_stack>
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
  48:	2bc50513          	addi	a0,a0,700 # 300 <_sidata>
  4c:	20000597          	auipc	a1,0x20000
  50:	fb458593          	addi	a1,a1,-76 # 20000000 <uart_data>
  54:	20000617          	auipc	a2,0x20000
  58:	fe060613          	addi	a2,a2,-32 # 20000034 <flag>
  5c:	00c5d863          	bge	a1,a2,6c <end_init_data>

00000060 <loop_init_data>:
  60:	4114                	lw	a3,0(a0)
  62:	c194                	sw	a3,0(a1)
  64:	0511                	addi	a0,a0,4
  66:	0591                	addi	a1,a1,4
  68:	fec5cce3          	blt	a1,a2,60 <loop_init_data>

0000006c <end_init_data>:
  6c:	20000517          	auipc	a0,0x20000
  70:	fc850513          	addi	a0,a0,-56 # 20000034 <flag>
  74:	80418593          	addi	a1,gp,-2044 # 20000038 <_ebss>
  78:	00b55763          	bge	a0,a1,86 <end_init_bss>

0000007c <loop_init_bss>:
  7c:	00052023          	sw	zero,0(a0)
  80:	0511                	addi	a0,a0,4
  82:	feb54de3          	blt	a0,a1,7c <loop_init_bss>

00000086 <end_init_bss>:
  86:	2aed                	jal	280 <main>

00000088 <loop>:
  88:	a001                	j	88 <loop>

0000008a <enable_IRQ>:
  8a:	40000793          	li	a5,1024
  8e:	30579073          	csrw	mtvec,a5
  92:	30046073          	csrsi	mstatus,8
  96:	30446073          	csrsi	mie,8
  9a:	8082                	ret

0000009c <return_m>:
  9c:	30200073          	mret
  a0:	8082                	ret

000000a2 <delay>:
  a2:	00151793          	slli	a5,a0,0x1
  a6:	97aa                	add	a5,a5,a0
  a8:	0792                	slli	a5,a5,0x4
  aa:	20000737          	lui	a4,0x20000
  ae:	8f89                	sub	a5,a5,a0
  b0:	01072683          	lw	a3,16(a4) # 20000010 <LOAD_VALUE>
  b4:	078e                	slli	a5,a5,0x3
  b6:	20000737          	lui	a4,0x20000
  ba:	01472703          	lw	a4,20(a4) # 20000014 <TIMER_STATUS>
  be:	8f89                	sub	a5,a5,a0
  c0:	0792                	slli	a5,a5,0x4
  c2:	c29c                	sw	a5,0(a3)
  c4:	4785                	li	a5,1
  c6:	c31c                	sw	a5,0(a4)
  c8:	431c                	lw	a5,0(a4)
  ca:	1007f793          	andi	a5,a5,256
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
 10a:	0027e793          	ori	a5,a5,2
 10e:	c31c                	sw	a5,0(a4)
 110:	8082                	ret

00000112 <uart_puts>:
 112:	00054603          	lbu	a2,0(a0)
 116:	ca1d                	beqz	a2,14c <uart_puts+0x3a>
 118:	20000737          	lui	a4,0x20000
 11c:	200007b7          	lui	a5,0x20000
 120:	00472703          	lw	a4,4(a4) # 20000004 <uart_status>
 124:	00c7a583          	lw	a1,12(a5) # 2000000c <uart_ctrl>
 128:	200006b7          	lui	a3,0x20000
 12c:	0006a803          	lw	a6,0(a3) # 20000000 <uart_data>
 130:	00150693          	addi	a3,a0,1
 134:	431c                	lw	a5,0(a4)
 136:	dffd                	beqz	a5,134 <uart_puts+0x22>
 138:	00c82023          	sw	a2,0(a6)
 13c:	419c                	lw	a5,0(a1)
 13e:	0685                	addi	a3,a3,1
 140:	0027e793          	ori	a5,a5,2
 144:	c19c                	sw	a5,0(a1)
 146:	fff6c603          	lbu	a2,-1(a3)
 14a:	f66d                	bnez	a2,134 <uart_puts+0x22>
 14c:	8082                	ret

0000014e <uart_puts_hex>:
 14e:	01c55793          	srli	a5,a0,0x1c
 152:	4725                	li	a4,9
 154:	1141                	addi	sp,sp,-16
 156:	03778693          	addi	a3,a5,55
 15a:	00f74463          	blt	a4,a5,162 <uart_puts_hex+0x14>
 15e:	03078693          	addi	a3,a5,48
 162:	41855793          	srai	a5,a0,0x18
 166:	00f7f613          	andi	a2,a5,15
 16a:	00d10223          	sb	a3,4(sp)
 16e:	45a5                	li	a1,9
 170:	03060713          	addi	a4,a2,48
 174:	00c5d463          	bge	a1,a2,17c <uart_puts_hex+0x2e>
 178:	03760713          	addi	a4,a2,55
 17c:	41455793          	srai	a5,a0,0x14
 180:	00e102a3          	sb	a4,5(sp)
 184:	00f7f613          	andi	a2,a5,15
 188:	45a5                	li	a1,9
 18a:	03060713          	addi	a4,a2,48
 18e:	00c5d463          	bge	a1,a2,196 <uart_puts_hex+0x48>
 192:	03760713          	addi	a4,a2,55
 196:	41055793          	srai	a5,a0,0x10
 19a:	00e10323          	sb	a4,6(sp)
 19e:	00f7f613          	andi	a2,a5,15
 1a2:	45a5                	li	a1,9
 1a4:	03060713          	addi	a4,a2,48
 1a8:	00c5d463          	bge	a1,a2,1b0 <uart_puts_hex+0x62>
 1ac:	03760713          	addi	a4,a2,55
 1b0:	40c55793          	srai	a5,a0,0xc
 1b4:	00e103a3          	sb	a4,7(sp)
 1b8:	00f7f613          	andi	a2,a5,15
 1bc:	45a5                	li	a1,9
 1be:	03060713          	addi	a4,a2,48
 1c2:	00c5d463          	bge	a1,a2,1ca <uart_puts_hex+0x7c>
 1c6:	03760713          	addi	a4,a2,55
 1ca:	40855793          	srai	a5,a0,0x8
 1ce:	00e10423          	sb	a4,8(sp)
 1d2:	00f7f613          	andi	a2,a5,15
 1d6:	45a5                	li	a1,9
 1d8:	03060713          	addi	a4,a2,48
 1dc:	00c5d463          	bge	a1,a2,1e4 <uart_puts_hex+0x96>
 1e0:	03760713          	addi	a4,a2,55
 1e4:	40455793          	srai	a5,a0,0x4
 1e8:	00e104a3          	sb	a4,9(sp)
 1ec:	00f7f613          	andi	a2,a5,15
 1f0:	45a5                	li	a1,9
 1f2:	03060713          	addi	a4,a2,48
 1f6:	00c5d463          	bge	a1,a2,1fe <uart_puts_hex+0xb0>
 1fa:	03760713          	addi	a4,a2,55
 1fe:	00e10523          	sb	a4,10(sp)
 202:	00f57793          	andi	a5,a0,15
 206:	4725                	li	a4,9
 208:	03778613          	addi	a2,a5,55
 20c:	00f74463          	blt	a4,a5,214 <uart_puts_hex+0xc6>
 210:	03078613          	addi	a2,a5,48
 214:	20000737          	lui	a4,0x20000
 218:	20000537          	lui	a0,0x20000
 21c:	200005b7          	lui	a1,0x20000
 220:	6785                	lui	a5,0x1
 222:	00472703          	lw	a4,4(a4) # 20000004 <uart_status>
 226:	00052503          	lw	a0,0(a0) # 20000000 <uart_data>
 22a:	00c5a583          	lw	a1,12(a1) # 2000000c <uart_ctrl>
 22e:	a0d78793          	addi	a5,a5,-1523 # a0d <_sidata+0x70d>
 232:	00c105a3          	sb	a2,11(sp)
 236:	00010723          	sb	zero,14(sp)
 23a:	00f11623          	sh	a5,12(sp)
 23e:	00510613          	addi	a2,sp,5
 242:	431c                	lw	a5,0(a4)
 244:	dffd                	beqz	a5,242 <uart_puts_hex+0xf4>
 246:	c114                	sw	a3,0(a0)
 248:	419c                	lw	a5,0(a1)
 24a:	00064683          	lbu	a3,0(a2)
 24e:	0605                	addi	a2,a2,1
 250:	0027e793          	ori	a5,a5,2
 254:	c19c                	sw	a5,0(a1)
 256:	f6f5                	bnez	a3,242 <uart_puts_hex+0xf4>
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret

0000025c <reverse_bits>:
 25c:	862a                	mv	a2,a0
 25e:	4701                	li	a4,0
 260:	4501                	li	a0,0
 262:	487d                	li	a6,31
 264:	02000593          	li	a1,32
 268:	00e657b3          	srl	a5,a2,a4
 26c:	40e806b3          	sub	a3,a6,a4
 270:	8b85                	andi	a5,a5,1
 272:	00d797b3          	sll	a5,a5,a3
 276:	0705                	addi	a4,a4,1
 278:	8d5d                	or	a0,a0,a5
 27a:	feb717e3          	bne	a4,a1,268 <reverse_bits+0xc>
 27e:	8082                	ret

00000280 <main>:
 280:	7179                	addi	sp,sp,-48
 282:	d606                	sw	ra,44(sp)
 284:	d422                	sw	s0,40(sp)
 286:	d226                	sw	s1,36(sp)
 288:	d04a                	sw	s2,32(sp)
 28a:	ce4e                	sw	s3,28(sp)
 28c:	40000793          	li	a5,1024
 290:	30579073          	csrw	mtvec,a5
 294:	30046073          	csrsi	mstatus,8
 298:	30446073          	csrsi	mie,8
 29c:	47a5                	li	a5,9
 29e:	c43e                	sw	a5,8(sp)
 2a0:	200007b7          	lui	a5,0x20000
 2a4:	0287a683          	lw	a3,40(a5) # 20000028 <i2s_en>
 2a8:	4522                	lw	a0,8(sp)
 2aa:	200007b7          	lui	a5,0x20000
 2ae:	0087a703          	lw	a4,8(a5) # 20000008 <uart_bauddiv>
 2b2:	200007b7          	lui	a5,0x20000
 2b6:	00c7a783          	lw	a5,12(a5) # 2000000c <uart_ctrl>
 2ba:	200005b7          	lui	a1,0x20000
 2be:	c288                	sw	a0,0(a3)
 2c0:	20000637          	lui	a2,0x20000
 2c4:	468d                	li	a3,3
 2c6:	01c5a903          	lw	s2,28(a1) # 2000001c <i2s_fifo_status>
 2ca:	01862983          	lw	s3,24(a2) # 20000018 <i2s_fifo_data>
 2ce:	4485                	li	s1,1
 2d0:	c314                	sw	a3,0(a4)
 2d2:	c384                	sw	s1,0(a5)
 2d4:	20000437          	lui	s0,0x20000
 2d8:	03442783          	lw	a5,52(s0) # 20000034 <flag>
 2dc:	dff5                	beqz	a5,2d8 <main+0x58>
 2de:	00092783          	lw	a5,0(s2)
 2e2:	00978b63          	beq	a5,s1,2f8 <main+0x78>
 2e6:	0009a783          	lw	a5,0(s3)
 2ea:	c63e                	sw	a5,12(sp)
 2ec:	4532                	lw	a0,12(sp)
 2ee:	3585                	jal	14e <uart_puts_hex>
 2f0:	00092783          	lw	a5,0(s2)
 2f4:	fe9799e3          	bne	a5,s1,2e6 <main+0x66>
 2f8:	02042a23          	sw	zero,52(s0)
 2fc:	bff1                	j	2d8 <main+0x58>
	...

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
   0:	2d41                	jal	690 <isr_handler+0x390>
   2:	0000                	unimp
   4:	7200                	.insn	2, 0x7200
   6:	7369                	lui	t1,0xffffa
   8:	01007663          	bgeu	zero,a6,14 <start+0x14>
   c:	00000023          	sb	zero,0(zero) # 0 <start>
  10:	1004                	addi	s1,sp,32
  12:	7205                	lui	tp,0xfffe1
  14:	3376                	.insn	2, 0x3376
  16:	6932                	.insn	2, 0x6932
  18:	7032                	.insn	2, 0x7032
  1a:	5f31                	li	t5,-20
  1c:	30703263          	.insn	4, 0x30703263
  20:	7a5f 6369 7273      	.insn	6, 0x727363697a5f
  26:	7032                	.insn	2, 0x7032
  28:	0030                	addi	a2,sp,8
  2a:	0108                	addi	a0,sp,128
  2c:	0b0a                	slli	s6,s6,0x2

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	.insn	4, 0x3a434347
   4:	2820                	.insn	2, 0x2820
   6:	2029                	jal	10 <start+0x10>
   8:	3431                	jal	fffffa14 <_stack+0xdfffda14>
   a:	322e                	.insn	2, 0x322e
   c:	302e                	.insn	2, 0x302e
	...

Disassembly of section .isr_handler_section:

00000300 <isr_handler>:
 300:	200007b7          	lui	a5,0x20000
 304:	4705                	li	a4,1
 306:	02e7aa23          	sw	a4,52(a5) # 20000034 <flag>
 30a:	30200073          	mret
 30e:	8082                	ret
