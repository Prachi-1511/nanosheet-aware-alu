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

## Day 5 – ALU Control Unit Design

Implemented a dedicated ALU control module to decode instruction opcodes
into ALU operation select signals.

- Designed combinational opcode-to-operation decoding logic
- Used parameterized opcode width for scalability
- Ensured safe synthesis with complete case coverage and default handling
- Established clean separation between control logic and datapath (ALU)

## Day 6 – FSM-Based Execution Control

Designed and implemented a clocked finite state machine (FSM) to control
the execution flow of the ALU-based execution unit.

- Implemented a 3-state Moore FSM (IDLE, EXECUTE, DONE)
- Separated state register, next-state logic, and output logic
- Generated execution enable and completion signals
- Established timing control independent of datapath computation