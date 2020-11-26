`timescale 1ns / 1ps
/*
This module lights up the rightmost LED.
Uses the left and right buttons to control the movement of the lit LED.

*/
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:02:24 11/24/2020 
// Design Name: 
// Module Name:    movementOfLED 
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
module movementOfLED(
		input clk_100mhz,
		input btn_left,
		input btn_right,
		output[7:0] module_output
    );
	 integer module_clk = 0;
	 parameter delay_time = 23000000;
	 reg[7:0] led_outs = 8'b00000001;
	 
	// Lateral Movement
	 always@ (posedge clk_100mhz)
		 begin
			if (module_clk > delay_time)
				begin
					if (btn_left)
						begin
							module_clk = 0;
							case (led_outs)
								8'b00000001: led_outs <= 8'b00000010;
								8'b00000010: led_outs <= 8'b00000100;
								8'b00000100: led_outs <= 8'b00001000;
								8'b00001000: led_outs <= 8'b00010000;
								8'b00010000: led_outs <= 8'b00100000;
								8'b00100000: led_outs <= 8'b01000000;
								8'b01000000: led_outs <= 8'b10000000;
								8'b10000000: led_outs <= 8'b00000001;
							endcase
						end
					if (btn_right)
						begin
							module_clk = 0;
							case (led_outs)
								8'b00000100: led_outs <= 8'b00000010;
								8'b00001000: led_outs <= 8'b00000100;
								8'b00010000: led_outs <= 8'b00001000;
								8'b00100000: led_outs <= 8'b00010000;
								8'b01000000: led_outs <= 8'b00100000;
								8'b10000000: led_outs <= 8'b01000000;
								8'b00000001: led_outs <= 8'b10000000;
								8'b00000010: led_outs <= 8'b00000001;
							endcase
						end
				end
			else
				module_clk = module_clk + 1;
		 end  
	assign module_output = led_outs;
endmodule
