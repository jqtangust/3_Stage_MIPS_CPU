`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 14:41:13
// Design Name: 
// Module Name: Branch
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


module Branch(
    input PCSc1,
    input Zero,

    input [31:0] PC,
    input [31:0] branchinto,

    output reg branch_go,
    output reg branch_error

    );

    always@(*)
    begin
        if(PCSc1==1&&Zero==1 && branchinto!=(PC-4))
        branch_go=1;
        else
        branch_go=0;

        if(PCSc1==1&&Zero==1 &&branchinto==(PC-4))
        branch_error=1;
        else
        branch_error=0;

    end





endmodule
