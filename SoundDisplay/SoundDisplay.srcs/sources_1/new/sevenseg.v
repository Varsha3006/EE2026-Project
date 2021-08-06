`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2020 05:34:18 PM
// Design Name: 
// Module Name: sevenseg
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


module sevseg (
input clk,
    input sw1,
    input [3:0] an0, 
    input [3:0] an1,
    input [3:0] an2,
    input [3:0] an3,
    output reg [3:0] anode, //anode to be on
    output reg [7:0] segment 
    );
    
    reg [1:0] num = 0; //led_pointer
    reg [7:0] led_output [3:0]; // like 2d array --> memory registers--> location will be [0-3] while each memory location can store 8 bitof data
    reg [18:0] counter = 0; 
    parameter MAXcounter = 500000; //loop through segment every 500000 clock cycles -> 1/200 seconds
    
    wire [3:0] memory [3:0]; // like 2d array --> memory registers--> each can store 4 bit of data with location in 4 places
    assign  memory[0] = an0;// assign the first memory location to an0 and so on for the rest
    assign  memory[1] = an1;
    assign  memory[2] = an2;
    assign  memory[3] = an3; // an is fo what number to be displayed
                      	 
    always @(posedge clk) begin
    
    segment[7] = 1;
    if(sw1==1) begin
        if (counter < MAXcounter) begin
            counter <= counter+1;
        end else begin
            num <= num + 1;
            counter <= 0;
        end
                
		case(memory[num]) //if memory[0]-> an0 (what number to be displayed) --> -4 bit of data can be stored
			 4'b0000 : led_output[num] <= 7'b1000000; //0
			 4'b0001 : led_output[num] <= 7'b1111001; //1
			 4'b0010 : led_output[num] <= 7'b0100100; //2
			 4'b0011 : led_output[num] <= 7'b0110000; //3
			 4'b0100 : led_output[num] <= 7'b0011001; //4
			 4'b0101 : led_output[num] <= 7'b0010010; //5
			 4'b0110 : led_output[num] <= 7'b0000010; //6
			 4'b0111 : led_output[num] <= 7'b1111000; //7
			 4'b1000 : led_output[num] <= 7'b0000000; //8
			 4'b1001 : led_output[num] <= 7'b0011000; //9
     	 endcase
        
        case(num)  //depending on the case num the respective anode will be on and the led_output will be updated accordingly 
            0: begin// so that it can go through the above case statemet for each value
                anode <= 4'b1110;
                segment <= led_output[0];
            end
                
            1: begin
                anode <= 4'b1101;
                segment <= led_output[1];            
            end
            
            2: begin
                anode <= 4'b1011;
                segment <= led_output[2];
            end
            
            3: begin
                anode <= 4'b0111;
                segment <= led_output[3];
            end                
        endcase 
        end 
      else if(!sw1) begin 
      anode = 4'b1111; // off all the anode when not sw1
      end
             
    end 
endmodule

