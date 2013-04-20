;
; A simple boot sector that prints a message to the screen using a BIOS routine.
;

mov ah, 0x0e          ;int 10/ah = 0eh -> scrolling teletype BIOS routine

; First attempt
mov al, the_secret
int 0x10              ; Does this print an X?

; Second attempt
mov al, [the_secret]
int 0x10              ; Does this print an X?

; Third attempt
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10              ; Does this print an X?

; Fourth attempt
mov al, [0x7c1d]
int 0x10              ; Does this print an X?

jmp $                 ; Jump forever.

the_secret:
  db "X"

;
; Padding and magic BIOS number.
;

times 510-($-$$) db 0 ; Pad the boot sector out with zeros

dw 0xaa55             ; Last two bytes (one word) form the magic number,
                      ; so BIOS knows we are a boot sector.
