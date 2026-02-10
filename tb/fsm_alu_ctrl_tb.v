`timescale 1ns/1ps
`include "rtl/fsm_alu_ctrl.v"

module fsm_alu_ctrl_tb;
    reg clk;
    reg rst;
    reg start;
    reg [3:0] op_in;

    wire alu_en;
    wire [3:0] alu_op;
    wire valid;

    // DUT = Device Under Test
    fsm_alu_ctrl dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .op_in(op_in),
        .alu_en(alu_en),
        .alu_op(alu_op),
        .valid(valid)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        // Dump waveforms
        $dumpfile("fsm_out.vcd");
        $dumpvars(0, fsm_alu_ctrl_tb);

        // Initial values
        clk   = 0;
        rst   = 1;
        start = 0;
        op_in = 4'b0010;  // Example: ADD

        // Reset pulse
        #10 rst = 0;

        // Apply start
        #10 start = 1;
        #10 start = 0;

        // Let FSM run
        #100;

        $finish;
    end

endmodule