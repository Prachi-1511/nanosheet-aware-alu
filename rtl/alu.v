`timescale 1ns / 1ps

module alu #(parameter WIDTH = 32)(
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire [2:0] alu_ctrl,

    output reg  [WIDTH-1:0] result,
    output reg Z,   // Zero flag
    output reg N,   // Negative flag
    output reg C,   // Carry flag
    output reg O    // Overflow flag
);

    // Extended wires for carry detection
    reg [WIDTH:0] sum_ext;
    reg [WIDTH:0] sub_ext;

    always @(*) begin
        // Default assignments (prevents latch inference)
        result = {WIDTH{1'b0}};
        C = 1'b0;
        O = 1'b0;

        case (alu_ctrl)
            3'b000: begin // ADD
                sum_ext = {1'b0, a} + {1'b0, b}; // 0 to avoid sign confusion
                result  = sum_ext[WIDTH-1:0];
                C       = sum_ext[WIDTH];
                O       = (~(a[WIDTH-1] ^ b[WIDTH-1])) &
                          (result[WIDTH-1] ^ a[WIDTH-1]);
            end

            3'b001: begin // SUB
                sub_ext = {1'b0, a} - {1'b0, b};
                result  = sub_ext[WIDTH-1:0];
                C       = ~sub_ext[WIDTH]; // borrow flag
                O       = ((a[WIDTH-1] ^ b[WIDTH-1])) &
                          (result[WIDTH-1] ^ a[WIDTH-1]);
            end

            3'b010: begin // AND
                result = a & b;
            end

            3'b011: begin // OR
                result = a | b;
            end

            3'b100: begin // Shift Left Logical
                result = a << b[$clog2(WIDTH)-1:0];
            end

            3'b101: begin // Shift Right Logical
                result = a >> b[$clog2(WIDTH)-1:0];
            end

            default: begin
                result = {WIDTH{1'b0}};
            end
        endcase

        // Flags
        Z = (result == {WIDTH{1'b0}});
        N = result[WIDTH-1];
    end

endmodule