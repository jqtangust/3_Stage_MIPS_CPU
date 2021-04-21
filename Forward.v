`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 14:51:52
// Design Name: 
// Module Name: Forward
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


module Forward(
    input [4:0] registerWr,
    input [31:0] next_ins,

    output reg choose1,
    output reg choose2

    );
    always@(*)
    begin
        if(registerWr==next_ins[25:21])
        choose1=1;
        else
        choose1=0;

        if(registerWr==next_ins[20:16])
        choose1=1;
        else
        choose1=0;
    end

endmodule
