`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2020 02:50:46 PM
// Design Name: 
// Module Name: my_clk
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
// 20khz --> m = (100*10^6/2(20*10^3))  - 1 = 2499

module clk20k(
    input CLOCK,
    output reg my_clk1 = 0
    );
    
    reg[15:0] count= 0;
    always @ (posedge CLOCK)
    begin 
    count <= (count == 2499)? 0 : count+1;
    my_clk1 <= (count == 0) ? ~ my_clk1 : my_clk1;
    end
endmodule
