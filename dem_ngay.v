module dem_ngay (
    input wire clk_1Hz,
    input wire rst_n,
	 	 input btn_up,
    input btn_down,
    input [2:0] mode,
    input [7:0] giay,
    input [7:0] phut,
    input [7:0] gio,
    input [7:0] thang,
    input [7:0] nam,
    output reg [7:0] ngay
);

// 1 if yes
wire year_DivisibleByFour; // Change reg to wire

DivisibleByFour DBF_inst(
    .bcd_number(nam),
    .divisible_by_four(year_DivisibleByFour)
);

wire [7:0] ngay_plus1;
bcd_plus1 bcd_inst(
    .BCD_in(ngay),
    .BCD_out(ngay_plus1)
);

wire [7:0] ngay_minus1;
bcd_minus1 bcd_inst_n(
    .BCD_in(ngay),
    .BCD_out(ngay_minus1)
);

always @(posedge clk_1Hz or negedge rst_n)
begin
    if (~rst_n) ngay <= 8'b00000001;
    else
	 
	   if (~mode == 3'b011)
		begin
			if (~btn_up)
				
				case (thang)
            8'b00000010:
                if (year_DivisibleByFour && ngay == 8'b00101001) ngay <= 8'b0000_0001;
                else if (~year_DivisibleByFour && ngay == 8'b00101000) ngay <= 8'b0000_0001;
                else ngay <= ngay_plus1;
            8'b00000100, 8'b00000110, 8'b00001001, 8'b00010001:
                if (ngay == 8'b00110000) ngay <= 8'b0000_0001;
                else ngay <= ngay_plus1;
            8'b00000001, 8'b00000011, 8'b00000101, 8'b00000111, 8'b00001000, 8'b00010000, 8'b00010010:
                if (ngay == 8'b00110001) ngay <= 8'b0000_0001;
                else ngay <= ngay_plus1;
            default: ngay <= ngay;
            endcase
				
			else if (~btn_down)
				
				case (thang)
            8'b00000010:
                if (year_DivisibleByFour && ngay == 8'b0000_0000) ngay <= 8'b00101001;
                else if (~year_DivisibleByFour && ngay == 8'b0000_0000) ngay <= 8'b00101000;
                else ngay <= ngay_minus1;
            8'b00000100, 8'b00000110, 8'b00001001, 8'b00010001:
                if (ngay == 8'b0000_0000) ngay <= 8'b00110000;
                else ngay <= ngay_minus1;
            8'b00000001, 8'b00000011, 8'b00000101, 8'b00000111, 8'b00001000, 8'b00010000, 8'b00010010:
                if (ngay == 8'b0000_0000) ngay <= 8'b00110001;
                else ngay <= ngay_minus1;
            default: ngay <= ngay;
            endcase
				
		end
		
		else
		
        if (giay == 8'b01011001 && phut == 8'b01011001 && gio == 8'b00100011)
            case (thang)
            8'b00000010:
                if (year_DivisibleByFour && ngay == 8'b00101001) ngay <= 8'b00000001;
                else if (~year_DivisibleByFour && ngay == 8'b00101000) ngay <= 8'b00000001;
                else ngay <= ngay_plus1;
            8'b00000100, 8'b00000110, 8'b00001001, 8'b00010001:
                if (ngay == 8'b00110000) ngay <= 8'b00000001;
                else ngay <= ngay_plus1;
            8'b00000001, 8'b00000011, 8'b00000101, 8'b00000111, 8'b00001000, 8'b00010000, 8'b00010010:
                if (ngay == 8'b00110001) ngay <= 8'b00000001;
                else ngay <= ngay_plus1;
            default: ngay <= ngay;
            endcase
        else ngay <= ngay;
end

endmodule
