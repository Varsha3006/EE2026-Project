`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2020 08:15:21 PM
// Design Name: 
// Module Name: debounce
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

module sp_mod(
    input pb,
    input sp_clock,
    output sp_out
    );
    
    wire dff_one_out, dff_two_out;
    
    dff_mod dff_one(sp_clock, pb, dff_one_out);
    dff_mod dff_two (sp_clock, dff_one_out, dff_two_out);
    
    assign sp_out = dff_one_out & ~dff_two_out;
    
endmodule


