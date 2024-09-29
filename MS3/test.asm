
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
  84:	17450513          	add	a0,a0,372 # 1f4 <_sidata>
  88:	20000597          	auipc	a1,0x20000
  8c:	f7858593          	add	a1,a1,-136 # 20000000 <gpio_oe_3>
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
  d0:	008000ef          	jal	d8 <main>

000000d4 <loop>:
  d4:	0000006f          	j	d4 <loop>

000000d8 <main>:
  d8:	200007b7          	lui	a5,0x20000
  dc:	0107a603          	lw	a2,16(a5) # 20000010 <gpio_oe_1>
  e0:	20000737          	lui	a4,0x20000
  e4:	fc010113          	add	sp,sp,-64
  e8:	00872683          	lw	a3,8(a4) # 20000008 <gpio_oe_2>
  ec:	1c400793          	li	a5,452
  f0:	02812e23          	sw	s0,60(sp)
  f4:	20000737          	lui	a4,0x20000
  f8:	00072383          	lw	t2,0(a4) # 20000000 <gpio_oe_3>
  fc:	01c7a803          	lw	a6,28(a5)
 100:	0207a503          	lw	a0,32(a5)
 104:	00062023          	sw	zero,0(a2)
 108:	0007a283          	lw	t0,0(a5)
 10c:	0047af83          	lw	t6,4(a5)
 110:	0087af03          	lw	t5,8(a5)
 114:	00c7ae83          	lw	t4,12(a5)
 118:	0107ae03          	lw	t3,16(a5)
 11c:	0147a303          	lw	t1,20(a5)
 120:	0187a883          	lw	a7,24(a5)
 124:	0247a583          	lw	a1,36(a5)
 128:	0287a703          	lw	a4,40(a5)
 12c:	0006a023          	sw	zero,0(a3)
 130:	02c7a783          	lw	a5,44(a5)
 134:	200006b7          	lui	a3,0x20000
 138:	0146a603          	lw	a2,20(a3) # 20000014 <gpio_data_1>
 13c:	fff00413          	li	s0,-1
 140:	200006b7          	lui	a3,0x20000
 144:	00c6a683          	lw	a3,12(a3) # 2000000c <gpio_data_2>
 148:	01012e23          	sw	a6,28(sp)
 14c:	02a12023          	sw	a0,32(sp)
 150:	0083a023          	sw	s0,0(t2)
 154:	00512023          	sw	t0,0(sp)
 158:	01f12223          	sw	t6,4(sp)
 15c:	01e12423          	sw	t5,8(sp)
 160:	01d12623          	sw	t4,12(sp)
 164:	01c12823          	sw	t3,16(sp)
 168:	00612a23          	sw	t1,20(sp)
 16c:	01112c23          	sw	a7,24(sp)
 170:	02b12223          	sw	a1,36(sp)
 174:	02e12423          	sw	a4,40(sp)
 178:	02f12623          	sw	a5,44(sp)
 17c:	200007b7          	lui	a5,0x20000
 180:	0047a803          	lw	a6,4(a5) # 20000004 <gpio_data_3>
 184:	03010513          	add	a0,sp,48
 188:	00010793          	mv	a5,sp
 18c:	0007a583          	lw	a1,0(a5)
 190:	0047a703          	lw	a4,4(a5)
 194:	00878793          	add	a5,a5,8
 198:	00b62023          	sw	a1,0(a2)
 19c:	00e6a023          	sw	a4,0(a3)
 1a0:	00062703          	lw	a4,0(a2)
 1a4:	0006a583          	lw	a1,0(a3)
 1a8:	00b70733          	add	a4,a4,a1
 1ac:	00e82023          	sw	a4,0(a6)
 1b0:	fca79ee3          	bne	a5,a0,18c <main+0xb4>
 1b4:	03c12403          	lw	s0,60(sp)
 1b8:	00000513          	li	a0,0
 1bc:	04010113          	add	sp,sp,64
 1c0:	00008067          	ret
 1c4:	0010                	.insn	2, 0x0010
 1c6:	0000                	.insn	2, 0x
 1c8:	0002                	.insn	2, 0x0002
 1ca:	0000                	.insn	2, 0x
 1cc:	0020                	.insn	2, 0x0020
 1ce:	0000                	.insn	2, 0x
 1d0:	00000003          	lb	zero,0(zero) # 0 <start>
 1d4:	0030                	.insn	2, 0x0030
 1d6:	0000                	.insn	2, 0x
 1d8:	0004                	.insn	2, 0x0004
 1da:	0000                	.insn	2, 0x
 1dc:	0040                	.insn	2, 0x0040
 1de:	0000                	.insn	2, 0x
 1e0:	0005                	.insn	2, 0x0005
 1e2:	0000                	.insn	2, 0x
 1e4:	0050                	.insn	2, 0x0050
 1e6:	0000                	.insn	2, 0x
 1e8:	0006                	.insn	2, 0x0006
 1ea:	0000                	.insn	2, 0x
 1ec:	0060                	.insn	2, 0x0060
 1ee:	0000                	.insn	2, 0x
 1f0:	00000007          	.insn	4, 0x0007

Disassembly of section .data:

20000000 <gpio_oe_3>:
20000000:	0004                	.insn	2, 0x0004
20000002:	c000                	.insn	2, 0xc000

20000004 <gpio_data_3>:
20000004:	0000                	.insn	2, 0x
20000006:	c000                	.insn	2, 0xc000

20000008 <gpio_oe_2>:
20000008:	0004                	.insn	2, 0x0004
2000000a:	8000                	.insn	2, 0x8000

2000000c <gpio_data_2>:
2000000c:	0000                	.insn	2, 0x
2000000e:	8000                	.insn	2, 0x8000

20000010 <gpio_oe_1>:
20000010:	0004                	.insn	2, 0x0004
20000012:	4000                	.insn	2, 0x4000

20000014 <gpio_data_1>:
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
   6:	39386367          	.insn	4, 0x39386367
   a:	6431                	.insn	2, 0x6431
   c:	6438                	.insn	2, 0x6438
   e:	20293263          	.insn	4, 0x20293263
  12:	3331                	.insn	2, 0x3331
  14:	322e                	.insn	2, 0x322e
  16:	302e                	.insn	2, 0x302e
	...
