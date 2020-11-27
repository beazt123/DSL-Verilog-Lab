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
	 parameter delay_time = 15000000;
	 reg[7:0] led_outs = 8'b00000001;
	 reg btn_en = 1;
	 
	// Lateral Movement
	 always@ (posedge clk_100mhz)
		begin
			if ((btn_left || btn_right) && btn_en == 1)
				begin 
					btn_en = 0;
					if (btn_left)
						begin
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
			if (btn_en == 0)
				begin
				 module_clk = module_clk + 1;
				 if (module_clk > delay_time)
					begin
						module_clk = 0;
						btn_en = 1;
					end
				end
		end
	assign module_output = led_outs;
endmodule
