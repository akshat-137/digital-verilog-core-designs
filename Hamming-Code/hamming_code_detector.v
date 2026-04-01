`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2026 09:23:10
// Design Name: 
// Module Name: hamming_code_detector
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


module hamming_code_detector(
    input [10:0]encrypted_code ,
    output [3:0]error_pos ,
    output error_detected ,
    output [6:0]decrypted_code 
    );
    wire [10:0]ec , ec_corr ;
    reg [10:0]correct;
    wire [3:0]p ;
    assign ec = encrypted_code ;
    assign p[0] = ec[0]^ec[2]^ec[4]^ec[6]^ec[8]^ec[10] ;
    assign p[1] = ec[1]^ec[2]^ec[5]^ec[6]^ec[9]^ec[10] ;
    assign p[2] = ec[3]^ec[4]^ec[5]^ec[6] ;
    assign p[3] = ec[7]^ec[8]^ec[9]^ec[10] ;
    assign error_pos = p ;
    always@(*)
        begin
            case(error_pos)
                4'b0000 : correct = ec  ;
                4'b0001 : correct = ec^11'b00000000001 ;
                4'b0010 : correct = ec^11'b00000000010 ;
                4'b0011 : correct = ec^11'b00000000100 ;
                4'b0100 : correct = ec^11'b00000001000 ;
                4'b0101 : correct = ec^11'b00000010000 ;
                4'b0110 : correct = ec^11'b00000100000 ;
                4'b0111 : correct = ec^11'b00001000000 ;
                4'b1000 : correct = ec^11'b00010000000 ;
                4'b1001 : correct = ec^11'b00100000000 ;
                4'b1010 : correct = ec^11'b01000000000 ;
                4'b1011 : correct = ec^11'b10000000000 ;
                default : correct = ec ;
           endcase
        end
    assign error_detected = (error_pos != 4'b0000)? 1'b1 : 1'b0 ;
    assign ec_corr = correct ;
    assign decrypted_code = {ec_corr[10],ec_corr[9],ec_corr[8],ec_corr[6],ec_corr[5],ec_corr[4],ec_corr[2]};
endmodule
