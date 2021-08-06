`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2020 06:30:27 PM
// Design Name: 
// Module Name: find_peak
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


module find_peak_mod(input clk_20k, input [11:0] MIC_in, input sw10, output reg [15:0] led,output reg [7:0] seg1, output reg [7:0] seg2, output reg [11:0] stored_MIC_peak);
    reg [25:0] COUNT = 0;
    //reg [11:0] MIC_peak;
    reg [11:0] MIC_peak;
    
    always @ (posedge clk_20k)
    begin
         COUNT <= (COUNT +1)%500; //every 499 readings 
         if(COUNT == 0)
         begin
            MIC_peak = 0;
         end
         if (MIC_in > MIC_peak)
         begin
              MIC_peak <= MIC_in;
         end
  end

  
always@(posedge clk_20k)
begin
stored_MIC_peak = (sw10 == 1)? stored_MIC_peak: MIC_peak;
if(MIC_peak <12'd2150)begin
led = 16'b0000_0000_0000_0001;
seg1= 8'b11000000; //0
end
  
else if(MIC_peak >= 12'd2150 && MIC_peak < 12'd2275) begin
led<= 16'b0000_0000_0000_0011;
seg1 = 8'b11111001; //1
end
  
else if(MIC_peak >= 12'd2275 && MIC_peak < 12'd2400) begin
led<= 16'b0000_0000_0000_0111;
seg1 = 8'b10100100; //2
end
  
else if(MIC_peak >= 12'd2400 && MIC_peak < 12'd2525) begin
led<= 16'b0000_0000_0000_1111;
seg1 = 8'b10110000; //3
end
 
else if(MIC_peak >= 12'd2525 && MIC_peak < 12'd2650) begin
led<= 16'b0000_0000_0001_1111;
seg1 = 8'b10011001; //4
end
 
else if(MIC_peak >= 12'd2650 && MIC_peak < 12'd2775) begin
led<= 16'b0000_0000_0011_1111;
seg1 = 8'b10010010; //5
end
      
else if(MIC_peak >= 12'd2775 && MIC_peak < 12'd2900) begin
led<= 16'b0000_0000_0111_1111;
seg1 = 8'b10000010; //6
end
       
else if(MIC_peak >= 12'd2900 && MIC_peak < 12'd3025) begin
led<= 16'b0000_0000_1111_1111;
seg1 = 8'b11111000; //7
end
        
 else if(MIC_peak >= 12'd3025 && MIC_peak < 12'd3150) begin
led<= 16'b0000_0001_1111_1111;
seg1 = 8'b10000000; //8
end
 
 //until 9
else if(MIC_peak >= 12'd3150 && MIC_peak < 12'd3275) begin
led<= 16'b0000_0011_1111_1111;
seg1 = 8'b10010000; //9
end
 
 else if(MIC_peak >= 12'd3275 && MIC_peak < 12'd3400) begin
 led<= 16'b0000_0111_1111_1111;
 seg1 = 8'b11000000; //0
end
  
else if(MIC_peak >= 12'd3400 && MIC_peak < 12'd3525) begin
led<= 16'b0000_1111_1111_1111;
 seg1 = 8'b11111001; //1
end
   
else if(MIC_peak >= 12'd3525 && MIC_peak < 12'd3650) begin
led <= 16'b0001_1111_1111_1111;
seg1 = 8'b10100100; //2
end
             
else if(MIC_peak >= 12'd3650 && MIC_peak < 12'd3775) begin
led<= 16'b0011_1111_1111_1111;
seg1 = 8'b10110000; //3
end
              
else if(MIC_peak >= 12'd3775 && MIC_peak < 12'd3900) begin
led<= 16'b0111_1111_1111_1111;
seg1 = 8'b10011001; //4
end

else if(MIC_peak >= 12'd3900 && MIC_peak <= 12'd4095) begin
led<= 16'b1111_1111_1111_1111;
seg1 = 8'b10010010; //5
end

if( MIC_peak >= 12'd3275)
begin 
seg2 = 8'b11111001; //always 1
end
else if(MIC_peak < 12'd3275)
begin
seg2 = 8'b11000000; //0
end

end  


//always @ (posedge clk_20k)
//    begin
//         COUNT <= (COUNT == 1999) ? 0 : COUNT+1;
//         if(COUNT == 0)
//         begin
//            MIC_peak = 0;
//         end
//         if (MIC_in > MIC_peak)
//         begin
//              MIC_peak <= MIC_in;
//         end
        
//    end
endmodule
