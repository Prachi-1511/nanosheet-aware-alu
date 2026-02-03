module exec_fsm (
    input  wire clk,
    input  wire reset,
    input  wire start,
    output reg  exec_en,
    output reg  done
);

    // State encoding
    localparam IDLE    = 2'b00;
    localparam EXECUTE = 2'b01;
    localparam DONE    = 2'b10;

    reg [1:0] current_state, next_state;

    // State register (sequential logic)
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next-state logic (combinational)
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (start)
                    next_state = EXECUTE;
                else
                    next_state = IDLE;
            end

            EXECUTE: begin
                next_state = DONE;
            end

            DONE: begin
                next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    // Output logic (Moore-style FSM)
    always @(*) begin
        exec_en = 1'b0;
        done    = 1'b0;

        case (current_state)
            EXECUTE: exec_en = 1'b1;
            DONE:    done    = 1'b1;
        endcase
    end

endmodule