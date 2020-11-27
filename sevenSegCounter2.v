`timescale 1ns / 1ps
/*
This module takes in a 4-bit input and outputs the controls to a 1-digit 7-segment display from 0-9.
*/


//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:34:43 11/24/2020 
// Design Name: 
// Module Name:    sevenSegCounter2 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//

module sevenSegCounter2(
	 input clk,
    input [15:0] score,
    output [7:0] seg,
	 output [3:0] dig
    );
  // next three lines turns the 7 seg display completely off
  
	
	parameter c_CNT_2ms  = 200000; //number of clocks for 2 milliseconds with 100MHz clock
	reg [31:0] r_CNT_2ms = 0;
	reg [1:0] TOGGLE_2ms = 2'b00;  //used for multiplexing 4 seven segments
	
	reg [15:0] displayed_number;    //counting number to be displayed
   reg [3:0] segment_pattern;
	reg [3:0] dig_reg;  
   reg [7:0] seg_reg;
	
	// count r_CNT_2ms    0      ->    1        ->    2      ->    3
    // activates      segment 1    segment 2      segment 3     segment 4
    // and repeat				 
	always @ (posedge clk)   
   begin
      if (r_CNT_2ms == c_CNT_2ms-1) // -1, since counter starts at 0
        begin    
			 r_CNT_2ms    <= 0;
			 if (TOGGLE_2ms == 3)
				TOGGLE_2ms <=0;
			 else 
				TOGGLE_2ms <=TOGGLE_2ms+1;         
        end
      else
        r_CNT_2ms <= r_CNT_2ms + 1;
   end 
	
	always @(TOGGLE_2ms)
   begin
		  displayed_number = score;
        case(TOGGLE_2ms)
        2'b00: begin
					dig_reg = 4'b0111; //activate first seven segment and deactivate other 3 seven segments
					segment_pattern = displayed_number/1000; //the first digit of the displaying number
              end
        2'b01: begin
					dig_reg = 4'b1011; //activate second seven segment and deactivate other 3 seven segments
					segment_pattern = (displayed_number % 1000)/100; //the second digit of the displaying number ("%" is the modulo operator, e.g., 13%10 = 3, 555%100 = 55)
              end
        2'b10: begin
					dig_reg = 4'b1101; //activate third seven segment and deactivate other 3 seven segments
					segment_pattern = ((displayed_number % 1000)%100)/10; //the third digit of the displaying number ("%" is the modulo operator, e.g., 13%10 = 3, 555%100 = 55)
                end
        2'b11: begin
					dig_reg = 4'b1110; //activate forth seven segment and deactivate other 3 seven segments
					segment_pattern = ((displayed_number % 1000)%100)%10; //the fourth digit of the displaying number ("%" is the modulo operator, e.g., 13%10 = 3, 555%100 = 55)    
               end
        endcase
   end
	 
     
   always @(segment_pattern) // Cathode patterns of the 7-segment display
   begin
        case(segment_pattern)
        4'b0000: seg_reg = 8'b11000000; // "0"     
        4'b0001: seg_reg = 8'b11111001; // "1" 
        4'b0010: seg_reg = 8'b10100100; // "2" 
        4'b0011: seg_reg = 8'b10110000; // "3" 
        4'b0100: seg_reg = 8'b10011001; // "4" 
        4'b0101: seg_reg = 8'b10010010; // "5" 
        4'b0110: seg_reg = 8'b10000010; // "6" 
        4'b0111: seg_reg = 8'b11111000; // "7" 
        4'b1000: seg_reg = 8'b10000000; // "8"     
        4'b1001: seg_reg = 8'b10011000; // "9" 
        default: seg_reg = 8'b11000000; // "0"
        endcase
   end
	
	assign dig = dig_reg;  			//selectives digits 0-3, ACTIVE LOW
   assign seg = seg_reg;

 
endmodule

