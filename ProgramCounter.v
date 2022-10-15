module PC ( input clk,
				input [7:0]PCin, 
				output reg[7:0]PCout);
	
always@(posedge clk)
begin
 PCout <= PCin;
end
endmodule 