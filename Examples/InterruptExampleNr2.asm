.include "m8def.inc"
 
.def temp = r16
 
.org 0x000
         rjmp main            ; Reset Handler
.org INT0addr
         rjmp int0_handler    ; IRQ0 Handler
.org INT1addr
         rjmp int1_handler    ; IRQ1 Handler
 
 
main:                         ; hier beginnt das Hauptprogramm
 
         ldi temp, LOW(RAMEND)
         out SPL, temp
         ldi temp, HIGH(RAMEND)
         out SPH, temp
 
         ldi temp, 0x00
         out DDRD, temp
 
         ldi temp, 0xFF
         out DDRB, temp
 
         ldi temp, (1<<ISC01) | (1<<ISC11) ; INT0 und INT1 auf fallende Flanke konfigurieren
         out MCUCR, temp
 
         ldi temp, (1<<INT0) | (1<<INT1) ; INT0 und INT1 aktivieren
         out GICR, temp
 
         sei                   ; Interrupts allgemein aktivieren
 
loop:    rjmp loop             ; eine leere Endlosschleife
 
int0_handler:
         push temp             ; Das SREG in temp sichern. Vorher
         in   temp, SREG       ; muss natürlich temp gesichert werden
 
         sbi PORTB, 0
 
         out SREG, temp        ; Die Register SREG und temp wieder
         pop temp              ; herstellen
         reti
 
int1_handler:
         push temp             ; Das SREG in temp sichern. Vorher
         in   temp, SREG       ; muss natürlich temp gesichert werden
 
         cbi PORTB, 0
 
         out SREG, temp        ; Die Register SREG und temp wieder
         pop temp              ; herstellen
         reti
