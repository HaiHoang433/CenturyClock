module DivisibleByFour(input [7:0] bcd_number, output reg divisible_by_four);

always @(*) begin
    // Extract the two least significant bits
    // Since we're dealing with BCD, the range of the input is from 0 to 99
    // Therefore, we need only 2 bits to represent the least significant digit
    // which corresponds to the last 4 bits of the 8-bit input.
    // Extracting those two least significant bits and checking if it's divisible by 4.
    case(bcd_number[1:0])
        2'b00: divisible_by_four = 1'b1; // 0 is divisible by 4
        2'b01: divisible_by_four = 1'b0; // 1 is not divisible by 4
        2'b10: divisible_by_four = 1'b0; // 2 is not divisible by 4
        2'b11: divisible_by_four = 1'b0; // 3 is not divisible by 4
        default: divisible_by_four = 1'b0; // In case of any other value
    endcase
end

endmodule
