`timescale 1ns / 1ps


module addr_load(
    input [31:0] BusA,
    input [31:0] imm,

    output reg [31:0] Address


    );

    always@(*)
    begin
        Address = BusA+imm;
        Address = ( Address[31:28] == 4'ha || Address[31:28] == 4'hb ) ? Address - 32'ha0000000 : Address;
    end

endmodule
