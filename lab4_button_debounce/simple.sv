module simple (clk, reset, SW, LEDR);
	input logic clk, reset;
	input logic [1:0] SW;
	output logic [2:0] LEDR;

	// State variables
	enum { outer, middle, left, right } ps, ns;

	// Next State logic
	always_comb begin
		case (ps)
		outer:  ns = middle;

		middle: if (~SW[0] & SW[1]) ns = right;
					else if (SW[0] & ~SW[1]) ns = left;
					else ns = outer;

		left: if (~SW[0] & SW[1]) ns = middle;
					else ns = right;

		right: if (SW[0] & ~SW[1]) ns = middle;
				else if (~SW[0] & SW[1]) ns = left;
					else ns = outer;
		endcase
	end

	// Output logic - could also be another always_comb block.
	always_comb begin
		case (ps)
		outer : LEDR = 3'b101;
		middle : LEDR = 3'b010;
		left : LEDR = 3'b100;
		right : LEDR = 3'b001;
		endcase
	end



	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
		ps <= outer;
		else
		ps <= ns;
	end

endmodule



module simple_testbench();
	logic clk, reset, w;
	logic out;

	simple dut (clk, reset, w, out);

	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
									@(posedge clk);
		reset <= 1; @(posedge clk); // Always reset FSMs at start
		reset <= 0; w <= 0; @(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
						w <= 1; @(posedge clk);
						w <= 0; @(posedge clk);
						w <= 1; @(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
						w <= 0; @(posedge clk);
									@(posedge clk);
		$stop; // End the simulation.
	end
endmodule
