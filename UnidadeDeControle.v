module ControlUnit (input [5:0]OP, Funct,
							output reg Jump, MemtoReg, MemWrite, Branch, ULASrc, RegDst, RegWrite,
							output reg [2:0]ULAControl);
							
always @(*)
begin
casex({OP, Funct})

12'b000000100000: begin RegWrite = 1; RegDst = 1; ULASrc = 0; ULAControl = 3'b010; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0; end
12'b000000100010: begin RegWrite = 1; RegDst = 1; ULASrc = 0; ULAControl = 3'b110; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end
12'b000000100100: begin RegWrite = 1; RegDst = 1; ULASrc = 0; ULAControl = 3'b000; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end
12'b000000100101: begin RegWrite = 1; RegDst = 1; ULASrc = 0; ULAControl = 3'b001; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end
12'b000000101010: begin RegWrite = 1; RegDst = 1; ULASrc = 0; ULAControl = 3'b111; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end
12'b100011xxxxxx: begin RegWrite = 1; RegDst = 0; ULASrc = 1; ULAControl = 3'b010; Branch = 0; MemWrite = 0; MemtoReg = 1; Jump = 0;end
12'b101011xxxxxx: begin RegWrite = 0; RegDst = 0; ULASrc = 1; ULAControl = 3'b010; Branch = 0; MemWrite = 1; MemtoReg = 0; Jump = 0;end
12'b000100xxxxxx: begin RegWrite = 0; RegDst = 0; ULASrc = 0; ULAControl = 3'b110; Branch = 1; MemWrite = 0; MemtoReg = 0; Jump = 0;end
12'b001000xxxxxx: begin RegWrite = 1; RegDst = 0; ULASrc = 1; ULAControl = 3'b010; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end
12'b000010xxxxxx: begin RegWrite = 0; RegDst = 0; ULASrc = 0; ULAControl = 0; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 1;end
12'b001100xxxxxx: begin RegWrite = 1; RegDst = 0; ULASrc = 1; ULAControl = 3'b000; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end //ANDi
12'b001101xxxxxx: begin RegWrite = 1; RegDst = 0; ULASrc = 1; ULAControl = 3'b001; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end //ORi

default begin RegWrite = 0; RegDst = 0; ULASrc = 0; ULAControl = 0; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end
endcase
end

endmodule

