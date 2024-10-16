
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
  84:	3e450513          	add	a0,a0,996 # 464 <_sidata>
  88:	20000597          	auipc	a1,0x20000
  8c:	f7858593          	add	a1,a1,-136 # 20000000 <uart_data>
  90:	20000617          	auipc	a2,0x20000
  94:	f9060613          	add	a2,a2,-112 # 20000020 <_ebss>
  98:	00c5dc63          	bge	a1,a2,b0 <end_init_data>

0000009c <loop_init_data>:
  9c:	00052683          	lw	a3,0(a0)
  a0:	00d5a023          	sw	a3,0(a1)
  a4:	00450513          	add	a0,a0,4
  a8:	00458593          	add	a1,a1,4
  ac:	fec5c8e3          	blt	a1,a2,9c <loop_init_data>

000000b0 <end_init_data>:
  b0:	20000517          	auipc	a0,0x20000
  b4:	f7050513          	add	a0,a0,-144 # 20000020 <_ebss>
  b8:	20000597          	auipc	a1,0x20000
  bc:	f6858593          	add	a1,a1,-152 # 20000020 <_ebss>
  c0:	00b55863          	bge	a0,a1,d0 <end_init_bss>

000000c4 <loop_init_bss>:
  c4:	00052023          	sw	zero,0(a0)
  c8:	00450513          	add	a0,a0,4
  cc:	feb54ce3          	blt	a0,a1,c4 <loop_init_bss>

000000d0 <end_init_bss>:
  d0:	0e0000ef          	jal	1b0 <main>

000000d4 <loop>:
  d4:	0000006f          	j	d4 <loop>

000000d8 <delay>:
  d8:	000017b7          	lui	a5,0x1
  dc:	77078793          	add	a5,a5,1904 # 1770 <_sidata+0x130c>
  e0:	02f50533          	mul	a0,a0,a5
  e4:	200007b7          	lui	a5,0x20000
  e8:	0107a783          	lw	a5,16(a5) # 20000010 <LOAD_VALUE>
  ec:	20000737          	lui	a4,0x20000
  f0:	01472703          	lw	a4,20(a4) # 20000014 <TIMER_STATUS>
  f4:	00a7a023          	sw	a0,0(a5)
  f8:	00100793          	li	a5,1
  fc:	00f72023          	sw	a5,0(a4)
 100:	00072783          	lw	a5,0(a4)
 104:	1007f793          	and	a5,a5,256
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
 158:	0027e793          	or	a5,a5,2
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
 184:	00150693          	add	a3,a0,1
 188:	00072783          	lw	a5,0(a4)
 18c:	fe078ee3          	beqz	a5,188 <uart_puts+0x24>
 190:	00c82023          	sw	a2,0(a6)
 194:	0005a783          	lw	a5,0(a1)
 198:	00168693          	add	a3,a3,1
 19c:	0027e793          	or	a5,a5,2
 1a0:	00f5a023          	sw	a5,0(a1)
 1a4:	fff6c603          	lbu	a2,-1(a3)
 1a8:	fe0610e3          	bnez	a2,188 <uart_puts+0x24>
 1ac:	00008067          	ret

