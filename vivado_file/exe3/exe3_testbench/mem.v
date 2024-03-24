`timescale 1ns / 1ps 

module mem
#(parameter MEM_SIZE = 2) //2^1
(
    input clk,
    input [15:0] addr, 
    input rd_en,
    input wr_en,
    output reg [31:0] rdata,
    input [31:0] wdata
    );
    
    
    reg [31:0] memData [MEM_SIZE:1]; //a big reg for instrcution/data

    
    always@(posedge clk)begin
     begin
            if(wr_en) memData[addr] <= wdata;
            if(rd_en)  rdata <=  memData[addr];
            else rdata<= 32'd0; 
        end
    end

endmodule
