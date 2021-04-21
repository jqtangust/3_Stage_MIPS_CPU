`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 15:08:16
// Design Name: 
// Module Name: CP0
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


module CP0(

    input reset,
    input clk,

    input [2:0] sel,
    input [4:0] rd,

    input EDR,
    input PCError,
    input [3:0] MEMWr2,
    input extra,

    input BS,
    input [31:0] ins,



    input [31:0] PCAddr,
    input [31:0] load_storeAddr,

    input not_exist,

    input ERET,

    input CP0Wr,
    input [31:0] BusB,

    input branch_case,


    input jumpfalse,
    input [31:0] jump,

    input branch_error,


    output reg [31:0] CP0_out
    

    );
    
    
    reg [31:0] register[31:0];



    
    always@(posedge clk)
    begin
        if(!reset)
        begin

            register[0]=0; register[1]=0; register[2]=0; register[3]=0; register[4]=0; 
            register[5]=0; register[6]=0; register[7]=0; register[8]=0; register[9]=0;

            register[10]=0; register[11]=0; register[12]=0; register[13]=0; register[14]=0;
            register[15]=0; register[16]=0; register[17]=0; register[18]=0; register[19]=0;

            register[20]=0; register[21]=0; register[22]=0; register[23]=0; register[24]=0;
            register[25]=0; register[26]=0; register[27]=0; register[28]=0; register[29]=0;

            register[30]=0; register[31]=0;

            register[12][22]=1;

        end

    // end

    // always@(posedge clk)
    // begin
        else if(PCError==1)
        begin
            register[13][6:2]=5'h04;
            register[8]=PCAddr-8;
            register[14]=PCAddr-8;
            register[12][1]=1;

                if(branch_case==1)
                begin
                    register[14]=PCAddr-12;
                    register[13][31]=1;
                end

            


        end


    // end

    
    // always@(posedge clk)
    // begin
        else if(branch_error==1)
        begin
            register[13][6:2]=5'h00;
            register[14]=PCAddr-4;
            register[12][1]=1;

                if(branch_case==1)
                begin
                    register[14]=PCAddr-12;
                    register[13][31]=1;

                end

        end

    // end
    
    // always@(posedge clk)
    // begin
        else if(EDR==1)
        begin
            if(MEMWr2==0)
            begin
                register[13][6:2]=5'h04;
                register[8]=load_storeAddr;
                register[14]=PCAddr-4;
                register[12][1]=1;

                if(branch_case==1)
                begin
                    register[14]=PCAddr-8;
                    register[13][31]=1;

                end


                
            end

            else
            begin
                register[13][6:2]=5'h05;
                register[8]=load_storeAddr;
                register[14]=PCAddr-4;
                register[12][1]=1;           
           

                if(branch_case==1)
                begin
                    register[14]=PCAddr-8;
                    register[13][31]=1;
                end

                
                // if(branch==1||j==1)
                // branch_cause=1;
                // else
                // branch_cause=0;
            end 

        end


    // end

    // always@(posedge clk)
    // begin
        else if(extra==1)
        begin
            register[13][6:2]=5'h0c;
            register[14]=PCAddr-4;
            register[12][1]=1;

            if(branch_case==1)
            begin
                register[14]=PCAddr-8;
                register[13][31]=1;
                

            end


            
        end
                    

    // end

    // always@(posedge clk)
    // begin
        else if(BS==1)
        begin
            if(ins[5:0]==6'b001101)
            begin
                register[13][6:2]=5'h09;
                register[14]=PCAddr-4;
                register[12][1]=1;


                if(branch_case==1)
                begin
                    register[14]=PCAddr-8;
                    register[13][31]=1;
                end

            end


            else if(ins[5:0]==6'b001100)
            begin
                register[13][6:2]=5'h08;
                register[14]=PCAddr-4;
                register[12][1]=1;


                if(branch_case==1)
                begin
                    register[14]=PCAddr-8;
                    register[13][31]=1;
                end

                

            end


        end           
        
    // end

    // always@(posedge clk)
    // begin
        else if(not_exist==0)
        begin
            register[13][6:2]=5'h0a;
            register[14]=PCAddr-4;
            register[12][1]=1;

            if(branch_case==1)
            begin
                register[14]=PCAddr-8;
                register[13][31]=1;
            end
            
        end

        

    // end

    // always@(posedge clk)
    // begin
        else if(jumpfalse==1)
        begin
            register[13][6:2]=5'h04;
            register[14]=jump;
            register[12][1]=1;
            register[8]=jump;

            if(branch_case==1)
            begin
                register[14]=jump;
                register[13][31]=1;
            end
            
        end

        else if(ERET==1)
        begin
            register[12][1]=0;
        end
                   
        else if(CP0Wr==1)
        register[rd]=BusB;

        

    end


    always @(*)
    begin
        if(ERET==1)
        begin
            CP0_out=register[14];
        end
            
        else
            CP0_out=register[rd];
        


        
    end



endmodule
