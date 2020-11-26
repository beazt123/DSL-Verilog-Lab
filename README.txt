Top level module is lab3part1.

Modules:

randomLED: randomly lights up an LED
movementOfLED: Moves the snake across the LEDs
sevenSegCounter: Takes in a 4-bit input and lights the 7-segment display accordingly from 0-9(our lab 2 code)

The above modules are all tested and works.
The only module that doesn't work well is:

calcScore: 
Reads the output of randomLED & movementOfLED and adds 1 to a counter everytime they are identical(i.e. both light up the 3rd LED, which means the snake has eaten the rabbit)
after that, will attempt to "turn off" the randomLED output.
Counter resets after score of 9.

git remote add origin https://github.com/beazt123/DSL-Verilog-Lab.git
