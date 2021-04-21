`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 21:01:17
// Design Name: 
// Module Name: Decode
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0;.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Decode(
    input [31:0] ins,
    input [31:0] address,
    
    output reg ALUSrc,
    output reg [5:0] ALUOp,
    output reg MEMWr1,
    output reg [3:0] MEMWr2,
    output reg [1:0] PCMEMReg,
    output reg PCSc1,
    output reg RegWr,
    output reg Scon,
    output reg J,
    output reg Jcol,
    output reg BS,
    output reg ERET,
    output reg MFC0,
    output reg [1:0] RegDst,

    output reg NOT_EXIST

    );




    always@(*)
    begin
            ALUSrc=0;
            ALUOp=0;
            MEMWr1=0;
            MEMWr2=0;
            PCMEMReg=2'b00;
            PCSc1=0;
            RegWr=0;
            Scon=0;
            J=0;
            Jcol=0;
            BS=0;
            ERET=0;
            MFC0=0;
            RegDst=0;
            NOT_EXIST=1;
            

        if(ins[31:26]==6'b000000)
        begin
            // if(ins[5:0]==6'b000000)//NOP
            // begin
                
            // // end
            // if (ins == 0) begin
            //     RegWr = 0;
            // end
            // else if begin 
            //     RegWr = 1;

            // end 


             if(ins[5:0]==6'b100000)//ADD
            begin
                PCMEMReg=2'b10;
                RegWr=1;
                RegDst=2'b01;
                ALUOp=6'b000001;
            end

            else if(ins[5:0]==6'b100001)//ADDU
            begin
                PCMEMReg=2'b10;
                RegWr=1;
                RegDst=2'b01;
                ALUOp=6'b000010;
            end
            else if(ins[5:0]==6'b100010)//SUB
            begin
                PCMEMReg=2'b10;
                RegWr=1;
                RegDst=2'b01;
                ALUOp=6'b000011;

            end
            else if(ins[5:0]==6'b100011)//SUBU
            begin
                PCMEMReg=2'b10;
                RegWr=1;
                RegDst=2'b01;
                ALUOp=6'b000100;

            end

            else if(ins[5:0]==6'b101010)//SLT
            begin
                PCMEMReg=2'b10;
                RegWr=1;
                RegDst=2'b01;
                ALUOp=6'b001000;

            end
            else if(ins[5:0]==6'b101011)//SLTU
            begin
                PCMEMReg=2'b10;
                RegWr=1;
                RegDst=2'b01;
                ALUOp=6'b001001;
            end

            else if(ins[5:0]==6'b011010)//DIV
            begin
                ALUOp=6'b001100;
            end
            else if(ins[5:0]==6'b011011)//DIVU
            begin
                ALUOp=6'b001101;
            end

            else if(ins[5:0]==6'b011000)//MULT
            begin
                ALUOp=6'b001110;
            end
            else if(ins[5:0]==6'b011001)//MULTU
            begin
                ALUOp=6'b001111; 
            end

            else if(ins[5:0]==6'b100100)//AND
            begin
                PCMEMReg=10;
                RegWr=1;
                RegDst=2'b01;
                ALUOp=6'b010000;
            end
            else if(ins[5:0]==6'b100111)//NOR
            begin
                PCMEMReg=10;
                RegWr=1;
                RegDst=2'b01;
                ALUOp=6'b010011;
            end
            else if(ins[5:0]==6'b100101)//OR
            begin
                PCMEMReg=2'b10;
                RegWr=1;
                RegDst=2'b01;
                ALUOp=6'b010100;
            end
            else if(ins[5:0]==6'b100110)//XOR
            begin
                PCMEMReg=2'b10;
                RegWr=1;
                RegDst=2'b01;
                ALUOp=6'b010110;
            end


            else if(ins[5:0]==6'b000100)//SLLV
            begin
                ALUSrc=0;
                Scon=0;
                PCMEMReg=10;
                RegWr=1; 
                RegDst=2'b01;
                ALUOp=6'b011001;
            end
            else if(ins[5:0]==6'b000000)//SLL
            begin
                ALUSrc=0;
                Scon=1;
                PCMEMReg=2'b10;
                RegWr=(ins == 0) ? 0 : 1;
                RegDst=2'b01;
                ALUOp=6'b011000;
            end
            else if(ins[5:0]==6'b000111)//SRAV
            begin
                ALUSrc=0;
                Scon=0;
                PCMEMReg=2'b10;
                RegWr=1;
                RegDst=2'b01;
                ALUOp=6'b011011;
            end
            else if(ins[5:0]==6'b000011)//SRA
            begin
                ALUSrc=0;
                Scon=1;
                PCMEMReg=2'b10;
                RegWr=1;
                RegDst=2'b01;
                ALUOp=6'b011010;
            end
            else if(ins[5:0]==6'b000110)//SRLV
            begin
                ALUSrc=0;
                Scon=0;
                PCMEMReg=2'b10;
                RegWr=1;
                RegDst=2'b01;
                ALUOp=6'b011101;
            end
            else if(ins[5:0]==6'b000010)//SRL
            begin
                ALUSrc=0;
                Scon=1;
                PCMEMReg=2'b10;
                RegWr=1;
                RegDst=2'b01;
                ALUOp=6'b011100;
            end


            else if(ins[5:0]==6'b010000)//MFHI
            begin
                ALUOp=6'b110010;
                RegWr=1;
                PCMEMReg=2'b10;
                RegDst=2'b01;
            end

            else if(ins[5:0]==6'b010010)//MFLO
            begin
                ALUOp=6'b110011;
                RegWr=1;
                PCMEMReg=2'b10;
                RegDst=2'b01;
            end


            else if(ins[5:0]==6'b010001)//MTHI
            begin
                ALUOp=6'b110000;
            end

            else if(ins[5:0]==6'b010011)//MTLO
            begin
                ALUOp=6'b110001;
            end


            else if(ins[31:26]==6'b000000 && ins[5:0]==6'b001101)//Break
            begin
                BS=1;
            end 

            else if(ins[31:26]==6'b000000 && ins[5:0]==6'b001100)//Syscall
            begin
                BS=1;
            end

            else if(ins[31:26]==6'b000000 && ins[5:0]==6'b001000)//JR
            begin
                Jcol=1;
                J=1;
            end
            else if(ins[31:26]==6'b000000 && ins[5:0]==6'b001001)//JALR(write back ra)
            begin
                Jcol=1;
                J=1;
                RegWr=1;
                RegDst=2'b10;
                PCMEMReg=2'b01;
            end




        end



        else if(ins[31:26]==6'b001000)//ADDI
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=2'b10;
                RegWr=1;
                RegDst=2'b00;
                ALUOp=6'b000101;
        end


        else if(ins[31:26]==6'b001001)//ADDIU
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=2'b10;
                RegWr=1;
                RegDst=2'b00;
                ALUOp=6'b000111;
        end

        else if(ins[31:26]==6'b001010)//SLTI
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=10;
                RegWr=1;
                RegDst=2'b00;
                ALUOp=6'b001010;
        end
        else if(ins[31:26]==6'b001011)//SLTIU
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=10;
                RegWr=1;
                RegDst=2'b00;
                ALUOp=6'b001011;
        end

        else if(ins[31:26]==6'b001100)//ANDI
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=10;
                RegWr=1;
                RegDst=2'b00;
                ALUOp=6'b010001;
        end

        
        else if(ins[31:26]==6'b001111)//LUI
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=10;
                RegWr=1;
                RegDst=2'b00;
                ALUOp=6'b010010;
        end

        else if(ins[31:26]==6'b001101)//ORI
                begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=10;
                RegWr=1;
                RegDst=2'b00;
                ALUOp=6'b010101;
        end

        else if(ins[31:26]==6'b001110)//XORI
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=10;
                RegWr=1;
                RegDst=2'b00;
                ALUOp=6'b010111;
                
        end



        else if(ins[31:26]==6'b100000)//LB
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=2'b00;
                RegWr=1;
                RegDst=2'b00;
                ALUOp=6'b101000;
                MEMWr1<=1;
                MEMWr2<=4'b0000;
                
        end
        else if(ins[31:26]==6'b100100)//LBU
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=2'b00;
                RegWr=1;
                RegDst=2'b00;
                ALUOp=6'b101001;
                MEMWr1<=1;
                MEMWr2<=4'b0000;
                
        end
        else if(ins[31:26]==6'b100001)//LH
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=2'b00;
                RegWr=1;
                RegDst=2'b00;
                ALUOp=6'b111000;
                MEMWr1<=1;
                MEMWr2<=4'b0000;
                
        end
        else if(ins[31:26]==6'b100101)//LHU
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=2'b00;
                RegWr=1;
                RegDst=2'b00;
                ALUOp=6'b111001;
                MEMWr1<=1;
                MEMWr2<=4'b0000;
                
        end
        else if(ins[31:26]==6'b100011)//LW 
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=2'b00;
                RegWr=1;
                RegDst=2'b00;
                ALUOp=6'b111010;
                MEMWr1<=1;
                MEMWr2<=4'b0000;
                

        end


        else if(ins[31:26]==6'b101000)//SB
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=2'b00;
                RegWr=0;
                RegDst=2'b00;
                ALUOp=6'b101010;
                MEMWr1<=1;

                case(address[1:0])
                2'b00:MEMWr2=4'b0001;
                2'b01:MEMWr2=4'b0010;
                2'b10:MEMWr2=4'b0100;
                2'b11:MEMWr2=4'b1000;
                default:MEMWr2=4'b0001;
                endcase
        end
        else if(ins[31:26]==6'b101001)//SH
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=2'b00;
                RegWr=0;
                RegDst=2'b00;
                ALUOp=6'b111011;
                MEMWr1<=1;

                case(address[1:0])
                2'b00:MEMWr2=4'b0011;
                2'b10:MEMWr2=4'b1100;
                default:MEMWr2=4'b0011;
                endcase
        end
        else if(ins[31:26]==6'b101011)//SW
        begin
                ALUSrc=1;
                Scon=0;
                PCMEMReg=2'b00;
                RegWr=0;
                RegDst=2'b00;
                ALUOp=6'b111100;
                MEMWr1=1;
                MEMWr2=4'b11111;
                
        end


        else if(ins[31:26]==6'b000100)//BEQ
        begin
            ALUSrc=0;
            Scon=0;
            
            ALUOp=6'b100000;
            
            PCSc1=1;
        end

        else if(ins[31:26]==6'b000101)//BNQ
        begin
            ALUOp=6'b100001;
            PCSc1=1;
        end

        else if(ins[31:26]==6'b000111)//BGTZ
        begin
            ALUOp=6'b100011;
            PCSc1=1;
        end

        else if(ins[31:26]==6'b000110)//BLEZ
        begin
            ALUOp=6'b100100;
            PCSc1=1;
        end


        else if(ins[31:26]==6'b000001)
        begin
            if(ins[20:16]==5'b00001)//BGEZ
            begin
                ALUOp=6'b100010;
                PCSc1=1;
            end
            else if(ins[20:16]==5'b00000)//BLTZ
            begin
                ALUOp=6'b100101;
                PCSc1=1;
            end
            else if(ins[20:16]==5'b10001)//BGEZAL(write back ra)
            begin
                ALUOp=6'b100111;
                RegWr=1;
                RegDst=2'b10;
                PCMEMReg=2'b01;
                PCSc1=1;

            end
            else if(ins[20:16]==5'b10000)//BLTZAL(write back ra)
            begin
                ALUOp=6'b100110;
                RegWr=1;
                RegDst=2'b10;
                PCMEMReg=2'b01;
                PCSc1=1;
            end

        end


        else if(ins[31:26]==6'b000010)//J
        begin

            J=1;
        end
        else if(ins[31:26]==6'b000011)//JAL
        begin
            J=1;
            RegWr=1;
            RegDst=2'b10;
            PCMEMReg=2'b01;
        end




        else if(ins[31:26]==6'b010000)
        begin
            if(ins[25:21]==5'b10000)//ERTL
            begin
                ERET=1;
            end
            else if(ins[25:21]==5'b00000)//MFC0
            begin
                PCMEMReg=2'b11;
                RegDst=2'b00;
                RegWr=1;
            end
            else if(ins[25:21]==5'b00100)//MTC0
            begin
                MFC0=1;
                
            end
        end



        else begin
            ALUSrc=0;
            ALUOp=0;
            MEMWr1=0;
            MEMWr2=0;
            PCMEMReg=2'b00;
            PCSc1=0;
            RegWr=0;
            Scon=0;
            J=0;
            Jcol=0;
            BS=0;
            ERET=0;
            MFC0=0;
            RegDst=0;
            NOT_EXIST=0;
        end


    end




endmodule
