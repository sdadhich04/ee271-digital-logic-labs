module seg7 (bcd, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
		input logic [3:0] bcd;
		output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
		always_comb begin
			case (bcd)
							// Light: 6543210
				3'b000: begin
				HEX0 = 7'b0010010; // S
				HEX1 = 7'b1000110; // C
				HEX2 = 7'b0001001; // H
				HEX3 = 7'b0000000; // B
				HEX4 = 7'b0000110; // E
				HEX5 = 7'b1000000; // O
				end

				3'b001: begin
				HEX5 = 7'b0010010; // S
				HEX4 = 7'b1000110; // C
				HEX3 = 7'b0001001; // H
				HEX2 = 7'b0000000; // B
				HEX1 = 7'b0000110; // E
				HEX0 = 7'b1000000; // O
				end
				3'b010: begin
				HEX1 = 7'b0010010; // S
				HEX2 = 7'b1000110; // C
				HEX3 = 7'b0001001; // H
				HEX4 = 7'b0000000; // B
				HEX5 = 7'b0000110; // E
				HEX0 = 7'b1000000; // O
				end
				3'b100: begin
				HEX2 = 7'b0010010; // S
				HEX3 = 7'b1000110; // C
				HEX4 = 7'b0001001; // H
				HEX5 = 7'b0000000; // B
				HEX0 = 7'b0000110; // E
				HEX1 = 7'b1000000; // O
				end
				3'b101: begin
				HEX3 = 7'b0010010; // S
				HEX4 = 7'b1000110; // C
				HEX5 = 7'b0001001; // H
				HEX0 = 7'b0000000; // B
				HEX1 = 7'b0000110; // E
				HEX2 = 7'b1000000; // O
				end
				3'b111:begin
				HEX4 = 7'b0010010; // S
				HEX5 = 7'b1000110; // C
				HEX0 = 7'b0001001; // H
				HEX1 = 7'b0000000; // B
				HEX2 = 7'b0000110; // E
				HEX3 = 7'b1000000; // O
				end
				default: begin
				HEX4 = 7'bx;
				HEX5 = 7'bx;
				HEX0 = 7'bx;
				HEX1 = 7'bx;
				HEX2 = 7'bx;
				HEX3 = 7'bx;
				end
			endcase
		end
	endmodule
