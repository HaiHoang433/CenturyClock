module dem_gio
(
	input wire clk_1Hz,
	input wire rst_n,
		 input btn_up,
    input btn_down,
    input [2:0] mode,
	input [7:0] giay,
	input [7:0] phut,
	output reg [7:0] gio
);

wire [7:0] gio_plus1;
bcd_plus1 bcd_inst(
    .BCD_in(gio),
    .BCD_out(gio_plus1)
);
wire [7:0] gio_minus1;
bcd_minus1 bcd_inst_n(
    .BCD_in(gio),
    .BCD_out(gio_minus1)
);

always @(posedge clk_1Hz or negedge rst_n)
begin
	if (~rst_n) gio <= 8'b00000000;
	else
	
		if (~mode == 3'b010)
		begin
			if (~btn_up)
				if (gio == 8'b0010_0011) gio <= 8'b0000_0000;
				else gio <= gio_plus1;
			else if (~btn_down)
				if (gio == 8'b0000_0000) gio <= 8'b0010_0011;
				else gio <= gio_minus1;
		end
		
		else
	
		if (giay == 8'b01011001 && phut == 8'b01011001)
			if (gio == 8'b00100011) gio <= 8'b00000000;
			else gio <= gio_plus1;
		else gio <= gio;
end

endmodule