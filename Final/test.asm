
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
  48:	1f050513          	addi	a0,a0,496 # 234 <_sidata>
  4c:	20000597          	auipc	a1,0x20000
  50:	fb458593          	addi	a1,a1,-76 # 20000000 <uart_data>
  54:	20000617          	auipc	a2,0x20000
  58:	fd860613          	addi	a2,a2,-40 # 2000002c <_ebss>
  5c:	00c5d863          	bge	a1,a2,6c <end_init_data>

00000060 <loop_init_data>:
  60:	4114                	lw	a3,0(a0)
  62:	c194                	sw	a3,0(a1)
  64:	0511                	addi	a0,a0,4
  66:	0591                	addi	a1,a1,4
  68:	fec5cce3          	blt	a1,a2,60 <loop_init_data>

0000006c <end_init_data>:
  6c:	20000517          	auipc	a0,0x20000
  70:	fc050513          	addi	a0,a0,-64 # 2000002c <_ebss>
  74:	20000597          	auipc	a1,0x20000
  78:	fb858593          	addi	a1,a1,-72 # 2000002c <_ebss>
  7c:	00b55763          	bge	a0,a1,8a <end_init_bss>

00000080 <loop_init_bss>:
  80:	00052023          	sw	zero,0(a0)
  84:	0511                	addi	a0,a0,4
  86:	feb54de3          	blt	a0,a1,80 <loop_init_bss>

0000008a <end_init_bss>:
  8a:	22a1                	jal	1d2 <main>

0000008c <loop>:
  8c:	a001                	j	8c <loop>

0000008e <delay>:
  8e:	00151793          	slli	a5,a0,0x1
  92:	97aa                	add	a5,a5,a0
  94:	0792                	slli	a5,a5,0x4
  96:	20000737          	lui	a4,0x20000
  9a:	8f89                	sub	a5,a5,a0
  9c:	01072683          	lw	a3,16(a4) # 20000010 <LOAD_VALUE>
  a0:	078e                	slli	a5,a5,0x3
  a2:	20000737          	lui	a4,0x20000
  a6:	01472703          	lw	a4,20(a4) # 20000014 <TIMER_STATUS>
  aa:	8f89                	sub	a5,a5,a0
  ac:	0792                	slli	a5,a5,0x4
  ae:	c29c                	sw	a5,0(a3)
  b0:	4785                	li	a5,1
  b2:	c31c                	sw	a5,0(a4)
  b4:	431c                	lw	a5,0(a4)
  b6:	1007f793          	andi	a5,a5,256
  ba:	dfed                	beqz	a5,b4 <delay+0x26>
  bc:	8082                	ret

000000be <uart_init>:
  be:	200007b7          	lui	a5,0x20000
  c2:	0087a703          	lw	a4,8(a5) # 20000008 <uart_bauddiv>
  c6:	200007b7          	lui	a5,0x20000
  ca:	00c7a783          	lw	a5,12(a5) # 2000000c <uart_ctrl>
  ce:	c308                	sw	a0,0(a4)
  d0:	4705                	li	a4,1
  d2:	c398                	sw	a4,0(a5)
  d4:	8082                	ret

000000d6 <uart_putc>:
  d6:	200007b7          	lui	a5,0x20000
  da:	0047a703          	lw	a4,4(a5) # 20000004 <uart_status>
  de:	431c                	lw	a5,0(a4)
  e0:	dffd                	beqz	a5,de <uart_putc+0x8>
  e2:	200007b7          	lui	a5,0x20000
  e6:	0007a783          	lw	a5,0(a5) # 20000000 <uart_data>
  ea:	20000737          	lui	a4,0x20000
  ee:	00c72703          	lw	a4,12(a4) # 2000000c <uart_ctrl>
  f2:	c388                	sw	a0,0(a5)
  f4:	431c                	lw	a5,0(a4)
  f6:	0027e793          	ori	a5,a5,2
  fa:	c31c                	sw	a5,0(a4)
  fc:	8082                	ret

