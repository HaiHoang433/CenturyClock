module dem_phut
(
	input wire clk_1Hz,
	input wire rst_n,
	input [7:0] giay,
	input btn_up,
   input btn_down,
   input [2:0] mode,
	output reg [7:0] phut
);

wire [7:0] phut_plus1;
bcd_plus1 bcd_inst(
    .BCD_in(phut),
    .BCD_out(phut_plus1)
);

wire [7:0] phut_minus1;
bcd_minus1 bcd_inst_n(
    .BCD_in(phut),
    .BCD_out(phut_minus1)
);

always @(posedge clk_1Hz or negedge rst_n)
begin
	if (~rst_n) phut <= 8'b00000000;
	else
		if (~mode == 3'b001)
		begin
			if (~btn_up)
				if (phut == 8'b0101_1001) phut <= 8'b0000_0000;
				else phut <= phut_plus1;
			else if (~btn_down)
				if (phut == 8'b0000_0000) phut <= 8'b0101_1001;
				else phut <= phut_minus1;
		end
		
		else
			if (giay == 8'b01011001)
				if (phut == 8'b01011001) phut <= 8'b00000000;
				else phut <= phut_plus1;
			else phut <= phut;
end

endmodule