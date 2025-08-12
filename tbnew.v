`timescale 1ns / 1ps

module tbnew;
    reg clk;
    reg reset;
    wire [31:0] pc;
    wire [31:0] x10;

    // Instantiate the DUT
    riscv_core uut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .x10(x10)
    );

    // Clock Generation: 10ns period
    always #5 clk = ~clk;

    // Initialize memory from hex file
    initial begin
        $display("Loading firmware...");
        $readmemh("test.hex", uut.mem);
    end

    // Stimulus block
    initial begin
        clk = 0;
        reset = 1;
        #20 reset = 0;
        #200 $display("Simulation completed.");
        $finish;
    end

    // Dump waveform
   initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tbnew);
    $dumpvars(0, tbnew.uut);

    // Dump registers x5 to x13 used in test program
    $dumpvars(0, tbnew.uut.regs[5]);  // x5
    $dumpvars(0, tbnew.uut.regs[6]);  // x6
    $dumpvars(0, tbnew.uut.regs[7]);  // x7
    $dumpvars(0, tbnew.uut.regs[8]);  // x8
    $dumpvars(0, tbnew.uut.regs[9]);  // x9
    $dumpvars(0, tbnew.uut.regs[10]); // x10
    $dumpvars(0, tbnew.uut.regs[11]); // x11
    $dumpvars(0, tbnew.uut.regs[12]); // x12
    $dumpvars(0, tbnew.uut.regs[13]); // x13

    // Optional: dump PC and memory interface signals
    $dumpvars(0, tbnew.uut.pc);
   // $dumpvars(0, tbnew.uut.mem_addr);
   // $dumpvars(0, tbnew.uut.mem_wdata);
    //$dumpvars(0, tbnew.uut.mem_rdata);
    //$dumpvars(0, tbnew.uut.trap);
end


endmodule