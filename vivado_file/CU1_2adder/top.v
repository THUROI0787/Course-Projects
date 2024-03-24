module top (BTNU,I,contr,Y);
input BTNU;
input [31:0] I;  // 8*4bits
input [5:0] contr; //M2M1M0m2m1m0 
output wire [7:0] Y; //??

wire [4:0] adder5[3:0];
wire [5:0] adder6[1:0];
wire [3:0] choo[7:0]; //input after choosing
reg [7:0] enable; //enable signal
wire [2:0] M,m;
wire flag;

integer k;

genvar j;
generate
    for (j=0; j<=7; j=j+1)
    begin
      assign choo[j]=enable[j]?I[4*j+3:4*j]:4'b0;
    end
endgenerate

genvar i;
generate
    for (i=0; i<=3; i=i+1)
    begin
      assign adder5[i]=choo[2*i]+choo[2*i+1];
    end
endgenerate

assign adder6[0]=adder5[0]+adder5[1];
assign adder6[1]=adder5[2]+adder5[3];
assign Y=adder6[0]+adder6[1];
assign flag=(contr[5:3]==contr[2:0])?0:1; 
assign M=(contr[5:3]>contr[2:0])?contr[5:3]:contr[2:0]; //bigger
assign m=(contr[5:3]<contr[2:0])?contr[5:3]:contr[2:0]; //smaller

always @(*) 
begin
  if(BTNU) enable=8'b0;
  else begin
    if(!flag)
    begin
      case(contr[5:3])//M
      3'b000:enable=8'b00000001; //??
      3'b001:enable=8'b00000010;
      3'b010:enable=8'b00000100;
      3'b011:enable=8'b00001000;
      3'b100:enable=8'b00010000;
      3'b101:enable=8'b00100000;
      3'b110:enable=8'b01000000;
      3'b111:enable=8'b10000000;
      endcase
    end
    else begin
      for (k=0;k<=7;k=k+1)
        enable[k]=((k>=m)&&(k<=M))?1:0;
    end
  end
end

endmodule