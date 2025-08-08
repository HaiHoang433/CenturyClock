module dem_thang
(
	input wire clk_1Hz,
	input wire rst_n,
		 input btn_up,
    input btn_down,
    input [2:0] mode,
	input [7:0] giay,
	input [7:0] phut,
	input [7:0] gio,
	input [7:0] ngay,
	output reg [4:0] thang
);

wire [7:0] thang_plus1;
bcd_plus1 bcd_inst(
	.BCD_in(thang),
	.BCD_out(thang_plus1)
);

wire [7:0] thang_minus1;
bcd_minus1 bcd_inst_n(
    .BCD_in(thang),
    .BCD_out(thang_minus1)
);

always @(posedge clk_1Hz or negedge rst_n)
begin
	if (~rst_n) thang <= 8'b00000001;
	else
	
		if (~mode == 3'b100)
		begin
			if (~btn_up)
				if (thang == 8'b0001_0010) thang <= 8'b0000_0001;
				else thang <= thang_plus1;
			else if (~btn_down)
				if (thang == 8'b0000_0001) thang <= 8'b0001_0010;
				else thang <= thang_minus1;
		end
		
		else
	
		if (giay == 8'b01011001 && phut == 8'b01011001 && gio == 8'b00100011 && ngay == 8'b00110001)
			if (thang == 8'b00010010) thang <= 8'b00000001;
			else thang <= thang_plus1;
		else thang <= thang;
end

endmodule