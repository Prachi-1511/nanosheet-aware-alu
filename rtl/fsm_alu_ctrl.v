module fsm_alu_ctrl (
    input  wire        clk,
    input  wire        rst,
    input  wire        start,
    input  wire [3:0]  op_in,
    input  wire        ready,
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
            WRITEBACK: begin
                if (ready)
                    next_state = DONE;
                else
                    next_state = WRITEBACK;
            end
            
            DONE:      next_state = IDLE;
            default:   next_state = IDLE;
        endcase
    end

    // Output logic
    // ALU operation register
    always @(posedge clk or posedge rst) begin
        if (rst)
            alu_op <= 0;
        else if (curr_state == LOAD_OP)
            alu_op <= op_in;
    end


// ALU enable (registered)
    always @(posedge clk or posedge rst) begin
        if (rst)
            alu_en <= 0;
        else if (curr_state == EXECUTE)
            alu_en <= 1;
        else
            alu_en <= 0;
    end


// Valid signal (stall-safe)
    always @(posedge clk or posedge rst) begin
        if (rst)
            valid <= 0;
        else if (curr_state == WRITEBACK)
            valid <= 1;
        else if (valid && ready)
            valid <= 0;
    end

endmodule