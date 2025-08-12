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

## Waveform Output
Below is the GTKWave output for the simulation of the `test.s` program:

<img width="1197" height="569" alt="image" src="https://github.com/user-attachments/assets/7c4aaf73-1547-4f80-9f16-76db71e48b9a" />

## Understanding the Waveform Output

The simulation generates a waveform file (`wave.vcd`) viewable with [GTKWave](http://gtkwave.sourceforge.net/). This waveform shows how the CPU executes instructions cycle-by-cycle.

### Key Signals Displayed
- **`pc`**: Program Counter, increments by 4 each instruction fetch.
- **`regs[5]` to `regs[13]`**: Register values used in the test program.
- **Instruction memory (`mem`)**: Holds the current instruction fetched.
- **Clock (`clk`)**: Drives the CPU cycles.

### Interpreting the Waveform for an Instruction
1. At each rising clock edge, the PC updates to fetch the next instruction.
2. Register values change on the clock edge following instruction execution.
3. For example, during the execution of `add x7, x5, x6`:
   - PC increments by 4.
   - Register `x7` updates to the sum of `x5` and `x6`.
4. Memory read and write operations appear as changes in `mem` values at addresses corresponding to the effective memory access.

### Navigation Tips
- Use the **Zoom** tool to focus on specific clock cycles.
- The **Search** bar lets you find signal names quickly.
- Toggle signals ON/OFF to reduce clutter.
- Follow the PC value to track program execution flow.

Viewing and understanding these waveforms will help you verify instruction execution and debug your CPU design.


