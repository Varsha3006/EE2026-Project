`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M
//
//  STUDENT A NAME: VARSHA MS
//  STUDENT A MATRICULATION NUMBER: A0205345M
//
//  STUDENT B NAME: TENG KIAN EN
//  STUDENT B MATRICULATION NUMBER: A0200053E
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
   input CLOCK,
   input  J_MIC3_Pin3,
   input sw0, sw1,
   input pb, btnU, btnL, btnR, btnD, // Connect from this signal to Audio_Capture.v
   input sw15, sw14, sw13, sw12, sw11,sw9, sw3, sw10,
   output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
   output J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
   output  [15:0] led,
   output cs,output sclk, output d_cn, output resn, output vccen, output pmoden,output sdin, output [7:0]seg, output[3:0]an);
    
    wire my_clk1;
    wire my_clk2;// for ck625
    wire [11:0] mic_in;
    wire frame_begin, sending_pixels,sample_pixel;
   wire  [13:0] pixel_index;
    wire [4:0]teststate;
    reg [15:0]oled_data = 16'd0;
    wire [15:0]volume;// for led
    wire [15:0]ledA; //for led
    wire frequency;
    wire [7:0]seg1;
    wire [7:0]seg2;
    wire [7:0]seg3;
   // wire [7:0] seg4;
    wire [3:0]anA;
    wire [3:0]anB;
    wire freq2;
    wire sp_out;
    reg [6:0] my_x;
    reg [6:0] my_y;
    wire [1:0] colour_scheme;
    wire [11:0] MIC_peak;
    reg loud;
    

 
 //assign led = (sw0 ==1)? volume : mic_in;
 assign led = sw1?ledA:(sw0?volume:mic_in);
           

assign seg[7] = 1;
 clk20k clk20Khz(CLOCK, my_clk1);
 myfreq clk381hz(CLOCK,frequency);
 peak_freq clk11hz(CLOCK,freq2);

 find_peak_mod peak(freq2,mic_in[11:0], sw10, volume[15:0],seg1[7:0],seg2[7:0],MIC_peak[11:0]);
 anode panel(frequency,sw0,sw1,seg1[7:0],seg2[7:0],seg[7:0],seg3[7:0],anB[3:0],an[3:0]);
  
 Audio_Capture dev1(.CLK(CLOCK),.cs(my_clk1),.MISO(J_MIC3_Pin3),.clk_samp(J_MIC3_Pin1),.sclk(J_MIC3_Pin4),.sample(mic_in));
 
 studentA_clock improve1(CLOCK,sw1,pb,btnU, btnL, btnR, btnD,seg3[7:0],anB[3:0],ledA[15:0]);

 
clk625 ck1(CLOCK, my_clk2); 
sp_mod reset(pb, my_clk2, sp_out);
//ledbar display(my_clk2,sw11,sw12,sw13,sw14,sw15,oled_data,pixel_index, MIC_peak[11:0]);
pick_colour_scheme choose_scheme(sw14, sw13, colour_scheme[1:0]);
 

  
  always @ (posedge my_clk2) begin
          
          my_x = (pixel_index)%96;
          my_y = (pixel_index)/96;
   if(sw9)       
          begin
          if (colour_scheme == 0) begin 
          if (sw15 && !sw12) begin
      
              if (my_y == 7'd0 || my_y == 7'd63 || my_x == 7'd0 || my_x == 7'd95)
                  oled_data = 16'hffff;
  
              else
                  oled_data = 16'h0000;
                                 
          end
          
          else if (!sw15 && !sw12) begin
              
              if (my_y <= 7'd2 || my_y >= 7'd61 || my_x <= 7'd2 || my_x >= 7'd93)
                  oled_data = 16'hffff;
  
              else
                  oled_data = 16'h0000;
          end
          
          else oled_data = 16'h0000;
           
          end   
          
          
          if(colour_scheme == 0) begin                     
              if (!sw11) begin
              //smallest mic_in to largest, 
             if (MIC_peak >= 12'd0 ) begin    //0
              if ((my_y <= 7'd55 && my_y >= 7'd54) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h07E0;  
              end  
              
              if ( MIC_peak >= 12'd2275) begin   //1
              if ((my_y <= 7'd52 && my_y >= 7'd51) && (my_x >= 7'd43 && my_x <= 7'd53))
                   oled_data = 16'h07E0;  
              end
              
            if ( MIC_peak >= 12'd2400) begin   //2
              if ((my_y <= 7'd49 && my_y >= 7'd48) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h07E0;                     
              end
              
            if ( MIC_peak >= 12'd2525) begin   //3
              if ((my_y <= 7'd46 && my_y >= 7'd45) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h07E0;       
              end
              
              if ( MIC_peak >= 12'd2650 ) begin   //4
              if ((my_y <= 7'd43 && my_y >= 7'd42) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h07E0;       
              end
              
              if (MIC_peak >= 12'd2775) begin   //5
              if ((my_y <= 7'd40 && my_y >= 7'd39) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h07E0;       
              end                        
              
              if ( MIC_peak >= 12'd2900) begin    //6       
              if ((my_y <= 7'd37 && my_y >= 7'd36) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hFFE0;                                                                              
              end
              
              if ( MIC_peak >= 12'd3025) begin     //7
              if ((my_y <= 7'd34 && my_y >= 7'd33) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hFFE0;  
              end
              
              if ( MIC_peak >= 12'd3150) begin      //8                 
              if ((my_y <= 7'd31 && my_y >= 7'd30) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hFFE0;  
              end
              
              if ( MIC_peak >= 12'd3275) begin     //9
              if ((my_y <= 7'd28 && my_y >= 7'd27) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hFFE0;   
              end
              
              if ( MIC_peak >= 12'd3400) begin          //10                       
              if ((my_y <= 7'd25 && my_y >= 7'd24) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hFFE0;   
              end
              
              if ( MIC_peak >= 12'd3525) begin          //11             
              if ((my_y <= 7'd22 && my_y >= 7'd21) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF800;               
              end
              
              if ( MIC_peak >= 12'd3650) begin   //12
              if ((my_y <= 7'd19 && my_y >= 7'd18) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF800;                      
              end            
              
              if ( MIC_peak >= 12'd3775) begin   //13
              if ((my_y <= 7'd16 && my_y >= 7'd15) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF800;                      
              end            
              
              if ( MIC_peak >= 12'd3900) begin   //14
              if ((my_y <= 7'd13 && my_y >= 7'd12) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF800;                      
              end
  
              if ( MIC_peak >= 12'd4095) begin   //15
              if ((my_y <= 7'd10 && my_y >= 7'd9) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF800;                       
              end
              end
              
              else begin
              if ((my_x >= 7'd43 && my_x<= 7'd53) && (my_y >= 7'd9 && my_y <= 55))
                  oled_data = 16'h0000;
              end
          end
          
          if (colour_scheme == 1) begin 
          if (sw15 && !sw12) begin
      
              if (my_y == 7'd0 || my_y == 7'd63 || my_x == 7'd0 || my_x == 7'd95)
                  oled_data = 16'h1048;
  
              else
                  oled_data = 16'hFFFF;
                                 
          end
          
          else if (!sw15 && !sw12) begin
              
              if (my_y <= 7'd3 || my_y >= 7'd61 || my_x <= 7'd3 || my_x >= 7'd93)
                  oled_data = 16'h1048;
  
              else
                  oled_data = 16'hFFFF;
          end  
          
          else oled_data = 16'hFFFF;
            
          end           
          
          if(colour_scheme == 1) begin                     
              if (!sw11) begin
              
              if (MIC_peak >= 12'd0) begin   
              if ((my_y <= 7'd55 && my_y >= 7'd54) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h07FF;  
              end
              
              if (MIC_peak >= 12'd2275 ) begin     
              if ((my_y <= 7'd52 && my_y >= 7'd51) && (my_x >= 7'd43 && my_x <= 7'd53))
                   oled_data = 16'h07FF;  
              end
              
              if (MIC_peak >= 12'd2400 ) begin   
              if ((my_y <= 7'd49 && my_y >= 7'd48) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h07FF;                     
              end
              
              if (MIC_peak >= 12'd2525 ) begin   
              if ((my_y <= 7'd46 && my_y >= 7'd45) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h07FF;       
              end
              
              if ( MIC_peak >= 12'd2650 ) begin   
              if ((my_y <= 7'd43 && my_y >= 7'd42) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h07FF;       
              end
              
              if (MIC_peak >= 12'd2775) begin   
              if ((my_y <= 7'd40 && my_y >= 7'd39) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h07FF;       
              end                        
              
              if (MIC_peak >= 12'd2900 ) begin           
              if ((my_y <= 7'd37 && my_y >= 7'd36) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF81F;                                                                              
              end
              
              if (MIC_peak >= 12'd3025) begin    
              if ((my_y <= 7'd34 && my_y >= 7'd33) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF81F;  
              end
              
              if ( MIC_peak >= 12'd3150 ) begin                      
              if ((my_y <= 7'd31 && my_y >= 7'd30) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF81F;  
              end
              
              if (MIC_peak >= 12'd3275 ) begin    
              if ((my_y <= 7'd28 && my_y >= 7'd27) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF81F;   
              end
              
              if ( MIC_peak >= 12'd3400 ) begin                                
              if ((my_y <= 7'd25 && my_y >= 7'd24) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF81F;   
              end
              
              if ( MIC_peak >= 12'd3525) begin                      
              if ((my_y <= 7'd22 && my_y >= 7'd21) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h001F;               
              end
              
              if ( MIC_peak >= 12'd3650) begin   
              if ((my_y <= 7'd19 && my_y >= 7'd18) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h001F;                      
              end
              
              if (MIC_peak >= 12'd3775 ) begin   
              if ((my_y <= 7'd16 && my_y >= 7'd15) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h001F;                      
              end
              
              if (MIC_peak >= 12'd3900 ) begin   
              if ((my_y <= 7'd13 && my_y >= 7'd12) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h001F;                      
              end                      
              
              if (MIC_peak >= 12'd4095 ) begin   
              if ((my_y <= 7'd10 && my_y >= 7'd9) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h001F;                      
              end            
              
              end
              
              else begin
              if ((my_x >= 7'd43 && my_x<= 7'd53) && (my_y >= 7'd9 && my_y <= 55)) 
              oled_data = 16'hFFFF;
              end
              
          end        
                 
                 
          if (colour_scheme == 2) begin 
          if (sw15 && !sw12) begin
      
              if (my_y == 7'd0 || my_y == 7'd63 || my_x == 7'd0 || my_x == 7'd95)
                  oled_data = 16'hF81F;
  
              else
                  oled_data = 16'h001F;
                                 
          end
          
          else if (!sw15 && !sw12) begin
              
              if (my_y <= 7'd3 || my_y >= 7'd61 || my_x <= 7'd3 || my_x >= 7'd93)
                  oled_data = 16'hF81F;
  
              else
                  oled_data = 16'h001F;
          end
          
          else oled_data = 16'h001F;
              
          end           
          
          if(colour_scheme == 2) begin                     
              if (!sw11) begin
              
              if (MIC_peak >= 12'd0) begin   
              if ((my_y <= 7'd55 && my_y >= 7'd54) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hFFFF;  
              end
              
              if ( MIC_peak >= 12'd2275) begin     
              if ((my_y <= 7'd52 && my_y >= 7'd51) && (my_x >= 7'd43 && my_x <= 7'd53))
                   oled_data = 16'hFFFF;  
              end
              
              if (MIC_peak >= 12'd2400) begin   
              if ((my_y <= 7'd49 && my_y >= 7'd48) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hFFFF;                     
              end
              
              if (MIC_peak >= 12'd2525) begin   
              if ((my_y <= 7'd46 && my_y >= 7'd45) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hFFFF;       
              end
              
              if (MIC_peak >= 12'd2650) begin   
              if ((my_y <= 7'd43 && my_y >= 7'd42) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hFFFF;       
              end
              
              if (MIC_peak >= 12'd2775) begin   
              if ((my_y <= 7'd40 && my_y >= 7'd39) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hFFFF;       
              end                        
              
              if (MIC_peak >= 12'd2900 ) begin           
              if ((my_y <= 7'd37 && my_y >= 7'd36) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF81F;                                                                              
              end
              
              if (MIC_peak >= 12'd3025) begin     
              if ((my_y <= 7'd34 && my_y >= 7'd33) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF81F;  
              end
              
              if ( MIC_peak >= 12'd3150) begin                       
              if ((my_y <= 7'd31 && my_y >= 7'd30) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF81F;  
              end
              
              if (MIC_peak >= 12'd3275 ) begin    
              if ((my_y <= 7'd28 && my_y >= 7'd27) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF81F;   
              end
              
              if (MIC_peak >= 12'd3400 ) begin                                 
              if ((my_y <= 7'd25 && my_y >= 7'd24) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'hF81F;   
              end
              
              if (MIC_peak >= 12'd3525) begin                       
              if ((my_y <= 7'd22 && my_y >= 7'd21) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h0000;               
              end
              
              if (MIC_peak >= 12'd3650 ) begin                       
              if ((my_y <= 7'd19 && my_y >= 7'd18) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h0000;               
              end            
              
              if (MIC_peak >= 12'd3775) begin                       
              if ((my_y <= 7'd16 && my_y >= 7'd15) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h0000;               
              end
              
              if (MIC_peak >= 12'd3900 ) begin                       
              if ((my_y <= 7'd13 && my_y >= 7'd12) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h0000;               
              end                        
              
              if ( MIC_peak >= 12'd4095) begin   
              if ((my_y <= 7'd10 && my_y >= 7'd9) && (my_x >= 7'd43 && my_x <= 7'd53))
                  oled_data = 16'h0000;                      
              end
              end
              
              else begin
              if ((my_x >= 7'd43 && my_x<= 7'd53) && (my_y >= 7'd9 && my_y <= 55))
              oled_data = 16'h001F;
              end
              
          end        
            
        end  
       //Kian En's improvement  
        else if (sw3 && !sw9) begin
        if(!sw15)begin
        if(((my_y <= 28 && my_y>=27)&&(my_x<=22 && my_x>=8))||((my_y<=34 && my_y>=29)&&(my_x<=22 && my_x>=21))||((my_x>=8 && my_x<=22)&&(my_y<=36&&my_y>=35))||((my_x<=9 && my_x>=8)&&(my_y<=46 && my_y>=37))||((my_x<=22 && my_x >=10)&&(my_y<=46 && my_y>=45))||((my_y <= 28 && my_y>=27)&&(my_x<=58 && my_x>=44))||((my_y<=34 && my_y>=29)&&(my_x<=58 && my_x>=57))||((my_x>=44 && my_x<=58)&&(my_y<=36 && my_y>=35))||((my_x<=45 && my_x>=44)&&(my_y<=46 && my_y>=37))||((my_x<=58 && my_x >=46)&&(my_y<=46 && my_y>=45))||((my_x<=39 && my_x>=27)&&(my_y<=28 && my_y >=27))||((my_x<=39 && my_x>=27)&&(my_y<=46 && my_y >=45))||((my_x>=27 && my_x<=28)&&(my_y>=29 && my_y<=44))||((my_x>=38 && my_x<=39)&&(my_y>=29 && my_y<=44))||((my_y<=28 && my_y>=27)&&(my_x<=74 && my_x>=63))||((my_x<=64 && my_x>=63)&&(my_y<=46 && my_y>=29))||((my_y<=36 && my_y>=35)&&(my_x<=74 && my_x >=65))||((my_x<=74 && my_x >=73)&&(my_y<=46 && my_y>=37))||((my_y<=46 && my_y>=45)&&(my_x<=72 && my_x>=65))||((my_y<=28 && my_y>=27)&&(my_x<=91 && my_x>=79))||((my_x<=91 && my_x>=90)&&(my_y>=29 && my_y<=37))||((my_y<=37 && my_y>=36)&&(my_x<=89 && my_x>=84))||((my_x >=84 && my_x <= 85)&&(my_y<=41 && my_y>=38))||((my_y<=46 && my_y>=45)&&(my_x<=85 && my_x>=84)))
        oled_data = 16'hffff;
        else oled_data = 16'h0000;
        end  
        else begin
        if(((my_y<=22 && my_y>=19)&&(my_x>=26 && my_x<=53))||((my_x<=29 && my_x>=26)&&(my_y<=54 && my_y>=23))||((my_x<=53 && my_x>=50)&&(my_y<=54 && my_y>=23))||((my_y<=38 && my_y>=35)&&(my_x<=49 && my_x >=30))||((my_y<=23 && my_y>=21)&&(my_x<=74 && my_x>=60))||((my_x<=68 && my_x>=66)&&(my_y<=29 && my_y>=15))||((my_x<=10 && my_x>=9)&&(my_y<=12 && my_y>=5))||((my_y<=6 && my_y>=5)&&(my_x<=13 && my_x>=11))||((my_y<=9 && my_y>=8)&&(my_x<=13 && my_x>=11))||((my_y<=12 && my_y>=11)&&(my_x<=13 && my_x>=11))||((my_y<=6 && my_y>=5)&&(my_x<=20 && my_x>=15))||((my_y<=10 && my_y>=9)&&(my_x<=18 && my_x>=17))||((my_x<=16 && my_x>=15)&&(my_y<=12 && my_y>=7))||((my_x<=20 && my_x>=19)&&(my_y<=12 && my_y>=7))||((my_y<=6 && my_y>=5)&&(my_x<=27 && my_x>=22))||((my_x<=23 && my_x>=22)&&(my_y<=9 && my_y>=7))||((my_y>=8 && my_y<=9)&&(my_x<=27 && my_x>=24))||((my_x<=27 && my_x>=26)&&(my_y>=10 && my_y<=12))||((my_y<=12 && my_y>=11)&&(my_x<=25 && my_x>=22))||((my_x<=30 && my_x>=29)&&(my_y<=9 && my_y>=5))||((my_x<=32 && my_x>=31)&&(my_y<=9 && my_y>=8))||((my_x<=34 && my_x>=33)&&(my_y<=12 && my_y >= 5))||((my_y<=12 && my_y>=11)&&(my_x<=32 && my_x>=29))) 
        oled_data = 16'hF800;
        else oled_data = 16'hffff;
        end
        end
       
//team component  
              else if(!sw9 && !sw3) begin
              if(MIC_peak<=12'd2275)begin //normal face
              if (((my_x >= 7'd12 && my_x<= 7'd20) && (my_y >= 7'd10 && my_y <= 7'd12)) || ((my_x >= 7'd72 && my_x<= 7'd81) && (my_y >= 7'd10 && my_y <= 7'd12)) || ((my_x >= 7'd12 && my_x<= 7'd81) && (my_y >= 7'd40 && my_y <= 7'd45)))
              oled_data = 16'h0000; //black colour
              else
              oled_data= 16'hffe0;
              end
              
           else if (MIC_peak> 12'd2275 && MIC_peak <= 12'd2655) begin    //"LOUDER"                                                                                                                         
           if (((my_x >= 7'd13 && my_x<= 7'd14) && (my_y >= 7'd21 && my_y <= 7'd44)) || ((my_x >= 7'd13 && my_x<= 7'd23) && (my_y >= 7'd44 && my_y <= 7'd45))  ||  //until here is L
      ((my_x >= 7'd28 && my_x<= 7'd29) && (my_y >= 7'd20 && my_y <= 7'd44)) || ((my_x >= 7'd28 && my_x<= 7'd37) && (my_y >= 7'd20 && my_y <= 7'd21)) || ((my_x >= 7'd28 && my_x<= 7'd37) && (my_y >= 7'd44 && my_y <= 7'd45)) || ((my_x >= 7'd37 && my_x<= 7'd38) && (my_y >= 7'd20 && my_y <= 7'd44)) ||// LETTER O
      ((my_x >= 7'd40 && my_x<= 7'd41) && (my_y >= 7'd20 && my_y <= 7'd44)) || ((my_x >= 7'd40 && my_x<= 7'd50) && (my_y >= 7'd44 && my_y <= 7'd45)) || ((my_y<=44 && my_y>=20)&&(my_x<=50 && my_x>=49))|| // Letter U
       ((my_x >= 7'd53 && my_x<= 7'd54) && (my_y >= 7'd20 && my_y <= 7'd44)) || ((my_x >= 7'd53 && my_x<= 7'd63) && (my_y >= 7'd20 && my_y <= 7'd21)) || ((my_x >= 7'd63 && my_x<= 7'd64) && (my_y >= 7'd20 && my_y <= 7'd44))|| ((my_x >= 7'd53 && my_x<= 7'd63) && (my_y >= 7'd44 && my_y <= 7'd45)) || //LETTER D
       ((my_x >= 7'd66 && my_x<= 7'd67) && (my_y >= 7'd20 && my_y <= 7'd44)) || ((my_x >= 7'd66 && my_x<= 7'd74) && (my_y >= 7'd20 && my_y <= 7'd21)) || ((my_x >= 7'd67 && my_x<= 7'd74) && (my_y >= 7'd33 && my_y <= 7'd34))|| ((my_x >= 7'd66 && my_x<= 7'd74) && (my_y >= 7'd44 && my_y <= 7'd44)) || //LETTER E
      ((my_x >= 7'd77 && my_x<= 7'd78) && (my_y >= 7'd20 && my_y <= 7'd44))|| ((my_x >= 7'd77 && my_x<= 7'd86) && (my_y >= 7'd20 && my_y <= 7'd21)) || ((my_x >= 7'd86 && my_x<= 7'd87) && (my_y >= 7'd20 && my_y <= 7'd30)) )//Letter R
                     oled_data = 16'hffff; //black colour
                       else 
                       oled_data= 16'h0000;
                       end 
               
              else if( MIC_peak<=12'd2900 && MIC_peak >12'd2650) begin
                      //shocked face
                if (((my_x >= 7'd12 && my_x<= 7'd14) && (my_y >= 7'd10 && my_y <= 7'd12)) || ((my_x >= 7'd79 && my_x<= 7'd81) && (my_y >= 7'd10 && my_y <= 7'd12)) || ((my_x >= 7'd44 && my_x<= 7'd54) && (my_y >= 7'd40 && my_y <= 7'd50)))
                oled_data = 16'h0000; //black
                  else 
                  oled_data= 16'hffe0;
                  end 
                  
              else if( MIC_peak<=12'd3150 && MIC_peak > 12'd2900) begin
                         //smiley face
                  if (((my_x >= 7'd12 && my_x<= 7'd14) && (my_y >= 7'd10 && my_y <= 7'd12)) || ((my_x >= 7'd79 && my_x<= 7'd81) && (my_y >= 7'd10 && my_y <= 7'd12)) || ((my_x >= 7'd12 && my_x<= 7'd81) && (my_y >= 7'd40 && my_y <= 7'd45)) || ((my_x >= 7'd12 && my_x<= 7'd14) && (my_y >= 7'd25 && my_y <= 7'd40)) || ((my_x >= 7'd79 && my_x<= 7'd81) && (my_y >= 7'd25 && my_y <= 7'd40)))
                  oled_data = 16'h0000; //black
                    else 
                    oled_data= 16'hffe0;
                    end           
                                                  
                  
               else if ( MIC_peak <= 12'd3525 && MIC_peak > 12'd3150)  begin 
                  //angry face        
                  if (((my_x >= 7'd22 && my_x<= 7'd24) && (my_y >= 7'd20 && my_y <= 7'd22)) || ((my_x >= 7'd69 && my_x<= 7'd71) && (my_y >= 7'd20 && my_y <= 7'd22)) || ((my_x >= 7'd12 && my_x<= 7'd81) && (my_y >= 7'd40 && my_y <= 7'd45)) || ((my_x >= 7'd12 && my_x<= 7'd14) && (my_y >= 7'd45 && my_y <= 7'd60)) ||
      ((my_x >= 7'd79 && my_x<= 7'd81) && (my_y >= 7'd45 && my_y <= 7'd60))  || ((my_x <= 7'd79 && my_x >= 7'd75) && (my_y <= 7'd8 && my_y >= 7'd7)) || ((my_x >= 7'd82 && my_x <= 7'd86) && (my_y >= 7'd7 && my_y <= 7'd8)) || ((my_x <= 7'd79 && my_x >= 7'd78) && (my_y <= 7'd7 && my_y >= 7'd3))||
                   ((my_x <= 7'd83 && my_x >= 7'd82) && (my_y <= 7'd7 && my_y >= 7'd3))  || ((my_x <= 7'd79 && my_x >= 7'd75) && (my_y <= 7'd12 && my_y >= 7'd11)) || ((my_x <= 7'd79 && my_x >= 7'd78) && (my_y <= 7'd17 && my_y >= 7'd12)) || ((my_x <= 7'd86 && my_x >= 7'd82) && (my_y <= 7'd12 && my_y >= 7'd11)) ||
                    ((my_x >= 7'd82 && my_x <= 7'd83) && (my_y <= 7'd16 && my_y >= 7'd12))) 
                  oled_data = 16'h0000; //black
                    else 
                    oled_data= 16'hffe0;
                    end             
              else if (MIC_peak > 12'd3525)  begin //"AHHH!"
              if(((my_x >= 7'd19 && my_x<= 7'd20) && (my_y >= 7'd15 && my_y <= 7'd45))|| ((my_x >= 7'd19 && my_x<= 7'd32) && (my_y >= 7'd15 && my_y <= 7'd16)) || ((my_x >= 7'd32 && my_x<= 7'd33) && (my_y >= 7'd15 && my_y <= 7'd45)) || ((my_x >= 7'd20 && my_x<= 7'd31) && (my_y >= 7'd30 && my_y <= 7'd31))|| //letter A
              ((my_x >= 7'd36 && my_x<= 7'd37) && (my_y >= 7'd14 && my_y <= 7'd44))|| ((my_x >= 7'd36 && my_x<= 7'd48) && (my_y >= 7'd30 && my_y <= 7'd31))  || ((my_x >= 7'd48 && my_x<= 7'd49) && (my_y >= 7'd15 && my_y <= 7'd45)) || //letter H
              ((my_x >= 7'd51 && my_x<= 7'd52) && (my_y >= 7'd15 && my_y <= 7'd45))|| ((my_x >= 7'd51 && my_x<= 7'd63) && (my_y >= 7'd30 && my_y <= 7'd31)) || ((my_x >= 7'd63 && my_x<= 7'd64) && (my_y >= 7'd15 && my_y <= 7'd45)) || // letter H
              ((my_x >= 7'd66 && my_x<= 7'd67) && (my_y >= 7'd15 && my_y <= 7'd45))|| ((my_x >= 7'd66 && my_x<= 7'd77) && (my_y >= 7'd30 && my_y <= 7'd31)) || ((my_x >= 7'd77 && my_x<= 7'd78) && (my_y >= 7'd15 && my_y <= 7'd45))|| // letter H   
              ((my_x >= 7'd81 && my_x<= 7'd83) && (my_y >= 7'd15 && my_y <= 7'd42))||((my_x >= 7'd81 && my_x<= 7'd83) && (my_y >= 7'd44 && my_y <= 7'd46))) //!
                  oled_data = 16'hF800; //red
                     else 
                     oled_data= 16'h0000;
                      end     
            end      
      end
      
      
       Oled_Display test(my_clk2, sp_out, frame_begin, sending_pixels,
      sample_pixel, pixel_index, oled_data, cs, sdin, sclk, d_cn, resn, vccen,
      pmoden, teststate); 
   
 endmodule
      