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