// thu 1 = hang don vi
// thu 2 = hang chuc

module hienthingaythangnam
(
    input wire [7:0] ngay,   
    input wire [7:0] thang,  
    input wire [7:0] nam,    
    output wire [6:0] led7,   // LED 7 doan thu nhat cho ngay
    output wire [6:0] led8,   // LED 7 doan thu hai cho ngay
    output wire [6:0] led9,   // LED 7 doan thu nhat cho thang
    output wire [6:0] led10,   // LED 7 doan thu nhat cho thang
    output wire [6:0] led11,   // LED 7 doan thu nhat cho nam
    output wire [6:0] led12    // LED 7 doan thu hai cho nam
);

wire [6:0] led7_wire;
wire [6:0] led8_wire;
giaima7thanh GiaiMaNgay1(.data(ngay[3:0]), .led(led7_wire));  // LED thu nhat cho ngay
giaima7thanh GiaiMaNgay2(.data(ngay[7:4]), .led(led8_wire));    // LED thu hai cho ngay

wire [6:0] led9_wire;
wire [6:0] led10_wire;
giaima7thanh GiaiMaThang1(.data(thang[3:0]), .led(led9_wire));  // LED thu nhat cho thang
giaima7thanh GiaiMaThang2(.data(thang[7:4]), .led(led10_wire));    // LED thu hai cho thang

wire [6:0] led11_wire;
wire [6:0] led12_wire;
giaima7thanh GiaiMaNam1(.data(nam[3:0]), .led(led11_wire));  // LED thu nhat cho nam
giaima7thanh GiaiMaNam2(.data(nam[7:4]), .led(led12_wire));  // LED thu hai cho nam

assign led7 = led7_wire;
assign led8 = led8_wire;
assign led9 = led9_wire;
assign led10 = led10_wire;
assign led11 = led11_wire;
assign led12 = led12_wire;

endmodule