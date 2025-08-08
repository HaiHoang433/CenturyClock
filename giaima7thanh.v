module giaima7thanh
(
    input [3:0] data,
    output reg [6:0] led
);

always @(data)
begin
    case(data)
        4'b0000: led = 7'b1000000; // So 0
        4'b0001: led = 7'b1111001; // So 1
        4'b0010: led = 7'b0100100; // So 2
        4'b0011: led = 7'b0110000; // So 3
        4'b0100: led = 7'b0011001; // So 4
        4'b0101: led = 7'b0010010; // So 5
        4'b0110: led = 7'b0000010; // So 6
        4'b0111: led = 7'b1111000; // So 7
        4'b1000: led = 7'b0000000; // So 8
        4'b1001: led = 7'b0010000; // So 9
        default: led = 7'b0111111; // Gach ngang
    endcase
end

endmodule

