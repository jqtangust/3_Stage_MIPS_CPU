`timescale 1ns / 1ps


module addr_store(
    input [31:0] BusB,
    input [31:0] address,

    output reg [31:0] Din

    );

    always@(*)
    begin
        case(address[1:0])
        2'b00:Din=BusB;
        2'b01:Din={BusB[23:0],8'b0};
        2'b10:Din={BusB[15:0],16'b0};
        2'b11:Din={BusB[7:0],24'b0};
        default:Din=BusB;
        endcase
        
    end
    
    

endmodule
