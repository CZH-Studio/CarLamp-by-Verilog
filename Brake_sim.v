module brake_sim();
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
        rstBrake = 1'b1;
        end
endmodule