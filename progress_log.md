# Progress Log

## Day 0
- Defined project scope and objectives
- Finalized RTL-first design strategy
- Set up repository structure
- Drafted initial documentation and README

## Day 1
- Defined ALU operation set and interface
- Implemented parameterized top-level ALU RTL
- Experimented with ALU operations

## Day 2 – ALU Core RTL
- Implemented a parameterized combinational ALU in Verilog.
- Datapath width controlled using WIDTH parameter.
- Supported arithmetic, logical, and shift operations.
- Implemented masked variable shifts using $clog2(WIDTH).
- Added standard ALU flags: Zero, Negative, Carry, Overflow.
- Used default assignments to prevent latch inference.
- Design is synthesizable and suitable as a reusable RTL IP block.

Status: ALU core complete. Verification to be added next.

## Day 3:
- Developed self-checking testbench for ALU
- Verified ADD/SUB overflow edge cases
- Validated logical and shift operations
- Implemented reusable verification task

## Day 4 – Functional Verification
Verified ALU operations using waveform analysis. Confirmed correct flag behavior for signed overflow, negative results, and shift operations.

## Day 5 – Execution Unit Planning (FSM & Control)

Defined the next phase of the project by extending the verified ALU
into an FSM-controlled execution unit.
Implemented a dedicated ALU control module to decode instruction opcodes
into ALU operation select signals.

- Finalized opcode mapping for arithmetic, logical, and shift operations
- Designed a 3-state FSM (IDLE → EXECUTE → DONE) for operation sequencing
- Established control–datapath separation between FSM, ALU control, and ALU