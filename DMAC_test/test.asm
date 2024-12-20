
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
  48:	3d850513          	addi	a0,a0,984 # 41c <_sidata>
  4c:	20000597          	auipc	a1,0x20000
  50:	fb458593          	addi	a1,a1,-76 # 20000000 <dmac_status>
  54:	20000617          	auipc	a2,0x20000
  58:	00460613          	addi	a2,a2,4 # 20000058 <flag>
  5c:	00c5d863          	bge	a1,a2,6c <end_init_data>

00000060 <loop_init_data>:
  60:	4114                	lw	a3,0(a0)
  62:	c194                	sw	a3,0(a1)
  64:	0511                	addi	a0,a0,4
  66:	0591                	addi	a1,a1,4
  68:	fec5cce3          	blt	a1,a2,60 <loop_init_data>

0000006c <end_init_data>:
  6c:	20000517          	auipc	a0,0x20000
  70:	fec50513          	addi	a0,a0,-20 # 20000058 <flag>
  74:	80418593          	addi	a1,gp,-2044 # 2000005c <_ebss>
  78:	00b55763          	bge	a0,a1,86 <end_init_bss>

0000007c <loop_init_bss>:
  7c:	00052023          	sw	zero,0(a0)
  80:	0511                	addi	a0,a0,4
  82:	feb54de3          	blt	a0,a1,7c <loop_init_bss>

00000086 <end_init_bss>:
  86:	2e01                	jal	396 <main>

00000088 <loop>:
  88:	a001                	j	88 <loop>

0000008a <isr_handler>:
  8a:	200007b7          	lui	a5,0x20000
  8e:	4705                	li	a4,1
  90:	04e7ac23          	sw	a4,88(a5) # 20000058 <flag>
  94:	30200073          	mret
  98:	8082                	ret

0000009a <enable_IRQ>:
  9a:	30551073          	csrw	mtvec,a0
  9e:	30046073          	csrsi	mstatus,8
  a2:	30446073          	csrsi	mie,8
  a6:	8082                	ret

000000a8 <return_m>:
  a8:	30200073          	mret
  ac:	8082                	ret

000000ae <delay>:
  ae:	00151793          	slli	a5,a0,0x1
  b2:	97aa                	add	a5,a5,a0
  b4:	0792                	slli	a5,a5,0x4
  b6:	20000737          	lui	a4,0x20000
  ba:	8f89                	sub	a5,a5,a0
  bc:	03472683          	lw	a3,52(a4) # 20000034 <LOAD_VALUE>
  c0:	078e                	slli	a5,a5,0x3
  c2:	20000737          	lui	a4,0x20000
  c6:	03872703          	lw	a4,56(a4) # 20000038 <TIMER_STATUS>
  ca:	8f89                	sub	a5,a5,a0
  cc:	0792                	slli	a5,a5,0x4
  ce:	c29c                	sw	a5,0(a3)
  d0:	4785                	li	a5,1
  d2:	c31c                	sw	a5,0(a4)
  d4:	431c                	lw	a5,0(a4)
  d6:	1007f793          	andi	a5,a5,256
  da:	dfed                	beqz	a5,d4 <delay+0x26>
  dc:	8082                	ret

000000de <uart_init>:
  de:	200007b7          	lui	a5,0x20000
  e2:	02c7a703          	lw	a4,44(a5) # 2000002c <uart_bauddiv>
  e6:	200007b7          	lui	a5,0x20000
  ea:	0307a783          	lw	a5,48(a5) # 20000030 <uart_ctrl>
  ee:	c308                	sw	a0,0(a4)
  f0:	4705                	li	a4,1
  f2:	c398                	sw	a4,0(a5)
  f4:	8082                	ret

000000f6 <uart_putc>:
  f6:	200007b7          	lui	a5,0x20000
  fa:	0287a703          	lw	a4,40(a5) # 20000028 <uart_status>
  fe:	431c                	lw	a5,0(a4)
 100:	dffd                	beqz	a5,fe <uart_putc+0x8>
 102:	200007b7          	lui	a5,0x20000
 106:	0247a783          	lw	a5,36(a5) # 20000024 <uart_data>
 10a:	20000737          	lui	a4,0x20000
 10e:	03072703          	lw	a4,48(a4) # 20000030 <uart_ctrl>
 112:	c388                	sw	a0,0(a5)
 114:	431c                	lw	a5,0(a4)
 116:	0027e793          	ori	a5,a5,2
 11a:	c31c                	sw	a5,0(a4)
 11c:	8082                	ret

