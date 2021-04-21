`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 14:46:30
// Design Name: 
// Module Name: ControlHAZARD
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


module ControlHAZARD(
    input branch_do,

    output reg reset

    );

    always@(*)
    begin
        if(branch_do==1)
        reset=1;
        else
        reset=0;
    end
endmodule
