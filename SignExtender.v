`timescale 1ns / 1ps

module SignExtender(OutBus, Imm26, Ctrl); 
   output reg [63:0] OutBus; 
   input [25:0]  Imm26; 
   input [2:0] Ctrl; 
   
   always@ (Ctrl, Imm26)
    begin
      case (Ctrl)
        // I-type, 12 bits in bus from [21:10], ALU extended to 64 bits
        3'b000: 
                begin
                OutBus = {{52{1'b0}}, Imm26[21:10]};
                //$display("00 Imm26[25] = %h, Imm26 = %x", Imm26[25], Imm26);
               end
        
        // D-type, 9 bits in bus from [20:12], ALU extended to 64 bits
        3'b001: begin
                OutBus = {{55{Imm26[20]}}, Imm26[20:12]}; 
                //$display("01 Imm26[25] = %h, Imm26 = %x", Imm26[25], Imm26);
               end
        
        // B, 26 bits that was entire bus, ALU extended to 64 bits, padded 2 0's to shift left
        3'b010: begin
               OutBus = {{38{Imm26[25]}}, Imm26[25:0]};
               //$display("10 Imm26[25] = %h, Imm26 = %x", Imm26[25], Imm26);
               end
        
        // CB, 19 bits in bus from [23:5], ALU extended to 64 bits, padded 2 0's to shift left
        3'b011: begin
                OutBus = {{45{Imm26[23]}}, Imm26[23:5]};
                //$display("11 Imm26[25] = %h, Imm26 = %x", Imm26[25], Imm26);
               end
        // MOVZ 0 bits
        3'b100:
                begin
                OutBus = Imm26[20:5] << (Imm26[22:21] * 16);
                $display("outbus = %h, Imm26 = %h", OutBus, Imm26);
               end
      endcase
    end
endmodule
