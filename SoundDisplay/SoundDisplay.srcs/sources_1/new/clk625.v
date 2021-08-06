`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2020 04:03:25 PM
// Design Name: 
// Module Name: clk625
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


module clk625(input CLOCK, output reg my_clk = 0);
  
    reg [2:0] count = 0;
    
    always @ (posedge CLOCK) begin
    count <= (count == 7)? 0: count + 1;
    my_clk <= (count == 0)? ~my_clk: my_clk;
    end
    
endmodule

