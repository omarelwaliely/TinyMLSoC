
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
  84:	23450513          	addi	a0,a0,564 # 2b4 <_sidata>
  88:	20000597          	auipc	a1,0x20000
  8c:	f7858593          	addi	a1,a1,-136 # 20000000 <uart_data>
  90:	20000617          	auipc	a2,0x20000
  94:	f9460613          	addi	a2,a2,-108 # 20000024 <_edata>
  98:	00c5dc63          	bge	a1,a2,b0 <end_init_data>

0000009c <loop_init_data>:
  9c:	00052683          	lw	a3,0(a0)
  a0:	00d5a023          	sw	a3,0(a1)
  a4:	00450513          	addi	a0,a0,4
  a8:	00458593          	addi	a1,a1,4
  ac:	fec5c8e3          	blt	a1,a2,9c <loop_init_data>

000000b0 <end_init_data>:
  b0:	20000517          	auipc	a0,0x20000
  b4:	f7450513          	addi	a0,a0,-140 # 20000024 <_edata>
  b8:	20000597          	auipc	a1,0x20000
  bc:	f6c58593          	addi	a1,a1,-148 # 20000024 <_edata>
  c0:	00b55863          	bge	a0,a1,d0 <end_init_bss>

000000c4 <loop_init_bss>:
  c4:	00052023          	sw	zero,0(a0)
  c8:	00450513          	addi	a0,a0,4
  cc:	feb54ce3          	blt	a0,a1,c4 <loop_init_bss>

000000d0 <end_init_bss>:
  d0:	12c000ef          	jal	ra,1fc <main>

000000d4 <loop>:
  d4:	0000006f          	j	d4 <loop>

000000d8 <delay>:
  d8:	000017b7          	lui	a5,0x1
  dc:	77078793          	addi	a5,a5,1904 # 1770 <_sidata+0x14bc>
  e0:	02f50533          	mul	a0,a0,a5
  e4:	200007b7          	lui	a5,0x20000
  e8:	0107a783          	lw	a5,16(a5) # 20000010 <LOAD_VALUE>
  ec:	20000737          	lui	a4,0x20000
  f0:	01472703          	lw	a4,20(a4) # 20000014 <TIMER_STATUS>
  f4:	00a7a023          	sw	a0,0(a5)
  f8:	00100793          	li	a5,1
  fc:	00f72023          	sw	a5,0(a4)
 100:	00072783          	lw	a5,0(a4)
 104:	1007f793          	andi	a5,a5,256
 108:	fe078ce3          	beqz	a5,100 <delay+0x28>
 10c:	00008067          	ret

00000110 <uart_init>:
 110:	200007b7          	lui	a5,0x20000
 114:	0087a703          	lw	a4,8(a5) # 20000008 <uart_bauddiv>
 118:	200007b7          	lui	a5,0x20000
 11c:	00c7a783          	lw	a5,12(a5) # 2000000c <uart_ctrl>
 120:	00a72023          	sw	a0,0(a4)
 124:	00100713          	li	a4,1
 128:	00e7a023          	sw	a4,0(a5)
 12c:	00008067          	ret

00000130 <uart_putc>:
 130:	200007b7          	lui	a5,0x20000
 134:	0047a703          	lw	a4,4(a5) # 20000004 <uart_status>
 138:	00072783          	lw	a5,0(a4)
 13c:	fe078ee3          	beqz	a5,138 <uart_putc+0x8>
 140:	200007b7          	lui	a5,0x20000
 144:	0007a783          	lw	a5,0(a5) # 20000000 <uart_data>
 148:	20000737          	lui	a4,0x20000
 14c:	00c72703          	lw	a4,12(a4) # 2000000c <uart_ctrl>
 150:	00a7a023          	sw	a0,0(a5)
 154:	00072783          	lw	a5,0(a4)
 158:	0027e793          	ori	a5,a5,2
 15c:	00f72023          	sw	a5,0(a4)
 160:	00008067          	ret

00000164 <uart_puts>:
 164:	00054603          	lbu	a2,0(a0)
 168:	04060263          	beqz	a2,1ac <uart_puts+0x48>
 16c:	200007b7          	lui	a5,0x20000
 170:	0047a703          	lw	a4,4(a5) # 20000004 <uart_status>
 174:	200007b7          	lui	a5,0x20000
 178:	0007a803          	lw	a6,0(a5) # 20000000 <uart_data>
 17c:	200007b7          	lui	a5,0x20000
 180:	00c7a583          	lw	a1,12(a5) # 2000000c <uart_ctrl>
 184:	00150693          	addi	a3,a0,1
 188:	00072783          	lw	a5,0(a4)
 18c:	fe078ee3          	beqz	a5,188 <uart_puts+0x24>
 190:	00c82023          	sw	a2,0(a6)
 194:	0005a783          	lw	a5,0(a1)
 198:	00168693          	addi	a3,a3,1
 19c:	0027e793          	ori	a5,a5,2
 1a0:	00f5a023          	sw	a5,0(a1)
 1a4:	fff6c603          	lbu	a2,-1(a3)
 1a8:	fe0610e3          	bnez	a2,188 <uart_puts+0x24>
 1ac:	00008067          	ret

