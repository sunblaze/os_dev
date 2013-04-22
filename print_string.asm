print_string:
  pusha
  mov ah, 0x0e
  print_string_begin:
  mov cl, [bx] ;TODO move directly to al
  cmp cl, 0    ;TODO cmp to al
  je print_string_end_loop
  mov al, cl   ;TODO remove
  int 0x10
  add bx, 1
  jmp print_string_begin
  print_string_end_loop:  
  popa
  ret
