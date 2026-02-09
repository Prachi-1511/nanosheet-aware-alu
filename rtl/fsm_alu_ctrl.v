module fsm_alu_ctrl (
    input  wire        clk,
    input  wire        rst,
    input  wire        start,
    input  wire [3:0]  op_in,
    output reg         alu_en,
    output reg  [3:0]  alu_op,
    output reg         valid
);

    typedef enum reg [2:0] {
        IDLE,
        LOAD_OP,
        EXECUTE,
        WRITEBACK,
        DONE
    } state_t;

    state_t curr_state, next_state;

    // State register
    always @(posedge clk or posedge rst) begin
        if (rst)
            curr_state <= IDLE;
        else
            curr_state <= next_state;
    end

    // Next-state logic
    always @(*) begin
        next_state = curr_state;
        case (curr_state)
            IDLE:      if (start) next_state = LOAD_OP;
            LOAD_OP:   next_state = EXECUTE;
            EXECUTE:   next_state = WRITEBACK;
            WRITEBACK: next_state = DONE;
            DONE:      next_state = IDLE;
            default:   next_state = IDLE;
        endcase
    end

    // Output logic (FIXING YOUR GAP)
    always @(*) begin
        alu_en  = 0;
        alu_op  = 0;
        valid   = 0;

        case (curr_state)
            LOAD_OP: begin
                alu_op = op_in;
            end
            EXECUTE: begin
                alu_en = 1;
            end
            WRITEBACK: begin
                valid = 1;
            end
        endcase
    end

endmodule