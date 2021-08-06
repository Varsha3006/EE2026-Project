`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2020 03:13:20 PM
// Design Name: 
// Module Name: midpulse
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


module midPulse(
input clockspeed, PUSHBUTTON,output PULSE
    );
    
    wire C1;
    wire C2;
    
    my_dff DFF1 (clockspeed, PUSHBUTTON, C1);
    my_dff DFF2 (clockspeed, C1, C2);
    
    assign PULSE = (C1&~C2);
endmodule
