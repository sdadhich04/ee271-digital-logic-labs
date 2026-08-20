// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic 		CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;


	 //assign HEX1 = 7'b1111111;
	 assign HEX2 = 7'b1111111;
	 assign HEX3 = 7'b1111111;
	 assign HEX4 = 7'b1111111;
	 assign HEX5 = 7'b1111111;


	// Generate clk off of CLOCK_50, whichClock picks rate.

	logic Reset;
	 assign Reset = SW[9];

	 logic [31:0] clk;
	 parameter whichClock = 15;
	 clock_divider cdiv (.reset(~KEY[1]), .clock(CLOCK_50), .divided_clocks(clk));
	 logic Clock;
//	 assign Clock = CLOCK_50; // simulation
	 assign Clock = clk[whichClock]; // board

	 logic L, R;
	 logic LK, RK;
	 logic cyber;
	 logic vic;

	 metastabilizer left_s  (.out(LK), .Clock, .Reset, .In(cyber));
	 metastabilizer right_s (.out(RK), .Clock, .Reset, .In(~KEY[0]));

	 buttonDetect leftInput (.out(L), .KEY(LK), .Clock, .Reset);
	 buttonDetect rightInput (.out(R), .KEY(RK), .Clock, .Reset);

	 LED_control LEDS (.LEDR, .L, .R, .Clock, .Reset(SW[9] | vic));

	 logic [1:0] out;

	 assign vic = (out[1] == 1) | (out[0] == 1);

	 winGame Game (.out(out), .LEDR, .L, .R, .Clock, .Reset);
	 counter Lcount (.HEX(HEX1), .win(out[1]), .Clock, .Reset);
	 counter Rcount (.HEX(HEX0), .win(out[0]), .Clock, .Reset);


	 logic [9:0] random;

	 lfsr LFSR (.random, .Clock, .Reset);
	 CyberPlayer cp (.out(cyber), .random, .SW(SW[8:0]), .Clock, .Reset);

endmodule

module DE1_SoC_testbench();
	 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 logic [9:0] LEDR;
	 logic [3:0] KEY;
	 logic [9:0] SW;
	 logic CLOCK_50;

	 DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);

	 parameter CLOCK_PERIOD = 100;
	 initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 = ~CLOCK_50;
	 end

	 initial begin
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		SW[9] <= 1;
		SW[8:0] = 9'b1111; KEY[0] = 1;@(posedge CLOCK_50);
		SW[9] <= 0;@(posedge CLOCK_50);
//		KEY[3] <= 1; KEY[0] <= 0;@(posedge CLOCK_50);
		@(posedge CLOCK_50);
//		KEY[3] <= 0;@(posedge CLOCK_50);
//		KEY[3] <= 1;@(posedge CLOCK_50);
//		KEY[3] <= 0;@(posedge CLOCK_50);
//		KEY[3] <= 1;@(posedge CLOCK_50);
//		KEY[3] <= 0;@(posedge CLOCK_50);
//		KEY[3] <= 1;@(posedge CLOCK_50);
//		KEY[3] <= 0;@(posedge CLOCK_50);
//		KEY[3] <= 1;@(posedge CLOCK_50);
//		KEY[3] <= 0;@(posedge CLOCK_50);
//		KEY[3] <= 1;@(posedge CLOCK_50);
//		KEY[3] <= 0;@(posedge CLOCK_50);
//		KEY[3] <= 1;@(posedge CLOCK_50);
//		KEY[3] <= 0;@(posedge CLOCK_50);
//		KEY[3] <= 1;@(posedge CLOCK_50);
//		KEY[3] <= 0;@(posedge CLOCK_50);
//		KEY[3] <= 1;@(posedge CLOCK_50);
//		KEY[3] <= 0;@(posedge CLOCK_50);
		SW[9] <= 1;@(posedge CLOCK_50);
		SW[9] <= 0;@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
//		KEY[3] <= 0; @(posedge CLOCK_50);

		KEY[0] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1;@(posedge CLOCK_50);
		KEY[0] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1;@(posedge CLOCK_50);
		KEY[0] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1;@(posedge CLOCK_50);
		KEY[0] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1;@(posedge CLOCK_50);
		KEY[0] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1;@(posedge CLOCK_50);
		KEY[0] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1;@(posedge CLOCK_50);
		KEY[0] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1;@(posedge CLOCK_50);
		KEY[0] <= 0;@(posedge CLOCK_50);
		SW[9] <= 1;@(posedge CLOCK_50);
		SW[9] <= 0;@(posedge CLOCK_50);
//		KEY[0] <= 1; KEY[3] <= 1; @(posedge CLOCK_50);
//		KEY[0] <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
		$stop; // End the simulation.
	end
endmodule
