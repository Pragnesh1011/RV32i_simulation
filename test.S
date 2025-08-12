# File: test.S
# Test program for RISC-V core
addi x5, x0, 7      # x5 = 7
addi x6, x0, 5      # x6 = 5
add  x7, x5, x6     # x7 = x5 + x6 = 12
sub  x8, x7, x5     # x8 = x7 - x5 = 12 - 7 = 5
and  x9, x7, x6     # x9 = x7 & x6 = 12 & 5 = 4 (binary: 1100 & 0101 = 0100)
or   x10, x7, x6    # x10 = x7 | x6 = 12 | 5 = 13 (binary: 1100 | 0101 = 1101)
sll  x11, x5, x6    # x11 = x5 << x6 = 7 << 5 = 224 (7 * 2^5)
sw   x10, 0(x0)     # Store x10 (13) to mem[0]
lw   x12, 0(x0)     # Load from mem[0] to x12, should be 13
beq  x12, x10, skip # If x12 == x10, skip next instruction
addi x10, x0, -1    # (Skipped) x10 = -1 if branch fails
skip:
jal  x13, end       # Jump to end, x13 = pc + 4
addi x10, x0, 0     # (Skipped) x10 = 0 if jal works
end:
add  x10, x12, x11  # x10 = x12 + x11 = 13 + 224 = 237
ecall                # Print x10 (237) and exit