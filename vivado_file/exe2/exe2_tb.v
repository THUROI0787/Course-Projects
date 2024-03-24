`timescale 1ns/1ps
module exe2_tb_simple();

reg sysclk,BTND,BTNU,swi;
wire [3:0] AN;
wire LED;
wire [7:0] leds;

 // Generate the clock
 initial begin
 forever
 #5 sysclk = ~sysclk;
 end

top i_top(
    .sysclk (sysclk),
    .BTND (BTND),
    .BTNU (BTNU),
    .swi (swi),
    .AN (AN), //out4
    .leds (leds), //out8
    .LED (LED) //out1
);


 initial begin
 // Initialization
 sysclk=0; BTND=0; BTNU=0; swi=1;

 // Reset the DUT
 #100
 BTNU=1; //initial
 #100
 BTNU=0; //wait for 10^6ns
 #100000
 BTND=1; //no use
 #100
 BTND=0;

 #1000
 BTNU=1;
 #100
 BTNU=0;
 #1333300 //right
 BTND=1;
 #100
 BTND=0;

 #1000
 BTNU=1;
 #100
 BTNU=0;
 #2500000 //end;no use
 BTND=1;
 #100
 BTND=0;
 
 #10000;
 $finish;
end
endmodule