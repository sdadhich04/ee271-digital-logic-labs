module theft (Discount, Stolen, U, P, C, M);

	output logic Discount, Stolen;
	input logic U,P,C,M;


	assign Discount = (U & C)| P;
	assign Stolen = ((U | ~C) & ~P ) & ~M;

endmodule


