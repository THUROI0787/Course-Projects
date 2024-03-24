module top (sysclk,BTND,BTNU,LED,leds,AN,swi); //BTNU复位
input sysclk,BTND,BTNU,swi;
output [3:0] AN;
output [7:0] leds;
output LED;

wire [7:0] leds;
wire [3:0] AN;
wire [3:0] A,B,C,D;
wire FLA;
reg Flag1,Flag2; 
reg [3:0] a,b,c,d; //分别代表从右到左的四位数
reg b1,c1;//二、三位的进位信号
reg [13:0] temp; //复位后的1s计时

assign A=a;
assign B=b;
assign C=c;
assign D=d;
assign LED=Flag1&&!Flag2;
assign FLA=Flag2;

always @(posedge CLK_10M or posedge BTND or posedge BTNU)   //test!!
begin

if(BTNU) begin
Flag1=0;Flag2=0;a=0;b=0;c=0;d=0;b1=0;c1=0;temp=0;
end

else if (!BTNU) begin


if(temp==14'd10000) Flag1=1;  //test!!
else temp=temp+1;


if(Flag1&&BTND) Flag2=1; 

else if(Flag1&&!BTND) begin
if(!Flag2) begin


if((a==4'd9)&&(b==4'd9)&&(c==4'd9)&&(d==4'd9)) a=4'd9;
else a=(a==4'd9)?(4'd0):(a+1);

if((b==4'd9)&&(c==4'd9)&&(d==4'd9)) b=4'd9;
else if(a==4'd0) begin
if(b==4'd9) begin b=4'd0;b1=1;end
else b=b+1;
end else;

if((c==4'd9)&&(d==4'd9)) c=4'd9;
else if(b1==1) begin
if(c==4'd9) begin c=4'd0;b1=0;c1=1;end
else begin c=c+1;b1=0; end
end else;

if(c1==1)begin
if(d!=4'd9) begin d=d+1;c1=0;end else;
end else;


end 
else; 

end 
else;
 


end 

end

clk_gen hyw1(sysclk, BTNU, CLK_1M); //分频1MHz
clk_gen2 hyw2(sysclk, BTNU, CLK_10M); //分频10MHz
BCD7 bcd27seg (FLA,swi,CLK_1M,A,B,C,D,leds,AN);

endmodule