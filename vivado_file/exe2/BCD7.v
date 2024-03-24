module BCD7(FLA,swi,clk,A,B,C,D,dout,anout); 
input clk,swi,FLA;
input [3:0] A,B,C,D;
output reg [7:0] dout;
output reg [3:0] anout;

//reg [15:0]din;
reg [1:0] num; 

reg [3:0] print;

always @(posedge clk)
begin

if(swi) begin
case(num)
2'd0:begin print=A;anout=4'b1110;dout[7]=1; num=2'd1;end
2'd1:begin print=B;anout=4'b1101;dout[7]=0; num=2'd2;end
2'd2:begin print=C;anout=4'b1011;dout[7]=1; num=2'd3;end
2'd3:begin print=D;anout=4'b0111;dout[7]=1; num=2'd0;end
default:begin print=A;anout=4'b1110;dout[7]=1; num=2'd1;end
endcase

case(print)
4'd0:dout[6:0]=7'b1000000;
4'd1:dout[6:0]=7'b1111001;
4'd2:dout[6:0]=7'b0100100;
4'd3:dout[6:0]=7'b0110000;
4'd4:dout[6:0]=7'b0011001;
4'd5:dout[6:0]=7'b0010010;
4'd6:dout[6:0]=7'b0000010;
4'd7:dout[6:0]=7'b1111000;
4'd8:dout[6:0]=7'b0;
4'd9:dout[6:0]=7'b0010000;
default:dout=8'b11111111; 
endcase
end

else begin
if (!FLA) anout=4'b1111;
else begin
case(num)
2'd0:begin print=A;anout=4'b1110;dout[7]=1; num=2'd1;end
2'd1:begin print=B;anout=4'b1101;dout[7]=0; num=2'd2;end
2'd2:begin print=C;anout=4'b1011;dout[7]=1; num=2'd3;end
2'd3:begin print=D;anout=4'b0111;dout[7]=1; num=2'd0;end
default:begin print=A;anout=4'b1110;dout[7]=1; num=2'd1;end
endcase

case(print)
4'd0:dout[6:0]=7'b1000000;
4'd1:dout[6:0]=7'b1111001;
4'd2:dout[6:0]=7'b0100100;
4'd3:dout[6:0]=7'b0110000;
4'd4:dout[6:0]=7'b0011001;
4'd5:dout[6:0]=7'b0010010;
4'd6:dout[6:0]=7'b0000010;
4'd7:dout[6:0]=7'b1111000;
4'd8:dout[6:0]=7'b0;
4'd9:dout[6:0]=7'b0010000;
default:dout=8'b11111111; 
endcase
end
end

end
endmodule