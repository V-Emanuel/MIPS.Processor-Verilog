module Parallel_IN(input [7:0]MemData, Address, DataIn,
							output reg [7:0]RegData);
always@*	begin
 if (Address == 8'hFF)
	RegData = DataIn;
	else
	RegData = MemData;
end 
endmodule
