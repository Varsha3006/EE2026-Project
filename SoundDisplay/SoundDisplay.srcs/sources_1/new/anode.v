`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2020 07:36:28 PM
// Design Name: 
// Module Name: anode
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


module anode(input CLOCK,sw0,input sw1,[7:0]seg1,[7:0]seg2, output reg [7:0]seg,input [7:0]seg3,[3:0]anB, output reg [3:0]an);

reg [1:0] COUNT =0;


always@ (posedge CLOCK) begin
if(sw0 == 1) begin 
COUNT =(COUNT +1)%4;

case(COUNT)
2'd0:
begin
if(sw1 ==1)begin
 an = anB;
 seg = seg3;
 end
else if(sw0==1) begin
an = 4'b1110; 
seg = seg1;
end 
end

2'd1:
begin
if(sw1 ==1)begin
 an = anB;
 seg = seg3;
 end
 else if(sw0==1) begin
an = 4'b1101;
seg = seg2;
end
end

2'd2:
if(sw1 ==1)begin
 an = anB;
 seg = seg3;
 end
 else if(sw0==1) begin
begin
an = 4'b1011;
seg = 8'b11000000;
end
end

2'd3:
begin
if(sw1 ==1)begin
 an = anB;
 seg = seg3;
 end
 else if(sw0==1) begin
an = 4'b0111;
seg = 8'b11000000;
end
end

endcase
end 
if(sw0 != 1)
begin 
an = 4'b1111;
end
end
endmodule
