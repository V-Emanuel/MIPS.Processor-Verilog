module clock_divisor(input CLK_entrada,output reg CLK_saida);

reg[24:0]contador=25'h0;

always@(posedge CLK_entrada)
begin 
if(contador==25'd25000)
begin
contador <=25'h0;
CLK_saida =~CLK_saida;
end
else
contador<=contador+1;
end
endmodule



