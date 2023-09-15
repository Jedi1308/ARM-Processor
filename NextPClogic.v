`timescale 1ns / 1ps

module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
   input [63:0] CurrentPC, SignExtImm64; 
   input 	Branch, ALUZero, Uncondbranch; 
   
   output reg [63:0] NextPC; 

   // when uncondbranch, directly add the SignExtImm64 to the CurrentPC
   // when Branch is conditional and when the ALU input is also 1, you will take the branch and the next PC will be calculated by adding the SignExtImm64 to the CurrentPC
   // when neither, increment PC by 4

   always @(*) begin
        if (Uncondbranch) begin NextPC = CurrentPC + (SignExtImm64 << 2); end
        else if (Branch && ALUZero) begin NextPC = CurrentPC + (SignExtImm64 << 2); end
        else begin NextPC = CurrentPC + 4; end
   end

endmodule
