`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//lab2.2
//////////////////////////////////////////////////////////////////////////////////
module labkit(
	input clk_100mhz,
	input [7:0] switch,

	input btn_up,       // buttons, depress = high
	input btn_enter,
	input btn_left,
	input btn_down,
	input btn_right,

	output [7:0] seg, 
	output [3:0] dig,   //selects digits 0-3, ACTIVE LOW
	output [7:0] led,   // 1 turns on leds

	output [2:0] vgaRed,
	output [2:0] vgaGreen,
	output [2:1] vgaBlue,
	output hsync,
	output vsync,

	inout [7:0] ja,
	inout [7:0] jb,
	inout [7:0] jc,
	input [7:0] jd,
	inout [19:0] exp_io_n,
	inout [19:0] exp_io_p
	);


    // all unused outputs must be assigned    VERY IMPORTANT!!!!!!
	assign vgaRed = 3'b111;
	assign vgaGreen = 3'b111;
	assign vgaBlue = 2'b11;
	assign hsync = 1'b1;
	assign vsync = 1'b1;
	
	
	//7 segment Control
	
	//assign dig = 4'b1110;
	 
	//assign led = 8'b0000_0000;
	//assign seg[7:0] = 8'b1111_1111;
	 
    ///////////////////////////////////////////////////////////////
	// Implement the project from here
	
	/*
	output of MovementLED;
	output of randomLED;
	
	On change of movementled or randomLED
	if output from movementled == randomLED:
		turn off randomLED
		increase a counter by 1.
		display the number on the 7 segment
		if 7 segment reaches9, restart the game.
	
	counter variable = 4'b_XXXX; increment by 4'b_0001;
	
	randomLED:
		on press of button
			output 1 
	*/
	
	wire[7:0] ledMovementWire;
	wire[7:0] randomLEDWire;
	wire[7:0] randomLEDWire2;
	wire[3:0] score;
	wire feedback_loop;
	
	
	movementOfLED(clk_100mhz, btn_left, btn_right, ledMovementWire);
	
	randomLED(clk_100mhz, btn_up, feedback_loop, ledMovementWire, randomLEDWire);
	
	calcScore(ledMovementWire, randomLEDWire, score, feedback_loop);
	
	sevenSegCounter2(clk_100mhz, score, seg, dig);
	
	assign led[7:0] = ledMovementWire | randomLEDWire; 
	assign dig[3:0] = dig;

	
	
endmodule
