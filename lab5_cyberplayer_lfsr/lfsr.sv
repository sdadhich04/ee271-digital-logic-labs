module lfsr(Clock, Reset, random);
input logic Clock, Reset;
output logic [9:0] random;

always_ff @(posedge Clock) begin
	if (Reset)
		random <= 10'b0000000000;
	else begin
		random[9:1] <= random[8:0];
		random[0] <= {~(random[9] ^ random[6])};
	end
end

endmodule

module LFSR_testbench();
	logic [9:0] random;
	logic Clock, Reset;

	lfsr dut (.random, .Clock, .Reset);

	parameter CLOCK_PERIOD = 100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end

	initial begin
		Reset <= 1;		@(posedge Clock);
		Reset <= 0;		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		$stop();
	end
endmodule
