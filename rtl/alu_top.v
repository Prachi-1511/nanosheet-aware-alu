module alu_top #(
    parameter WIDTH = 32
)(
    input  wire clk,
    input  wire rst_n,
    input  wire [WIDTH-1:0] op_a,
    input  wire [WIDTH-1:0] op_b,
    input  wire [3:0] alu_op,
    output reg  [WIDTH-1:0] result,
    output wire zero
);

    // Zero flag
    assign zero = (result == {WIDTH{1'b0}});

    always @(*) begin
        case (alu_op)
            4'b0000: result = op_a + op_b;        // ADD
            4'b0001: result = op_a - op_b;        // SUB
            4'b0010: result = op_a & op_b;        // AND
            4'b0011: result = op_a | op_b;        // OR
            4'b0100: result = op_a ^ op_b;        // XOR
            4'b0101: result = op_a << op_b[$clog2(WIDTH)-1:0]; // SLL
            4'b0110: result = op_a >> op_b[$clog2(WIDTH)-1:0]; // SRL
            4'b0111: result = (op_a < op_b) ? {{(WIDTH-1){1'b0}}, 1'b1} : {WIDTH{1'b0}};
            default: result = {WIDTH{1'b0}};
        endcase
    end

endmodule