000001b0 <main>:
 1b0:	200007b7          	lui	a5,0x20000
 1b4:	0187a783          	lw	a5,24(a5) # 20000018 <gpio_oe_A>
 1b8:	fe010113          	add	sp,sp,-32
 1bc:	00112e23          	sw	ra,28(sp)
 1c0:	00812c23          	sw	s0,24(sp)
 1c4:	00912a23          	sw	s1,20(sp)
 1c8:	01212823          	sw	s2,16(sp)
 1cc:	01312623          	sw	s3,12(sp)
 1d0:	01412423          	sw	s4,8(sp)
 1d4:	01512223          	sw	s5,4(sp)
 1d8:	fff00613          	li	a2,-1
 1dc:	20000737          	lui	a4,0x20000
 1e0:	200006b7          	lui	a3,0x20000
 1e4:	00872703          	lw	a4,8(a4) # 20000008 <uart_bauddiv>
 1e8:	00c6a683          	lw	a3,12(a3) # 2000000c <uart_ctrl>
 1ec:	00c7a023          	sw	a2,0(a5)
 1f0:	200007b7          	lui	a5,0x20000
 1f4:	01c7af83          	lw	t6,28(a5) # 2000001c <gpio_data_A>
 1f8:	200007b7          	lui	a5,0x20000
 1fc:	0107af03          	lw	t5,16(a5) # 20000010 <LOAD_VALUE>
 200:	200007b7          	lui	a5,0x20000
 204:	0147a603          	lw	a2,20(a5) # 20000014 <TIMER_STATUS>
 208:	27100513          	li	a0,625
 20c:	200007b7          	lui	a5,0x20000
 210:	200005b7          	lui	a1,0x20000
 214:	0047a783          	lw	a5,4(a5) # 20000004 <uart_status>
 218:	0005a583          	lw	a1,0(a1) # 20000000 <uart_data>
 21c:	005b9837          	lui	a6,0x5b9
 220:	00a72023          	sw	a0,0(a4)
 224:	00100713          	li	a4,1
 228:	00010537          	lui	a0,0x10
 22c:	00e6a023          	sw	a4,0(a3)
 230:	fff50513          	add	a0,a0,-1 # ffff <_sidata+0xfb9b>
 234:	44800893          	li	a7,1096
 238:	3e900993          	li	s3,1001
 23c:	3f500913          	li	s2,1013
 240:	40100493          	li	s1,1025
 244:	41100413          	li	s0,1041
 248:	41d00093          	li	ra,1053
 24c:	42d00393          	li	t2,1069
 250:	43900293          	li	t0,1081
 254:	00700e93          	li	t4,7
 258:	d8080813          	add	a6,a6,-640 # 5b8d80 <_sidata+0x5b891c>
 25c:	00100e13          	li	t3,1
 260:	00600313          	li	t1,6
 264:	00150713          	add	a4,a0,1
 268:	00afa023          	sw	a0,0(t6)
 26c:	03d77533          	remu	a0,a4,t4
 270:	010f2023          	sw	a6,0(t5)
 274:	01c62023          	sw	t3,0(a2)
 278:	00062703          	lw	a4,0(a2)
 27c:	10077713          	and	a4,a4,256
 280:	fe070ce3          	beqz	a4,278 <main+0xc8>
 284:	12a36a63          	bltu	t1,a0,3b8 <main+0x208>
 288:	00251713          	sll	a4,a0,0x2
 28c:	00e88733          	add	a4,a7,a4
 290:	00072703          	lw	a4,0(a4)
 294:	00070067          	jr	a4
 298:	00038a93          	mv	s5,t2
 29c:	04900a13          	li	s4,73
 2a0:	0007a703          	lw	a4,0(a5)
 2a4:	fe070ee3          	beqz	a4,2a0 <main+0xf0>
 2a8:	0145a023          	sw	s4,0(a1)
 2ac:	0006a703          	lw	a4,0(a3)
 2b0:	000aca03          	lbu	s4,0(s5)
 2b4:	001a8a93          	add	s5,s5,1
 2b8:	00276713          	or	a4,a4,2
 2bc:	00e6a023          	sw	a4,0(a3)
 2c0:	fe0a10e3          	bnez	s4,2a0 <main+0xf0>
 2c4:	fa1ff06f          	j	264 <main+0xb4>
 2c8:	00008a93          	mv	s5,ra
 2cc:	04900a13          	li	s4,73
 2d0:	0007a703          	lw	a4,0(a5)
 2d4:	fe070ee3          	beqz	a4,2d0 <main+0x120>
 2d8:	0145a023          	sw	s4,0(a1)
 2dc:	0006a703          	lw	a4,0(a3)
 2e0:	000aca03          	lbu	s4,0(s5)
 2e4:	001a8a93          	add	s5,s5,1
 2e8:	00276713          	or	a4,a4,2
 2ec:	00e6a023          	sw	a4,0(a3)
 2f0:	fe0a10e3          	bnez	s4,2d0 <main+0x120>
 2f4:	f71ff06f          	j	264 <main+0xb4>
 2f8:	00040a93          	mv	s5,s0
 2fc:	04900a13          	li	s4,73
 300:	0007a703          	lw	a4,0(a5)
 304:	fe070ee3          	beqz	a4,300 <main+0x150>
 308:	0145a023          	sw	s4,0(a1)
 30c:	0006a703          	lw	a4,0(a3)
 310:	000aca03          	lbu	s4,0(s5)
 314:	001a8a93          	add	s5,s5,1
 318:	00276713          	or	a4,a4,2
 31c:	00e6a023          	sw	a4,0(a3)
 320:	fe0a10e3          	bnez	s4,300 <main+0x150>
 324:	f41ff06f          	j	264 <main+0xb4>
 328:	00048a93          	mv	s5,s1
 32c:	04900a13          	li	s4,73
 330:	0007a703          	lw	a4,0(a5)
 334:	fe070ee3          	beqz	a4,330 <main+0x180>
 338:	0145a023          	sw	s4,0(a1)
 33c:	0006a703          	lw	a4,0(a3)
 340:	000aca03          	lbu	s4,0(s5)
 344:	001a8a93          	add	s5,s5,1
 348:	00276713          	or	a4,a4,2
 34c:	00e6a023          	sw	a4,0(a3)
 350:	fe0a10e3          	bnez	s4,330 <main+0x180>
 354:	f11ff06f          	j	264 <main+0xb4>
 358:	00090a93          	mv	s5,s2
 35c:	04900a13          	li	s4,73
 360:	0007a703          	lw	a4,0(a5)
 364:	fe070ee3          	beqz	a4,360 <main+0x1b0>
 368:	0145a023          	sw	s4,0(a1)
 36c:	0006a703          	lw	a4,0(a3)
 370:	000aca03          	lbu	s4,0(s5)
 374:	001a8a93          	add	s5,s5,1
 378:	00276713          	or	a4,a4,2
 37c:	00e6a023          	sw	a4,0(a3)
 380:	fe0a10e3          	bnez	s4,360 <main+0x1b0>
 384:	ee1ff06f          	j	264 <main+0xb4>
 388:	00098a93          	mv	s5,s3
 38c:	04900a13          	li	s4,73
 390:	0007a703          	lw	a4,0(a5)
 394:	fe070ee3          	beqz	a4,390 <main+0x1e0>
 398:	0145a023          	sw	s4,0(a1)
 39c:	0006a703          	lw	a4,0(a3)
 3a0:	000aca03          	lbu	s4,0(s5)
 3a4:	001a8a93          	add	s5,s5,1
 3a8:	00276713          	or	a4,a4,2
 3ac:	00e6a023          	sw	a4,0(a3)
 3b0:	fe0a10e3          	bnez	s4,390 <main+0x1e0>
 3b4:	eb1ff06f          	j	264 <main+0xb4>
 3b8:	00028a13          	mv	s4,t0
 3bc:	04900513          	li	a0,73
 3c0:	0007a703          	lw	a4,0(a5)
 3c4:	fe070ee3          	beqz	a4,3c0 <main+0x210>
 3c8:	00a5a023          	sw	a0,0(a1)
 3cc:	0006a703          	lw	a4,0(a3)
 3d0:	000a4503          	lbu	a0,0(s4)
 3d4:	001a0a13          	add	s4,s4,1
 3d8:	00276713          	or	a4,a4,2
 3dc:	00e6a023          	sw	a4,0(a3)
 3e0:	fe0510e3          	bnez	a0,3c0 <main+0x210>
 3e4:	e81ff06f          	j	264 <main+0xb4>
 3e8:	2749                	.insn	2, 0x2749
 3ea:	206d                	.insn	2, 0x206d
 3ec:	6572                	.insn	2, 0x6572
 3ee:	2164                	.insn	2, 0x2164
 3f0:	000a                	.insn	2, 0x000a
 3f2:	0000                	.insn	2, 0x
 3f4:	2749                	.insn	2, 0x2749
 3f6:	206d                	.insn	2, 0x206d
 3f8:	6c62                	.insn	2, 0x6c62
 3fa:	6575                	.insn	2, 0x6575
 3fc:	0a21                	.insn	2, 0x0a21
 3fe:	0000                	.insn	2, 0x
 400:	2749                	.insn	2, 0x2749
 402:	206d                	.insn	2, 0x206d
 404:	7570                	.insn	2, 0x7570
 406:	7072                	.insn	2, 0x7072
 408:	656c                	.insn	2, 0x656c
 40a:	0a21                	.insn	2, 0x0a21
 40c:	0000                	.insn	2, 0x
 40e:	0000                	.insn	2, 0x
 410:	2749                	.insn	2, 0x2749
 412:	206d                	.insn	2, 0x206d
 414:	65657267          	.insn	4, 0x65657267
 418:	216e                	.insn	2, 0x216e
 41a:	000a                	.insn	2, 0x000a
 41c:	2749                	.insn	2, 0x2749
 41e:	206d                	.insn	2, 0x206d
 420:	6579                	.insn	2, 0x6579
 422:	6c6c                	.insn	2, 0x6c6c
 424:	0a21776f          	jal	a4,174c6 <_sidata+0x17062>
 428:	0000                	.insn	2, 0x
 42a:	0000                	.insn	2, 0x
 42c:	2749                	.insn	2, 0x2749
 42e:	206d                	.insn	2, 0x206d
 430:	7161                	.insn	2, 0x7161
 432:	6175                	.insn	2, 0x6175
 434:	0a21                	.insn	2, 0x0a21
 436:	0000                	.insn	2, 0x
 438:	2749                	.insn	2, 0x2749
 43a:	206d                	.insn	2, 0x206d
 43c:	6c62                	.insn	2, 0x6c62
 43e:	6361                	.insn	2, 0x6361
 440:	0a283a6b          	.insn	4, 0x0a283a6b
 444:	0000                	.insn	2, 0x
 446:	0000                	.insn	2, 0x
 448:	03b8                	.insn	2, 0x03b8
 44a:	0000                	.insn	2, 0x
 44c:	0388                	.insn	2, 0x0388
 44e:	0000                	.insn	2, 0x
 450:	0358                	.insn	2, 0x0358
 452:	0000                	.insn	2, 0x
 454:	0328                	.insn	2, 0x0328
 456:	0000                	.insn	2, 0x
 458:	02f8                	.insn	2, 0x02f8
 45a:	0000                	.insn	2, 0x
 45c:	02c8                	.insn	2, 0x02c8
 45e:	0000                	.insn	2, 0x
 460:	0298                	.insn	2, 0x0298
	...

Disassembly of section .data:

20000000 <uart_data>:
20000000:	000c                	.insn	2, 0x000c
20000002:	5000                	.insn	2, 0x5000

20000004 <uart_status>:
20000004:	0008                	.insn	2, 0x0008
20000006:	5000                	.insn	2, 0x5000

20000008 <uart_bauddiv>:
20000008:	0004                	.insn	2, 0x0004
2000000a:	5000                	.insn	2, 0x5000

2000000c <uart_ctrl>:
2000000c:	0000                	.insn	2, 0x
2000000e:	5000                	.insn	2, 0x5000

20000010 <LOAD_VALUE>:
20000010:	0004                	.insn	2, 0x0004
20000012:	4300                	.insn	2, 0x4300

20000014 <TIMER_STATUS>:
20000014:	0000                	.insn	2, 0x
20000016:	4300                	.insn	2, 0x4300

20000018 <gpio_oe_A>:
20000018:	0004                	.insn	2, 0x0004
2000001a:	4000                	.insn	2, 0x4000

2000001c <gpio_data_A>:
2000001c:	0000                	.insn	2, 0x
2000001e:	4000                	.insn	2, 0x4000

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
