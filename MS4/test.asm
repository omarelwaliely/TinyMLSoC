
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
  84:	1a850513          	addi	a0,a0,424 # 228 <_sidata>
  88:	20000597          	auipc	a1,0x20000
  8c:	f7858593          	addi	a1,a1,-136 # 20000000 <uart_data>
  90:	20000617          	auipc	a2,0x20000
  94:	f8860613          	addi	a2,a2,-120 # 20000018 <_edata>
  98:	00c5dc63          	bge	a1,a2,b0 <end_init_data>

0000009c <loop_init_data>:
  9c:	00052683          	lw	a3,0(a0)
  a0:	00d5a023          	sw	a3,0(a1)
  a4:	00450513          	addi	a0,a0,4
  a8:	00458593          	addi	a1,a1,4
  ac:	fec5c8e3          	blt	a1,a2,9c <loop_init_data>

000000b0 <end_init_data>:
  b0:	20000517          	auipc	a0,0x20000
  b4:	f6850513          	addi	a0,a0,-152 # 20000018 <_edata>
  b8:	20000597          	auipc	a1,0x20000
  bc:	f6058593          	addi	a1,a1,-160 # 20000018 <_edata>
  c0:	00b55863          	bge	a0,a1,d0 <end_init_bss>

000000c4 <loop_init_bss>:
  c4:	00052023          	sw	zero,0(a0)
  c8:	00450513          	addi	a0,a0,4
  cc:	feb54ce3          	blt	a0,a1,c4 <loop_init_bss>

000000d0 <end_init_bss>:
  d0:	0c0000ef          	jal	ra,190 <main>

000000d4 <loop>:
  d4:	0000006f          	j	d4 <loop>

000000d8 <uart_init>:
  d8:	200007b7          	lui	a5,0x20000
  dc:	0087a703          	lw	a4,8(a5) # 20000008 <uart_bauddiv>
  e0:	200007b7          	lui	a5,0x20000
  e4:	00c7a783          	lw	a5,12(a5) # 2000000c <uart_ctrl>
  e8:	00a72023          	sw	a0,0(a4)
  ec:	00100713          	li	a4,1
  f0:	00e7a023          	sw	a4,0(a5)
  f4:	00008067          	ret

000000f8 <uart_putc>:
  f8:	200007b7          	lui	a5,0x20000
  fc:	0047a703          	lw	a4,4(a5) # 20000004 <uart_status>
 100:	00072783          	lw	a5,0(a4)
 104:	fe078ee3          	beqz	a5,100 <uart_putc+0x8>
 108:	200007b7          	lui	a5,0x20000
 10c:	0007a783          	lw	a5,0(a5) # 20000000 <uart_data>
 110:	20000737          	lui	a4,0x20000
 114:	00c72703          	lw	a4,12(a4) # 2000000c <uart_ctrl>
 118:	00a7a023          	sw	a0,0(a5)
 11c:	00072783          	lw	a5,0(a4)
 120:	0027e793          	ori	a5,a5,2
 124:	00f72023          	sw	a5,0(a4)
 128:	00008067          	ret

0000012c <uart_puts>:
 12c:	00054603          	lbu	a2,0(a0)
 130:	04060263          	beqz	a2,174 <uart_puts+0x48>
 134:	200007b7          	lui	a5,0x20000
 138:	0047a703          	lw	a4,4(a5) # 20000004 <uart_status>
 13c:	200007b7          	lui	a5,0x20000
 140:	0007a803          	lw	a6,0(a5) # 20000000 <uart_data>
 144:	200007b7          	lui	a5,0x20000
 148:	00c7a583          	lw	a1,12(a5) # 2000000c <uart_ctrl>
 14c:	00150693          	addi	a3,a0,1
 150:	00072783          	lw	a5,0(a4)
 154:	fe078ee3          	beqz	a5,150 <uart_puts+0x24>
 158:	00c82023          	sw	a2,0(a6)
 15c:	0005a783          	lw	a5,0(a1)
 160:	00168693          	addi	a3,a3,1
 164:	0027e793          	ori	a5,a5,2
 168:	00f5a023          	sw	a5,0(a1)
 16c:	fff6c603          	lbu	a2,-1(a3)
 170:	fe0610e3          	bnez	a2,150 <uart_puts+0x24>
 174:	00008067          	ret

00000178 <exit>:
 178:	200007b7          	lui	a5,0x20000
 17c:	0147a703          	lw	a4,20(a5) # 20000014 <gpio_data>
 180:	f00fe7b7          	lui	a5,0xf00fe
 184:	00e78793          	addi	a5,a5,14 # f00fe00e <_stack+0xd00fc00e>
 188:	00f72023          	sw	a5,0(a4)
 18c:	00008067          	ret

