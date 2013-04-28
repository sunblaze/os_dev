;
; A boot sector that enters 32-bit protected mode.
;
; Setup Code
[org 0x7c00]          ; Tell the assembler where this code will be loaded

mov ax, 0             ; Zeros out the ax register, I could use "xor ax, ax" but I don't want to optimize if it makes the command more obscure to understand
mov ds, ax            ; ds register can only be set with the value in another register. ds has to be initialized to zero because there is no guarantee
                      ; it's cleared on boot. And we want our mov [BOOT_DRIVE] and all other [x] calls to direct to the correct segment
mov ss, ax            ; ss register also has to be cleared like the ds register, so our stack position gets set to the correct location (0x8000)

mov [BOOT_DRIVE], dl  ; BIOS stores our boot drive in DL, so it's
                      ; best to remember this for later.

mov bp, 0x9000        ; Here we set our stack safely out of the 
mov sp, bp            ; way, at 0x9000

; Main Code
mov bx, MSG_REAL_MODE
call print_string

call switch_to_pm     ; Note that we never return from here.

jmp $                 ; Jump forever.

%include "print_string.asm"
%include "gdt.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"

[bits 32]

; This is where we arrive after switching to and initializing protected mode.
BEGIN_PM:

  mov ebx, MSG_PROT_MODE
  call print_string_pm    ; Use our 32-bit print routine.

  jmp $                   ; Hang.

; Global variables
BOOT_DRIVE: db 0
MSG_REAL_MODE: db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE: db "Successfully landed in 32-bit Protected Mode", 0

;
; Padding and magic BIOS number.
;

times 510-($-$$) db 0 ; Pad the boot sector out with zeros

dw 0xaa55             ; Last two bytes (one word) form the magic number,
                      ; so BIOS knows we are a boot sector.
