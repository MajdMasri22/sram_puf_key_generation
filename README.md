# SRAM PUF (Physical Unclonable Function) - Key Generation & Storage

## Overview

SystemVerilog-based implementation of a simulated SRAM Physical Unclonable
Function (PUF) system for generating a 32-bit key from a 256-bit PUF response.

The project explores hardware-based key generation using helper-data-based
response reconstruction and reliability testing under simulated bit errors.

## Project Objectives

- Generate a simulated 256-bit PUF response.
- Reconstruct a stable response using helper data.
- Generate a 32-bit key from the stable response.
- Evaluate PUF reliability using simulated bit errors and BER measurements.

## System Architecture

The design consists of three main stages:

1. **PUF Response Generation**
   - Generates a simulated 256-bit PUF response using an LFSR-based mechanism
     for pseudo-random simulation behavior.

2. **Response Reconstruction**
   - Uses helper data and XOR-based reconstruction to obtain a stable response.

3. **Key Generation**
   - Processes the stable response through a hashing stage to produce a 32-bit key.

### Simplified Data Flow

```text
256-bit Raw PUF Response
          │
          ▼
   Helper Data / XOR
          │
          ▼
   Stable PUF Response
          │
          ▼
      Hash Function
          │
          ▼
       32-bit Key
```

## Reliability Testing
Two testbenches were developed to evaluate PUF behavior and reliability.

### Error correction Test
`ecc_tb_key_gen.sv` introduces simulated bit flips into the PUF response
and evaluates the XOR-based response reconstruction and measures the effect of simulated bit flips on the PUF response.

### BER (Bit Error Rate) Testing
`ber_tb_key_gen.sv` introduces a 5% probability of flipping each bit and
measures the resulting Bit Error Rate (BER) across multiple simulation runs.
This provides a simplified model for studying PUF reliability degradation, providing
a simplified model for studying PUF response instability and reliability degradation.

## Main Modules
| Module | Description |
| --- | --- |
| `sram_puf.sv` | Generates the simulated 256-bit PUF response |
| `error_correction.sv` |	Performs helper-data-based XOR reconstruction |
| `hash.sv` |	Generates a 32-bit key from the stable response |
| `key_gen.sv` | Top-level module connecting the design |
| `tb_key_gen.sv` |	Functional key-generation testbench |
| `ecc_tb_key_gen.sv` |	Tests response reconstruction under simulated errors |
| `ber_tb_key_gen.sv` |	Measures BER under simulated bit flips |

## Technologies

- SystemVerilog
- RTL Design
- Hardware Security / PUFs
- Digital Logic Design
- Simulation & Testbench Development

## What I Learned

- Modular RTL design using SystemVerilog
- SystemVerilog testbench development
- Parameterized hardware modules
- Hardware reliability testing
- BER measurement and analysis
- PUF-based hardware security concepts

## Future Improvements

- Implement a more robust error-correcting code.
- Use a more realistic SRAM startup behavior model.
- Improve the hashing/key-generation algorithm.
- Develop a more detailed aging and reliability model.
- Evaluate the design through a synthesis and physical-design flow.
