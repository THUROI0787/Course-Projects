module clk_gen(clk, reset, clk_1M);

input           clk;
input           reset;
output          clk_1M;

reg             clk_1M;

parameter   CNT = 16'd50000;

reg     [15:0]  count;

always @(posedge clk or posedge reset)
begin
    if(reset) begin
        clk_1M <= 1'b0;
        count <= 16'd0;
    end
    else begin
        count <= (count==CNT-16'd1) ? 16'd0 : count + 16'd1;
        clk_1M <= (count==16'd0) ? ~clk_1M : clk_1M;
    end
end

endmodule
