interruptBeispiel.asm


.org	0
	jmp		Init 			// bei Reset

.org 	0x0004
	jmp		ISR_INT1		// interrupt 

Init:
	ldi		r16,



	out		SPH, r16 
	ldi 	r16, low(RAMEND)
	out 	PSL, r16

	call 	InitPorts
	call	InitISR

	ldi		r17, 0


MainLoop:
	in 		r16, PORTC
	nop
	nop
	out 	PORTC, r16

:-------------------------------------------------------------------------------
InitPorts:
	ldi		r16, 0b10
	out		PORTD, r16

	ldi 	r16, 0xFF


:-------------------------------------------------------------------------------
InitISR:
	sei						// enable global interrupt

:-------------------------------------------------------------------------------

Delay:
	ldi		r19, 5
	clr 	r18
delay1:
	dec 	r18


:-------------------------------------------------------------------------------
ISR_INT1:
	
	push	r16
	in 		r16, SREG
	push 	r16

	in 		r16, PORTC
	inc 	r16
	out 	PORTC, r16

	pop		r16
	out		SREG, r16


