
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
  48:	47450513          	addi	a0,a0,1140 # 4b8 <_sidata>
  4c:	20000597          	auipc	a1,0x20000
  50:	fb458593          	addi	a1,a1,-76 # 20000000 <gpio_data_A>
  54:	20000617          	auipc	a2,0x20000
  58:	00060613          	mv	a2,a2
  5c:	00c5d863          	bge	a1,a2,6c <end_init_data>

00000060 <loop_init_data>:
  60:	4114                	lw	a3,0(a0)
  62:	c194                	sw	a3,0(a1)
  64:	0511                	addi	a0,a0,4
  66:	0591                	addi	a1,a1,4
  68:	fec5cce3          	blt	a1,a2,60 <loop_init_data>

0000006c <end_init_data>:
  6c:	20000517          	auipc	a0,0x20000
  70:	fe850513          	addi	a0,a0,-24 # 20000054 <mic_out>
  74:	84418593          	addi	a1,gp,-1980 # 20000098 <_ebss>
  78:	00b55763          	bge	a0,a1,86 <end_init_bss>

0000007c <loop_init_bss>:
  7c:	00052023          	sw	zero,0(a0)
  80:	0511                	addi	a0,a0,4
  82:	feb54de3          	blt	a0,a1,7c <loop_init_bss>

00000086 <end_init_bss>:
  86:	2e79                	jal	424 <main>

00000088 <loop>:
  88:	a001                	j	88 <loop>

0000008a <enable_IRQ>:
  8a:	1101                	addi	sp,sp,-32
  8c:	ce06                	sw	ra,28(sp)
  8e:	cc22                	sw	s0,24(sp)
  90:	1000                	addi	s0,sp,32
  92:	fea42623          	sw	a0,-20(s0)
  96:	fec42783          	lw	a5,-20(s0)
  9a:	30579073          	csrw	mtvec,a5
  9e:	30046073          	csrsi	mstatus,8
  a2:	30446073          	csrsi	mie,8
  a6:	0001                	nop
  a8:	40f2                	lw	ra,28(sp)
  aa:	4462                	lw	s0,24(sp)
  ac:	6105                	addi	sp,sp,32
  ae:	8082                	ret

000000b0 <return_m>:
  b0:	1141                	addi	sp,sp,-16
  b2:	c606                	sw	ra,12(sp)
  b4:	c422                	sw	s0,8(sp)
  b6:	0800                	addi	s0,sp,16
  b8:	30200073          	mret
  bc:	0001                	nop
  be:	40b2                	lw	ra,12(sp)
  c0:	4422                	lw	s0,8(sp)
  c2:	0141                	addi	sp,sp,16
  c4:	8082                	ret

000000c6 <isr_handler>:
  c6:	1101                	addi	sp,sp,-32
  c8:	ce06                	sw	ra,28(sp)
  ca:	cc22                	sw	s0,24(sp)
  cc:	1000                	addi	s0,sp,32
  ce:	4705                	li	a4,1
  d0:	84e1a023          	sw	a4,-1984(gp) # 20000094 <flag>
  d4:	fe042623          	sw	zero,-20(s0)
  d8:	a00d                	j	fa <isr_handler+0x34>
  da:	200007b7          	lui	a5,0x20000
  de:	05478713          	addi	a4,a5,84 # 20000054 <mic_out>
  e2:	fec42783          	lw	a5,-20(s0)
  e6:	078a                	slli	a5,a5,0x2
  e8:	97ba                	add	a5,a5,a4
  ea:	439c                	lw	a5,0(a5)
  ec:	853e                	mv	a0,a5
  ee:	2a35                	jal	22a <uart_puts_hex>
  f0:	fec42783          	lw	a5,-20(s0)
  f4:	0785                	addi	a5,a5,1
  f6:	fef42623          	sw	a5,-20(s0)
  fa:	fec42703          	lw	a4,-20(s0)
  fe:	47bd                	li	a5,15
 100:	fce7dde3          	bge	a5,a4,da <isr_handler+0x14>
 104:	3775                	jal	b0 <return_m>
 106:	0001                	nop
 108:	40f2                	lw	ra,28(sp)
 10a:	4462                	lw	s0,24(sp)
 10c:	6105                	addi	sp,sp,32
 10e:	8082                	ret

