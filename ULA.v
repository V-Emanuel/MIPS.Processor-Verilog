module ULA(SrcA,SrcB,ULAControl,ULAResult,FlagZ);

input [7:0]SrcA,SrcB;
input [2:0]ULAControl;
output reg[7:0]ULAResult;
output reg FlagZ;

always@(*)
begin
case(ULAControl)
3'b000:ULAResult = SrcA & SrcB;
3'b001:ULAResult = SrcA | SrcB;
3'b010:ULAResult = SrcA + SrcB;
3'b110:ULAResult = SrcA + ~SrcB + 1;
3'b111:if(SrcA<SrcB)
ULAResult = 1;
else
ULAResult = 0;

endcase
if(ULAResult == 0)
FlagZ = 1;
else
FlagZ = 0;

end
endmodule