0000011e <uart_puts>:
 11e:	00054603          	lbu	a2,0(a0)
 122:	ca1d                	beqz	a2,158 <uart_puts+0x3a>
 124:	20000737          	lui	a4,0x20000
 128:	200007b7          	lui	a5,0x20000
 12c:	02872703          	lw	a4,40(a4) # 20000028 <uart_status>
 130:	0307a583          	lw	a1,48(a5) # 20000030 <uart_ctrl>
 134:	200006b7          	lui	a3,0x20000
 138:	0246a803          	lw	a6,36(a3) # 20000024 <uart_data>
 13c:	00150693          	addi	a3,a0,1
 140:	431c                	lw	a5,0(a4)
 142:	dffd                	beqz	a5,140 <uart_puts+0x22>
 144:	00c82023          	sw	a2,0(a6)
 148:	419c                	lw	a5,0(a1)
 14a:	0685                	addi	a3,a3,1
 14c:	0027e793          	ori	a5,a5,2
 150:	c19c                	sw	a5,0(a1)
 152:	fff6c603          	lbu	a2,-1(a3)
 156:	f66d                	bnez	a2,140 <uart_puts+0x22>
 158:	8082                	ret

0000015a <uart_puts_hex>:
 15a:	01c55793          	srli	a5,a0,0x1c
 15e:	4725                	li	a4,9
 160:	1141                	addi	sp,sp,-16
 162:	03778693          	addi	a3,a5,55
 166:	00f74463          	blt	a4,a5,16e <uart_puts_hex+0x14>
 16a:	03078693          	addi	a3,a5,48
 16e:	41855793          	srai	a5,a0,0x18
 172:	00f7f613          	andi	a2,a5,15
 176:	00d10223          	sb	a3,4(sp)
 17a:	45a5                	li	a1,9
 17c:	03060713          	addi	a4,a2,48
 180:	00c5d463          	bge	a1,a2,188 <uart_puts_hex+0x2e>
 184:	03760713          	addi	a4,a2,55
 188:	41455793          	srai	a5,a0,0x14
 18c:	00e102a3          	sb	a4,5(sp)
 190:	00f7f613          	andi	a2,a5,15
 194:	45a5                	li	a1,9
 196:	03060713          	addi	a4,a2,48
 19a:	00c5d463          	bge	a1,a2,1a2 <uart_puts_hex+0x48>
 19e:	03760713          	addi	a4,a2,55
 1a2:	41055793          	srai	a5,a0,0x10
 1a6:	00e10323          	sb	a4,6(sp)
 1aa:	00f7f613          	andi	a2,a5,15
 1ae:	45a5                	li	a1,9
 1b0:	03060713          	addi	a4,a2,48
 1b4:	00c5d463          	bge	a1,a2,1bc <uart_puts_hex+0x62>
 1b8:	03760713          	addi	a4,a2,55
 1bc:	40c55793          	srai	a5,a0,0xc
 1c0:	00e103a3          	sb	a4,7(sp)
 1c4:	00f7f613          	andi	a2,a5,15
 1c8:	45a5                	li	a1,9
 1ca:	03060713          	addi	a4,a2,48
 1ce:	00c5d463          	bge	a1,a2,1d6 <uart_puts_hex+0x7c>
 1d2:	03760713          	addi	a4,a2,55
 1d6:	40855793          	srai	a5,a0,0x8
 1da:	00e10423          	sb	a4,8(sp)
 1de:	00f7f613          	andi	a2,a5,15
 1e2:	45a5                	li	a1,9
 1e4:	03060713          	addi	a4,a2,48
 1e8:	00c5d463          	bge	a1,a2,1f0 <uart_puts_hex+0x96>
 1ec:	03760713          	addi	a4,a2,55
 1f0:	40455793          	srai	a5,a0,0x4
 1f4:	00e104a3          	sb	a4,9(sp)
 1f8:	00f7f613          	andi	a2,a5,15
 1fc:	45a5                	li	a1,9
 1fe:	03060713          	addi	a4,a2,48
 202:	00c5d463          	bge	a1,a2,20a <uart_puts_hex+0xb0>
 206:	03760713          	addi	a4,a2,55
 20a:	00e10523          	sb	a4,10(sp)
 20e:	00f57793          	andi	a5,a0,15
 212:	4725                	li	a4,9
 214:	03778613          	addi	a2,a5,55
 218:	00f74463          	blt	a4,a5,220 <uart_puts_hex+0xc6>
 21c:	03078613          	addi	a2,a5,48
 220:	20000737          	lui	a4,0x20000
 224:	20000537          	lui	a0,0x20000
 228:	200005b7          	lui	a1,0x20000
 22c:	6785                	lui	a5,0x1
 22e:	02872703          	lw	a4,40(a4) # 20000028 <uart_status>
 232:	02452503          	lw	a0,36(a0) # 20000024 <uart_data>
 236:	0305a583          	lw	a1,48(a1) # 20000030 <uart_ctrl>
 23a:	a0d78793          	addi	a5,a5,-1523 # a0d <_sidata+0x5f1>
 23e:	00c105a3          	sb	a2,11(sp)
 242:	00010723          	sb	zero,14(sp)
 246:	00f11623          	sh	a5,12(sp)
 24a:	00510613          	addi	a2,sp,5
 24e:	431c                	lw	a5,0(a4)
 250:	dffd                	beqz	a5,24e <uart_puts_hex+0xf4>
 252:	c114                	sw	a3,0(a0)
 254:	419c                	lw	a5,0(a1)
 256:	00064683          	lbu	a3,0(a2)
 25a:	0605                	addi	a2,a2,1
 25c:	0027e793          	ori	a5,a5,2
 260:	c19c                	sw	a5,0(a1)
 262:	f6f5                	bnez	a3,24e <uart_puts_hex+0xf4>
 264:	0141                	addi	sp,sp,16
 266:	8082                	ret