00000110 <delay>:
 110:	1101                	addi	sp,sp,-32
 112:	ce06                	sw	ra,28(sp)
 114:	cc22                	sw	s0,24(sp)
 116:	1000                	addi	s0,sp,32
 118:	fea42623          	sw	a0,-20(s0)
 11c:	200007b7          	lui	a5,0x20000
 120:	01c7a683          	lw	a3,28(a5) # 2000001c <LOAD_VALUE>
 124:	fec42703          	lw	a4,-20(s0)
 128:	87ba                	mv	a5,a4
 12a:	0786                	slli	a5,a5,0x1
 12c:	97ba                	add	a5,a5,a4
 12e:	0792                	slli	a5,a5,0x4
 130:	8f99                	sub	a5,a5,a4
 132:	078e                	slli	a5,a5,0x3
 134:	8f99                	sub	a5,a5,a4
 136:	0792                	slli	a5,a5,0x4
 138:	c29c                	sw	a5,0(a3)
 13a:	200007b7          	lui	a5,0x20000
 13e:	0187a783          	lw	a5,24(a5) # 20000018 <TIMER_STATUS>
 142:	4705                	li	a4,1
 144:	c398                	sw	a4,0(a5)
 146:	0001                	nop
 148:	200007b7          	lui	a5,0x20000
 14c:	0187a783          	lw	a5,24(a5) # 20000018 <TIMER_STATUS>
 150:	439c                	lw	a5,0(a5)
 152:	1007f793          	andi	a5,a5,256
 156:	dbed                	beqz	a5,148 <delay+0x38>
 158:	0001                	nop
 15a:	0001                	nop
 15c:	40f2                	lw	ra,28(sp)
 15e:	4462                	lw	s0,24(sp)
 160:	6105                	addi	sp,sp,32
 162:	8082                	ret

00000164 <uart_init>:
 164:	1101                	addi	sp,sp,-32
 166:	ce06                	sw	ra,28(sp)
 168:	cc22                	sw	s0,24(sp)
 16a:	1000                	addi	s0,sp,32
 16c:	fea42623          	sw	a0,-20(s0)
 170:	200007b7          	lui	a5,0x20000
 174:	0247a783          	lw	a5,36(a5) # 20000024 <uart_bauddiv>
 178:	fec42703          	lw	a4,-20(s0)
 17c:	c398                	sw	a4,0(a5)
 17e:	200007b7          	lui	a5,0x20000
 182:	0207a783          	lw	a5,32(a5) # 20000020 <uart_ctrl>
 186:	4705                	li	a4,1
 188:	c398                	sw	a4,0(a5)
 18a:	0001                	nop
 18c:	40f2                	lw	ra,28(sp)
 18e:	4462                	lw	s0,24(sp)
 190:	6105                	addi	sp,sp,32
 192:	8082                	ret

00000194 <uart_putc>:
 194:	1101                	addi	sp,sp,-32
 196:	ce06                	sw	ra,28(sp)
 198:	cc22                	sw	s0,24(sp)
 19a:	1000                	addi	s0,sp,32
 19c:	87aa                	mv	a5,a0
 19e:	fef407a3          	sb	a5,-17(s0)
 1a2:	0001                	nop
 1a4:	200007b7          	lui	a5,0x20000
 1a8:	0287a783          	lw	a5,40(a5) # 20000028 <uart_status>
 1ac:	439c                	lw	a5,0(a5)
 1ae:	dbfd                	beqz	a5,1a4 <uart_putc+0x10>
 1b0:	200007b7          	lui	a5,0x20000
 1b4:	02c7a783          	lw	a5,44(a5) # 2000002c <uart_data>
 1b8:	fef44703          	lbu	a4,-17(s0)
 1bc:	c398                	sw	a4,0(a5)
 1be:	200007b7          	lui	a5,0x20000
 1c2:	0207a783          	lw	a5,32(a5) # 20000020 <uart_ctrl>
 1c6:	4398                	lw	a4,0(a5)
 1c8:	200007b7          	lui	a5,0x20000
 1cc:	0207a783          	lw	a5,32(a5) # 20000020 <uart_ctrl>
 1d0:	00276713          	ori	a4,a4,2
 1d4:	c398                	sw	a4,0(a5)
 1d6:	0001                	nop
 1d8:	40f2                	lw	ra,28(sp)
 1da:	4462                	lw	s0,24(sp)
 1dc:	6105                	addi	sp,sp,32
 1de:	8082                	ret

