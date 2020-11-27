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
// Module Name:    sevenSegCounter 
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
    input [3:0] switch,
    output [7:0] seg,   
    output [3:0] dig   //selects digits 0-3, ACTIVE LOW
    );
  // next three lines turns the 7 seg display completely off
   
   assign dig = 4'b1110;  			//selectives digits 0-3, ACTIVE LOW
   assign seg[7] = 1'b1;
	
	wire Y0, Y1, Y2, Y3, Y4, Y5, D1, D2, D3, D4, C1, E1, E2, E3;
	

	and A1(Y0, ~switch[0], ~switch[2]);
	and A2(Y1, switch[0], switch[2]);
	or O1(Y2, switch[3], switch[1], Y0, Y1);
   not n1(seg[0], Y2);
	
	and A3(Y3, ~switch[1], ~switch[0]);
	and A4(Y4, switch[1], switch[0]);
	or O2(Y5, ~switch[2], Y4, Y3);
	not n2 (seg[1], Y5);
	
	//c
	or c1(C1, switch[3], switch[2],~switch[1], switch[0]);
	not C0(seg[2],C1);
	
	// XYZW:3210
	//d = x + zw' + y'w' + y'z + yz'w
	and d1(D1, switch[1], ~switch[0]);
	and d2(D2, ~switch[2], ~switch[0]);
	and d3(D3, ~switch[2], switch[1]);
	and d4(D4, switch[2], ~switch[1] , switch[0]);
	or d5(D5, switch[3], D1, D2, D3, D4);
	not d0(seg[3], D5);
	
	//e = zw' + y'z'w'
	and e1(E1, switch[1], ~switch[0]);
	and e2(E2, ~switch[2], ~switch[1], ~switch[0]);
	or e3(E3, E1, E2);
	not e0(seg[4], E3);
	
	//f = x + z'w' + yw' + yz'
	and f1(F1, ~switch[1], ~switch[0]);
	and f2(F2, switch[2], ~switch[0]);
	and f3(F3, switch[2], ~switch[1]);
	or f4(F4, switch[3], F1, F2, F3);
	not f0(seg[5], F4);
	
	//g = x + yz' + yw' + x'y'z
	and g1(G1, switch[2], ~switch[1]);
	and g2(G2, switch[2], ~switch[0]);
	and g3(G3, ~switch[3], ~switch[2], switch[1]);
	or g4(G4, switch[3], G1, G2, G3);
	not g0(seg[6], G4);
	
	
	
 
endmodule

