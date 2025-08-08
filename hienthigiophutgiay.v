module hienthigiophutgiay
(
    input wire [7:0] gio,   
    input wire [7:0] phut,
    input wire [7:0] giay, 
    output wire [6:0] led1,  // LED 7 doan thu 1 cho gio
    output wire [6:0] led2,  // LED 7 doan thu 2 cho gio
    output wire [6:0] led3,  // LED 7 doan thu 1 cho phut
    output wire [6:0] led4,  // LED 7 doan thu 2 cho phut
    output wire [6:0] led5,  // LED 7 doan thu 1 cho giay
    output wire [6:0] led6   // LED 7 doan thu 2 cho giay
);

wire [6:0] led6_wire;
wire [6:0] led5_wire;
giaima7thanh GiaiMaGio1(.data(gio[3:0]), .led(led1_wire));  // LED th? nh?t cho gio
giaima7thanh GiaiMaGio2(.data(gio[7:4]), .led(led2_wire));  // LED th? hai cho gio

wire [6:0] led4_wire;
wire [6:0] led3_wire;
giaima7thanh GiaiMaPhut1(.data(phut[3:0]), .led(led3_wire));  // LED th? nh?t cho phut
giaima7thanh GiaiMaPhut2(.data(phut[7:4]), .led(led4_wire));  // LED th? hai cho phut

wire [6:0] led2_wire;
wire [6:0] led1_wire;
giaima7thanh GiaiMaGiay1(.data(giay[3:0]), .led(led5_wire));  // LED th? nh?t cho giay
giaima7thanh GiaiMaGiay2(.data(giay[7:4]), .led(led6_wire));  // LED th? hai cho giay

assign led6 = led6_wire;
assign led5 = led5_wire;
assign led4 = led4_wire;
assign led3 = led3_wire;
assign led2 = led2_wire;
assign led1 = led1_wire;

endmodule