000001e0 <uart_puts>:
 1e0:	7179                	addi	sp,sp,-48
 1e2:	d606                	sw	ra,44(sp)
 1e4:	d422                	sw	s0,40(sp)
 1e6:	1800                	addi	s0,sp,48
 1e8:	fca42e23          	sw	a0,-36(s0)
 1ec:	fe042623          	sw	zero,-20(s0)
 1f0:	a839                	j	20e <uart_puts+0x2e>
 1f2:	fec42783          	lw	a5,-20(s0)
 1f6:	fdc42703          	lw	a4,-36(s0)
 1fa:	97ba                	add	a5,a5,a4
 1fc:	0007c783          	lbu	a5,0(a5)
 200:	853e                	mv	a0,a5
 202:	3f49                	jal	194 <uart_putc>
 204:	fec42783          	lw	a5,-20(s0)
 208:	0785                	addi	a5,a5,1
 20a:	fef42623          	sw	a5,-20(s0)
 20e:	fec42783          	lw	a5,-20(s0)
 212:	fdc42703          	lw	a4,-36(s0)
 216:	97ba                	add	a5,a5,a4
 218:	0007c783          	lbu	a5,0(a5)
 21c:	fbf9                	bnez	a5,1f2 <uart_puts+0x12>
 21e:	0001                	nop
 220:	0001                	nop
 222:	50b2                	lw	ra,44(sp)
 224:	5422                	lw	s0,40(sp)
 226:	6145                	addi	sp,sp,48
 228:	8082                	ret

0000022a <uart_puts_hex>:
 22a:	7139                	addi	sp,sp,-64
 22c:	de06                	sw	ra,60(sp)
 22e:	dc22                	sw	s0,56(sp)
 230:	0080                	addi	s0,sp,64
 232:	fca42623          	sw	a0,-52(s0)
 236:	4a400793          	li	a5,1188
 23a:	438c                	lw	a1,0(a5)
 23c:	43d0                	lw	a2,4(a5)
 23e:	4794                	lw	a3,8(a5)
 240:	47d8                	lw	a4,12(a5)
 242:	fcb42823          	sw	a1,-48(s0)
 246:	fcc42a23          	sw	a2,-44(s0)
 24a:	fcd42c23          	sw	a3,-40(s0)
 24e:	fce42e23          	sw	a4,-36(s0)
 252:	0107c783          	lbu	a5,16(a5)
 256:	fef40023          	sb	a5,-32(s0)
 25a:	fcc42783          	lw	a5,-52(s0)
 25e:	83f1                	srli	a5,a5,0x1c
 260:	17c1                	addi	a5,a5,-16
 262:	97a2                	add	a5,a5,s0
 264:	fe07c783          	lbu	a5,-32(a5)
 268:	fef40223          	sb	a5,-28(s0)
 26c:	fcc42783          	lw	a5,-52(s0)
 270:	87e1                	srai	a5,a5,0x18
 272:	8bbd                	andi	a5,a5,15
 274:	17c1                	addi	a5,a5,-16
 276:	97a2                	add	a5,a5,s0
 278:	fe07c783          	lbu	a5,-32(a5)
 27c:	fef402a3          	sb	a5,-27(s0)
 280:	fcc42783          	lw	a5,-52(s0)
 284:	87d1                	srai	a5,a5,0x14
 286:	8bbd                	andi	a5,a5,15
 288:	17c1                	addi	a5,a5,-16
 28a:	97a2                	add	a5,a5,s0
 28c:	fe07c783          	lbu	a5,-32(a5)
 290:	fef40323          	sb	a5,-26(s0)
 294:	fcc42783          	lw	a5,-52(s0)
 298:	87c1                	srai	a5,a5,0x10
 29a:	8bbd                	andi	a5,a5,15
 29c:	17c1                	addi	a5,a5,-16
 29e:	97a2                	add	a5,a5,s0
 2a0:	fe07c783          	lbu	a5,-32(a5)
 2a4:	fef403a3          	sb	a5,-25(s0)
 2a8:	fcc42783          	lw	a5,-52(s0)
 2ac:	87b1                	srai	a5,a5,0xc
 2ae:	8bbd                	andi	a5,a5,15
 2b0:	17c1                	addi	a5,a5,-16
 2b2:	97a2                	add	a5,a5,s0
 2b4:	fe07c783          	lbu	a5,-32(a5)
 2b8:	fef40423          	sb	a5,-24(s0)
 2bc:	fcc42783          	lw	a5,-52(s0)
 2c0:	87a1                	srai	a5,a5,0x8
 2c2:	8bbd                	andi	a5,a5,15
 2c4:	17c1                	addi	a5,a5,-16
 2c6:	97a2                	add	a5,a5,s0
 2c8:	fe07c783          	lbu	a5,-32(a5)
 2cc:	fef404a3          	sb	a5,-23(s0)
 2d0:	fcc42783          	lw	a5,-52(s0)
 2d4:	8791                	srai	a5,a5,0x4
 2d6:	8bbd                	andi	a5,a5,15
 2d8:	17c1                	addi	a5,a5,-16
 2da:	97a2                	add	a5,a5,s0
 2dc:	fe07c783          	lbu	a5,-32(a5)
 2e0:	fef40523          	sb	a5,-22(s0)
 2e4:	fcc42783          	lw	a5,-52(s0)
 2e8:	8bbd                	andi	a5,a5,15
 2ea:	17c1                	addi	a5,a5,-16
 2ec:	97a2                	add	a5,a5,s0
 2ee:	fe07c783          	lbu	a5,-32(a5)
 2f2:	fef405a3          	sb	a5,-21(s0)
 2f6:	47b5                	li	a5,13
 2f8:	fef40623          	sb	a5,-20(s0)
 2fc:	47a9                	li	a5,10
 2fe:	fef406a3          	sb	a5,-19(s0)
 302:	fe040723          	sb	zero,-18(s0)
 306:	fe440793          	addi	a5,s0,-28
 30a:	853e                	mv	a0,a5
 30c:	3dd1                	jal	1e0 <uart_puts>
 30e:	0001                	nop
 310:	50f2                	lw	ra,60(sp)
 312:	5462                	lw	s0,56(sp)
 314:	6121                	addi	sp,sp,64
 316:	8082                	ret

