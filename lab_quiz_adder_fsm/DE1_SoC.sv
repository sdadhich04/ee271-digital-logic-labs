/*
Continuous adder FSM demo.

The circuit repeatedly adds the value selected on SW[7:0] and displays the
running value on the HEX displays. SW[8] resets the design, SW[9] pauses the
adder, and KEY[0] selects a faster board clock.
*/
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;

	// assign HEX0 = 7'b1111111;
	// assign HEX1 = 7'b1111111;
	// assign HEX2 = 7'b1111111;
	// assign HEX3 = 7'b1111111;
	// assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	//
	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic reset;
	logic [31:0] div_clk;
	assign reset = SW[8];

	parameter whichClock = 23; // 0.75 Hz clock
	clock_divider cdiv (.clock(CLOCK_50), .reset(reset), .divided_clocks(div_clk));

	// Clock selection; allows for easy switching between simulation and board clocks
	logic clkSelect;

	// Uncomment ONE of the following two lines depending on intention
	//assign clkSelect = CLOCK_50; // for simulation
	assign clkSelect = div_clk[{3'b101, KEY[0], 1'b1}]; // for board

	logic [16:0] outVal;

	continuousAdder contAdd (.clk(clkSelect), .reset, .SW, .outVal);

	// Convert multi-digit output to single digits for each HEX
	seg7 hexzero (.bcd(outVal % 10), .leds(HEX0));
	seg7 hexone (.bcd((outVal / 10) % 10), .leds(HEX1));
	seg7 hextwo (.bcd((outVal / 100) % 10), .leds(HEX2));
	seg7 hexthree (.bcd((outVal / 1000) % 10), .leds(HEX3));
	seg7 hexfour (.bcd((outVal / 10000) % 10), .leds(HEX4));

endmodule


module DE1_SoC_testbench;
	// Inputs
	logic CLOCK_50;
	logic [3:0] KEY;
	logic [9:0] SW;

	// Outputs
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;

	// Instantiate the Unit Under Test (UUT)
	DE1_SoC uut (
		.CLOCK_50(CLOCK_50),
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX3(HEX3),
		.HEX4(HEX4),
		.HEX5(HEX5),
		.KEY(KEY),
		.LEDR(LEDR),
		.SW(SW)
	);

	// Clock generation
	always #10 CLOCK_50 = ~CLOCK_50; // 50MHz clock

	initial begin
		// Initialize Inputs
		CLOCK_50 = 0;
		KEY = 4'b1111; // All keys not pressed
		SW = 10'b0000000000; // All switches off

		// Test scenario 1: Reset
		#50;
		SW[8] = 1; // Assert reset
		#20;
		SW[8] = 0; // Deassert reset

		// Test scenario 2: Basic addition
		#50;
		SW[7:0] = 8'b00000001; // Set a value to SW
		#500;

		// Test scenario 3: Pause the addition
		SW[9] = 1; // Pause
		#500;
		SW[9] = 0; // Resume

		// Test scenario 4: Speed up addition (press KEY[0])
		#500;
		KEY[0] = 0; // Press KEY[0]
		#1000;
		KEY[0] = 1; // Release KEY[0]

		// Test scenario 5: Reset while adding
		SW[8] = 1; // Assert reset
		#20;
		SW[8] = 0; // Deassert reset

		// Test scenario 6: Test HEX display outputs
		SW[7:0] = 8'b00001111; // Set a value to SW
		#500;

		// Finish simulation
		#2000;
		$stop;
	end

	// Monitor outputs
	initial begin
		$monitor("Time: %0t | HEX0: %b | HEX1: %b | HEX2: %b | HEX3: %b | HEX4: %b | HEX5: %b | SW: %b | KEY: %b",
			$time, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, SW, KEY);
	end

endmodule
