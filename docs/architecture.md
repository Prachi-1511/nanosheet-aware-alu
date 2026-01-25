# ALU Architecture

## Overview
The ALU is designed as a modular and parameterized RTL block suitable for integration into larger digital systems.

## Supported Operations
| Opcode | Operation |
|------|----------|
| 0000 | ADD |
| 0001 | SUB |
| 0010 | AND |
| 0011 | OR |
| 0100 | XOR |
| 0101 | Shift Left Logical |
| 0110 | Shift Right Logical |
| 0111 | Set Less Than |

## Design Goals
- Parameterized bit-width
- Clean separation of functional units
- Synthesis-friendly coding style
- Easy extensibility