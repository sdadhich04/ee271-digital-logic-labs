// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output logic [9:0] LEDR;
input logic [3:0] KEY;
input logic [9:0] SW;



theft detector (.U(SW[9]),.P(SW[8]),.C(SW[7]),.M(SW[0]),.Discount(LEDR[0]),.Stolen(LEDR[1]));
seg7 display (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .bcd(SW[9:7]));

endmodule

module DE1_SoC_testbench();
    logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    logic [9:0] LEDR;
    logic [3:0] KEY;
    logic [9:0] SW;
    DE1_SoC dut (
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

    initial begin
        for (int i = 0; i < 16; i++) begin
				{SW[9], SW[7], SW[8], SW[0]} = i; #10;
        end
    end
endmodule
