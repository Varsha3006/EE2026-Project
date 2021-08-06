`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2020 12:53:08 PM
// Design Name: 
// Module Name: pink_colour_scheme
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


module pick_colour_scheme(
    input sw14,
    input sw13,
    output [1:0] colour_scheme
    );
    
    assign colour_scheme = ((sw14)? 2 : ((sw13)? 1 : 0));
    
endmodule

