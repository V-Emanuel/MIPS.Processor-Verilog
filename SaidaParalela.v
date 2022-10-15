module Parallel_OUT (input [7:0]Address, RegData,
								input clk, we, 
								output reg [7:0]DataOut, 
								output wren);
wire fioA, fioB;

assign fioA = (Address == 8'hFF)?1:0;
assign wren = (~fioA) & we;
assign fioB = we & fioA;
	always@(posedge clk) 
	begin
		if (fioB == 1)
			DataOut = RegData;
	end

endmodule 