`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2020 03:07:21 PM
// Design Name: 
// Module Name: test_clk_divider
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


module test_clk_divider();
reg basys_clk;
wire my_clk;

count_method_C dev0 (basys_clk ,my_clk);

initial begin 
basys_clk = 0; #10;
end

always begin 
#5 basys_clk = ~basys_clk;
end
endmodule
