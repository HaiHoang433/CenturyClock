module clk_gen(
    input clk,
    output reg clk_1Hz
);

reg [24:0] count;

always @(posedge clk)
begin
	count <= count + 1;
	if (count == 2500000)
	begin
		clk_1Hz <= ~clk_1Hz;
		count <= 0;
	end
end

endmodule