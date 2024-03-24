module top (System_clk,BTND,BTNU,SW1,LED,LED0);
input System_clk,BTND,BTNU,SW1;
output LED,LED0;  //101011

    reg [2:0] LED;
    reg LED0;

initial
begin
LED=3'b0;
LED0=0;
end

debounce xdebounce(.clk(System_clk),.key_i(BTND),.key_o(clk_o));

always @(posedge clk_o or posedge BTNU)
begin

    if(BTNU) begin
        LED=3'b0;
        LED0=0;end
    else if(!BTNU)
        begin
            case(LED)
                3'h0: LED=(SW1?3'h1:3'h0);
      			3'h1: begin
                    LED0=0;LED=((!SW1)?3'h2:3'h1);end
 				3'h2: LED=(SW1?3'h3:3'h0);
  				3'h3: LED=((!SW1)?3'h4:3'h1);
  				3'h4: LED=(SW1?3'h5:3'h0);
 			    3'h5:begin
                    if(SW1)begin
                        LED=3'h1;LED0=1;end
                    else LED=3'h4;end
                default:;
            endcase
        end

end

endmodule