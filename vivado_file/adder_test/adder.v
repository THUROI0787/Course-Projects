module adder (
 input clk , // Clock
 input rst_n ,
 input [3:0] data_in1, // Asynchronous reset active low
 input [3:0] data_in2,
 output [3:0] data_out
);
 reg [3:0] data_out_q;
 assign data_out = data_out_q;
 always @(posedge clk or negedge rst_n) begin : proc_data_out
 if(~rst_n) begin
 data_out_q <= 0;
 end else begin
 data_out_q <= data_in1+data_in2;
 end
 end
endmodule