00000190 <main>:
 190:	200007b7          	lui	a5,0x20000
 194:	0107a703          	lw	a4,16(a5) # 20000010 <gpio_oe>
 198:	200006b7          	lui	a3,0x20000
 19c:	200007b7          	lui	a5,0x20000
 1a0:	0087a783          	lw	a5,8(a5) # 20000008 <uart_bauddiv>
 1a4:	00c6a583          	lw	a1,12(a3) # 2000000c <uart_ctrl>
 1a8:	fff00693          	li	a3,-1
 1ac:	00d72023          	sw	a3,0(a4)
 1b0:	200006b7          	lui	a3,0x20000
 1b4:	0006a503          	lw	a0,0(a3) # 20000000 <uart_data>
 1b8:	20000737          	lui	a4,0x20000
 1bc:	00a00693          	li	a3,10
 1c0:	00472703          	lw	a4,4(a4) # 20000004 <uart_status>
 1c4:	00d7a023          	sw	a3,0(a5)
 1c8:	00100793          	li	a5,1
 1cc:	00f5a023          	sw	a5,0(a1)
 1d0:	21900693          	li	a3,537
 1d4:	04800613          	li	a2,72
 1d8:	00072783          	lw	a5,0(a4)
 1dc:	fe078ee3          	beqz	a5,1d8 <main+0x48>
 1e0:	00c52023          	sw	a2,0(a0)
 1e4:	0005a783          	lw	a5,0(a1)
 1e8:	00168693          	addi	a3,a3,1
 1ec:	fff6c603          	lbu	a2,-1(a3)
 1f0:	0027e793          	ori	a5,a5,2
 1f4:	00f5a023          	sw	a5,0(a1)
 1f8:	fe0610e3          	bnez	a2,1d8 <main+0x48>
 1fc:	200007b7          	lui	a5,0x20000
 200:	0147a703          	lw	a4,20(a5) # 20000014 <gpio_data>
 204:	f00fe7b7          	lui	a5,0xf00fe
 208:	00e78793          	addi	a5,a5,14 # f00fe00e <_stack+0xd00fc00e>
 20c:	00f72023          	sw	a5,0(a4)
 210:	00000513          	li	a0,0
 214:	00008067          	ret
 218:	6548                	flw	fa0,12(a0)
 21a:	6c6c                	flw	fa1,92(s0)
 21c:	6f57206f          	j	73110 <_sidata+0x72ee8>
 220:	6c72                	flw	fs8,28(sp)
 222:	2164                	fld	fs1,192(a0)
 224:	000a                	c.slli	zero,0x2
	...

Disassembly of section .data:

20000000 <uart_data>:
20000000:	000c                	0xc
20000002:	5000                	lw	s0,32(s0)

20000004 <uart_status>:
20000004:	0008                	0x8
20000006:	5000                	lw	s0,32(s0)

20000008 <uart_bauddiv>:
20000008:	0004                	0x4
2000000a:	5000                	lw	s0,32(s0)

2000000c <uart_ctrl>:
2000000c:	0000                	unimp
2000000e:	5000                	lw	s0,32(s0)

20000010 <gpio_oe>:
20000010:	0004                	0x4
20000012:	4000                	lw	s0,0(s0)

20000014 <gpio_data>:
20000014:	0000                	unimp
20000016:	4000                	lw	s0,0(s0)

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	2041                	jal	80 <start+0x80>
   2:	0000                	unimp
   4:	7200                	flw	fs0,32(a2)
   6:	7369                	lui	t1,0xffffa
   8:	01007663          	bgeu	zero,a6,14 <start+0x14>
   c:	0016                	c.slli	zero,0x5
   e:	0000                	unimp
  10:	1004                	addi	s1,sp,32
  12:	7205                	lui	tp,0xfffe1
  14:	3376                	fld	ft6,376(sp)
  16:	6932                	flw	fs2,12(sp)
  18:	7032                	flw	ft0,44(sp)
  1a:	5f30                	lw	a2,120(a4)
  1c:	326d                	jal	fffff9c6 <_stack+0xdfffd9c6>
  1e:	3070                	fld	fa2,224(s0)
	...

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	fmsub.d	ft6,ft6,ft4,ft7,rmm
   4:	2820                	fld	fs0,80(s0)
   6:	69466953          	0x69466953
   a:	6576                	flw	fa0,92(sp)
   c:	4720                	lw	s0,72(a4)
   e:	38204343          	fmadd.s	ft6,ft0,ft2,ft7,rmm
  12:	332e                	fld	ft6,232(sp)
  14:	302e                	fld	ft0,232(sp)
  16:	322d                	jal	fffff940 <_stack+0xdfffd940>
  18:	3130                	fld	fa2,96(a0)
  1a:	2e39                	jal	338 <_sidata+0x110>
  1c:	3830                	fld	fa2,112(s0)
  1e:	302e                	fld	ft0,232(sp)
  20:	2029                	jal	2a <start+0x2a>
  22:	2e38                	fld	fa4,88(a2)
  24:	00302e33          	sgtz	t3,gp
