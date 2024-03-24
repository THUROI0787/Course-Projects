`timescale 1ns / 1ps

module ALU(input wire [4:0] ALUCtrl,
           input wire Sign,
           input wire [31:0]in1,
           input wire [31:0]in2,
           output reg [31:0]out,
           output wire zero);
    parameter ADDS  = 6'b0000_01; 
    parameter ADDU  = 6'b0000_00;
    parameter SUBS  = 6'b0000_11;
    parameter SUBU  = 6'b0000_10;
    parameter AND   = 6'b0001_00; //逻辑运算符号置零
    parameter OR    = 6'b0001_10;
    parameter XOR   = 6'b0010_00;
    parameter NOR   = 6'b0010_10;
    parameter SLL   = 6'b0011_00;
    parameter SRL   = 6'b0011_10;
    parameter SRA   = 6'b0100_00; //移位位数无符号
    parameter SLTS  = 6'b0100_11;
    parameter SLTU  = 6'b0101_01;
    parameter BEQ   = 6'b0101_11;
    parameter LUI   = 6'b0110_00; //LUI无符号
    parameter OTHER = 6'b1111_11;

    assign zero = (out == 32'b0)?1'b1:1'b0;

    always @(*) begin
        case({ALUCtrl[4:0],Sign})
        ADDS: out = $signed(in1) + $signed(in2); //有符号
        ADDU: out = in1 + in2;
        SUBS:out = $signed(in1) - $signed(in2);
        SUBU:out = in1 - in2;
        AND: out = in1 & in2;
        OR : out = in1 | in2;
        XOR: out = in1 ^ in2;
        NOR: out = ~(in1 | in2);
        SLL: out = in1 << in2;
        SRL: out = in1 >> in2;
        SRA: out = in1 >>> in2;
        SLTS: out = ($signed (in1) < $signed(in2) )?32'b1:32'b0;
        SLTU: out = (in1 < in2)?32'b1:32'b0;
        BEQ: out = (in1 == in2)?32'b0:32'b1;  
        LUI: out = in2 << 16;
        OTHER: ;
        default: ;
        endcase
    end
endmodule