00000318 <dmac_init>:
 318:	1101                	addi	sp,sp,-32
 31a:	ce06                	sw	ra,28(sp)
 31c:	cc22                	sw	s0,24(sp)
 31e:	1000                	addi	s0,sp,32
 320:	fea42623          	sw	a0,-20(s0)
 324:	200007b7          	lui	a5,0x20000
 328:	0307a783          	lw	a5,48(a5) # 20000030 <dmac_saddr>
 32c:	fec42703          	lw	a4,-20(s0)
 330:	4318                	lw	a4,0(a4)
 332:	c398                	sw	a4,0(a5)
 334:	200007b7          	lui	a5,0x20000
 338:	0347a783          	lw	a5,52(a5) # 20000034 <dmac_daddr>
 33c:	fec42703          	lw	a4,-20(s0)
 340:	4358                	lw	a4,4(a4)
 342:	c398                	sw	a4,0(a5)
 344:	fec42783          	lw	a5,-20(s0)
 348:	00c7c783          	lbu	a5,12(a5)
 34c:	873e                	mv	a4,a5
 34e:	fec42783          	lw	a5,-20(s0)
 352:	00a7c783          	lbu	a5,10(a5)
 356:	0792                	slli	a5,a5,0x4
 358:	973e                	add	a4,a4,a5
 35a:	200007b7          	lui	a5,0x20000
 35e:	03c7a783          	lw	a5,60(a5) # 2000003c <dmac_scfg>
 362:	c398                	sw	a4,0(a5)
 364:	fec42783          	lw	a5,-20(s0)
 368:	00d7c783          	lbu	a5,13(a5)
 36c:	873e                	mv	a4,a5
 36e:	fec42783          	lw	a5,-20(s0)
 372:	00b7c783          	lbu	a5,11(a5)
 376:	0796                	slli	a5,a5,0x5
 378:	973e                	add	a4,a4,a5
 37a:	200007b7          	lui	a5,0x20000
 37e:	0407a783          	lw	a5,64(a5) # 20000040 <dmac_dcfg>
 382:	c398                	sw	a4,0(a5)
 384:	fec42783          	lw	a5,-20(s0)
 388:	00e7c783          	lbu	a5,14(a5)
 38c:	873e                	mv	a4,a5
 38e:	fec42783          	lw	a5,-20(s0)
 392:	00f7c783          	lbu	a5,15(a5)
 396:	0792                	slli	a5,a5,0x4
 398:	973e                	add	a4,a4,a5
 39a:	200007b7          	lui	a5,0x20000
 39e:	0447a783          	lw	a5,68(a5) # 20000044 <dmac_cfg>
 3a2:	c398                	sw	a4,0(a5)
 3a4:	fec42783          	lw	a5,-20(s0)
 3a8:	0087c703          	lbu	a4,8(a5)
 3ac:	200007b7          	lui	a5,0x20000
 3b0:	0487a783          	lw	a5,72(a5) # 20000048 <dmac_bcount>
 3b4:	c398                	sw	a4,0(a5)
 3b6:	fec42783          	lw	a5,-20(s0)
 3ba:	0097c703          	lbu	a4,9(a5)
 3be:	200007b7          	lui	a5,0x20000
 3c2:	04c7a783          	lw	a5,76(a5) # 2000004c <dmac_bsize>
 3c6:	c398                	sw	a4,0(a5)
 3c8:	0001                	nop
 3ca:	40f2                	lw	ra,28(sp)
 3cc:	4462                	lw	s0,24(sp)
 3ce:	6105                	addi	sp,sp,32
 3d0:	8082                	ret

