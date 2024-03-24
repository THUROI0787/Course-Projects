module top (System_clk,BTND,BTNU, SW1,LED,LED0);
input System_clk,BTND,BTNU,SW1;
output LED,LED0;  //101011

reg [5:0] LED;
reg LED0;

initial
begin
LED=6'b0;
LED0=0;
end

debounce xdebounce(.clk(System_clk),.key_i(BTND),.key_o(clk_o));

always @(posedge clk_o or posedge BTNU)
begin

if(BTNU)
begin
LED=6'b0;
LED0=0;
end
else if(!BTNU) 
begin
LED={LED[4:0],SW1};
if(LED==6'b101011) LED0=1;
else LED0=0;
end

end

endmodule