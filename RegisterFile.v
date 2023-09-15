`timescale 1ns / 1ps

module RegisterFile(BusA, BusB, BusW, RW, RA, RB, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RW;
    input [4:0] RA;
    input [4:0] RB;
    input RegWr;
    input Clk;
    reg [63:0] registers [31:0];
     
    //assign #2 BusA = registers[RA];
    //assign #2 BusB = registers[RB];
    
    // use ternary operator to make A and B 0 when RA or RB 
    //assign BusA = RA || RB ? 0 : 1;
    //assign BusB = RA || RB ? 0 : 1;
     
    always @ (negedge Clk) begin
        if(RegWr)
            if (RW != 31) registers[RW] <= #3 BusW;
    end
    
    assign #2 BusA = RA == 31 ? 0 : registers[RA];
    assign #2 BusB = RB == 31 ? 0 : registers[RB];
    
    /*
    always (RA) begin
        if (RA == 31 #2 
            BusA = 0;
        else #2 
            BusA = registers[RA];
    end
    always (RB) begin
        if (RB == 31 #2 
            BusB = 0;
        else #2 
            BusB = registers[RB];
    end
    */
    
endmodule