000003d2 <memset>:
 3d2:	7179                	addi	sp,sp,-48
 3d4:	d606                	sw	ra,44(sp)
 3d6:	d422                	sw	s0,40(sp)
 3d8:	1800                	addi	s0,sp,48
 3da:	fca42e23          	sw	a0,-36(s0)
 3de:	fcb42c23          	sw	a1,-40(s0)
 3e2:	fcc42a23          	sw	a2,-44(s0)
 3e6:	fdc42783          	lw	a5,-36(s0)
 3ea:	fef42623          	sw	a5,-20(s0)
 3ee:	a829                	j	408 <memset+0x36>
 3f0:	fec42783          	lw	a5,-20(s0)
 3f4:	00178713          	addi	a4,a5,1
 3f8:	fee42623          	sw	a4,-20(s0)
 3fc:	fd842703          	lw	a4,-40(s0)
 400:	0ff77713          	zext.b	a4,a4
 404:	00e78023          	sb	a4,0(a5)
 408:	fd442783          	lw	a5,-44(s0)
 40c:	fff78713          	addi	a4,a5,-1
 410:	fce42a23          	sw	a4,-44(s0)
 414:	fff1                	bnez	a5,3f0 <memset+0x1e>
 416:	fdc42783          	lw	a5,-36(s0)
 41a:	853e                	mv	a0,a5
 41c:	50b2                	lw	ra,44(sp)
 41e:	5422                	lw	s0,40(sp)
 420:	6145                	addi	sp,sp,48
 422:	8082                	ret

00000424 <main>:
 424:	7179                	addi	sp,sp,-48
 426:	d606                	sw	ra,44(sp)
 428:	d422                	sw	s0,40(sp)
 42a:	1800                	addi	s0,sp,48
 42c:	440007b7          	lui	a5,0x44000
 430:	07c1                	addi	a5,a5,16 # 44000010 <_stack+0x23ffe010>
 432:	fef42023          	sw	a5,-32(s0)
 436:	200007b7          	lui	a5,0x20000
 43a:	05478793          	addi	a5,a5,84 # 20000054 <mic_out>
 43e:	fef42223          	sw	a5,-28(s0)
 442:	4785                	li	a5,1
 444:	fef40423          	sb	a5,-24(s0)
 448:	47bd                	li	a5,15
 44a:	fef404a3          	sb	a5,-23(s0)
 44e:	fe040523          	sb	zero,-22(s0)
 452:	4785                	li	a5,1
 454:	fef405a3          	sb	a5,-21(s0)
 458:	4789                	li	a5,2
 45a:	fef40623          	sb	a5,-20(s0)
 45e:	4789                	li	a5,2
 460:	fef406a3          	sb	a5,-19(s0)
 464:	fe040723          	sb	zero,-18(s0)
 468:	fe0407a3          	sb	zero,-17(s0)
 46c:	fe040793          	addi	a5,s0,-32
 470:	853e                	mv	a0,a5
 472:	355d                	jal	318 <dmac_init>
 474:	0c600513          	li	a0,198
 478:	3909                	jal	8a <enable_IRQ>
 47a:	200007b7          	lui	a5,0x20000
 47e:	0047a783          	lw	a5,4(a5) # 20000004 <i2s_en>
 482:	4725                	li	a4,9
 484:	c398                	sw	a4,0(a5)
 486:	450d                	li	a0,3
 488:	39f1                	jal	164 <uart_init>
 48a:	06100793          	li	a5,97
 48e:	fcf40da3          	sb	a5,-37(s0)
 492:	06200793          	li	a5,98
 496:	fcf40d23          	sb	a5,-38(s0)
 49a:	fc042a23          	sw	zero,-44(s0)
 49e:	0001                	nop
 4a0:	bffd                	j	49e <main+0x7a>
 4a2:	0000                	unimp
 4a4:	3130                	.insn	2, 0x3130
 4a6:	3332                	.insn	2, 0x3332
 4a8:	3534                	.insn	2, 0x3534
 4aa:	3736                	.insn	2, 0x3736
 4ac:	3938                	.insn	2, 0x3938
 4ae:	4241                	li	tp,16
 4b0:	46454443          	.insn	4, 0x46454443
 4b4:	0000                	unimp
	...

