module clk_gen2(clk, reset, clk_10M); //·ÖÆµ10MHz

input           clk;
input           reset;
output          clk_10M; 

reg             clk_10M;

parameter   CNT = 13'd5000;

reg     [12:0]  count;

always @(posedge clk or posedge reset)
begin
    if(reset) begin
        clk_10M <= 1'b0;
        count <= 13'd0;
    end
    else begin
        count <= (count==CNT-13'd1) ? 13'd0 : count + 13'd1;
        clk_10M <= (count==13'd0) ? ~clk_10M : clk_10M;
    end
end

endmodule
