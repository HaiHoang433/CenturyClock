module top_module 
(
	// rst_n => KEY3
	// btn_up => KEY2
	// btn_down => KEY1
	// FPGA SW     17 16 15 ...  876            5                     4321          0      
	// Verilog sw                mode[2:0]      year_divisible_by_4   pin[3:0]      hienthi
   input clk,                 // 1 clock
	input rst_n,               // 1 sw
	input hienthi,             // 1 sw - giophutgiay (0) or ngaythangnam (1)
	input [3:0] pin,           // 4 sw - count_day_in_mon
	input year_divisible_by_4, // 1 sw - count_day_in_mon
	// FPGA 88 88 8888
	// HEX  76 54 3210
   output [6:0] HEX3,         // giay/ngay (chuc)
	output [6:0] HEX2,		   // giay/ngay (donvi)
	output [6:0] HEX5,         // phut/thang (chuc)
	output [6:0] HEX4,         // phut/thang (donvi)
	output [6:0] HEX7,         // gio/nam (chuc)
	output [6:0] HEX6,         // gio/nam (donvi)
	output [6:0] HEX1,         // (led2 in count_day_in_mon) no_of_day hang chuc
	output [6:0] HEX0,         // (led1 in count_day_in_mon) no_of_day hang don vi
	input [2:0] mode,
	input btn_up,
	input btn_down
);

// thu 1 = hang don vi
// thu 2 = hang chuc
wire clk_1Hz;
wire [7:0] giay;
wire [7:0] phut;
wire [7:0] gio;
wire [7:0] ngay;
wire [7:0] thang;
wire [7:0] nam;
wire [6:0] led1;  // LED 7 don vi cho gio
wire [6:0] led2;  // LED 7 chuc cho gio
wire [6:0] led3;  // LED 7 don vi cho phut
wire [6:0] led4;  // LED 7 chuc cho phut
wire [6:0] led5;  // LED 7 don vi cho giay
wire [6:0] led6;  // LED 7 chuc cho giay
wire [6:0] led7;  // LED 7 don vi cho ngay
wire [6:0] led8;  // LED 7 chuc cho ngay
wire [6:0] led9;  // LED 7 don vi cho thang
wire [6:0] led10; // LED 7 chuc cho thang
wire [6:0] led11; // LED 7 don vi cho nam
wire [6:0] led12; // LED 7 chuc cho nam

reg [6:0] HEX3_reg, HEX2_reg, HEX5_reg, HEX4_reg, HEX7_reg, HEX6_reg;

clk_gen IC1 (
    .clk(clk),
    .clk_1Hz(clk_1Hz)
);

dem_giay IC2 (
	.clk_1Hz(clk_1Hz),
	.rst_n(rst_n),
	.btn_up(btn_up),
	.btn_down(btn_down),
	.mode(mode),
	.giay(giay)
);

dem_phut IC3 (
	.clk_1Hz(clk_1Hz),
	.rst_n(rst_n),
   .giay(giay),
	.btn_up(btn_up),
	.btn_down(btn_down),
	.mode(mode),
	.phut(phut)
);

dem_gio IC4 (
	.clk_1Hz(clk_1Hz),
	.rst_n(rst_n),
        .giay(giay),
		  .btn_up(btn_up),
	.btn_down(btn_down),
	.mode(mode),
	.phut(phut),
	.gio(gio)
);

dem_ngay IC5 (
	.clk_1Hz(clk_1Hz),
	.rst_n(rst_n),
        .giay(giay),
		  .btn_up(btn_up),
	.btn_down(btn_down),
	.mode(mode),
	.phut(phut),
	.gio(gio),
	.thang(thang),
	.nam(nam),
	.ngay(ngay)
);

dem_thang IC6 (
	.clk_1Hz(clk_1Hz),
	.rst_n(rst_n),
	.btn_up(btn_up),
	.btn_down(btn_down),
	.mode(mode),
    .giay(giay),
	.phut(phut),
	.gio(gio),
	.ngay(ngay),
	.thang(thang)
);

dem_nam IC7 (
	.clk_1Hz(clk_1Hz),
	.rst_n(rst_n),
	.btn_up(btn_up),
	.btn_down(btn_down),
	.mode(mode),
        .giay(giay),
	.phut(phut),
	.gio(gio),
	.ngay(ngay),
	.thang(thang),
	.nam(nam)
);

hienthigiophutgiay IC8(
	.giay(giay),
	.phut(phut),
	.gio(gio),
	.led1(led1),
	.led2(led2),
	.led3(led3),
	.led4(led4),
	.led5(led5),
	.led6(led6)
);

hienthingaythangnam IC9
(
	.ngay(ngay),
	.thang(thang),
	.nam(nam),
	.led7(led7),
	.led8(led8),
	.led9(led9),
	.led10(led10),
	.led11(led11),
	.led12(led12)
);


always @(hienthi) begin
	if (hienthi == 0)
	begin
		HEX3_reg = led6;
		HEX2_reg = led5;
		HEX5_reg = led4;
		HEX4_reg = led3;
		HEX7_reg = led2;
		HEX6_reg = led1;
	end
	else
	begin
		HEX3_reg = led8;
		HEX2_reg = led7;
		HEX5_reg = led10;
		HEX4_reg = led9;
		HEX7_reg = led12;
		HEX6_reg = led11;
	end
end

assign HEX3 = HEX3_reg;
assign HEX2 = HEX2_reg;
assign HEX5 = HEX5_reg;
assign HEX4 = HEX4_reg;
assign HEX7 = HEX7_reg;
assign HEX6 = HEX6_reg;

count_day_in_mon IC10
(
	.pin(pin),
	.year_divisible_by_4(year_divisible_by_4),
	.led1(HEX0),
	.led2(HEX1)
);

endmodule