000000fe <uart_puts>:
  fe:	00054603          	lbu	a2,0(a0)
 102:	ca1d                	beqz	a2,138 <uart_puts+0x3a>
 104:	20000737          	lui	a4,0x20000
 108:	200007b7          	lui	a5,0x20000
 10c:	00472703          	lw	a4,4(a4) # 20000004 <uart_status>
 110:	00c7a583          	lw	a1,12(a5) # 2000000c <uart_ctrl>
 114:	200006b7          	lui	a3,0x20000
 118:	0006a803          	lw	a6,0(a3) # 20000000 <uart_data>
 11c:	00150693          	addi	a3,a0,1
 120:	431c                	lw	a5,0(a4)
 122:	dffd                	beqz	a5,120 <uart_puts+0x22>
 124:	00c82023          	sw	a2,0(a6)
 128:	419c                	lw	a5,0(a1)
 12a:	0685                	addi	a3,a3,1
 12c:	0027e793          	ori	a5,a5,2
 130:	c19c                	sw	a5,0(a1)
 132:	fff6c603          	lbu	a2,-1(a3)
 136:	f66d                	bnez	a2,120 <uart_puts+0x22>
 138:	8082                	ret

0000013a <uart_puts_hex>:
 13a:	1141                	addi	sp,sp,-16
 13c:	0054                	addi	a3,sp,4
 13e:	4771                	li	a4,28
 140:	48a5                	li	a7,9
 142:	5871                	li	a6,-4
 144:	40e557b3          	sra	a5,a0,a4
 148:	00f7f593          	andi	a1,a5,15
 14c:	1771                	addi	a4,a4,-4
 14e:	03758613          	addi	a2,a1,55
 152:	00b8c463          	blt	a7,a1,15a <uart_puts_hex+0x20>
 156:	03058613          	addi	a2,a1,48
 15a:	00c68023          	sb	a2,0(a3)
 15e:	0685                	addi	a3,a3,1
 160:	ff0712e3          	bne	a4,a6,144 <uart_puts_hex+0xa>
 164:	6785                	lui	a5,0x1
 166:	00414683          	lbu	a3,4(sp)
 16a:	a0d78793          	addi	a5,a5,-1523 # a0d <_sidata+0x7d9>
 16e:	00010723          	sb	zero,14(sp)
 172:	00f11623          	sh	a5,12(sp)
 176:	ca95                	beqz	a3,1aa <uart_puts_hex+0x70>
 178:	20000737          	lui	a4,0x20000
 17c:	200007b7          	lui	a5,0x20000
 180:	00472703          	lw	a4,4(a4) # 20000004 <uart_status>
 184:	00c7a583          	lw	a1,12(a5) # 2000000c <uart_ctrl>
 188:	20000637          	lui	a2,0x20000
 18c:	00062503          	lw	a0,0(a2) # 20000000 <uart_data>
 190:	00510613          	addi	a2,sp,5
 194:	431c                	lw	a5,0(a4)
 196:	dffd                	beqz	a5,194 <uart_puts_hex+0x5a>
 198:	c114                	sw	a3,0(a0)
 19a:	419c                	lw	a5,0(a1)
 19c:	00064683          	lbu	a3,0(a2)
 1a0:	0605                	addi	a2,a2,1
 1a2:	0027e793          	ori	a5,a5,2
 1a6:	c19c                	sw	a5,0(a1)
 1a8:	f6f5                	bnez	a3,194 <uart_puts_hex+0x5a>
 1aa:	0141                	addi	sp,sp,16
 1ac:	8082                	ret

000001ae <reverse_bits>:
 1ae:	862a                	mv	a2,a0
 1b0:	4701                	li	a4,0
 1b2:	4501                	li	a0,0
 1b4:	487d                	li	a6,31
 1b6:	02000593          	li	a1,32
 1ba:	00e657b3          	srl	a5,a2,a4
 1be:	40e806b3          	sub	a3,a6,a4
 1c2:	8b85                	andi	a5,a5,1
 1c4:	00d797b3          	sll	a5,a5,a3
 1c8:	0705                	addi	a4,a4,1
 1ca:	8d5d                	or	a0,a0,a5
 1cc:	feb717e3          	bne	a4,a1,1ba <reverse_bits+0xc>
 1d0:	8082                	ret

