`timescale 1ns / 1ps
/*
This module chooses 1 of 8 LEDs at random using hashing techniques and lights it up on pressing the up_button.
Does not turn it off.
*/


//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:07:09 11/24/2020 
// Design Name: 
// Module Name:    randomLED 
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
module randomLED(
	input clk_100mhz,
	input module_trigger,
	input calScore_clear,
	output [7:0] module_output
    );
	 integer module_clk = 0;
	 integer selected_led = 0;
	 parameter delay_time = 15000000;
	 reg[7:0] led_outs = 8'b00000000;
	 
// Random LED light up
	always@(posedge clk_100mhz)
		begin
			module_clk = module_clk + 1;
			if (module_clk > delay_time)
				begin
					if (module_trigger)
						begin
							selected_led = module_clk % 8;
							led_outs[selected_led] = 1'b1;
							module_clk = 0;
						end
				end
//			if (module_clk == 15000000) led_outs = 8'b00000000;
			if (calScore_clear == 1)
			begin
				led_outs = 8'b00000000;
			end
		end
	assign module_output = led_outs;
endmodule
