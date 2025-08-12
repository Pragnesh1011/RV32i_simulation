module riscv_core(
    input wire clk,
    input wire reset,
    output reg [31:0] pc,
    output [31:0] x10
);
    reg [31:0] regs [0:31];      // 32-bit register file (x0 to x31)
    reg [31:0] mem [0:1023];     // 4KB memory (1024 words)
    wire [31:0] instr;           // Current instruction

    assign instr = mem[pc[11:2]]; // Word-aligned fetch
    assign x10 = regs[10];        // Output register a0 (x10)

    wire [6:0] opcode = instr[6:0];
    wire [4:0] rd     = instr[11:7];
    wire [2:0] funct3 = instr[14:12];
    wire [4:0] rs1    = instr[19:15];
    wire [4:0] rs2    = instr[24:20];
    wire [6:0] funct7 = instr[31:25];

    wire [31:0] imm_i = {{20{instr[31]}}, instr[31:20]};
    wire [31:0] imm_s = {{20{instr[31]}}, instr[31:25], instr[11:7]};
    wire [31:0] imm_b = {{20{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
    wire [31:0] imm_j = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};

    integer i; // Declare integer for loop compatibility
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 0;
            // Explicitly initialize registers (Verilog-1995 compatible)
            regs[0] = 0; regs[1] = 0; regs[2] = 0; regs[3] = 0;
            regs[4] = 0; regs[5] = 0; regs[6] = 0; regs[7] = 0;
            regs[8] = 0; regs[9] = 0; regs[10] = 0; regs[11] = 0;
            regs[12] = 0; regs[13] = 0; regs[14] = 0; regs[15] = 0;
            regs[16] = 0; regs[17] = 0; regs[18] = 0; regs[19] = 0;
            regs[20] = 0; regs[21] = 0; regs[22] = 0; regs[23] = 0;
            regs[24] = 0; regs[25] = 0; regs[26] = 0; regs[27] = 0;
            regs[28] = 0; regs[29] = 0; regs[30] = 0; regs[31] = 0;
        end else begin
            pc <= pc + 4; // Default increment
            case (opcode)
                7'b0010011: begin // I-type (addi)
                    if (funct3 == 3'b000)
                        regs[rd] = regs[rs1] + imm_i;
                end
                7'b0110011: begin // R-type (add, sub, and, or, sll)
                    case ({funct7, funct3})
                        10'b0000000_000: regs[rd] = regs[rs1] + regs[rs2]; // add
                        10'b0100000_000: regs[rd] = regs[rs1] - regs[rs2]; // sub
                        10'b0000000_111: regs[rd] = regs[rs1] & regs[rs2]; // and
                        10'b0000000_110: regs[rd] = regs[rs1] | regs[rs2]; // or
                        10'b0000000_001: regs[rd] = regs[rs1] << regs[rs2][4:0]; // sll
                    endcase
                end
                7'b0000011: begin // Load (lw)
                    if (funct3 == 3'b010)
                        regs[rd] = mem[(regs[rs1] + imm_i) >> 2];
                end
                7'b0100011: begin // Store (sw)
                    if (funct3 == 3'b010)
                        mem[(regs[rs1] + imm_s) >> 2] = regs[rs2];
                end
                7'b1100011: begin // Branch (beq)
                    if (funct3 == 3'b000 && regs[rs1] == regs[rs2])
                        pc = pc + imm_b - 4;
                end
                7'b1101111: begin // Jump (jal)
                    regs[rd] = pc + 4;
                    pc = pc + imm_j - 4;
                end
                7'b1110011: begin // ecall
                    $display("ECALL: x10 = %d", regs[10]);
                    $finish;
                end
            endcase
            regs[0] = 0; // Ensure x0 is always 0
        end
    end
endmodule