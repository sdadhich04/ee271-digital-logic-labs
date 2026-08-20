module comparator(out,A,B,Clock,Reset);
	input logic [9:0] A,B;
	input logic Clock, Reset;
	output logic out;

	always_comb begin
		if (A > B)
			out = 1;
		else
			out = 0;
	end

endmodule

module comparator_testbench();
	logic out;
	logic Clock, Reset;
	logic [9:0] A, B;

	comparator dut (.out, .A, .B, .Clock, .Reset);

	initial begin
		Clock = 1; Reset = 0;
		A = 10'b0000000000;
		B = 10'b0000000000;
		#10;
		A = 10'b0000000001;
		B = 10'b0000000010;
		#10;
		A = 10'b0000000001;
		B = 10'b0000000000;
		#10;
	end

endmodule