00000268 <dmac_init>:
 268:	200007b7          	lui	a5,0x20000
 26c:	0207a703          	lw	a4,32(a5) # 20000020 <dmac_saddr>
 270:	4114                	lw	a3,0(a0)
 272:	200007b7          	lui	a5,0x20000
 276:	01c7a783          	lw	a5,28(a5) # 2000001c <dmac_daddr>
 27a:	c314                	sw	a3,0(a4)
 27c:	4158                	lw	a4,4(a0)
 27e:	200006b7          	lui	a3,0x20000
 282:	0146a683          	lw	a3,20(a3) # 20000014 <dmac_scfg>
 286:	c398                	sw	a4,0(a5)
 288:	00a54783          	lbu	a5,10(a0)
 28c:	00c54603          	lbu	a2,12(a0)
 290:	20000737          	lui	a4,0x20000
 294:	0792                	slli	a5,a5,0x4
 296:	97b2                	add	a5,a5,a2
 298:	c29c                	sw	a5,0(a3)
 29a:	00b54783          	lbu	a5,11(a0)
 29e:	00d54683          	lbu	a3,13(a0)
 2a2:	01072703          	lw	a4,16(a4) # 20000010 <dmac_dcfg>
 2a6:	0792                	slli	a5,a5,0x4
 2a8:	97b6                	add	a5,a5,a3
 2aa:	c31c                	sw	a5,0(a4)
 2ac:	00f54783          	lbu	a5,15(a0)
 2b0:	00e54683          	lbu	a3,14(a0)
 2b4:	20000737          	lui	a4,0x20000
 2b8:	00c72703          	lw	a4,12(a4) # 2000000c <dmac_cfg>
 2bc:	0792                	slli	a5,a5,0x4
 2be:	97b6                	add	a5,a5,a3
 2c0:	c31c                	sw	a5,0(a4)
 2c2:	200007b7          	lui	a5,0x20000
 2c6:	0087a703          	lw	a4,8(a5) # 20000008 <dmac_bcount>
 2ca:	00854683          	lbu	a3,8(a0)
 2ce:	200007b7          	lui	a5,0x20000
 2d2:	0047a783          	lw	a5,4(a5) # 20000004 <dmac_bsize>
 2d6:	c314                	sw	a3,0(a4)
 2d8:	00954703          	lbu	a4,9(a0)
 2dc:	c398                	sw	a4,0(a5)
 2de:	8082                	ret

