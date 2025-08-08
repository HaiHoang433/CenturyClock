module bcd_plus1(
    input [7:0] BCD_in,
    output [7:0] BCD_out
);

// Declare intermediate signals
reg [7:0] BCD_temp;

// Add one to the BCD number
always @(BCD_in) begin
    if (BCD_in == 8'b1001_1001) // If input is 99 (BCD), roll over to 00
        BCD_temp <= 8'b0000_0000;
    else if (BCD_in[3:0] == 4'b1001) // If least significant digit is 9 (BCD), increment to 0
		begin
        BCD_temp[7:4] <= BCD_in[7:4] + 1;
		  BCD_temp[3:0] <= 4'b0000;
		end
    else
        BCD_temp <= BCD_in + 8'b0000_0001; // Increment by 1
end

// Output the result
assign BCD_out = BCD_temp;

endmodule

module bcd_minus1
(
    input [7:0] BCD_in,
    output [7:0] BCD_out
);

// Declare intermediate signals
reg [7:0] BCD_temp;

// Add one to the BCD number
always @(BCD_in) begin
    if (BCD_in == 8'b0000_0000) // If input is 00 (BCD), roll over to 99
        BCD_temp <= 8'b1001_1001;
    else if (BCD_in[3:0] == 4'b0000) // If least significant digit is 0 (BCD), decrement to 9
		begin
        BCD_temp[7:4] <= BCD_in[7:4] - 1;
		  BCD_temp[3:0] <= 4'b1001;
		end
    else
        BCD_temp <= BCD_in - 8'b0000_0001; // Increment by 1
end

// Output the result
assign BCD_out = BCD_temp;

endmodule