module contador(clk,saida,chave);
input clk,chave;
output reg[3:0]saida;

initial
begin
saida = 4'b0000;
end
always@(posedge clk)
begin
if(saida<9)
saida = saida+1;
else 
saida = 4'b0000;
if(chave==0)
saida=4'b0000;
end
endmodule

