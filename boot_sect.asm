;
; A boot sector that prints a hex value
;
[org 0x7c00]          ; Tell the assembler where this code will be loaded

mov bp, 0x8000        ; Here we set our stack safely out of the 
mov sp, bp            ; way, at 0x8000

mov dx, 0x1fb6        ; store the value to print in dx
call print_hex        ; call the function

jmp $                 ; Jump forever.

%include "print_string.asm"
%include "print_hex.asm"

;
; Padding and magic BIOS number.
;

times 510-($-$$) db 0 ; Pad the boot sector out with zeros

dw 0xaa55             ; Last two bytes (one word) form the magic number,
                      ; so BIOS knows we are a boot sector.
