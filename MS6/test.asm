
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
  84:	11c50513          	add	a0,a0,284 # 19c <_sidata>
  88:	20000597          	auipc	a1,0x20000
  8c:	f7858593          	add	a1,a1,-136 # 20000000 <mode>
  90:	20000617          	auipc	a2,0x20000
  94:	f7c60613          	add	a2,a2,-132 # 2000000c <_ebss>
  98:	00c5dc63          	bge	a1,a2,b0 <end_init_data>

0000009c <loop_init_data>:
  9c:	00052683          	lw	a3,0(a0)
  a0:	00d5a023          	sw	a3,0(a1)
  a4:	00450513          	add	a0,a0,4
  a8:	00458593          	add	a1,a1,4
  ac:	fec5c8e3          	blt	a1,a2,9c <loop_init_data>

000000b0 <end_init_data>:
  b0:	20000517          	auipc	a0,0x20000
  b4:	f5c50513          	add	a0,a0,-164 # 2000000c <_ebss>
  b8:	20000597          	auipc	a1,0x20000
  bc:	f5458593          	add	a1,a1,-172 # 2000000c <_ebss>
  c0:	00b55863          	bge	a0,a1,d0 <end_init_bss>

000000c4 <loop_init_bss>:
  c4:	00052023          	sw	zero,0(a0)
  c8:	00450513          	add	a0,a0,4
  cc:	feb54ce3          	blt	a0,a1,c4 <loop_init_bss>

000000d0 <end_init_bss>:
  d0:	030000ef          	jal	100 <main>

000000d4 <loop>:
  d4:	0000006f          	j	d4 <loop>

000000d8 <send_data_bit_by_bit>:
  d8:	200007b7          	lui	a5,0x20000
  dc:	0087a603          	lw	a2,8(a5) # 20000008 <gpio_data_A>
  e0:	02000693          	li	a3,32
  e4:	00000793          	li	a5,0
  e8:	00f55733          	srl	a4,a0,a5
  ec:	00177713          	and	a4,a4,1
  f0:	00e62023          	sw	a4,0(a2)
  f4:	00178793          	add	a5,a5,1
  f8:	fed798e3          	bne	a5,a3,e8 <send_data_bit_by_bit+0x10>
  fc:	00008067          	ret

00000100 <main>:
 100:	200007b7          	lui	a5,0x20000
 104:	0007a703          	lw	a4,0(a5) # 20000000 <mode>
 108:	200007b7          	lui	a5,0x20000
 10c:	0047a783          	lw	a5,4(a5) # 20000004 <gpio_oe_A>
 110:	00200613          	li	a2,2
 114:	200006b7          	lui	a3,0x20000
 118:	0086a683          	lw	a3,8(a3) # 20000008 <gpio_data_A>
 11c:	abbbc537          	lui	a0,0xabbbc
 120:	00c72023          	sw	a2,0(a4)
 124:	abaab5b7          	lui	a1,0xabaab
 128:	00800713          	li	a4,8
 12c:	00e7a023          	sw	a4,0(a5)
 130:	bbb50513          	add	a0,a0,-1093 # abbbbbbb <_stack+0x8bbb9bbb>
 134:	02000613          	li	a2,32
 138:	aaa58593          	add	a1,a1,-1366 # abaaaaaa <_stack+0x8baa8aaa>
 13c:	0006a703          	lw	a4,0(a3)
 140:	00000793          	li	a5,0
 144:	00877713          	and	a4,a4,8
 148:	02071463          	bnez	a4,170 <main+0x70>
 14c:	00f5d733          	srl	a4,a1,a5
 150:	00177713          	and	a4,a4,1
 154:	00e6a023          	sw	a4,0(a3)
 158:	00178793          	add	a5,a5,1
 15c:	fec798e3          	bne	a5,a2,14c <main+0x4c>
 160:	0006a703          	lw	a4,0(a3)
 164:	00000793          	li	a5,0
 168:	00877713          	and	a4,a4,8
 16c:	fe0700e3          	beqz	a4,14c <main+0x4c>
 170:	00f55733          	srl	a4,a0,a5
 174:	00177713          	and	a4,a4,1
 178:	00e6a023          	sw	a4,0(a3)
 17c:	00178793          	add	a5,a5,1
 180:	fac78ee3          	beq	a5,a2,13c <main+0x3c>
 184:	00f55733          	srl	a4,a0,a5
 188:	00177713          	and	a4,a4,1
 18c:	00e6a023          	sw	a4,0(a3)
 190:	00178793          	add	a5,a5,1
 194:	fcc79ee3          	bne	a5,a2,170 <main+0x70>
 198:	fa5ff06f          	j	13c <main+0x3c>

Disassembly of section .data:

20000000 <mode>:
20000000:	0000                	.insn	2, 0x
20000002:	4400                	.insn	2, 0x4400

20000004 <gpio_oe_A>:
20000004:	0004                	.insn	2, 0x0004
20000006:	4000                	.insn	2, 0x4000

20000008 <gpio_data_A>:
20000008:	0000                	.insn	2, 0x
2000000a:	4000                	.insn	2, 0x4000

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
