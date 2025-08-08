module count_day_in_mon
(
    input [3:0] pin,                   // Input from FPGA switch [1 - 12] (month)
    input year_divisible_by_4,         // Input from switch if year is divisible by 4
    output reg [6:0] led1,             // Units place of the number of days
    output reg [6:0] led2              // Tens place of the number of days
);

wire [6:0] led_thirty1_1;
wire [6:0] led_thirty1_2;
wire [6:0] led_thirty0_1;
wire [6:0] led_thirty0_2;
wire [6:0] led_year_divisible_by_4_1;
wire [6:0] led_year_divisible_by_4_2;
wire [6:0] led_year_not_divisible_by_4_1;
wire [6:0] led_year_not_divisible_by_4_2;
wire [6:0] led_otherwise_1;
wire [6:0] led_otherwise_2;
giaima7thanh thirty1_1(
    .data(4'b0001), 
    .led(led_thirty1_1)
); // 1

giaima7thanh thirty1_2(
    .data(4'b0011), 
    .led(led_thirty1_2)
); // 3

giaima7thanh thirty0_1(
    .data(4'b0000), 
    .led(led_thirty0_1)
); // 0

giaima7thanh thirty0_2(
    .data(4'b0011), 
    .led(led_thirty0_2)
); // 3

giaima7thanh year_divisible_by_4_1(
    .data(4'b1001), 
    .led(led_year_divisible_by_4_1)
); // 9

giaima7thanh year_divisible_by_4_2(
    .data(4'b0010), 
    .led(led_year_divisible_by_4_2)
); // 2

giaima7thanh year_not_divisible_by_4_1(
    .data(4'b1000), 
    .led(led_year_not_divisible_by_4_1)
); // 8

giaima7thanh year_not_divisible_by_4_2(
    .data(4'b0010), 
    .led(led_year_not_divisible_by_4_2)
); // 2

giaima7thanh otherwise_1(
    .data(4'b1111), 
    .led(led_otherwise_1)
); // -

giaima7thanh otherwise_2(
    .data(4'b1111), 
    .led(led_otherwise_2)
); // -

always @*
begin
    case(pin)
        // 1, 3, 5, 7, 8, 10, 12: 31
        4'b0001, 4'b0011, 4'b0101, 4'b0111, 4'b1000, 4'b1010, 4'b1100:
        begin
            led1 <= led_thirty1_1; // 1
            led2 <= led_thirty1_2; // 3
        end
        
        // 4, 6, 9, 11: 30
        4'b0100, 4'b0110, 4'b1001, 4'b1011:
        begin
            led1 <= led_thirty0_1; // 0
            led2 <= led_thirty0_2; // 3
        end
        
        // 2: 29 (% 4 == 0) / 28
        4'b0010:
        if (year_divisible_by_4) 
        begin
                led1 <= led_year_divisible_by_4_1; // 9
                led2 <= led_year_divisible_by_4_2; // 2
        end
        else
        begin
            led1 <= led_year_not_divisible_by_4_1; // 8
                led2 <= led_year_not_divisible_by_4_2; // 2
        end
        
        default: 
        begin
            led1 <= led_otherwise_1; // -
                led2 <= led_otherwise_2; // -
        end
    endcase
end

endmodule
