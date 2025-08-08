module dem_nam
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
	input [7:0] thang,
	output reg [7:0] nam
);

wire [7:0] nam_plus1;
bcd_plus1 bcd_inst(
    .BCD_in(nam),
    .BCD_out(nam_plus1)
);
wire [7:0] nam_minus1;
bcd_minus1 bcd_inst_n(
    .BCD_in(nam),
    .BCD_out(nam_minus1)
);

always @(posedge clk_1Hz or negedge rst_n)
begin
	if (~rst_n) nam <= 8'b00000000;
	else
	
		if (~mode == 3'b101)
		begin
			if (~btn_up)
				if (nam == 8'b1001_1001) nam <= 8'b0000_0000;
				else nam <= nam_plus1;
			else if (~btn_down)
				if (nam == 8'b0000_0000) nam <= 8'b1001_1001;
				else nam <= nam_minus1;
		end
		
		else
		
		if (giay == 8'b01011001 && phut == 8'b01011001 && gio == 8'b00100011 && ngay == 8'b00110001 && thang == 8'b00010010)
			if (nam == 8'b10011001) nam <= 8'b00000000;
			else nam <= nam_plus1;
		else nam <= nam;
end

endmodule