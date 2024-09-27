
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
  84:	09050513          	addi	a0,a0,144 # 110 <_sidata>
  88:	20000597          	auipc	a1,0x20000
  8c:	f7858593          	addi	a1,a1,-136 # 20000000 <test>
  90:	20000617          	auipc	a2,0x20000
  94:	f7c60613          	addi	a2,a2,-132 # 2000000c <_ebss>
  98:	00c5dc63          	bge	a1,a2,b0 <end_init_data>

0000009c <loop_init_data>:
  9c:	00052683          	lw	a3,0(a0)
  a0:	00d5a023          	sw	a3,0(a1)
  a4:	00450513          	addi	a0,a0,4
  a8:	00458593          	addi	a1,a1,4
  ac:	fec5c8e3          	blt	a1,a2,9c <loop_init_data>

000000b0 <end_init_data>:
  b0:	20000517          	auipc	a0,0x20000
  b4:	f5c50513          	addi	a0,a0,-164 # 2000000c <_ebss>
  b8:	20000597          	auipc	a1,0x20000
  bc:	f5458593          	addi	a1,a1,-172 # 2000000c <_ebss>
  c0:	00b55863          	bge	a0,a1,d0 <end_init_bss>

000000c4 <loop_init_bss>:
  c4:	00052023          	sw	zero,0(a0)
  c8:	00450513          	addi	a0,a0,4
  cc:	feb54ce3          	blt	a0,a1,c4 <loop_init_bss>

000000d0 <end_init_bss>:
  d0:	008000ef          	jal	ra,d8 <main>

000000d4 <loop>:
  d4:	0000006f          	j	d4 <loop>

000000d8 <main>:
  d8:	200007b7          	lui	a5,0x20000
  dc:	0047a783          	lw	a5,4(a5) # 20000004 <gpio_oe>
  e0:	20000737          	lui	a4,0x20000
  e4:	00872683          	lw	a3,8(a4) # 20000008 <gpio_data>
  e8:	20000737          	lui	a4,0x20000
  ec:	00072703          	lw	a4,0(a4) # 20000000 <test>
  f0:	fff00613          	li	a2,-1
  f4:	00c7a023          	sw	a2,0(a5)
  f8:	f00fe7b7          	lui	a5,0xf00fe
  fc:	00f6a023          	sw	a5,0(a3)
 100:	00378793          	addi	a5,a5,3 # f00fe003 <_stack+0xd00fc003>
 104:	00f72023          	sw	a5,0(a4)
 108:	00000513          	li	a0,0
 10c:	00008067          	ret

Disassembly of section .data:

20000000 <test>:
20000000:	0008                	0x8
20000002:	4000                	lw	s0,0(s0)

20000004 <gpio_oe>:
20000004:	0004                	0x4
20000006:	4000                	lw	s0,0(s0)

20000008 <gpio_data>:
20000008:	0000                	unimp
2000000a:	4000                	lw	s0,0(s0)

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	1b41                	addi	s6,s6,-16
   2:	0000                	unimp
   4:	7200                	flw	fs0,32(a2)
   6:	7369                	lui	t1,0xffffa
   8:	01007663          	bgeu	zero,a6,14 <start+0x14>
   c:	0011                	c.nop	4
   e:	0000                	unimp
  10:	1004                	addi	s1,sp,32
  12:	7205                	lui	tp,0xfffe1
  14:	3376                	fld	ft6,376(sp)
  16:	6932                	flw	fs2,12(sp)
  18:	7032                	flw	ft0,44(sp)
  1a:	0030                	addi	a2,sp,8

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	fmsub.d	ft6,ft6,ft4,ft7,rmm
   4:	2820                	fld	fs0,80(s0)
   6:	2029                	jal	10 <start+0x10>
   8:	3031                	jal	fffff814 <_stack+0xdfffd814>
   a:	322e                	fld	ft4,232(sp)
   c:	302e                	fld	ft0,232(sp)
	...
