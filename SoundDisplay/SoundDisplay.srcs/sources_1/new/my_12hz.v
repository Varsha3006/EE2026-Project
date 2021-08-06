`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2020 03:15:58 PM
// Design Name: 
// Module Name: my_12hz
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

module my_12hz(
    input CLOCK,
    output reg slowclock
    );
    
    reg [21:0] COUNT = 0;
    
    always @ (posedge CLOCK) begin
        COUNT <= COUNT + 1;
        slowclock <= (COUNT == 22'b0) ? ~slowclock : slowclock;
    end

endmodule
