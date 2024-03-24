`timescale 1ns/1ps
`define CPB 104170
module exe3_tb_simple();

reg sysclk,BTNU,SW0;
reg Rx;
wire recv_done;
wire send_done;
wire Tx_Serial;

 // Generate the clock
 initial begin
 forever
 #5 sysclk = ~sysclk;
 end

UART_MEM i_UART_MEM(
    .clk (sysclk),
    .rst (BTNU),
    .mem2uart (SW0),
    .recv_done (recv_done), 
    .send_done (send_done), 
    .Rx_Serial (Rx),
    .Tx_Serial (Tx_Serial)
);


 initial begin
 // Initialization
 sysclk=0; BTNU=0;SW0=0; Rx=1;

 // Reset the DUT
 #100
 BTNU=1; //initial
 #100
 BTNU=0; 
 #1000

 Rx=0;      //1
 #(`CPB)
 Rx=1; 
 #(`CPB)
 Rx=0; 
 #(`CPB*7)
 Rx=1; 
 #(`CPB)
 Rx=0;      //2
 #(`CPB*2)
 Rx=1; 
 #(`CPB)
 Rx=0; 
 #(`CPB*6)
 Rx=1; 
 #(`CPB)
 Rx=0;       //3
 #(`CPB)
 Rx=1; 
 #(`CPB*2)
 Rx=0; 
 #(`CPB*6)
 Rx=1; 
 #(`CPB)
 Rx=0;       //4
 #(`CPB*3)
 Rx=1; 
 #(`CPB)
 Rx=0; 
 #(`CPB*5)
 Rx=1; 
 #(`CPB)
 
 Rx=0;       //4
 #(`CPB*3)
 Rx=1; 
 #(`CPB)
 Rx=0; 
 #(`CPB*5)
 Rx=1; 
 #(`CPB)
 Rx=0;       //3
 #(`CPB)
 Rx=1; 
 #(`CPB*2)
 Rx=0; 
 #(`CPB*6)
 Rx=1; 
 #(`CPB)
 Rx=0;      //2
 #(`CPB*2)
 Rx=1; 
 #(`CPB)
 Rx=0; 
 #(`CPB*6)
 Rx=1; 
 #(`CPB)
 Rx=0;      //1
 #(`CPB)
 Rx=1; 
 #(`CPB)
 Rx=0; 
 #(`CPB*7)
 Rx=1; 
 #(`CPB)
 
///////////////

 Rx=0;      //0
 #(`CPB*9)
 Rx=1; 
 #(`CPB)
 Rx=0;      //1
 #(`CPB)
 Rx=1; 
 #(`CPB)
 Rx=0; 
 #(`CPB*7)
 Rx=1; 
 #(`CPB)
 Rx=0;      //2
 #(`CPB*2)
 Rx=1; 
 #(`CPB)
 Rx=0; 
 #(`CPB*6)
 Rx=1; 
 #(`CPB)
 Rx=0;       //3
 #(`CPB)
 Rx=1; 
 #(`CPB*2)
 Rx=0; 
 #(`CPB*6)
 Rx=1; 
 #(`CPB)
 
 Rx=0;       //4
 #(`CPB*3)
 Rx=1; 
 #(`CPB)
 Rx=0; 
 #(`CPB*5)
 Rx=1; 
 #(`CPB)
 Rx=0;       //5
 #(`CPB)
 Rx=1; 
 #(`CPB)
 Rx=0; 
 #(`CPB)
 Rx=1; 
 #(`CPB)
 Rx=0; 
 #(`CPB*5)
 Rx=1; 
 #(`CPB)
 Rx=0;       //6
 #(`CPB*2)
 Rx=1; 
 #(`CPB*2)
 Rx=0; 
 #(`CPB*5)
 Rx=1; 
 #(`CPB)
 Rx=0;       //7
 #(`CPB)
 Rx=1; 
 #(`CPB*3)
 Rx=0; 
 #(`CPB*5)
 Rx=1; 
 #(`CPB)

 #2000000
 SW0=1;
 #(`CPB*260)
 
 #10000;
 BTNU=1;
 #100
 BTNU=0; 
 #10000
 $finish;
end
endmodule