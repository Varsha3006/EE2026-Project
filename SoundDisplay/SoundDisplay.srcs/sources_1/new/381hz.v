`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2020 07:33:18 PM
// Design Name: 
// Module Name: 381hz
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


module  myfreq(
  input CLOCK,
  output reg my_clk1 = 0
  );
  
  reg[17:0] count= 0;
  always @ (posedge CLOCK)
  begin 
  count <= count+1;
  my_clk1 <= (count == 0) ? ~ my_clk1 : my_clk1;
  end
endmodule
