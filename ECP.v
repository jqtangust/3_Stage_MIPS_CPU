`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 14:16:58
// Design Name: 
// Module Name: ECP
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


module ECP(

    input clk,
    input reset,
    input J,
    input branch,


    input EDR,//��ַ����
    input extra,//����ж�
    input PCError,
    input Not_exist,
    input branch_error,

    input RegWr,
    input MEMWr1,
    input [3:0] MEMWr2,
    input jump,



    output reg nRegWr,
    output reg nMEMWr1,
    output reg [3:0] nMEMWr2,
    output reg AddrChange,

    output reg obranch_case


    );


    reg branch_case1;
    reg branch_case2;


    always@(posedge clk)
    begin
        if(!reset)
        begin
            branch_case1=0;
            branch_case2=0;

        end
        

        if(J==1||branch==1)
        branch_case1=1;
        else
        branch_case1=0;

        obranch_case=branch_case2;
        branch_case2=branch_case1;


        

    end

    always@(*)
    begin
        AddrChange=1'b0;


        if(EDR==1 || Not_exist==0 ||PCError==1 ||branch_error==1)
        begin
        nRegWr=0;
        nMEMWr1=0;
        nMEMWr2=0;
        AddrChange=1'b1; 
        end

        else if(extra==1)
        begin
            nRegWr=0;
            AddrChange=1'b1; 
        end

        else
        begin
        nRegWr=RegWr;
        nMEMWr1=MEMWr1;
        nMEMWr2=MEMWr2;

        end

end


endmodule
