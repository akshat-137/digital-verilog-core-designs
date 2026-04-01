`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2026 08:04:08
// Design Name: 
// Module Name: hamming_code_generator
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


module hamming_code_generator(
    input [6:0]data_in ,
    output [10:0]encrypted_code
    );
    wire p1 , p2 , p3 , p4 ; //parity bits
    wire [6:0]d; //data bits 
    //take input
    assign d = data_in ;
    // find parity bits
    assign p1 = d[0]^d[1]^d[3]^d[4]^d[6] ;
    assign p2 = d[0]^d[2]^d[3]^d[5]^d[6] ;
    assign p3 = d[1]^d[2]^d[3] ;
    assign p4 = d[4]^d[5]^d[6] ;
    //genreated code
    assign encrypted_code = {d[6] , d[5] , d[4], p4 , d[3] , d[2] , d[1] , p3 , d[0] , p2 , p1} ;
endmodule