000001b0 <uart_puts_int>:
 1b0:	200007b7          	lui	a5,0x20000
 1b4:	0047a703          	lw	a4,4(a5) # 20000004 <uart_status>
 1b8:	200007b7          	lui	a5,0x20000
 1bc:	0007a883          	lw	a7,0(a5) # 20000000 <uart_data>
 1c0:	200007b7          	lui	a5,0x20000
 1c4:	00c7a583          	lw	a1,12(a5) # 2000000c <uart_ctrl>
 1c8:	01800693          	li	a3,24
 1cc:	ff800813          	li	a6,-8
 1d0:	40d55633          	sra	a2,a0,a3
 1d4:	00072783          	lw	a5,0(a4)
 1d8:	fe078ee3          	beqz	a5,1d4 <uart_puts_int+0x24>
 1dc:	0ff67793          	andi	a5,a2,255
 1e0:	00f8a023          	sw	a5,0(a7)
 1e4:	0005a783          	lw	a5,0(a1)
 1e8:	ff868693          	addi	a3,a3,-8
 1ec:	0027e793          	ori	a5,a5,2
 1f0:	00f5a023          	sw	a5,0(a1)
 1f4:	fd069ee3          	bne	a3,a6,1d0 <uart_puts_int+0x20>
 1f8:	00008067          	ret

000001fc <main>:
 1fc:	200007b7          	lui	a5,0x20000
 200:	01c7a703          	lw	a4,28(a5) # 2000001c <gpio_oe_A>
 204:	200006b7          	lui	a3,0x20000
 208:	00c6a583          	lw	a1,12(a3) # 2000000c <uart_ctrl>
 20c:	200007b7          	lui	a5,0x20000
 210:	fff00693          	li	a3,-1
 214:	0087a783          	lw	a5,8(a5) # 20000008 <uart_bauddiv>
 218:	00d72023          	sw	a3,0(a4)
 21c:	200006b7          	lui	a3,0x20000
 220:	0006a503          	lw	a0,0(a3) # 20000000 <uart_data>
 224:	200006b7          	lui	a3,0x20000
 228:	0186ae03          	lw	t3,24(a3) # 20000018 <i2s_data>
 22c:	20000737          	lui	a4,0x20000
 230:	27100693          	li	a3,625
 234:	00472703          	lw	a4,4(a4) # 20000004 <uart_status>
 238:	00d7a023          	sw	a3,0(a5)
 23c:	00100793          	li	a5,1
 240:	00f5a023          	sw	a5,0(a1)
 244:	04800313          	li	t1,72
 248:	ff800893          	li	a7,-8
 24c:	00072783          	lw	a5,0(a4)
 250:	fe078ee3          	beqz	a5,24c <main+0x50>
 254:	ff010113          	addi	sp,sp,-16
 258:	00652023          	sw	t1,0(a0)
 25c:	0005a783          	lw	a5,0(a1)
 260:	01800693          	li	a3,24
 264:	0027e793          	ori	a5,a5,2
 268:	00f5a023          	sw	a5,0(a1)
 26c:	000e2783          	lw	a5,0(t3)
 270:	00f12623          	sw	a5,12(sp)
 274:	00c12803          	lw	a6,12(sp)
 278:	40d85633          	sra	a2,a6,a3
 27c:	00072783          	lw	a5,0(a4)
 280:	fe078ee3          	beqz	a5,27c <main+0x80>
 284:	0ff67793          	andi	a5,a2,255
 288:	00f52023          	sw	a5,0(a0)
 28c:	0005a783          	lw	a5,0(a1)
 290:	ff868693          	addi	a3,a3,-8
 294:	0027e793          	ori	a5,a5,2
 298:	00f5a023          	sw	a5,0(a1)
 29c:	fd169ee3          	bne	a3,a7,278 <main+0x7c>
 2a0:	00072783          	lw	a5,0(a4)
 2a4:	fa079ae3          	bnez	a5,258 <main+0x5c>
 2a8:	00072783          	lw	a5,0(a4)
 2ac:	fe078ae3          	beqz	a5,2a0 <main+0xa4>
 2b0:	fa9ff06f          	j	258 <main+0x5c>

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

20000010 <LOAD_VALUE>:
20000010:	0004                	0x4
20000012:	4300                	lw	s0,0(a4)

20000014 <TIMER_STATUS>:
20000014:	0000                	unimp
20000016:	4300                	lw	s0,0(a4)

20000018 <i2s_data>:
20000018:	0000                	unimp
2000001a:	4400                	lw	s0,8(s0)

2000001c <gpio_oe_A>:
2000001c:	0004                	0x4
2000001e:	4000                	lw	s0,0(s0)

20000020 <gpio_data_A>:
20000020:	0000                	unimp
20000022:	4000                	lw	s0,0(s0)

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
  1a:	2e39                	jal	338 <_sidata+0x84>
  1c:	3830                	fld	fa2,112(s0)
  1e:	302e                	fld	ft0,232(sp)
  20:	2029                	jal	2a <start+0x2a>
  22:	2e38                	fld	fa4,88(a2)
  24:	00302e33          	sgtz	t3,gp
