# EE 271 Digital Logic Labs

SystemVerilog portfolio archive from UW EE 271: Digital Circuits and Systems. The repository shows a progression from combinational logic through finite-state machines, clocking, button synchronization, and an LFSR-based reaction game.

## Contents

| Folder | Focus |
| --- | --- |
| `lab1_mux/` | Two-input and four-input multiplexers with a DE1-SoC top level and testbenches. |
| `lab2_boolean_seg7/` | Boolean logic and seven-segment display decoding. |
| `lab3_fsm/` | FSM design with clock division and display output. |
| `lab4_button_debounce/` | Button synchronization, metastability handling, LED control, and win-state logic. |
| `lab5_cyberplayer_lfsr/` | Reaction-game modules using an LFSR, comparator, counter, synchronized button input, and LED control. |
| `lab_quiz_adder_fsm/` | Continuous-adder FSM with a DE1-SoC top level and simulation testbench. |

## Notes

- Targets the Terasic DE1-SoC board and Intel Quartus-style SystemVerilog workflow.
- Course handouts, reports, board videos, screenshots, and generated Quartus artifacts are intentionally not bundled.
- The `lab_quiz_adder_fsm/` source was reconstructed from an archived personal PDF record because the retained Quartus source tree contained the intentionally broken starter version. The included files are marked as post-course curation, not a claim about the original source archive state.

## Suggested Workflow

Open an individual lab folder in Quartus or compile the relevant `.sv` files with your preferred SystemVerilog simulator. Each folder is kept self-contained so the examples can be reviewed independently.
