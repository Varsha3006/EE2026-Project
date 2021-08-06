`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2020 05:08:55 PM
// Design Name: 
// Module Name: studentA
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


module studentA_clock(
   input CLOCK, //100MHZ clock
   input sw1,
   input pb,btnU, btnL, btnR, btnD, //  pushbutton
   output [7:0]seg, output [3:0]an, // 7-Segment Display
   output reg[15:0]led
   );
   // calculation: 100 MHz / 100000000 = 1 Hz => 1 second 
   parameter MAXcounter = 1_0000_0000; 
   parameter displaytime = 1'b0; // display time mode is the real clock
   parameter set_time = 1'b1;   // when switch 2 is on, automatically be in set mode 
   reg [31:0] counter = 0;
   reg [5:0] Hour, Mins, Seconds = 0; 
   reg [3:0] an0,an1, an2, an3 = 0;  // number to show on the anode panel
   reg flag = 0;  // flag can be 1 or 0
   reg  mode = set_time;  //--> to set the time

    wire CLOCK_12hz;
    wire centerButton;
    wire upButton;
    wire downButton;
    wire leftButton;
    wire rightButton;
     
    my_12hz (CLOCK, CLOCK_12hz); 
    midPulse d1(CLOCK_12hz, pb, centerButton);
    topPulse d2(CLOCK_12hz, btnU, upButton);
    downPulse d3(CLOCK_12hz, btnD, downButton);
    leftPulse d4(CLOCK_12hz, btnL, leftButton);
    rightPulse d5(CLOCK_12hz, btnR, rightButton);        
   
      

 
  //initiate module 
  sevseg display(CLOCK,sw1,an0,an1,an2,an3,an,seg);
   
   
   
    always @(posedge CLOCK) begin
    
    if(sw1) begin
         
       if (Seconds >= 60) begin // After 60 seconds, increment minutes
               Seconds <= 0;
               Mins <= Mins + 1;
       end
       if (Mins >= 60) begin // After 60 Mins, increment hours
               Mins <= 0;
              Hour <= Hour + 1;
       end
       if (Hour >= 24) begin // set back to 0 after 2359
           Hour <= 0;
       end
       
       else begin             
           an0 <= Mins % 10;  // number to be dislayed in an2 (of minutes)
           an1 <= Mins / 10;  // number to be dislayed in an2 (of minutes)           
           
           if (Hour < 24) begin
               if (Hour == 0) begin 
                  
                  an2 <= 0;
                   
                  an3 <= 0; 
               end else begin
                   an2 <= Hour % 10;    // number to be dislayed in an2 (of Hour)
                   an3 <= Hour / 10;    // number to be dislayed in an2 (of Hour)
               end
              
            
           end else begin 
               if (Hour == 24) begin 
                   an2 <= 0;
                   an3 <= 0;
                              
           end        
       end 
      case(mode)
           1'b0: begin // mode = 0 = set time
               if (pb) begin // if centerbuton is pressed
                   mode <= set_time; // mode == set_time automatically
                   counter <= 0; // all variables to be set back to 0
                   flag <= 0;
                   Seconds <= 0;  
                   led = 15'b0; // led off to show it is in set time mode
               end
               
               if (counter < MAXcounter) begin 
                   counter <= counter + 1;
               end 
               else begin
                   counter <= 0;
                   Seconds <= Seconds + 1;
               end                                
           end 
           1'b1: begin //mode = 1 = displaytime
               if (pb) begin // Push center button to commit time set and return to Clock mode
                   mode <= displaytime;
                   led = 16'b1111111111111111; // all led on to showit is in clock mode
               end
               
               if (counter < (2500_0000)) begin 
                   counter <= counter + 1;
               end else begin
                   counter <= 0;
                   case (flag) // flag starts with 0
                       1'b0: begin //Mins
                           if (btnU) begin // Increment Mins when you push up
                               Mins <= Mins + 1;
                           end
                           if (btnD) begin // Decrement Mins when you push down
                               if (Mins > 0) begin
                                   Mins <= Mins - 1;
                               end else if (Hour > 1) begin
                                   Hour <= Hour - 1;
                                   Mins <= 59;
                               end else if (Hour == 1) begin
                                   
                                   Hour <=23;
                                   Mins <= 59;
                               end
                           end
                           // press the left/right button to switch between Hour/Mins
                           if (btnL || btnR) begin 
                               flag <= 1;  //flag is changed to 1 to get into the next case
                           end
                       end 
                       1'b1: begin //Hour
                       // Increase Hour when you up button pressed
                           if (btnU) begin 
                               Hour <= Hour + 1;
                           end
                          // Decrease Mins when down button pressed
                           if (btnD) begin 
                               if (Hour > 1) begin
                                   Hour <= Hour - 1;
                               end else if (Hour == 24) begin 
                                   
                                   Hour<=0; 
                                   
                               end
                           end
                           // Press left/right button to swap between Hour/Mins
                           if (btnR || btnL) begin 
                               flag <= 0;
                           end
                       end                   
               endcase            
               end                    
           end 
       endcase 
       
   
    end

 
   end 
   end    
endmodule
