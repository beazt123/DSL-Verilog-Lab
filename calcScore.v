`timescale 1ns / 1ps
/*
Calculates the score the user scores.
adds 1 to a counter every time the movementofLED and randomLED registers are identical(i.e. when the snake eats the rabbit)

When that happens, attempts to zero the randomLED register, but as of now doesn't do it very well even on introducing a new variable var3
*/

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:17:03 11/24/2020 
// Design Name: 
// Module Name:    calcScore 
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
//////////////////////////////////////////////////////////////////////////////////
module calcScore(input [7:0] var1,
						input [7:0] var2,
						output [3:0] switch,
						output calScore_clear
    );
	 integer counter = 0;
	 reg[3:0] counter_in_Bit = 4'b_0000;
	 
	 reg calScore_reg = 0;
	 
	 always @ (var1)
		begin
			if (var1 == var2 && var1[7:0] != 8'b00000000 && var2[7:0] != 8'b00000000)
				begin
				   calScore_reg = 1;
					counter = counter + 1;
					if (counter > 9)
						counter = 0;	
				end
			else 
			begin 
				calScore_reg = 0;
			end
		end
		
	always @ (counter)
		begin
			case (counter)
				0: counter_in_Bit = 4'b_0000;
				1: counter_in_Bit = 4'b_0001;
				2: counter_in_Bit = 4'b_0010;
				3: counter_in_Bit = 4'b_0011;
				4: counter_in_Bit = 4'b_0100;
				5: counter_in_Bit = 4'b_0101;
				6: counter_in_Bit = 4'b_0110;
				7: counter_in_Bit = 4'b_0111;
				8: counter_in_Bit = 4'b_1000;
				9: counter_in_Bit = 4'b_1001;
			endcase
		end
		

	assign switch = counter_in_Bit;
	assign calScore_clear = calScore_reg;
endmodule
