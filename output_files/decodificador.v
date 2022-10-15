module dec(input [3:0]entrada,
						output reg [6:0]saida);
								
		always @(*) begin
			case(entrada)
				4'd0: saida = ~(7'b1111110);
				4'd1: saida = ~(7'b0110000);
				4'd2: saida = ~(7'b1101101);
				4'd3: saida = ~(7'b1111001);
				4'd4: saida = ~(7'b0110011);
				4'd5: saida = ~(7'b1011011);
				4'd6: saida = ~(7'b1011111);
				4'd7: saida = ~(7'b1110000);
				4'd8: saida = ~(7'b1111111);
				4'd9: saida = ~(7'b1110011);
				4'd10: saida = ~(7'b1110111);
				4'd11: saida = ~(7'b0011111);
				4'd12: saida = ~(7'b1001110);
				4'd13: saida = ~(7'b0111101);
				4'd14: saida = ~(7'b1001111);
				4'd15: saida = ~(7'b1000111);
				default: saida = ~(7'b0000000);
			endcase
		end
endmodule

