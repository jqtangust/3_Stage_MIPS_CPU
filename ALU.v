`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 14:03:07
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    clk,
    reset,
    Num1,
    Num2,
    ALUre,
    Zero,
    EDR,
    extra,
    ALUop
    );

input clk;  
input reset;

input [5:0] ALUop;   
input [31:0] Num1;
input [31:0] Num2;


output reg [31:0] ALUre;
output reg extra;
output reg Zero;
output reg EDR;

reg [31:0] HI;
reg [31:0] LO;
reg [63:0] HL;


parameter NOP=6'b000000;
parameter ADD=6'b000001;
parameter ADDU=6'b000010;
parameter SUB=6'b000011;
parameter SUBU=6'b000100;
parameter ADDI=6'b000101;
parameter ADDIU=6'b000111;
parameter SLT=6'b001000;
parameter SLTU=6'b001001;
parameter SLTI=6'b001010;
parameter SLTUI=6'b001011;
parameter DIV=6'b001100;
parameter DIVU=6'b001101;
parameter MULT=6'b001110;
parameter MULTU=6'b001111;
parameter AND=6'b010000;
parameter ANDI=6'b010001;
parameter LUI=6'b010010;
parameter NOR=6'b010011;
parameter OR=6'b010100;
parameter ORI=6'b010101;
parameter XOR=6'b010110;
parameter XORI=6'b010111;

parameter SLL=6'b011000;
parameter SLLV=6'b011001;
parameter SRA=6'b011010;
parameter SRAV=6'b011011;
parameter SRL=6'b011100;
parameter SRLV=6'b011101;

parameter BEQ=6'b100000;
parameter BNE=6'b100001;
parameter BGEZ =6'b100010;
parameter BGTZ=6'b100011;
parameter BLEZ=6'b100100;
parameter BLTZ=6'b100101;
parameter BLTZAL=6'b100110;
parameter BGEZAL=6'b100111;



parameter MFHI=6'b110010;
parameter MFLO=6'b110011;

parameter MTHI=6'b110000;
parameter MTLO=6'b110001;

parameter LB=6'b101000;
parameter LBU=6'b101001;
parameter SB=6'b101010;

parameter LH=6'b111000;
parameter LHU=6'b111001;
parameter LW=6'b111010;
parameter SH=6'b111011;
parameter SW=6'b111100;


wire bias=32'h00000000;

always@(posedge clk)
begin
    if(!reset)
    begin
        HI=0;
        LO=0;
        HL=0;
    end
    case (ALUop)

        DIV:  
        begin
        HI=($signed(Num1))%($signed(Num2)); 
        LO=$signed(Num1)/$signed(Num2);
        end
        
        DIVU: 
        begin
        HI=Num1%Num2; LO=Num1/Num2;
        end
        
        MULT: 
        begin
        HL=$signed(Num1)*$signed(Num2);
        HI=HL[63:32];
        LO=HL[31:0];
        end
        
        MULTU:
        begin
        HL=Num1*Num2;
        HI=HL[63:32];
        LO=HL[31:0];
        end

                
        MTHI:HI=Num1;
        MTLO:LO=Num1;

    endcase

end

always@(*)

begin


    ALUre=0;
    extra=0;
    Zero=0;
    EDR=0;


case(ALUop)

    NOP:ALUre=Num2;
    
    ADD:
    begin
    ALUre=Num1+Num2;
    // ï¿½ï¿½ï¿½ï¿½Ð¶ï¿???
    extra=((~(Num1[31]^Num2[31]))&(ALUre[31]^Num1[31]));
    end

    
    ADDU:ALUre=Num1+Num2;
    
    SUB:
    begin
    ALUre=Num1-Num2;
    // ï¿½ï¿½ï¿½ï¿½Ð¶ï¿???
    extra=(Num1[31]^Num2[31]) & (Num1[31]^ALUre[31]) ;
    end


    SUBU:ALUre=Num1-Num2;

    ADDI:
    begin
    ALUre=Num1+Num2;
    extra=((~(Num1[31]^Num2[31]))&(ALUre[31]^Num1[31]));
    end

        

    ADDIU:ALUre=Num1+Num2;
    
    SLT:  ALUre=($signed(Num1) < $signed(Num2)) ? 1:0;
    SLTU:  ALUre=(Num1 < Num2) ? 1:0;
    SLTI:  ALUre=($signed(Num1) < $signed(Num2)) ? 1:0;
    SLTUI:  ALUre=(Num1 < Num2) ? 1:0;
    

    AND: ALUre=Num1 & Num2;

    ANDI:
    begin
        ALUre=Num1 & {16'b0,Num2[15:0]};
    end

    LUI: ALUre=Num2 << 16; 
    NOR: ALUre=~(Num1 | Num2);
    OR:  ALUre=Num1 | Num2;

    ORI:
    begin
        ALUre=Num1 | {16'b0,Num2[15:0]} ;
    end 

    XOR: ALUre=Num1 ^ Num2;

    XORI:
    begin
        ALUre=Num1 ^ {16'b0,Num2[15:0]};
    end
    
    SLL: ALUre=Num2 << Num1;
    SLLV:ALUre=Num2 << Num1[4:0];
    SRA: ALUre=$signed(Num2) >>> Num1;
    SRAV:ALUre=$signed(Num2) >>> Num1[4:0];
    SRL: ALUre=Num2 >> Num1;
    SRLV:ALUre=Num2 >> Num1[4:0];


    BEQ:
    begin
    Zero=(Num1==Num2) ? 1:0;
    end  

    BNE:
    begin
    Zero=(Num1!=Num2) ? 1:0;
    end

    BGEZ:
    begin
        Zero=($signed(Num1)>=0) ? 1:0;
    end

    BGTZ:
    begin

        Zero=($signed(Num1)>0) ? 1:0;
    end
    BLEZ:
    begin

        Zero=($signed(Num1)<=0) ? 1:0;
    end
    BLTZ:
    begin

        Zero=($signed(Num1)<0) ? 1:0;
    end   

    BLTZAL:
    begin
        Zero=($signed(Num1)<0) ? 1:0;
    end  
    BGEZAL:
    begin
        Zero=($signed(Num1)>=0) ? 1:0;
    end

    

        
    MFHI:ALUre=HI;
    MFLO:ALUre=LO;
    


    LB:
    begin
        ALUre=Num1+Num2;
        ALUre=(ALUre[31:28]==4'ha || ALUre[31:28]==4'hb)?ALUre-32'ha0000000:ALUre;
    end
    
    LBU:
    begin
        ALUre=Num1+Num2;
        ALUre=(ALUre[31:28]==4'ha || ALUre[31:28]==4'hb)?ALUre-32'ha0000000:ALUre;
    end
    


    LH:
    begin
    ALUre=Num1+Num2;
    ALUre=(ALUre[31:28]==4'ha || ALUre[31:28]==4'hb)?ALUre-32'ha0000000:ALUre;
    EDR=(ALUre%2!=0)?1:0;
    end
    
    LHU:
    begin
    ALUre=Num1+Num2;
    ALUre=(ALUre[31:28]==4'ha || ALUre[31:28]==4'hb)?ALUre-32'ha0000000:ALUre;
    EDR=((ALUre%2)!=0)?1:0;
    end
    
    LW:
    begin
    ALUre=Num1+Num2;
    ALUre=(ALUre[31:28]==4'ha || ALUre[31:28]==4'hb)?ALUre-32'ha0000000:ALUre;
    EDR=((ALUre%4)!=0)?1:0;
    end

    
    SB:
    begin
    ALUre=Num1+Num2;
    ALUre=(ALUre[31:28]==4'ha || ALUre[31:28]==4'hb)?ALUre-32'ha0000000:ALUre;
    end

    SH:
    begin
    ALUre=Num1+Num2;
    ALUre=(ALUre[31:28]==4'ha || ALUre[31:28]==4'hb)?ALUre-32'ha0000000:ALUre;
    EDR=((ALUre%2)!=0)?1:0;
    end
    
    SW:
    begin
    ALUre=Num1+Num2;
    ALUre=(ALUre[31:28]==4'ha || ALUre[31:28]==4'hb)?ALUre-32'ha0000000:ALUre;
    EDR=(ALUre%4!=0)?1:0;
    end



    
endcase




end           
        
    
endmodule

