module Mux2_1(entrada1,entrada2,ch,saida);
input [7:0]entrada1,entrada2;

input ch;
output reg [7:0]saida;
always@(*)
begin
if(ch==1)
saida = entrada1;
else
saida = entrada2;
end
endmodule
