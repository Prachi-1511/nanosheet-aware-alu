module alu_control #(
    parameter OP_WIDTH = 4
)(
    input  wire [OP_WIDTH-1:0] optcode,
    output reg  [3:0]           alu_op
);

    always @(*) begin
        case (optcode)
            4'b0000: alu_op = 4'b0000; // ADD
            4'b0001: alu_op = 4'b0001; // SUB
            4'b0010: alu_op = 4'b0010; // OR
            4'b0011: alu_op = 4'b0011; // AND
            4'b0100: alu_op = 4'b0100; // SHIFT LEFT
            4'b0101: alu_op = 4'b0101; // SHIFT RIGHT
            
            default: alu_op = 4'b0000; // Safe default: ADD
        endcase
    end

endmodule