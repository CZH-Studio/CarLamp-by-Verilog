module water_lamp(
    input clk,
    input rstL,
    input rstR,
    input rstBrake,
    input rstDoor,
    output reg [2:0] ledL,
    output reg [2:0] ledR,
    output reg [6:0] ledNum1,
    output reg [6:0] ledNum2,
    output reg [1:0] lit = 2'b11
);
reg [26:0]cnt;
reg [29:0]cntDoor;
reg stL = 1'b0;
reg stR = 1'b0;
reg stBrake = 1'b0;
reg stDoor = 1'b0;
reg doorcount = 1'b0;

//Ê±ÖÓ¿ØÖÆ
always@(posedge clk)
    begin
        if(cnt < 27'd1000_0000)
            cnt <= cnt + 1;
        else
            cnt <= 0;
    end
always@(posedge clk)
    begin
        if(cntDoor < 30'b1000_0000_0000_0000_0000_0000_0000_00 && rstDoor)
            cntDoor <= cntDoor + 1;
        else
            cntDoor <= 0;
    end
//µÆ¹â¿ØÖÆ
always@(posedge clk or posedge rstL or posedge rstR or posedge rstBrake or posedge rstDoor or negedge rstL or negedge rstR or negedge rstBrake or negedge rstDoor)
begin
    if(!rstL && !rstR && !rstBrake && !rstDoor) begin
        ledR <= 3'b000;
        ledL <= 3'b000;
        stL <= 1'b0;
        stR <= 1'b0;
        stBrake <= 1'b0;
        stDoor <= 1'b0;
        doorcount <= 1'b0;
        ledNum1 <= 7'b0110000; //ÓÒ²àÏÔÊ¾1
        ledNum2 <= 7'b0110000; //×ó²àÏÔÊ¾1
    end
    else if(rstL && !rstR && !rstBrake && !rstDoor)begin //×ó²à
        if(stL == 1'b1) begin
            if(cnt==27'd1000_0000)
                ledL<={ledL[1:0],ledL[2]};
            else
                ledL<=ledL;
        end
        else begin
            ledNum1 <= 7'b0111111; //×ó²àÏÔÊ¾0
            ledNum2 <= 7'b0110000; //ÓÒ²àÏÔÊ¾1
            ledL <= 3'b001;
            stL <= 1'b1;
        end
    end
    else if(!rstL && rstR && !rstBrake && !rstDoor) begin //ÓÒ²à
        if(stR == 1'b1) begin
            if(cnt==27'd1000_0000)
                ledR<={ledR[1:0],ledR[2]};
            else
                ledR<=ledR;
            end
        else begin
            ledNum1 <= 7'b0110000; //×ó²àÏÔÊ¾1
            ledNum2 <= 7'b0111111; //ÓÒ²àÏÔÊ¾0
            ledR <= 3'b001;
            stR <= 1'b1;
        end
    end
    else if(!rstL && !rstR && rstBrake && !rstDoor) begin //É²³µ
        if(stBrake == 1'b1) begin
            if(cnt==27'd1000_0000) begin //µÆÉÁË¸
                ledL <= ~ledL;
                ledR <= ~ledR;
            end
            else begin
                ledL <= ledL;
                ledR <= ledR;
            end
        end
        else begin
            ledNum1 <= 7'b1110011; //ÓÒ²àÏÔÊ¾P
            ledNum2 <= 7'b1110011; //×ó²àÏÔÊ¾P
            ledL <= 3'b111;
            ledR <= 3'b111;
            stBrake <= 1'b1;
        end 
    end
    else if(!rstL && !rstR && !rstBrake && rstDoor) begin //¿ªÃÅ
        if(doorcount == 1'b1) begin
            ledL <= 3'b000; //Ï¨Ãğ
            ledR <= 3'b000;
        end
        else if(doorcount == 1'b0 && stDoor == 1'b1) begin
            if(cntDoor==30'b1000_0000_0000_0000_0000_0000_0000_00)begin
                ledL <= 3'b000; //Ï¨Ãğ
                ledR <= 3'b000;
                stDoor <= 1'b0;
                doorcount <= 1'b1;
            end
            else begin
                ledL <= ledL;
                ledR <= ledR;
            end
        end
        else if(doorcount == 1'b0 && stDoor == 1'b0) begin
            ledNum1 <= 7'b1111001; //ÓÒ²àÏÔÊ¾E
            ledNum2 <= 7'b1111001; //×ó²àÏÔÊ¾E
            ledL <= 3'b111; //µãÁÁ
            ledR <= 3'b111;
            stDoor <= 1'b1;
        end
        else begin
            ledL <= 3'b000; //Ï¨Ãğ
            ledR <= 3'b000;
        end
   end 
   else begin
        ledR <= 3'b000;
        ledL <= 3'b000;
        stL <= 1'b0;
        stR <= 1'b0;
        stBrake <= 1'b0;
        stDoor <= 1'b0;
        doorcount <= 1'b0;
        ledNum1 <= 7'b0110000; //ÓÒ²àÏÔÊ¾1
        ledNum2 <= 7'b0110000; //×ó²àÏÔÊ¾1
    end
end
endmodule