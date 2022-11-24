`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/22 08:08:36
// Design Name: 
// Module Name: car_sim
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


module left_sim();
reg clk;
reg rstL;
reg rstR;
reg rstBrake;
reg rstDoor;
wire [2:0] ledL;
wire [2:0] ledR;
wire [6:0] ledNum1;
wire [6:0] ledNum2;

water_lamp u0(
    .clk(clk),
    .rstL(rstL),
    .ledL(ledL),
    .rstR(rstR),
    .ledR(ledR),
    .rstBrake(rstBrake),
    .rstDoor(rstDoor),
    .ledNum1(ledNum1),
    .ledNum2(ledNum2)
    );
parameter CYCLE = 10;
always # (CYCLE)clk=~clk;
    initial
        begin
        clk = 1'b0;
        rstL = 1'b0;
        rstR = 1'b0;
        rstDoor = 1'b0;
        rstBrake = 1'b0;
        #100;
        rstL = 1'b1;
        end
endmodule
