`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/20 22:03:17
// Design Name: 
// Module Name: TestBench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TestBench();
    reg clk=0;
    reg d=0;
    wire q;
    wire qb;
    
    Lab_4_1 test(
        .clk(clk),
        .d(d),
        .q(q),
        .qb(qb)
    );
    
    initial
        begin
            clk = 0;
            d = 0;
            #100;
          end
          
      always #20 clk=~clk;
      always #30 d=~d;
      
endmodule
