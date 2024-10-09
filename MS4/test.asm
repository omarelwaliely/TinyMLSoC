
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
  84:	0e450513          	add	a0,a0,228 # 164 <_sidata>
  88:	20000597          	auipc	a1,0x20000
  8c:	f7858593          	add	a1,a1,-136 # 20000000 <gpio_oe_A>
  90:	20000617          	auipc	a2,0x20000
  94:	f7860613          	add	a2,a2,-136 # 20000008 <_ebss>
  98:	00c5dc63          	bge	a1,a2,b0 <end_init_data>

0000009c <loop_init_data>:
  9c:	00052683          	lw	a3,0(a0)
  a0:	00d5a023          	sw	a3,0(a1)
  a4:	00450513          	add	a0,a0,4
  a8:	00458593          	add	a1,a1,4
  ac:	fec5c8e3          	blt	a1,a2,9c <loop_init_data>

000000b0 <end_init_data>:
  b0:	20000517          	auipc	a0,0x20000
  b4:	f5850513          	add	a0,a0,-168 # 20000008 <_ebss>
  b8:	20000597          	auipc	a1,0x20000
  bc:	f5058593          	add	a1,a1,-176 # 20000008 <_ebss>
  c0:	00b55863          	bge	a0,a1,d0 <end_init_bss>

000000c4 <loop_init_bss>:
  c4:	00052023          	sw	zero,0(a0)
  c8:	00450513          	add	a0,a0,4
  cc:	feb54ce3          	blt	a0,a1,c4 <loop_init_bss>

000000d0 <end_init_bss>:
  d0:	034000ef          	jal	104 <main>

000000d4 <loop>:
  d4:	0000006f          	j	d4 <loop>

000000d8 <delay>:
  d8:	ff010113          	add	sp,sp,-16
  dc:	00a12623          	sw	a0,12(sp)
  e0:	00c12783          	lw	a5,12(sp)
  e4:	00f05c63          	blez	a5,fc <delay+0x24>
  e8:	00c12783          	lw	a5,12(sp)
  ec:	fff78793          	add	a5,a5,-1
  f0:	00f12623          	sw	a5,12(sp)
  f4:	00c12783          	lw	a5,12(sp)
  f8:	fef048e3          	bgtz	a5,e8 <delay+0x10>
  fc:	01010113          	add	sp,sp,16
 100:	00008067          	ret

00000104 <main>:
 104:	200007b7          	lui	a5,0x20000
 108:	0007a783          	lw	a5,0(a5) # 20000000 <gpio_oe_A>
 10c:	20000737          	lui	a4,0x20000
 110:	00472583          	lw	a1,4(a4) # 20000004 <gpio_data_A>
 114:	fff00713          	li	a4,-1
 118:	000186b7          	lui	a3,0x18
 11c:	00e7a023          	sw	a4,0(a5)
 120:	00010737          	lui	a4,0x10
 124:	ff010113          	add	sp,sp,-16
 128:	fff70713          	add	a4,a4,-1 # ffff <_sidata+0xfe9b>
 12c:	6a068693          	add	a3,a3,1696 # 186a0 <_sidata+0x1853c>
 130:	00700613          	li	a2,7
 134:	00e5a023          	sw	a4,0(a1)
 138:	00d12623          	sw	a3,12(sp)
 13c:	00c12783          	lw	a5,12(sp)
 140:	00f05c63          	blez	a5,158 <main+0x54>
 144:	00c12783          	lw	a5,12(sp)
 148:	fff78793          	add	a5,a5,-1
 14c:	00f12623          	sw	a5,12(sp)
 150:	00c12783          	lw	a5,12(sp)
 154:	fef048e3          	bgtz	a5,144 <main+0x40>
 158:	00170713          	add	a4,a4,1
 15c:	02c77733          	remu	a4,a4,a2
 160:	fd5ff06f          	j	134 <main+0x30>

Disassembly of section .data:

20000000 <gpio_oe_A>:
20000000:	0004                	.insn	2, 0x0004
20000002:	4000                	.insn	2, 0x4000

20000004 <gpio_data_A>:
20000004:	0000                	.insn	2, 0x
20000006:	4000                	.insn	2, 0x4000

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