000002e0 <memset>:
 2e0:	fff60813          	addi	a6,a2,-1
 2e4:	c655                	beqz	a2,390 <memset+0xb0>
 2e6:	40a00733          	neg	a4,a0
 2ea:	4895                	li	a7,5
 2ec:	0ff5f693          	zext.b	a3,a1
 2f0:	00377793          	andi	a5,a4,3
 2f4:	0908ff63          	bgeu	a7,a6,392 <memset+0xb2>
 2f8:	88aa                	mv	a7,a0
 2fa:	cb85                	beqz	a5,32a <memset+0x4a>
 2fc:	00d50023          	sb	a3,0(a0)
 300:	8b09                	andi	a4,a4,2
 302:	00150893          	addi	a7,a0,1
 306:	ffe60813          	addi	a6,a2,-2
 30a:	c305                	beqz	a4,32a <memset+0x4a>
 30c:	00d500a3          	sb	a3,1(a0)
 310:	470d                	li	a4,3
 312:	00250893          	addi	a7,a0,2
 316:	ffd60813          	addi	a6,a2,-3
 31a:	00e79863          	bne	a5,a4,32a <memset+0x4a>
 31e:	00d50123          	sb	a3,2(a0)
 322:	00350893          	addi	a7,a0,3
 326:	ffc60813          	addi	a6,a2,-4
 32a:	00869713          	slli	a4,a3,0x8
 32e:	8e1d                	sub	a2,a2,a5
 330:	01069593          	slli	a1,a3,0x10
 334:	8f55                	or	a4,a4,a3
 336:	8f4d                	or	a4,a4,a1
 338:	97aa                	add	a5,a5,a0
 33a:	01869593          	slli	a1,a3,0x18
 33e:	ffc67313          	andi	t1,a2,-4
 342:	8f4d                	or	a4,a4,a1
 344:	006785b3          	add	a1,a5,t1
 348:	c398                	sw	a4,0(a5)
 34a:	0791                	addi	a5,a5,4
 34c:	feb79ee3          	bne	a5,a1,348 <memset+0x68>
 350:	04660063          	beq	a2,t1,390 <memset+0xb0>
 354:	40680833          	sub	a6,a6,t1
 358:	006887b3          	add	a5,a7,t1
 35c:	00d78023          	sb	a3,0(a5)
 360:	02080863          	beqz	a6,390 <memset+0xb0>
 364:	00d780a3          	sb	a3,1(a5)
 368:	4705                	li	a4,1
 36a:	02e80363          	beq	a6,a4,390 <memset+0xb0>
 36e:	00d78123          	sb	a3,2(a5)
 372:	4709                	li	a4,2
 374:	00e80e63          	beq	a6,a4,390 <memset+0xb0>
 378:	00d781a3          	sb	a3,3(a5)
 37c:	470d                	li	a4,3
 37e:	00e80963          	beq	a6,a4,390 <memset+0xb0>
 382:	00d78223          	sb	a3,4(a5)
 386:	4711                	li	a4,4
 388:	00e80463          	beq	a6,a4,390 <memset+0xb0>
 38c:	00d782a3          	sb	a3,5(a5)
 390:	8082                	ret
 392:	87aa                	mv	a5,a0
 394:	b7e1                	j	35c <memset+0x7c>

00000396 <main>:
 396:	7159                	addi	sp,sp,-112
 398:	1018                	addi	a4,sp,32
 39a:	04000613          	li	a2,64
 39e:	4581                	li	a1,0
 3a0:	853a                	mv	a0,a4
 3a2:	d686                	sw	ra,108(sp)
 3a4:	3f35                	jal	2e0 <memset>
 3a6:	010117b7          	lui	a5,0x1011
 3aa:	872a                	mv	a4,a0
 3ac:	441006b7          	lui	a3,0x44100
 3b0:	81078793          	addi	a5,a5,-2032 # 1010810 <_sidata+0x10103f4>
 3b4:	0808                	addi	a0,sp,16
 3b6:	cc3e                	sw	a5,24(sp)
 3b8:	ca3a                	sw	a4,20(sp)
 3ba:	ce02                	sw	zero,28(sp)
 3bc:	c836                	sw	a3,16(sp)
 3be:	356d                	jal	268 <dmac_init>
 3c0:	08a00793          	li	a5,138
 3c4:	30579073          	csrw	mtvec,a5
 3c8:	30046073          	csrsi	mstatus,8
 3cc:	30446073          	csrsi	mie,8
 3d0:	47a5                	li	a5,9
 3d2:	c43e                	sw	a5,8(sp)
 3d4:	200007b7          	lui	a5,0x20000
 3d8:	45a2                	lw	a1,8(sp)
 3da:	04c7a783          	lw	a5,76(a5) # 2000004c <i2s_en>
 3de:	20000737          	lui	a4,0x20000
 3e2:	02c72603          	lw	a2,44(a4) # 2000002c <uart_bauddiv>
 3e6:	20000737          	lui	a4,0x20000
 3ea:	03072683          	lw	a3,48(a4) # 20000030 <uart_ctrl>
 3ee:	20000737          	lui	a4,0x20000
 3f2:	c38c                	sw	a1,0(a5)
 3f4:	05472703          	lw	a4,84(a4) # 20000054 <gpio_data_A>
 3f8:	478d                	li	a5,3
 3fa:	c21c                	sw	a5,0(a2)
 3fc:	4605                	li	a2,1
 3fe:	c290                	sw	a2,0(a3)
 400:	c31c                	sw	a5,0(a4)
 402:	c602                	sw	zero,12(sp)
 404:	20000737          	lui	a4,0x20000
 408:	05872783          	lw	a5,88(a4) # 20000058 <flag>
 40c:	dff5                	beqz	a5,408 <main+0x72>
 40e:	04072c23          	sw	zero,88(a4)
 412:	05872783          	lw	a5,88(a4)
 416:	dbed                	beqz	a5,408 <main+0x72>
 418:	bfdd                	j	40e <main+0x78>
	...

