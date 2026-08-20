/*

This module takes care of the adding logic for the top level
module. You may notice that there is a better way to implement
it. However, to get credit for this quiz, you must maintain the
general structure. In other words, there must be state logic.


*/
module continuousAdder (clk, reset, SW, outVal);
	input logic clk, reset;
	input logic [9:0] SW;
	output logic [16:0] outVal;

	// State Variables
	enum {state_stop, state_add} ps, ns;

	// Next State Logic
	always_comb begin
		ns = ps;
		case (ps)
			state_stop:
				if (SW[9] == 0)	ns = state_add;
			state_add:
				if (SW[9] == 1)	ns = state_stop;
		endcase
	end

	// DFFs
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= state_stop;
			outVal <= 0;
		end
		else begin
			ps <= ns;
			if (ps == state_add)
				outVal <= outVal + SW[5:0];
		end
	end

endmodule
