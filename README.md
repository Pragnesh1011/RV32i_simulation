# - RV32I RISC-V Core Simulation

## - Overview
This project is a **single-cycle RV32I RISC-V processor** implemented in Verilog, simulated with a custom test program and visualized in GTKWave.  
It demonstrates basic instruction execution, memory operations, branching, and jump behavior, making it ideal for educational purposes and processor design experiments.

---

## - Architecture Details
- **Core Type:** Single-cycle, non-pipelined
- **ISA:** RV32I base integer instruction set
- **Registers:** 32 registers (x0–x31), 32-bit wide
- **Memory:** 4KB unified memory (Von Neumann architecture)
- **Word Alignment:** Instructions and data are word-aligned (PC increments by 4)
- **Reset Behavior:** Clears PC and all registers

---

## - Implemented Instructions

### Arithmetic & Logic
- `ADD`  (R-type)
- `SUB`  (R-type)
- `AND`  (R-type)
- `OR`   (R-type)
- `SLL`  (R-type)
- `ADDI` (I-type)

### Memory Access
- `LW` (Load Word)
- `SW` (Store Word)

### Control Flow
- `BEQ` (Branch if Equal)
- `JAL` (Jump and Link)

### System
- `ECALL` (Prints `x10` value and halts simulation)

---

## - Test Program (`test.s`)
The included assembly program demonstrates:
1. **Immediate and register arithmetic** (`ADDI`, `ADD`, `SUB`)
2. **Bitwise operations** (`AND`, `OR`, `SLL`)
3. **Memory store/load** (`SW`, `LW`)
4. **Conditional branching** (`BEQ`)
5. **Unconditional jump** (`JAL`)
6. **System call output** (`ECALL`)

