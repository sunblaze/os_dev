; prints the string located at bx address
print_string:
  pusha
  mov ah, 0x0e
  print_string_begin:
  mov al, [bx]
  cmp al, 0
  je print_string_end_loop
  int 0x10
  inc bx
  jmp print_string_begin
  print_string_end_loop:  
  popa
  ret
