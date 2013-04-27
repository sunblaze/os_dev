set kaslr-memory-search 0
set disassembly-flavor intel
set architecture i8086

# Connect to our cpu emulator's gdb session
target remote localhost:1234

echo **** James' command reference ****\n
echo br *0x7c00     ; Sets a breakpoint at the first command in the bootsector\n
echo c              ; Continue
echo x/i $eip       ; Shows next instruction\n
echo si             ; Steps to next instruction\n
echo info registers ; Shows all registers and their values
echo **** Done ****\n
