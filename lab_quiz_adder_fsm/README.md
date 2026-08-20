# Continuous Adder FSM

This folder contains a reconstructed, portfolio-ready version of a continuous-adder FSM demo for the DE1-SoC board.

The circuit repeatedly adds the value selected on `SW[7:0]`, shows the running value on the HEX displays, uses `SW[8]` as reset, uses `SW[9]` as pause, and uses `KEY[0]` for a faster board clock selection. `DE1_SoC.sv` includes a simulation testbench covering reset, addition, pause/resume, speed selection, and display output behavior.

The reconstruction note is kept here because the local project folder retained the intentionally broken starter version, while the final working source was only available as an archived personal PDF record.
