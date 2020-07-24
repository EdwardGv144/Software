
;CodeVisionAVR C Compiler V3.42 Evaluation
;(C) Copyright 1998-2020 Pavel Haiduc, HP InfoTech S.R.L.
;http://www.hpinfotech.ro

;Build configuration    : Debug
;Chip type              : ATmega32U4
;Program type           : Application
;Clock frequency        : 16.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 640 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32U4
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2560
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU WDTCSR=0x60
	.EQU UCSR1A=0xC8
	.EQU UDR1=0xCE
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x0AFF
	.EQU __DSTACK_SIZE=0x0280
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETW1Z
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETD1Z
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETW2X
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETD2X
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF __lcd_x=R4
	.DEF __lcd_y=R3
	.DEF __lcd_maxx=R6

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _twi_int_handler
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G105:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G105:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x0:
	.DB  0x25,0x75,0x0
_0x2000003:
	.DB  0x7
_0x2020003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  _twi_result
	.DW  _0x2000003*2

	.DW  0x02
	.DW  __base_y_G101
	.DW  _0x2020003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0x380

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
     .EQU __sm_adc_noise_red=0x02 // 26022010_1
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif
;unsigned char read_adc(unsigned char adc_input)
; 0000 002E {

	.CSEG
_read_adc:
; .FSTART _read_adc
; 0000 002F ADMUX=(adc_input & 0x1f) | ADC_VREF_TYPE;
	ST   -Y,R17
	MOV  R17,R26
;	adc_input -> R17
	MOV  R30,R17
	ANDI R30,LOW(0x1F)
	ORI  R30,LOW(0x60)
	STS  124,R30
; 0000 0030 if (adc_input & 0x20) ADCSRB|=(1<<MUX5);
	SBRS R17,5
	RJMP _0x3
	LDS  R30,123
	ORI  R30,0x20
	RJMP _0xC
; 0000 0031 else ADCSRB&= ~(1<<MUX5);
_0x3:
	LDS  R30,123
	ANDI R30,0xDF
_0xC:
	STS  123,R30
; 0000 0032 // Delay needed for the stabilization of the ADC input voltage
; 0000 0033 delay_us(10);
	__DELAY_USB 53
; 0000 0034 // Start the AD conversion
; 0000 0035 ADCSRA|=(1<<ADSC);
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
; 0000 0036 // Wait for the AD conversion to complete
; 0000 0037 while ((ADCSRA & (1<<ADIF))==0);
_0x5:
	LDS  R30,122
	ANDI R30,LOW(0x10)
	BREQ _0x5
; 0000 0038 ADCSRA|=(1<<ADIF);
	LDS  R30,122
	ORI  R30,0x10
	STS  122,R30
; 0000 0039 return ADCH;
	LDS  R30,121
	JMP  _0x20E0002
; 0000 003A }
; .FEND
;void main(void)
; 0000 003D {
_main:
; .FSTART _main
; 0000 003E // Declare your local variables here
; 0000 003F 
; 0000 0040 // Crystal Oscillator division factor: 1
; 0000 0041 #pragma optsize-
; 0000 0042 CLKPR=(1<<CLKPCE);
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 0043 CLKPR=(0<<CLKPCE) | (0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 0044 #ifdef _OPTIMIZE_SIZE_
; 0000 0045 #pragma optsize+
; 0000 0046 #endif
; 0000 0047 
; 0000 0048 // Input/Output Ports initialization
; 0000 0049 // Port B initialization
; 0000 004A // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=Out Bit2=In Bit1=In Bit0=In
; 0000 004B DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (1<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	LDI  R30,LOW(8)
	OUT  0x4,R30
; 0000 004C // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=0 Bit2=T Bit1=T Bit0=T
; 0000 004D PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x5,R30
; 0000 004E 
; 0000 004F // Port C initialization
; 0000 0050 // Function: Bit7=In Bit6=In
; 0000 0051 DDRC=(0<<DDC7) | (0<<DDC6);
	OUT  0x7,R30
; 0000 0052 // State: Bit7=T Bit6=T
; 0000 0053 PORTC=(0<<PORTC7) | (0<<PORTC6);
	OUT  0x8,R30
; 0000 0054 
; 0000 0055 // Port D initialization
; 0000 0056 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0057 DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0xA,R30
; 0000 0058 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0059 PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0xB,R30
; 0000 005A 
; 0000 005B // Port E initialization
; 0000 005C // Function: Bit6=In Bit2=In
; 0000 005D DDRE=(0<<DDE6) | (0<<DDE2);
	OUT  0xD,R30
; 0000 005E // State: Bit6=T Bit2=T
; 0000 005F PORTE=(0<<PORTE6) | (0<<PORTE2);
	OUT  0xE,R30
; 0000 0060 
; 0000 0061 // Port F initialization
; 0000 0062 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit1=In Bit0=In
; 0000 0063 DDRF=(0<<DDF7) | (0<<DDF6) | (0<<DDF5) | (0<<DDF4) | (0<<DDF1) | (0<<DDF0);
	OUT  0x10,R30
; 0000 0064 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit1=T Bit0=T
; 0000 0065 PORTF=(0<<PORTF7) | (0<<PORTF6) | (0<<PORTF5) | (0<<PORTF4) | (0<<PORTF1) | (0<<PORTF0);
	OUT  0x11,R30
; 0000 0066 
; 0000 0067 PLLCSR=(0<<PINDIV) | (0<<PLLE) | (0<<PLOCK);
	OUT  0x29,R30
; 0000 0068 PLLFRQ=(0<<PINMUX) | (0<<PLLUSB) | (0<<PLLTM1) | (0<<PLLTM0) | (0<<PDIV3) | (0<<PDIV2) | (0<<PDIV1) | (0<<PDIV0);
	OUT  0x32,R30
; 0000 0069 
; 0000 006A // Timer/Counter 0 initialization
; 0000 006B // Clock source: System Clock
; 0000 006C // Clock value: Timer 0 Stopped
; 0000 006D // Mode: Normal top=0xFF
; 0000 006E // OC0A output: Disconnected
; 0000 006F // OC0B output: Disconnected
; 0000 0070 TCCR0A=(0<<COM0A1) | (0<<COM0A0) | (0<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (0<<WGM00);
	OUT  0x24,R30
; 0000 0071 TCCR0B=(0<<WGM02) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x25,R30
; 0000 0072 TCNT0=0x00;
	OUT  0x26,R30
; 0000 0073 OCR0A=0x00;
	OUT  0x27,R30
; 0000 0074 OCR0B=0x00;
	OUT  0x28,R30
; 0000 0075 
; 0000 0076 // Timer/Counter 1 initialization
; 0000 0077 // Clock source: System Clock
; 0000 0078 // Clock value: Timer1 Stopped
; 0000 0079 // Mode: Normal top=0xFFFF
; 0000 007A // OC1A output: Disconnected
; 0000 007B // OC1B output: Disconnected
; 0000 007C // OC1C output: Disconnected
; 0000 007D // Noise Canceler: Off
; 0000 007E // Input Capture on Falling Edge
; 0000 007F // Timer1 Overflow Interrupt: Off
; 0000 0080 // Input Capture Interrupt: Off
; 0000 0081 // Compare A Match Interrupt: Off
; 0000 0082 // Compare B Match Interrupt: Off
; 0000 0083 // Compare C Match Interrupt: Off
; 0000 0084 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<COM1C1) | (0<<COM1C0) | (0<<WGM11) | (0<<WGM10);
	STS  128,R30
; 0000 0085 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	STS  129,R30
; 0000 0086 TCNT1H=0x00;
	STS  133,R30
; 0000 0087 TCNT1L=0x00;
	STS  132,R30
; 0000 0088 ICR1H=0x00;
	STS  135,R30
; 0000 0089 ICR1L=0x00;
	STS  134,R30
; 0000 008A OCR1AH=0x00;
	STS  137,R30
; 0000 008B OCR1AL=0x00;
	STS  136,R30
; 0000 008C OCR1BH=0x00;
	STS  139,R30
; 0000 008D OCR1BL=0x00;
	STS  138,R30
; 0000 008E OCR1CH=0x00;
	STS  141,R30
; 0000 008F OCR1CL=0x00;
	STS  140,R30
; 0000 0090 
; 0000 0091 // Timer/Counter 3 initialization
; 0000 0092 // Clock source: System Clock
; 0000 0093 // Clock value: Timer3 Stopped
; 0000 0094 // Mode: Normal top=0xFFFF
; 0000 0095 // OC3A output: Disconnected
; 0000 0096 // OC3B output: Disconnected
; 0000 0097 // OC3C output: Disconnected
; 0000 0098 // Noise Canceler: Off
; 0000 0099 // Input Capture on Falling Edge
; 0000 009A // Timer3 Overflow Interrupt: Off
; 0000 009B // Input Capture Interrupt: Off
; 0000 009C // Compare A Match Interrupt: Off
; 0000 009D // Compare B Match Interrupt: Off
; 0000 009E // Compare C Match Interrupt: Off
; 0000 009F TCCR3A=(0<<COM3A1) | (0<<COM3A0) | (0<<COM3B1) | (0<<COM3B0) | (0<<COM3C1) | (0<<COM3C0) | (0<<WGM31) | (0<<WGM30);
	STS  144,R30
; 0000 00A0 TCCR3B=(0<<ICNC3) | (0<<ICES3) | (0<<WGM33) | (0<<WGM32) | (0<<CS32) | (0<<CS31) | (0<<CS30);
	STS  145,R30
; 0000 00A1 TCNT3H=0x00;
	STS  149,R30
; 0000 00A2 TCNT3L=0x00;
	STS  148,R30
; 0000 00A3 ICR3H=0x00;
	STS  151,R30
; 0000 00A4 ICR3L=0x00;
	STS  150,R30
; 0000 00A5 OCR3AH=0x00;
	STS  153,R30
; 0000 00A6 OCR3AL=0x00;
	STS  152,R30
; 0000 00A7 OCR3BH=0x00;
	STS  155,R30
; 0000 00A8 OCR3BL=0x00;
	STS  154,R30
; 0000 00A9 OCR3CH=0x00;
	STS  157,R30
; 0000 00AA OCR3CL=0x00;
	STS  156,R30
; 0000 00AB 
; 0000 00AC // Timer/Counter 4 initialization
; 0000 00AD // Clock: Timer4 Stopped
; 0000 00AE // Mode: Normal top=OCR4C
; 0000 00AF // OC4A output: OC4A=Disc. /OC4A=Disc.
; 0000 00B0 // OC4B output: OC4B=Disc. /OC4B=Disc.
; 0000 00B1 // OC4D output: OC4D=Disc. /OC4D=Disc.
; 0000 00B2 // Fault Protection: Off
; 0000 00B3 // Fault Protection Noise Canceler: Off
; 0000 00B4 // Fault Protection triggered on Falling Edge
; 0000 00B5 // Timer4 Overflow Interrupt: Off
; 0000 00B6 // Compare A Match Interrupt: Off
; 0000 00B7 // Compare B Match Interrupt: Off
; 0000 00B8 // Compare D Match Interrupt: Off
; 0000 00B9 // Fault Protection Interrupt: Off
; 0000 00BA // Dead Time Prescaler: 1
; 0000 00BB // Dead Time Rising Edge: 0.000 us
; 0000 00BC // Dead Time Falling Edge: 0.000 us
; 0000 00BD 
; 0000 00BE // Set Timer4 for synchronous operation
; 0000 00BF PLLFRQ&=(1<<PINMUX) | (1<<PLLUSB) | (0<<PLLTM1) | (0<<PLLTM0) | (1<<PDIV3) | (1<<PDIV2) | (1<<PDIV1) | (1<<PDIV0);
	IN   R30,0x32
	ANDI R30,LOW(0xCF)
	OUT  0x32,R30
; 0000 00C0 
; 0000 00C1 TCCR4A=(0<<COM4A1) | (0<<COM4A0) | (0<<COM4B1) | (0<<COM4B0) | (0<<FOC4A) | (0<<FOC4B) | (0<<PWM4A) | (0<<PWM4B);
	LDI  R30,LOW(0)
	STS  192,R30
; 0000 00C2 TCCR4B=(0<<PWM4X) | (0<<PSR4) | (0<<DTPS41) | (0<<DTPS40) | (0<<CS43) | (0<<CS42) | (0<<CS41) | (0<<CS40);
	STS  193,R30
; 0000 00C3 TCCR4C=(0<<COM4A1S) | (0<<COM4A0S) | (0<<COM4B1S) | (0<<COM4B0S) | (0<<COM4D1) | (0<<COM4D0) | (0<<FOC4D) | (0<<PWM4D);
	STS  194,R30
; 0000 00C4 TCCR4D=(0<<FPIE4) | (0<<FPEN4) | (0<<FPNC4) | (0<<FPES4) | (0<<FPAC4) | (0<<FPF4) | (0<<WGM41) | (0<<WGM40);
	STS  195,R30
; 0000 00C5 TCCR4E=(0<<TLOCK4) | (0<<ENHC4) | (0<<OC4OE5) | (0<<OC4OE4) | (0<<OC4OE3) | (0<<OC4OE2) | (0<<OC4OE1) | (0<<OC4OE0);
	STS  196,R30
; 0000 00C6 TC4H=0x00;
	RCALL SUBOPT_0x0
; 0000 00C7 TCNT4=0x00;
	STS  190,R30
; 0000 00C8 TC4H=0x00;
	RCALL SUBOPT_0x0
; 0000 00C9 OCR4A=0x00;
	STS  207,R30
; 0000 00CA TC4H=0x00;
	RCALL SUBOPT_0x0
; 0000 00CB OCR4B=0x00;
	STS  208,R30
; 0000 00CC TC4H=0x00;
	RCALL SUBOPT_0x0
; 0000 00CD OCR4C=0x00;
	STS  209,R30
; 0000 00CE TC4H=0x00;
	RCALL SUBOPT_0x0
; 0000 00CF OCR4D=0x00;
	STS  210,R30
; 0000 00D0 DT4=0x00;
	LDI  R30,LOW(0)
	STS  212,R30
; 0000 00D1 
; 0000 00D2 // Timer/Counter 0 Interrupt(s) initialization
; 0000 00D3 TIMSK0=(0<<OCIE0B) | (0<<OCIE0A) | (0<<TOIE0);
	STS  110,R30
; 0000 00D4 
; 0000 00D5 // Timer/Counter 1 Interrupt(s) initialization
; 0000 00D6 TIMSK1=(0<<ICIE1) | (0<<OCIE1C) | (0<<OCIE1B) | (0<<OCIE1A) | (0<<TOIE1);
	STS  111,R30
; 0000 00D7 
; 0000 00D8 // Timer/Counter 3 Interrupt(s) initialization
; 0000 00D9 TIMSK3=(0<<ICIE3) | (0<<OCIE3C) | (0<<OCIE3B) | (0<<OCIE3A) | (0<<TOIE3);
	STS  113,R30
; 0000 00DA 
; 0000 00DB // Timer/Counter 4 Interrupt(s) initialization
; 0000 00DC TIMSK4=(0<<OCIE4D) | (0<<OCIE4A) | (0<<OCIE4B) | (0<<TOIE4);
	STS  114,R30
; 0000 00DD 
; 0000 00DE // External Interrupt(s) initialization
; 0000 00DF // INT0: Off
; 0000 00E0 // INT1: Off
; 0000 00E1 // INT2: Off
; 0000 00E2 // INT3: Off
; 0000 00E3 // INT6: Off
; 0000 00E4 EICRA=(0<<ISC31) | (0<<ISC30) | (0<<ISC21) | (0<<ISC20) | (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	STS  105,R30
; 0000 00E5 EICRB=(0<<ISC61) | (0<<ISC60);
	STS  106,R30
; 0000 00E6 EIMSK=(0<<INT6) | (0<<INT3) | (0<<INT2) | (0<<INT1) | (0<<INT0);
	OUT  0x1D,R30
; 0000 00E7 // PCINT0 interrupt: Off
; 0000 00E8 // PCINT1 interrupt: Off
; 0000 00E9 // PCINT2 interrupt: Off
; 0000 00EA // PCINT3 interrupt: Off
; 0000 00EB // PCINT4 interrupt: Off
; 0000 00EC // PCINT5 interrupt: Off
; 0000 00ED // PCINT6 interrupt: Off
; 0000 00EE // PCINT7 interrupt: Off
; 0000 00EF PCMSK0=(0<<PCINT7) | (0<<PCINT6) | (0<<PCINT5) | (0<<PCINT4) | (0<<PCINT3) | (0<<PCINT2) | (0<<PCINT1) | (0<<PCINT0);
	STS  107,R30
; 0000 00F0 PCICR=(0<<PCIE0);
	STS  104,R30
; 0000 00F1 
; 0000 00F2 // USART1 initialization
; 0000 00F3 // USART1 disabled
; 0000 00F4 UCSR1B=(0<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (0<<RXEN1) | (0<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);
	STS  201,R30
; 0000 00F5 
; 0000 00F6 // Analog Comparator initialization
; 0000 00F7 // Analog Comparator: Off
; 0000 00F8 // The Analog Comparator's positive input is
; 0000 00F9 // connected to the AIN0 pin
; 0000 00FA // The Analog Comparator's negative input is
; 0000 00FB // connected to the AIN1 pin
; 0000 00FC ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 00FD ADCSRB=(0<<ACME);
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 00FE // Digital input buffer on AIN0: On
; 0000 00FF DIDR1=(0<<AIN0D);
	STS  127,R30
; 0000 0100 
; 0000 0101 // ADC initialization
; 0000 0102 // ADC Clock frequency: 1000.000 kHz
; 0000 0103 // ADC Voltage Reference: AVCC pin
; 0000 0104 // ADC High Speed Mode: Off
; 0000 0105 // ADC Auto Trigger Source: ADC Stopped
; 0000 0106 // Only the 8 most significant bits of
; 0000 0107 // the AD conversion result are used
; 0000 0108 // Digital input buffers on ADC0: On, ADC1: Off
; 0000 0109 // ADC4: On, ADC5: On, ADC6: Off, ADC7: On
; 0000 010A DIDR0=(0<<ADC7D) | (1<<ADC6D) | (0<<ADC5D) | (0<<ADC4D) | (1<<ADC1D) | (0<<ADC0D);
	LDI  R30,LOW(66)
	STS  126,R30
; 0000 010B // Digital input buffers on ADC8: On, ADC9: On, ADC10: On, ADC11: On
; 0000 010C // ADC12: On, ADC13: On
; 0000 010D DIDR2=(0<<ADC13D) | (0<<ADC12D) | (0<<ADC11D) | (0<<ADC10D) | (0<<ADC9D) | (0<<ADC8D);
	LDI  R30,LOW(0)
	STS  125,R30
; 0000 010E ADMUX=ADC_VREF_TYPE;
	LDI  R30,LOW(96)
	STS  124,R30
; 0000 010F ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	LDI  R30,LOW(132)
	STS  122,R30
; 0000 0110 ADCSRB=(1<<ADHSM) | (0<<MUX5) | (0<<ADTS3) | (0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
	LDI  R30,LOW(128)
	STS  123,R30
; 0000 0111 
; 0000 0112 // SPI initialization
; 0000 0113 // SPI Type: Slave
; 0000 0114 // SPI Clock Rate: 4000.000 kHz
; 0000 0115 // SPI Clock Phase: Cycle Start
; 0000 0116 // SPI Clock Polarity: Low
; 0000 0117 // SPI Data Order: MSB First
; 0000 0118 SPCR=(0<<SPIE) | (1<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	LDI  R30,LOW(64)
	OUT  0x2C,R30
; 0000 0119 SPSR=(0<<SPI2X);
	LDI  R30,LOW(0)
	OUT  0x2D,R30
; 0000 011A 
; 0000 011B // TWI initialization
; 0000 011C // Mode: TWI Master
; 0000 011D // Bit Rate: 100 kHz
; 0000 011E twi_master_init(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	RCALL _twi_master_init
; 0000 011F 
; 0000 0120 // Globally enable interrupts
; 0000 0121 #asm("sei")
	SEI
; 0000 0122 
; 0000 0123 // I2C LCD Shield initialization for TWI
; 0000 0124 // PCF8574 I2C bus address: 0x27
; 0000 0125 // LCD characters/line: 20
; 0000 0126 lcd_twi_init(0x3F,20);
	LDI  R30,LOW(63)
	ST   -Y,R30
	LDI  R26,LOW(20)
	RCALL _lcd_twi_init
; 0000 0127 //lcd_putsf("Prueba Serial");
; 0000 0128 while (1)
_0x8:
; 0000 0129 {
; 0000 012A // Place your code here
; 0000 012B lcd_printfxy(1,2,"%u",read_adc(1));
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x1
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x2
; 0000 012C lcd_printfxy(2,3,"%u",read_adc(6));
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x1
	LDI  R26,LOW(6)
	RCALL SUBOPT_0x2
; 0000 012D 
; 0000 012E 
; 0000 012F 
; 0000 0130 }
	RJMP _0x8
; 0000 0131 }
_0xB:
	RJMP _0xB
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
     .EQU __sm_adc_noise_red=0x02 // 26022010_1
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif

	.DSEG

	.CSEG
_twi_master_init:
; .FSTART _twi_master_init
	RCALL __SAVELOCR4
	MOVW R18,R26
	SBI  0x1E,1
	LDI  R30,LOW(7)
	STS  _twi_result,R30
	LDI  R30,LOW(0)
	STS  _twi_slave_rx_handler_G100,R30
	STS  _twi_slave_rx_handler_G100+1,R30
	STS  _twi_slave_tx_handler_G100,R30
	STS  _twi_slave_tx_handler_G100+1,R30
	CBI  0xB,1
	CBI  0xB,0
	STS  188,R30
	LDS  R30,185
	ANDI R30,LOW(0xFC)
	STS  185,R30
	MOVW R30,R18
	LDI  R26,LOW(8000)
	LDI  R27,HIGH(8000)
	RCALL __DIVW21U
	MOV  R17,R30
	CPI  R17,8
	BRLO _0x2000006
	SUBI R17,LOW(8)
_0x2000006:
	STS  184,R17
	LDS  R30,188
	ANDI R30,LOW(0x80)
	ORI  R30,LOW(0x45)
	STS  188,R30
	RCALL __LOADLOCR4
	ADIW R28,4
	RET
; .FEND
_twi_master_trans:
; .FSTART _twi_master_trans
	SBIW R28,4
	RCALL __SAVELOCR6
	MOV  R17,R26
	__GETWRS 18,19,10
	LDD  R16,Y+12
	__GETWRS 20,21,13
	SBIS 0x1E,1
	RJMP _0x2000007
	LDD  R30,Y+15
	LSL  R30
	STS  _slave_address_G100,R30
	__PUTWMRN _twi_tx_buffer_G100,0,20,21
	LDI  R30,LOW(0)
	STS  _twi_tx_index,R30
	STS  _bytes_to_tx_G100,R16
	__PUTWMRN _twi_rx_buffer_G100,0,18,19
	STS  _twi_rx_index,R30
	STS  _bytes_to_rx_G100,R17
	LDI  R30,LOW(6)
	STS  _twi_result,R30
	SEI
	CPI  R16,0
	BREQ _0x2000008
	MOV  R0,R20
	OR   R0,R21
	BREQ _0x20E0005
	CPI  R17,0
	BREQ _0x200000B
	CLR  R0
	CP   R0,R18
	CPC  R0,R19
	BREQ _0x200000C
_0x200000B:
	RJMP _0x200000A
_0x200000C:
	RJMP _0x20E0005
_0x200000A:
	SBI  0x1E,0
	RJMP _0x200000F
_0x2000008:
	CPI  R17,0
	BREQ _0x2000010
	MOV  R0,R18
	OR   R0,R19
	BREQ _0x20E0005
	LDS  R30,_slave_address_G100
	ORI  R30,1
	STS  _slave_address_G100,R30
	CBI  0x1E,0
_0x200000F:
	CBI  0x1E,1
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xA0)
	STS  188,R30
	__GETD1N 0x7A120
	RCALL SUBOPT_0x3
_0x2000016:
	SBIC 0x1E,1
	RJMP _0x2000018
	__GETD1S 6
	SBIW R30,1
	SBCI R22,0
	SBCI R23,0
	RCALL SUBOPT_0x3
	BRNE _0x2000019
	LDI  R30,LOW(5)
	STS  _twi_result,R30
	SBI  0x1E,1
	RJMP _0x20E0005
_0x2000019:
	RJMP _0x2000016
_0x2000018:
_0x2000010:
	LDS  R26,_twi_result
	LDI  R30,LOW(0)
	RCALL __EQB12
	RJMP _0x20E0004
_0x2000007:
_0x20E0005:
	LDI  R30,LOW(0)
_0x20E0004:
	RCALL __LOADLOCR6
	ADIW R28,16
	RET
; .FEND
_twi_int_handler:
; .FSTART _twi_int_handler
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	ST   -Y,R21
	ST   -Y,R20
	ST   -Y,R19
	ST   -Y,R18
	ST   -Y,R17
	ST   -Y,R16
	LDS  R17,_twi_rx_index
	LDS  R16,_twi_tx_index
	LDS  R19,_bytes_to_tx_G100
	LDS  R18,_twi_result
	MOV  R30,R17
	LDS  R26,_twi_rx_buffer_G100
	LDS  R27,_twi_rx_buffer_G100+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R20,R30
	LDS  R30,185
	ANDI R30,LOW(0xF8)
	CPI  R30,LOW(0x8)
	BRNE _0x2000023
	LDI  R18,LOW(0)
	RJMP _0x2000024
_0x2000023:
	CPI  R30,LOW(0x10)
	BRNE _0x2000025
_0x2000024:
	LDS  R30,_slave_address_G100
	RJMP _0x2000080
_0x2000025:
	CPI  R30,LOW(0x18)
	BREQ _0x2000029
	CPI  R30,LOW(0x28)
	BRNE _0x200002A
_0x2000029:
	CP   R16,R19
	BRSH _0x200002B
	MOV  R30,R16
	SUBI R16,-1
	LDS  R26,_twi_tx_buffer_G100
	LDS  R27,_twi_tx_buffer_G100+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
_0x2000080:
	STS  187,R30
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	STS  188,R30
	RJMP _0x200002C
_0x200002B:
	LDS  R30,_bytes_to_rx_G100
	CP   R17,R30
	BRSH _0x200002D
	LDS  R30,_slave_address_G100
	ORI  R30,1
	STS  _slave_address_G100,R30
	CBI  0x1E,0
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xA0)
	STS  188,R30
	RJMP _0x2000022
_0x200002D:
	RJMP _0x2000030
_0x200002C:
	RJMP _0x2000022
_0x200002A:
	CPI  R30,LOW(0x50)
	BRNE _0x2000031
	LDS  R30,187
	MOVW R26,R20
	ST   X,R30
	SUBI R17,-LOW(1)
	RJMP _0x2000032
_0x2000031:
	CPI  R30,LOW(0x40)
	BRNE _0x2000033
_0x2000032:
	LDS  R30,_bytes_to_rx_G100
	SUBI R30,LOW(1)
	CP   R17,R30
	BRLO _0x2000034
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	RJMP _0x2000081
_0x2000034:
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
_0x2000081:
	STS  188,R30
	RJMP _0x2000022
_0x2000033:
	CPI  R30,LOW(0x58)
	BRNE _0x2000036
	LDS  R30,187
	MOVW R26,R20
	ST   X,R30
	SUBI R17,-LOW(1)
	RJMP _0x2000037
_0x2000036:
	CPI  R30,LOW(0x20)
	BRNE _0x2000038
_0x2000037:
	RJMP _0x2000039
_0x2000038:
	CPI  R30,LOW(0x30)
	BRNE _0x200003A
_0x2000039:
	RJMP _0x200003B
_0x200003A:
	CPI  R30,LOW(0x48)
	BRNE _0x200003C
_0x200003B:
	CPI  R18,0
	BRNE _0x200003D
	SBIS 0x1E,0
	RJMP _0x200003E
	CP   R16,R19
	BRLO _0x2000040
	RJMP _0x2000041
_0x200003E:
	LDS  R30,_bytes_to_rx_G100
	CP   R17,R30
	BRSH _0x2000042
_0x2000040:
	LDI  R18,LOW(4)
_0x2000042:
_0x2000041:
_0x200003D:
_0x2000030:
	RJMP _0x2000082
_0x200003C:
	CPI  R30,LOW(0x38)
	BRNE _0x2000045
	LDI  R18,LOW(2)
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	RJMP _0x2000083
_0x2000045:
	CPI  R30,LOW(0x68)
	BREQ _0x2000048
	CPI  R30,LOW(0x78)
	BRNE _0x2000049
_0x2000048:
	LDI  R18,LOW(2)
	RJMP _0x200004A
_0x2000049:
	CPI  R30,LOW(0x60)
	BREQ _0x200004D
	CPI  R30,LOW(0x70)
	BRNE _0x200004E
_0x200004D:
	LDI  R18,LOW(0)
_0x200004A:
	LDI  R17,LOW(0)
	CBI  0x1E,0
	LDS  R30,_twi_rx_buffer_size_G100
	CPI  R30,0
	BRNE _0x2000051
	LDI  R18,LOW(1)
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	RJMP _0x2000084
_0x2000051:
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
_0x2000084:
	STS  188,R30
	RJMP _0x2000022
_0x200004E:
	CPI  R30,LOW(0x80)
	BREQ _0x2000054
	CPI  R30,LOW(0x90)
	BRNE _0x2000055
_0x2000054:
	SBIS 0x1E,0
	RJMP _0x2000056
	LDI  R18,LOW(1)
	RJMP _0x2000057
_0x2000056:
	LDS  R30,187
	MOVW R26,R20
	ST   X,R30
	SUBI R17,-LOW(1)
	LDS  R30,_twi_rx_buffer_size_G100
	CP   R17,R30
	BRSH _0x2000058
	LDS  R30,_twi_slave_rx_handler_G100
	LDS  R31,_twi_slave_rx_handler_G100+1
	SBIW R30,0
	BRNE _0x2000059
	LDI  R18,LOW(6)
	RJMP _0x2000057
_0x2000059:
	LDI  R26,LOW(0)
	__CALL1MN _twi_slave_rx_handler_G100,0
	CPI  R30,0
	BREQ _0x200005A
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
	STS  188,R30
	RJMP _0x2000022
_0x200005A:
	RJMP _0x200005B
_0x2000058:
	SBI  0x1E,0
_0x200005B:
	RJMP _0x200005E
_0x2000055:
	CPI  R30,LOW(0x88)
	BRNE _0x200005F
_0x200005E:
	RJMP _0x2000060
_0x200005F:
	CPI  R30,LOW(0x98)
	BRNE _0x2000061
_0x2000060:
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	STS  188,R30
	RJMP _0x2000022
_0x2000061:
	CPI  R30,LOW(0xA0)
	BRNE _0x2000062
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
	STS  188,R30
	SBI  0x1E,1
	LDS  R30,_twi_slave_rx_handler_G100
	LDS  R31,_twi_slave_rx_handler_G100+1
	SBIW R30,0
	BREQ _0x2000065
	LDI  R26,LOW(1)
	__CALL1MN _twi_slave_rx_handler_G100,0
	RJMP _0x2000066
_0x2000065:
	LDI  R18,LOW(6)
_0x2000066:
	RJMP _0x2000022
_0x2000062:
	CPI  R30,LOW(0xB0)
	BRNE _0x2000067
	LDI  R18,LOW(2)
	RJMP _0x2000068
_0x2000067:
	CPI  R30,LOW(0xA8)
	BRNE _0x2000069
_0x2000068:
	LDS  R30,_twi_slave_tx_handler_G100
	LDS  R31,_twi_slave_tx_handler_G100+1
	SBIW R30,0
	BREQ _0x200006A
	LDI  R26,LOW(0)
	__CALL1MN _twi_slave_tx_handler_G100,0
	MOV  R19,R30
	CPI  R30,0
	BREQ _0x200006C
	LDI  R18,LOW(0)
	RJMP _0x200006D
_0x200006A:
_0x200006C:
	LDI  R18,LOW(6)
	RJMP _0x2000057
_0x200006D:
	LDI  R16,LOW(0)
	CBI  0x1E,0
	RJMP _0x2000070
_0x2000069:
	CPI  R30,LOW(0xB8)
	BRNE _0x2000071
_0x2000070:
	SBIS 0x1E,0
	RJMP _0x2000072
	LDI  R18,LOW(1)
	RJMP _0x2000057
_0x2000072:
	MOV  R30,R16
	SUBI R16,-1
	LDS  R26,_twi_tx_buffer_G100
	LDS  R27,_twi_tx_buffer_G100+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	STS  187,R30
	CP   R16,R19
	BRSH _0x2000073
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
	RJMP _0x2000085
_0x2000073:
	SBI  0x1E,0
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
_0x2000085:
	STS  188,R30
	RJMP _0x2000022
_0x2000071:
	CPI  R30,LOW(0xC0)
	BREQ _0x2000078
	CPI  R30,LOW(0xC8)
	BRNE _0x2000079
_0x2000078:
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
	STS  188,R30
	LDS  R30,_twi_slave_tx_handler_G100
	LDS  R31,_twi_slave_tx_handler_G100+1
	SBIW R30,0
	BREQ _0x200007A
	LDI  R26,LOW(1)
	__CALL1MN _twi_slave_tx_handler_G100,0
_0x200007A:
	RJMP _0x2000043
_0x2000079:
	CPI  R30,0
	BRNE _0x2000022
	LDI  R18,LOW(3)
_0x2000057:
_0x2000082:
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xD0)
_0x2000083:
	STS  188,R30
_0x2000043:
	SBI  0x1E,1
_0x2000022:
	STS  _twi_rx_index,R17
	STS  _twi_tx_index,R16
	STS  _twi_result,R18
	STS  _bytes_to_tx_G100,R19
	LD   R16,Y+
	LD   R17,Y+
	LD   R18,Y+
	LD   R19,Y+
	LD   R20,Y+
	LD   R21,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
     .EQU __sm_adc_noise_red=0x02 // 26022010_1
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif

	.DSEG

	.CSEG
__lcd_setbit_G101:
; .FSTART __lcd_setbit_G101
	RCALL SUBOPT_0x4
	LDS  R26,_bus_data_G101
	RCALL SUBOPT_0x5
	RJMP _0x20E0002
; .FEND
__lcd_clrbit_G101:
; .FSTART __lcd_clrbit_G101
	RCALL SUBOPT_0x4
	COM  R30
	LDS  R26,_bus_data_G101
	AND  R30,R26
	RCALL SUBOPT_0x6
	RJMP _0x20E0002
; .FEND
__lcd_write_nibble_hi_G101:
; .FSTART __lcd_write_nibble_hi_G101
	ST   -Y,R17
	MOV  R17,R26
	LDS  R30,__pcf8574_addr_G101
	ST   -Y,R30
	LDS  R30,_bus_data_G101
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	MOV  R30,R17
	ANDI R30,LOW(0xF0)
	RCALL SUBOPT_0x5
	LDI  R26,LOW(4)
	RCALL __lcd_setbit_G101
	LDI  R26,LOW(4)
	RJMP _0x20E0003
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_hi_G101
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_hi_G101
	__DELAY_USW 200
	ADIW R28,1
	RET
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	RCALL SUBOPT_0x7
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G101)
	SBCI R31,HIGH(-__base_y_G101)
	LD   R30,Z
	ADD  R30,R16
	MOV  R26,R30
	RCALL __lcd_write_data
	MOV  R4,R16
	MOV  R3,R17
	RJMP _0x20E0001
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x8
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x8
	LDI  R30,LOW(0)
	MOV  R3,R30
	MOV  R4,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R17
	MOV  R17,R26
	CPI  R17,10
	BREQ _0x2020005
	CP   R4,R6
	BRLO _0x2020004
_0x2020005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R3
	MOV  R26,R3
	RCALL _lcd_gotoxy
	CPI  R17,10
	BREQ _0x20E0002
_0x2020004:
	INC  R4
	LDI  R26,LOW(1)
	RCALL __lcd_setbit_G101
	MOV  R26,R17
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
_0x20E0003:
	RCALL __lcd_clrbit_G101
_0x20E0002:
	LD   R17,Y+
	RET
; .FEND
_lcd_twi_init:
; .FSTART _lcd_twi_init
	RCALL SUBOPT_0x7
	STS  __pcf8574_addr_G101,R16
	LDS  R30,__pcf8574_addr_G101
	ST   -Y,R30
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x6
	MOV  R6,R17
	MOV  R30,R17
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G101,2
	MOV  R30,R17
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G101,3
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0x9
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_hi_G101
	__DELAY_USW 400
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20E0001:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,3
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
     .EQU __sm_adc_noise_red=0x02 // 26022010_1
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG

	.CSEG
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.CSEG
_pcf8574_write:
; .FSTART _pcf8574_write
	ST   -Y,R26
	LDD  R30,Y+1
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _twi_master_trans
	ADIW R28,2
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
     .EQU __sm_adc_noise_red=0x02 // 26022010_1
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG
__print_G105:
; .FSTART __print_G105
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x20A001C:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x20A001E
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x20A0022
	CPI  R18,37
	BRNE _0x20A0023
	LDI  R17,LOW(1)
	RJMP _0x20A0024
_0x20A0023:
	RCALL SUBOPT_0xA
_0x20A0024:
	RJMP _0x20A0021
_0x20A0022:
	CPI  R30,LOW(0x1)
	BRNE _0x20A0025
	CPI  R18,37
	BRNE _0x20A0026
	RCALL SUBOPT_0xA
	RJMP _0x20A00D2
_0x20A0026:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x20A0027
	LDI  R16,LOW(1)
	RJMP _0x20A0021
_0x20A0027:
	CPI  R18,43
	BRNE _0x20A0028
	LDI  R20,LOW(43)
	RJMP _0x20A0021
_0x20A0028:
	CPI  R18,32
	BRNE _0x20A0029
	LDI  R20,LOW(32)
	RJMP _0x20A0021
_0x20A0029:
	RJMP _0x20A002A
_0x20A0025:
	CPI  R30,LOW(0x2)
	BRNE _0x20A002B
_0x20A002A:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x20A002C
	ORI  R16,LOW(128)
	RJMP _0x20A0021
_0x20A002C:
	RJMP _0x20A002D
_0x20A002B:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x20A0021
_0x20A002D:
	CPI  R18,48
	BRLO _0x20A0030
	CPI  R18,58
	BRLO _0x20A0031
_0x20A0030:
	RJMP _0x20A002F
_0x20A0031:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x20A0021
_0x20A002F:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x20A0035
	RCALL SUBOPT_0xB
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	RCALL SUBOPT_0xC
	RJMP _0x20A0036
_0x20A0035:
	CPI  R30,LOW(0x73)
	BRNE _0x20A0038
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0xD
	RCALL _strlen
	MOV  R17,R30
	RJMP _0x20A0039
_0x20A0038:
	CPI  R30,LOW(0x70)
	BRNE _0x20A003B
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0xD
	RCALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x20A0039:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x20A003C
_0x20A003B:
	CPI  R30,LOW(0x64)
	BREQ _0x20A003F
	CPI  R30,LOW(0x69)
	BRNE _0x20A0040
_0x20A003F:
	ORI  R16,LOW(4)
	RJMP _0x20A0041
_0x20A0040:
	CPI  R30,LOW(0x75)
	BRNE _0x20A0042
_0x20A0041:
	LDI  R30,LOW(_tbl10_G105*2)
	LDI  R31,HIGH(_tbl10_G105*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x20A0043
_0x20A0042:
	CPI  R30,LOW(0x58)
	BRNE _0x20A0045
	ORI  R16,LOW(8)
	RJMP _0x20A0046
_0x20A0045:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x20A0077
_0x20A0046:
	LDI  R30,LOW(_tbl16_G105*2)
	LDI  R31,HIGH(_tbl16_G105*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x20A0043:
	SBRS R16,2
	RJMP _0x20A0048
	RCALL SUBOPT_0xB
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	LD   R30,X+
	LD   R31,X+
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDD  R26,Y+11
	TST  R26
	BRPL _0x20A0049
	RCALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x20A0049:
	CPI  R20,0
	BREQ _0x20A004A
	SUBI R17,-LOW(1)
	RJMP _0x20A004B
_0x20A004A:
	ANDI R16,LOW(251)
_0x20A004B:
	RJMP _0x20A004C
_0x20A0048:
	RCALL SUBOPT_0xB
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0x20A004C:
_0x20A003C:
	SBRC R16,0
	RJMP _0x20A004D
_0x20A004E:
	CP   R17,R21
	BRSH _0x20A0050
	SBRS R16,7
	RJMP _0x20A0051
	SBRS R16,2
	RJMP _0x20A0052
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x20A0053
_0x20A0052:
	LDI  R18,LOW(48)
_0x20A0053:
	RJMP _0x20A0054
_0x20A0051:
	LDI  R18,LOW(32)
_0x20A0054:
	RCALL SUBOPT_0xA
	SUBI R21,LOW(1)
	RJMP _0x20A004E
_0x20A0050:
_0x20A004D:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x20A0055
_0x20A0056:
	CPI  R19,0
	BREQ _0x20A0058
	SBRS R16,3
	RJMP _0x20A0059
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x20A005A
_0x20A0059:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x20A005A:
	RCALL SUBOPT_0xA
	CPI  R21,0
	BREQ _0x20A005B
	SUBI R21,LOW(1)
_0x20A005B:
	SUBI R19,LOW(1)
	RJMP _0x20A0056
_0x20A0058:
	RJMP _0x20A005C
_0x20A0055:
_0x20A005E:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RCALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x20A0060:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x20A0062
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x20A0060
_0x20A0062:
	CPI  R18,58
	BRLO _0x20A0063
	SBRS R16,3
	RJMP _0x20A0064
	SUBI R18,-LOW(7)
	RJMP _0x20A0065
_0x20A0064:
	SUBI R18,-LOW(39)
_0x20A0065:
_0x20A0063:
	SBRC R16,4
	RJMP _0x20A0067
	CPI  R18,49
	BRSH _0x20A0069
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x20A0068
_0x20A0069:
	RJMP _0x20A00D3
_0x20A0068:
	CP   R21,R19
	BRLO _0x20A006D
	SBRS R16,0
	RJMP _0x20A006E
_0x20A006D:
	RJMP _0x20A006C
_0x20A006E:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x20A006F
	LDI  R18,LOW(48)
_0x20A00D3:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x20A0070
	ANDI R16,LOW(251)
	ST   -Y,R20
	RCALL SUBOPT_0xC
	CPI  R21,0
	BREQ _0x20A0071
	SUBI R21,LOW(1)
_0x20A0071:
_0x20A0070:
_0x20A006F:
_0x20A0067:
	RCALL SUBOPT_0xA
	CPI  R21,0
	BREQ _0x20A0072
	SUBI R21,LOW(1)
_0x20A0072:
_0x20A006C:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x20A005F
	RJMP _0x20A005E
_0x20A005F:
_0x20A005C:
	SBRS R16,0
	RJMP _0x20A0073
_0x20A0074:
	CPI  R21,0
	BREQ _0x20A0076
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL SUBOPT_0xC
	RJMP _0x20A0074
_0x20A0076:
_0x20A0073:
_0x20A0077:
_0x20A0036:
_0x20A00D2:
	LDI  R17,LOW(0)
_0x20A0021:
	RJMP _0x20A001C
_0x20A001E:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LD   R30,X+
	LD   R31,X+
	RCALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_put_lcd_G105:
; .FSTART _put_lcd_G105
	RCALL __SAVELOCR4
	MOVW R16,R26
	LDD  R19,Y+4
	MOV  R26,R19
	RCALL _lcd_putchar
	MOVW R26,R16
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RCALL __LOADLOCR4
	ADIW R28,5
	RET
; .FEND
_lcd_printfxy:
; .FSTART _lcd_printfxy
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	RCALL __SAVELOCR4
	MOVW R30,R28
	RCALL __ADDW1R15
	LDD  R19,Z+12
	LDD  R18,Z+13
	MOVW R26,R28
	ADIW R26,6
	RCALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+6,R30
	STD  Y+6+1,R30
	STD  Y+8,R30
	STD  Y+8+1,R30
	ST   -Y,R18
	MOV  R26,R19
	RCALL _lcd_gotoxy
	MOVW R26,R28
	ADIW R26,10
	RCALL __ADDW2R15
	LD   R30,X+
	LD   R31,X+
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_lcd_G105)
	LDI  R31,HIGH(_put_lcd_G105)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G105
	RCALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET
; .FEND

	.CSEG

	.DSEG
_twi_tx_index:
	.BYTE 0x1
_twi_rx_index:
	.BYTE 0x1
_twi_result:
	.BYTE 0x1
_slave_address_G100:
	.BYTE 0x1
_twi_tx_buffer_G100:
	.BYTE 0x2
_bytes_to_tx_G100:
	.BYTE 0x1
_twi_rx_buffer_G100:
	.BYTE 0x2
_bytes_to_rx_G100:
	.BYTE 0x1
_twi_rx_buffer_size_G100:
	.BYTE 0x1
_twi_slave_rx_handler_G100:
	.BYTE 0x2
_twi_slave_tx_handler_G100:
	.BYTE 0x2
__base_y_G101:
	.BYTE 0x4
__pcf8574_addr_G101:
	.BYTE 0x1
_bus_data_G101:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(0)
	STS  191,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1:
	ST   -Y,R30
	__POINTW1FN _0x0,0
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2:
	RCALL _read_adc
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _lcd_printfxy
	ADIW R28,8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	ST   -Y,R17
	MOV  R17,R26
	LDS  R30,__pcf8574_addr_G101
	ST   -Y,R30
	MOV  R30,R17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5:
	OR   R30,R26
	STS  _bus_data_G101,R30
	MOV  R26,R30
	RJMP _pcf8574_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	STS  _bus_data_G101,R30
	MOV  R26,R30
	RJMP _pcf8574_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
	LDD  R16,Y+2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8:
	RCALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x9:
	LDI  R26,LOW(48)
	RCALL __lcd_write_nibble_hi_G101
	__DELAY_USW 400
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0xA:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0xB:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xC:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xD:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	LD   R30,X+
	LD   R31,X+
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__ADDW1R15:
	CLR  R0
	ADD  R30,R15
	ADC  R31,R0
	RET

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__EQB12:
	CP   R30,R26
	LDI  R30,1
	BREQ __EQB12T
	CLR  R30
__EQB12T:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0xFA0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