Disassembly of section .data:

20000000 <gpio_data_A>:
20000000:	0000                	unimp
20000002:	4000                	lw	s0,0(s0)

20000004 <i2s_en>:
20000004:	0000                	unimp
20000006:	4400                	lw	s0,8(s0)

20000008 <i2s_done>:
20000008:	0004                	.insn	2, 0x0004
2000000a:	4400                	lw	s0,8(s0)

2000000c <i2s_data>:
2000000c:	0008                	.insn	2, 0x0008
2000000e:	4400                	lw	s0,8(s0)

20000010 <i2s_fifo_status>:
20000010:	000c                	.insn	2, 0x000c
20000012:	4400                	lw	s0,8(s0)

20000014 <i2s_fifo_data>:
20000014:	0010                	.insn	2, 0x0010
20000016:	4400                	lw	s0,8(s0)

20000018 <TIMER_STATUS>:
20000018:	0000                	unimp
2000001a:	4300                	lw	s0,0(a4)

2000001c <LOAD_VALUE>:
2000001c:	0004                	.insn	2, 0x0004
2000001e:	4300                	lw	s0,0(a4)

20000020 <uart_ctrl>:
20000020:	0000                	unimp
20000022:	8000                	.insn	2, 0x8000

20000024 <uart_bauddiv>:
20000024:	0004                	.insn	2, 0x0004
20000026:	8000                	.insn	2, 0x8000

20000028 <uart_status>:
20000028:	0008                	.insn	2, 0x0008
2000002a:	8000                	.insn	2, 0x8000

2000002c <uart_data>:
2000002c:	000c                	.insn	2, 0x000c
2000002e:	8000                	.insn	2, 0x8000

20000030 <dmac_saddr>:
20000030:	0000                	unimp
20000032:	6000                	.insn	2, 0x6000

20000034 <dmac_daddr>:
20000034:	0004                	.insn	2, 0x0004
20000036:	6000                	.insn	2, 0x6000

20000038 <dmac_ctrl>:
20000038:	0008                	.insn	2, 0x0008
2000003a:	6000                	.insn	2, 0x6000

2000003c <dmac_scfg>:
2000003c:	000c                	.insn	2, 0x000c
2000003e:	6000                	.insn	2, 0x6000

20000040 <dmac_dcfg>:
20000040:	0010                	.insn	2, 0x0010
20000042:	6000                	.insn	2, 0x6000

20000044 <dmac_cfg>:
20000044:	0014                	.insn	2, 0x0014
20000046:	6000                	.insn	2, 0x6000

20000048 <dmac_bcount>:
20000048:	0018                	.insn	2, 0x0018
2000004a:	6000                	.insn	2, 0x6000

2000004c <dmac_bsize>:
2000004c:	001c                	.insn	2, 0x001c
2000004e:	6000                	.insn	2, 0x6000

20000050 <dmac_status>:
20000050:	0020                	addi	s0,sp,8
20000052:	6000                	.insn	2, 0x6000

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	2d41                	jal	690 <_sidata+0x1d8>
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
