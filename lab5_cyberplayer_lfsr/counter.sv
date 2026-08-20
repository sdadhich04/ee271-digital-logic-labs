module counter(Clock, Reset, win, HEX);
	input logic Clock, Reset, win;
	output logic [6:0] HEX;
	logic [2:0] count;

	//logic for counting up
//	always_comb begin
//		if (win)
//			count = count + 1'b1;
//
//		else if (Reset)
//			count = 3'b000;
//		else
//			count = count;
//	end

	//output for hex
	always_comb begin
		case(count)
			3'b000:				HEX = 7'b1000000;
			3'b001:				HEX = 7'b1111001;
			3'b010:				HEX = 7'b0100100;
			3'b011:				HEX = 7'b0110000;
			3'b100:				HEX = 7'b0011001;
			3'b101:				HEX = 7'b0010010;
			3'b110:				HEX = 7'b0000010;
			3'b111:				HEX = 7'b1111000;
			default:				HEX = 7'bX;
		endcase
	end


	always_ff @(posedge Clock) begin
		if (Reset)
			count <= 3'b000;
		else if (win)
			count = count + 1'b1;
		else
			count <= count;

	end
endmodule


module counter_testbench();
	logic win;
	logic Clock, Reset;
	logic [6:0] HEX;

	counter dut(.win, .HEX, .Clock, .Reset);

	parameter CLOCK_PERIOD = 100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end

	initial begin
		Reset <= 1;				@(posedge Clock);
		Reset <= 0;				@(posedge Clock);
		win <= 1;				@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);

		win <= 0;
      @(posedge Clock);
      @(posedge Clock);

		Reset <= 1;				@(posedge Clock);
		Reset <= 0;				@(posedge Clock);

		win <= 1;
      @(posedge Clock);
      @(posedge Clock);
      @(posedge Clock);
		$stop();
	end
endmodule
