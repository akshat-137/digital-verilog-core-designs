`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2026 08:36:38
// Design Name: 
// Module Name: hamming_code_tb
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


module hamming_code_tb(

    );
    //variable declaration 
    /*reg [10:0]encrypted_code ;
    wire [3:0]error_pos ;
    wire error_detected ;
    wire [6:0]decrypted_code ;*/
    reg [6:0]data_in ;
    wire [10:0]encrypted_code ;
    //instantiation
/*    hamming_code_detector decoder(encrypted_code , error_pos , error_detected , decrypted_code) ;*/
      hamming_code_generator encode(data_in , encrypted_code) ;
    //initialization 
    initial
        data_in = 0 ;
        /*encrypted_code = 0 ;*/
    //driving the inputs 
    initial
        begin
       /* encrypted_code = 11'b10101010111 ;
        #200 ;
        encrypted_code = 11'b10101000111 ;*/
        data_in = 7'b1011011 ;
        #200 ;
        data_in = 7'b1011010 ;
        end
        
endmodule
