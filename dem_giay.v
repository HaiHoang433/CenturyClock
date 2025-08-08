module dem_giay
(
    input wire clk_1Hz,
    input wire rst_n,
	 input btn_up,
    input btn_down,
    input [2:0] mode,
    output reg [7:0] giay
);

wire [7:0] giay_plus1;
bcd_plus1 bcd_inst(
    .BCD_in(giay),
    .BCD_out(giay_plus1)
);
wire [7:0] giay_minus1;
bcd_minus1 bcd_inst_n(
    .BCD_in(giay),
    .BCD_out(giay_minus1)
);

always @(posedge clk_1Hz or negedge rst_n) 
begin
    if (~rst_n) 
        giay <= 8'b00000000;
    else
		if (~mode == 3'b000)
		begin
			if (~btn_up)
				if (giay == 8'b0101_1001) giay <= 8'b0000_0000;
				else giay <= giay_plus1;
			else if (~btn_down)
				if (giay == 8'b0000_0000) giay <= 8'b0101_1001;
				else giay <= giay_minus1;
		end
		
		else 
        if (giay == 8'b01011001) // 59
            giay <= 8'b00000000;
        else
            giay <= giay_plus1;
    
end

endmodule
