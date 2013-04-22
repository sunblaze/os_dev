; prints the value of DX as hex.
print_hex:
  pusha
  mov ax, 5                       ; start with the least significant hex digit
  begin_hex_fillout:
  mov bx, HEX_OUT
  add bx, ax

  mov cx, dx
  and cl, 0x0f

  cmp cl, 0x0a
  jge set_alpha_char

  add cl, '0'                     ; add 0 character int to offset
  jmp end_of_dec_or_alpha_if

  set_alpha_char:

  add cl, 'W'                     ; add `W` adding 10 will result in an `a` character int to offset

  end_of_dec_or_alpha_if:

  mov [bx], cl                    ; put calculated character into HEX_OUT global variable

  shr dx, 4
  dec ax
  cmp ax, 1
  jne begin_hex_fillout

  mov bx, HEX_OUT                 ; print the string pointed to
  call print_string               ; by BX
  popa
  ret

; global variables
HEX_OUT: db '0x0000',0
