`timescale 1ns/1ps
`define PERIOD 10
module adder_tb_simple();
 reg clk ;
 reg rst_n;
 reg [3:0] data_in1;
 reg [3:0] data_in2;
 wire [3:0] data_out;
 // Generate the clock
 initial begin
 forever
 #(`PERIOD/2) clk = ~clk;
 end
 // Adder Instance
 adder i_adder (
 .clk (clk ),
 .rst_n (rst_n ),
 .data_in1(data_in1),
 .data_in2(data_in2),
 .data_out(data_out)
 );
 initial begin
 // Initialization
 rst_n = 1'b1;
 clk = 1'b0;
 data_in1 = 4'b0;
 data_in2 = 4'b0;
 // Reset the DUT
 #(`PERIOD*5)
 rst_n = 1'b0;
 #(`PERIOD*5)
 rst_n = 1'b1;
 #(`PERIOD)
 data_in1 = 4'b1110;
 data_in2 = 4'b0010;
 #(`PERIOD)
 data_in2 = 4'b0100;
 #(`PERIOD)
 data_in1 = 4'b0001;
 // ......
 #(`PERIOD*2);
 $finish;
 end
endmodule