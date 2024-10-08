
test.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <start>:
   0:	00000093          	li	ra,0
   4:	20002117          	auipc	sp,0x20002
   8:	ffc10113          	addi	sp,sp,-4 # 20002000 <_stack>
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
  84:	0ac50513          	addi	a0,a0,172 # 12c <_sidata>
  88:	20000597          	auipc	a1,0x20000
  8c:	f7858593          	addi	a1,a1,-136 # 20000000 <gpio_oe_C>
  90:	20000617          	auipc	a2,0x20000
  94:	f8860613          	addi	a2,a2,-120 # 20000018 <_ebss>
  98:	00c5dc63          	bge	a1,a2,b0 <end_init_data>

0000009c <loop_init_data>:
  9c:	00052683          	lw	a3,0(a0)
  a0:	00d5a023          	sw	a3,0(a1)
  a4:	00450513          	addi	a0,a0,4
  a8:	00458593          	addi	a1,a1,4
  ac:	fec5c8e3          	blt	a1,a2,9c <loop_init_data>

000000b0 <end_init_data>:
  b0:	20000517          	auipc	a0,0x20000
  b4:	f6850513          	addi	a0,a0,-152 # 20000018 <_ebss>
  b8:	20000597          	auipc	a1,0x20000
  bc:	f6058593          	addi	a1,a1,-160 # 20000018 <_ebss>
  c0:	00b55863          	bge	a0,a1,d0 <end_init_bss>

000000c4 <loop_init_bss>:
  c4:	00052023          	sw	zero,0(a0)
  c8:	00450513          	addi	a0,a0,4
  cc:	feb54ce3          	blt	a0,a1,c4 <loop_init_bss>

000000d0 <end_init_bss>:
  d0:	008000ef          	jal	d8 <main>

000000d4 <loop>:
  d4:	0000006f          	j	d4 <loop>

000000d8 <main>:
  d8:	200007b7          	lui	a5,0x20000
  dc:	0107a503          	lw	a0,16(a5) # 20000010 <gpio_oe_A>
  e0:	200007b7          	lui	a5,0x20000
  e4:	0087a703          	lw	a4,8(a5) # 20000008 <gpio_oe_B>
  e8:	200007b7          	lui	a5,0x20000
  ec:	0007a783          	lw	a5,0(a5) # 20000000 <gpio_oe_C>
  f0:	200005b7          	lui	a1,0x20000
  f4:	00052023          	sw	zero,0(a0)
  f8:	20000637          	lui	a2,0x20000
  fc:	200006b7          	lui	a3,0x20000
 100:	0145a583          	lw	a1,20(a1) # 20000014 <gpio_data_A>
 104:	00c62603          	lw	a2,12(a2) # 2000000c <gpio_data_B>
 108:	0046a683          	lw	a3,4(a3) # 20000004 <gpio_data_C>
 10c:	00072023          	sw	zero,0(a4)
 110:	fff00713          	li	a4,-1
 114:	00e7a023          	sw	a4,0(a5)
 118:	0005a783          	lw	a5,0(a1)
 11c:	00062703          	lw	a4,0(a2)
 120:	00e787b3          	add	a5,a5,a4
 124:	00f6a023          	sw	a5,0(a3)
 128:	ff1ff06f          	j	118 <main+0x40>

Disassembly of section .data:

20000000 <gpio_oe_C>:
20000000:	0004                	.insn	2, 0x0004
20000002:	4200                	.insn	2, 0x4200

20000004 <gpio_data_C>:
20000004:	0000                	.insn	2, 0x
20000006:	4200                	.insn	2, 0x4200

20000008 <gpio_oe_B>:
20000008:	0004                	.insn	2, 0x0004
2000000a:	4100                	.insn	2, 0x4100

2000000c <gpio_data_B>:
2000000c:	0000                	.insn	2, 0x
2000000e:	4100                	.insn	2, 0x4100

20000010 <gpio_oe_A>:
20000010:	0004                	.insn	2, 0x0004
20000012:	4000                	.insn	2, 0x4000

20000014 <gpio_data_A>:
20000014:	0000                	.insn	2, 0x
20000016:	4000                	.insn	2, 0x4000

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	1b41                	.insn	2, 0x1b41
   2:	0000                	.insn	2, 0x
   4:	7200                	.insn	2, 0x7200
   6:	7369                	.insn	2, 0x7369
   8:	01007663          	bgeu	zero,a6,14 <start+0x14>
   c:	0011                	.insn	2, 0x0011
   e:	0000                	.insn	2, 0x
  10:	1004                	.insn	2, 0x1004
  12:	7205                	.insn	2, 0x7205
  14:	3376                	.insn	2, 0x3376
  16:	6932                	.insn	2, 0x6932
  18:	7032                	.insn	2, 0x7032
  1a:	0031                	.insn	2, 0x0031

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	.insn	4, 0x3a434347
   4:	2820                	.insn	2, 0x2820
   6:	2029                	.insn	2, 0x2029
   8:	3431                	.insn	2, 0x3431
   a:	322e                	.insn	2, 0x322e
   c:	302e                	.insn	2, 0x302e
	...