000001d2 <main>:
 1d2:	7179                	addi	sp,sp,-48
 1d4:	47a5                	li	a5,9
 1d6:	c43e                	sw	a5,8(sp)
 1d8:	200007b7          	lui	a5,0x20000
 1dc:	0207a603          	lw	a2,32(a5) # 20000020 <i2s_en>
 1e0:	45a2                	lw	a1,8(sp)
 1e2:	200007b7          	lui	a5,0x20000
 1e6:	0087a703          	lw	a4,8(a5) # 20000008 <uart_bauddiv>
 1ea:	200007b7          	lui	a5,0x20000
 1ee:	d422                	sw	s0,40(sp)
 1f0:	d226                	sw	s1,36(sp)
 1f2:	d04a                	sw	s2,32(sp)
 1f4:	ce4e                	sw	s3,28(sp)
 1f6:	00c7a783          	lw	a5,12(a5) # 2000000c <uart_ctrl>
 1fa:	d606                	sw	ra,44(sp)
 1fc:	c20c                	sw	a1,0(a2)
 1fe:	200006b7          	lui	a3,0x20000
 202:	440d                	li	s0,3
 204:	01c6a483          	lw	s1,28(a3) # 2000001c <i2s_done>
 208:	c300                	sw	s0,0(a4)
 20a:	4705                	li	a4,1
 20c:	c398                	sw	a4,0(a5)
 20e:	200009b7          	lui	s3,0x20000
 212:	20000937          	lui	s2,0x20000
 216:	409c                	lw	a5,0(s1)
 218:	fe879fe3          	bne	a5,s0,216 <main+0x44>
 21c:	0189a703          	lw	a4,24(s3) # 20000018 <i2s_data>
 220:	02892783          	lw	a5,40(s2) # 20000028 <gpio_data_A>
 224:	4318                	lw	a4,0(a4)
 226:	c63a                	sw	a4,12(sp)
 228:	4732                	lw	a4,12(sp)
 22a:	c398                	sw	a4,0(a5)
 22c:	4532                	lw	a0,12(sp)
 22e:	3731                	jal	13a <uart_puts_hex>
 230:	b7dd                	j	216 <main+0x44>
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

20000018 <i2s_data>:
20000018:	0008                	.insn	2, 0x0008
2000001a:	4400                	lw	s0,8(s0)

2000001c <i2s_done>:
2000001c:	0004                	.insn	2, 0x0004
2000001e:	4400                	lw	s0,8(s0)

20000020 <i2s_en>:
20000020:	0000                	unimp
20000022:	4400                	lw	s0,8(s0)

20000024 <gpio_oe_A>:
20000024:	0004                	.insn	2, 0x0004
20000026:	4000                	lw	s0,0(s0)

20000028 <gpio_data_A>:
20000028:	0000                	unimp
2000002a:	4000                	lw	s0,0(s0)

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	2041                	jal	80 <loop_init_bss>
   2:	0000                	unimp
   4:	7200                	.insn	2, 0x7200
   6:	7369                	lui	t1,0xffffa
   8:	01007663          	bgeu	zero,a6,14 <start+0x14>
   c:	0016                	c.slli	zero,0x5
   e:	0000                	unimp
  10:	1004                	addi	s1,sp,32
  12:	7205                	lui	tp,0xfffe1
  14:	3376                	.insn	2, 0x3376
  16:	6932                	.insn	2, 0x6932
  18:	7032                	.insn	2, 0x7032
  1a:	5f31                	li	t5,-20
  1c:	30703263          	.insn	4, 0x30703263
	...

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	.insn	4, 0x3a434347
   4:	2820                	.insn	2, 0x2820
   6:	2029                	jal	10 <start+0x10>
   8:	3431                	jal	fffffa14 <_stack+0xdfffda14>
   a:	322e                	.insn	2, 0x322e
   c:	302e                	.insn	2, 0x302e
	...