Disassembly of section .data:

20000000 <dmac_status>:
20000000:	0020                	addi	s0,sp,8
20000002:	6000                	.insn	2, 0x6000

20000004 <dmac_bsize>:
20000004:	001c                	.insn	2, 0x001c
20000006:	6000                	.insn	2, 0x6000

20000008 <dmac_bcount>:
20000008:	0018                	.insn	2, 0x0018
2000000a:	6000                	.insn	2, 0x6000

2000000c <dmac_cfg>:
2000000c:	0014                	.insn	2, 0x0014
2000000e:	6000                	.insn	2, 0x6000

20000010 <dmac_dcfg>:
20000010:	0010                	.insn	2, 0x0010
20000012:	6000                	.insn	2, 0x6000

20000014 <dmac_scfg>:
20000014:	000c                	.insn	2, 0x000c
20000016:	6000                	.insn	2, 0x6000

20000018 <dmac_ctrl>:
20000018:	0008                	.insn	2, 0x0008
2000001a:	6000                	.insn	2, 0x6000

2000001c <dmac_daddr>:
2000001c:	0004                	.insn	2, 0x0004
2000001e:	6000                	.insn	2, 0x6000

20000020 <dmac_saddr>:
20000020:	0000                	unimp
20000022:	6000                	.insn	2, 0x6000

20000024 <uart_data>:
20000024:	000c                	.insn	2, 0x000c
20000026:	8000                	.insn	2, 0x8000

20000028 <uart_status>:
20000028:	0008                	.insn	2, 0x0008
2000002a:	8000                	.insn	2, 0x8000

2000002c <uart_bauddiv>:
2000002c:	0004                	.insn	2, 0x0004
2000002e:	8000                	.insn	2, 0x8000

20000030 <uart_ctrl>:
20000030:	0000                	unimp
20000032:	8000                	.insn	2, 0x8000

20000034 <LOAD_VALUE>:
20000034:	0004                	.insn	2, 0x0004
20000036:	4300                	lw	s0,0(a4)

20000038 <TIMER_STATUS>:
20000038:	0000                	unimp
2000003a:	4300                	lw	s0,0(a4)

2000003c <i2s_fifo_data>:
2000003c:	0010                	.insn	2, 0x0010
2000003e:	4400                	lw	s0,8(s0)

20000040 <i2s_fifo_status>:
20000040:	000c                	.insn	2, 0x000c
20000042:	4400                	lw	s0,8(s0)

20000044 <i2s_data>:
20000044:	0008                	.insn	2, 0x0008
20000046:	4400                	lw	s0,8(s0)

20000048 <i2s_done>:
20000048:	0004                	.insn	2, 0x0004
2000004a:	4400                	lw	s0,8(s0)

2000004c <i2s_en>:
2000004c:	0000                	unimp
2000004e:	4400                	lw	s0,8(s0)

20000050 <gpio_oe_A>:
20000050:	0004                	.insn	2, 0x0004
20000052:	4000                	lw	s0,0(s0)

20000054 <gpio_data_A>:
20000054:	0000                	unimp
20000056:	4000                	lw	s0,0(s0)

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	2d41                	jal	690 <_sidata+0x274>
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
