`timescale 1ns/1ps
`include "alu.v"

module alu_tb;

    parameter WIDTH = 32;

    reg  [WIDTH-1:0] a;
    reg  [WIDTH-1:0] b;
    reg  [2:0] alu_ctrl;

    wire [WIDTH-1:0] result;
    wire Z;
    wire N;
    wire C;
    wire O;

    // DUT instantiation
    alu #(.WIDTH(WIDTH)) dut (
        .a(a),
        .b(b),
        .alu_ctrl(alu_ctrl),
        .result(result),
        .Z(Z),
        .N(N),
        .C(C),
        .O(O)
    );

    // Task for checking result
    task check;
        input [WIDTH-1:0] exp_result;
        input exp_Z, exp_N, exp_C, exp_O;
        begin
            #1;
            if (result !== exp_result ||
                Z !== exp_Z ||
                N !== exp_N ||
                C !== exp_C ||
                O !== exp_O)
            begin
                $display("❌ FAIL | ctrl=%b a=%0d b=%0d | res=%0d",
                          alu_ctrl, a, b, result);
            end
            else begin
                $display("✅ PASS | ctrl=%b a=%0d b=%0d | res=%0d",
                          alu_ctrl, a, b, result);
            end
        end
    endtask

    initial begin
        $display("---- ALU TEST START ----");

        // ADD (no overflow)
        alu_ctrl = 3'b000;
        a = 10; b = 20;
        check(30, 0, 0, 0, 0);

        // ADD overflow
        a = 32'sd2147483647; b = 1;
        check(32'h80000000, 0, 1, 0, 1);

        // SUB (no overflow)
        alu_ctrl = 3'b001;
        a = 50; b = 20;
        check(30, 0, 0, 1, 0);

        // SUB overflow
        a = 32'sd-2147483648; b = 1;
        check(32'h7FFFFFFF, 0, 0, 1, 1);

        // AND
        alu_ctrl = 3'b010;
        a = 32'hF0F0; b = 32'h0FF0;
        check(32'h00F0, 0, 0, 0, 0);

        // OR
        alu_ctrl = 3'b011;
        check(32'hFFF0, 0, 1, 0, 0);

        // Shift Left
        alu_ctrl = 3'b100;
        a = 1; b = 4;
        check(16, 0, 0, 0, 0);

        // Shift Right
        alu_ctrl = 3'b101;
        a = 32; b = 2;
        check(8, 0, 0, 0, 0);

        $display("---- ALU TEST END ----");
        $finish;
    end

    // Dump waveform
    initial begin
        $dumpfile("alu_ex.vcd");
        $dumpvars(0, alu_tb);
    end

endmodule