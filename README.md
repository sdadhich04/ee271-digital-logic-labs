# EE 271 Digital Logic Labs

A collection of SystemVerilog lab directories for digital-logic designs. Each lab includes source for a `DE1_SoC` top-level module; the top-level port definitions use DE1-SoC board signals such as `CLOCK_50`, `KEY`, `LEDR`, `SW`, and `HEX`.

## Contents

| Folder | Source included |
| --- | --- |
| `lab1_mux/` | Two-input and four-input multiplexer modules and a `DE1_SoC` top level. |
| `lab2_boolean_seg7/` | `theft` logic, a seven-segment module, multiplexers, and a top level. |
| `lab3_fsm/` | A `simple` finite-state machine, clock divider, seven-segment module, and a top level. |
| `lab4_button_debounce/` | Metastability, button-detection, LED-control, and win-state modules with a top level. |
| `lab5_cyberplayer_lfsr/` | LFSR, comparator, counter, button, LED-control, win-state, and `CyberPlayer` modules with a top level. |
| `lab_quiz_adder_fsm/` | A continuous-adder FSM, clock divider, seven-segment module, and a top level. |

## Hardware and tools

- SystemVerilog (`.sv`) source.
- The `DE1_SoC` top-level comments identify the DE1-SoC board; the clocked top levels declare a 50 MHz `CLOCK_50` input.
- No Quartus project files, pin-assignment files, or build scripts are included.

## How to run

Choose one lab directory, add that directory's `.sv` files to a SystemVerilog project or simulator, and use its `DE1_SoC` module as the top level. The source also contains inline modules named `*_testbench` for simulation. Board programming requires board pin assignments, which are not included in this repository.

## Credits

Git history shows one contributor: Sparsh Dadhich. No second contributor appears in the repository's commit history.
