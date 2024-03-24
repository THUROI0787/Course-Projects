module ALUControl (
    input wire [5:0] OpCode,
    input wire [5:0] Funct,
    output reg  [4:0] ALUCtrl,
    output reg Sign
);
parameter ADDS = 6'b0000_01;
parameter ADDU = 6'b0000_00;
parameter SUBS = 6'b0000_11;
parameter SUBU = 6'b0000_10;
parameter AND = 6'b0001_00; //逻辑运算符号置零
parameter OR = 6'b0001_10;
parameter XOR = 6'b0010_00;
parameter NOR = 6'b0010_10;
parameter SLL = 6'b0011_00;
parameter SRL = 6'b0011_10;
parameter SRA = 6'b0100_00; //移位位数无符号
parameter SLTS = 6'b0100_11;
parameter SLTU = 6'b0101_01;
parameter BEQ = 6'b0101_11;
parameter LUI = 6'b0110_00; //LUI无符号
parameter OTHER = 6'b1111_11; //another bit for others

    always @(*) begin
        case (OpCode)
            6'h23: {ALUCtrl[4:0],Sign} = ADDS;
            6'h2b: {ALUCtrl[4:0],Sign} = ADDS;
            6'h0f: {ALUCtrl[4:0],Sign} = LUI;
            6'h08: {ALUCtrl[4:0],Sign} = ADDS;
            6'h09: {ALUCtrl[4:0],Sign} = ADDU;
            6'h0c: {ALUCtrl[4:0],Sign} = AND;
            6'h0a: {ALUCtrl[4:0],Sign} = SLTS;
            6'h0b: {ALUCtrl[4:0],Sign} = SLTU;
            6'h04: {ALUCtrl[4:0],Sign} = ADDS;
            6'h00:begin
                case(Funct)
                6'h20: {ALUCtrl[4:0],Sign} = ADDS;
                6'h21: {ALUCtrl[4:0],Sign} = ADDU;
                6'h22: {ALUCtrl[4:0],Sign} = SUBS;
                6'h23: {ALUCtrl[4:0],Sign} = SUBU;
                6'h24: {ALUCtrl[4:0],Sign} = AND;
                6'h25: {ALUCtrl[4:0],Sign} = OR;
                6'h26: {ALUCtrl[4:0],Sign} = XOR;
                6'h27: {ALUCtrl[4:0],Sign} = NOR;
                6'h00: {ALUCtrl[4:0],Sign} = SLL;
                6'h02: {ALUCtrl[4:0],Sign} = SRL;
                6'h03: {ALUCtrl[4:0],Sign} = SRA;
                6'h2a: {ALUCtrl[4:0],Sign} = SLTS;
                6'h2b: {ALUCtrl[4:0],Sign} = SLTU;
                default: {ALUCtrl[4:0],Sign} = OTHER;
                endcase
            end
            default: {ALUCtrl[4:0],Sign} = OTHER;
        endcase
    end
endmodule