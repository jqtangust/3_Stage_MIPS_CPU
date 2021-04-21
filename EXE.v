`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 14:15:53
// Design Name: 
// Module Name: EXE
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


module EXE(

    input clk,
    input reset,
    input [31:0] iPC2,
    input [31:0] iBusA,
    input [31:0] iBusB,
    input [4:0] isa,
    input [31:0] iimm,
    input [4:0] irt,
    input [4:0] ird,
    input [27:0] iinstr,

    input iALUSrc,
    input [5:0] iALUop,
    input iMENWr1,
    input [3:0] iMENWr2,
    input [1:0] iPCMEMRegCP0,
    input iPCSc1,
    input iRegWr,
    input iscon,
    input iJ,
    input iJcol,
    input iBS,
    input iERET,
    input iMFC0,
    input iCP0Wr,

    input [1:0] iRegdst,
    input [31:0] iinstruction,

    input iPCError2,
    input iNOT_EXIST,


    output [31:0] oPC2,
    output [31:0] oBusA,
    output [31:0] oBusB,
    output [31:0] osa,
    output [31:0] oimm,
    output [4:0] ort,
    output [4:0] ord,
    output [27:0] oinstr,

    output oALUSrc,
    output [5:0] oALUop,
    output oMENWr1,
    output [3:0] oMENWr2,
    output [1:0] oPCMEMRegCP0,
    output oPCSc1,
    output oRegWr,
    output oscon,
    output oJ,
    output oJcol,
    output oBS,
    output oERET,
    output oMFC0,
    output [1:0] oRegdst,

    output [31:0] oinstruction,

    
    output oPCError2,


    output [2:0] sel,

    output oNOT_EXIST

    

    );

    reg [31:0] PC2;
    reg [31:0] BusA;
    reg [31:0] BusB;
    reg [4:0] sa;
    reg [31:0] imm;
    reg [4:0] rt;
    reg [4:0] rd;
    reg [27:0] instr;

    reg ALUSrc;
    reg [5:0] ALUop;
    reg MENWr1;
    reg [3:0] MENWr2;
    reg [1:0] PCMEMRegCP0;
    reg PCSc1;
    reg RegWr;
    reg scon;
    reg J;
    reg Jcol;
    reg BS;
    reg ERET;
    reg MFC0;
    
    reg [1:0] Regdst;

    reg [31:0] instruction;

    reg PCError2;

    reg NOT_EXIST;

    

    assign oPC2=PC2;
    assign oBusA=BusA;

    assign oBusB=BusB;
    assign osa={27'b0,sa};
    assign oimm=imm;
    assign ort=rt;
    assign ord=rd;
    assign oinstr=instr;

    assign oALUSrc=ALUSrc;
    assign oALUop=ALUop;
    assign oMENWr1=MENWr1;
    assign oMENWr2=MENWr2;
    assign oPCMEMRegCP0=PCMEMRegCP0;
    assign oPCSc1=PCSc1;
    assign oRegWr=RegWr;
    assign oscon=scon;
    assign oJ=J;
    assign oJcol=Jcol;
    assign oBS=BS;
    assign oERET=ERET;
    assign oMFC0=MFC0;

    assign oRegdst=Regdst;

    assign oinstruction=instruction;

    assign oPCError2=PCError2;


    assign sel=instruction[2:0];

    assign oNOT_EXIST=NOT_EXIST;

    



always@(posedge clk)

begin

    if(!reset)
    begin
        PC2=0;
        BusA=0;
        BusB=0;
        sa=0;
        imm=0;
        rt=0;
        rd=0;
        instr=0;

        ALUSrc=0;
        ALUop=0;
        MENWr1=0;
        MENWr2=0;
        PCMEMRegCP0=0;
        PCSc1=0;
        RegWr=0;
        scon=0;
        J=0;
        Jcol=0;
        BS=0;
        ERET=0;
        MFC0=0;
        Regdst=0;
        instruction=0;
        PCError2=0;
        NOT_EXIST=1;


    end


    PC2<=iPC2;
    BusA<=iBusA;
    BusB<=iBusB;
    sa<=isa;
    imm<=iimm;
    rt<=irt;
    rd<=ird;
    instr<=iinstr;

    ALUSrc<=iALUSrc;
    ALUop<=iALUop;
    MENWr1<=iMENWr1;
    MENWr2<=iMENWr2;
    PCMEMRegCP0<=iPCMEMRegCP0;
    PCSc1<=iPCSc1;
    RegWr<=iRegWr;
    scon<=iscon;
    J<=iJ;
    Jcol<=iJcol;
    BS<=iBS;
    ERET<=iERET;
    MFC0<=iMFC0;

    Regdst<=iRegdst;
    instruction<=iinstruction;

    PCError2<=iPCError2;

    NOT_EXIST=iNOT_EXIST;

    

end

endmodule
