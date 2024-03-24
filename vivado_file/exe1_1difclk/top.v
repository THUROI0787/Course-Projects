module top (System_clk,BTND,an,ano, SW0, leds);
input System_clk,BTND,SW0;
input [3:0] an;
output [3:0] ano;
output [6:0] leds;

wire [6:0] leds;
assign ano=an;

reg [3:0] Res;

initial
begin
Res=0;
end

debounce xdebounce(.clk(System_clk),.key_i(BTND),.key_o(clk_o));

always @(posedge clk_o or posedge SW0)
begin
if (!SW0) Res=0;
else if (SW0)
  begin
  if (Res<4'h9)
    Res=(Res+1);
  else if (Res==4'h9)
    Res=4'h0;
  end
end

BCD7 bcd27seg (Res,leds);

endmodule