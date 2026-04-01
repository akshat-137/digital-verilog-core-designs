`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2026 04:49:02
// Design Name: 
// Module Name: FIFO_8x8_tb
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


module FIFO_8x8_tb(

    );
    //variable declaration
    reg clk , rst , w_enb , r_enb ;
    reg [7:0]data_in ;
    wire [7:0]data_out ;
    wire full , empty ;
    //instantiation
    FIFO_8x8 fifo(clk , rst , w_enb , r_enb , data_in , data_out , full , empty) ;
    //initialization 
    initial
        begin
            {clk , rst , w_enb , r_enb , data_in} = 0 ;
        end
    //generation clock pulse
    always #5 clk = ~clk ;
    //driving the inputs 
    initial
        begin
            rst = 1'b1 ;
            #10 ;
            rst = 1'b0 ;
            #10 ;
            w_enb = 1'b1 ;
            data_in = 5 ; //write data 1
            #10 ;
            w_enb = 1'b1 ;
            data_in = 23 ; //write data 2
            #10 ;
            w_enb = 1'b0 ;
            r_enb = 1'b1 ; //read data 1 
            #10 ;
            r_enb = 1'b1 ; //read data 2 
            #10 ;
            r_enb = 1'b0 ;
            w_enb = 1'b1 ; 
            data_in = 22 ; //write data 1
            #10 ;
            w_enb = 1'b1 ;
            data_in = 53 ; //write data 2 
            #10 ;
            w_enb = 1'b1 ;
            data_in = 43 ; //write data 3
            #10 ;
            w_enb = 1'b1 ;
            data_in = 68 ; //write data 4
            #10 ;
            w_enb = 1'b1 ;
            data_in = 67 ; //write data 5
            #10 ;
            w_enb = 1'b1 ;
            data_in = 13 ; //write data 6 
            #10 ;
            w_enb = 1'b1 ;
            data_in = 19 ; //write data 7
            #10 ;
            w_enb = 1'b1 ;
            data_in = 10 ; //write data 8
            #10 ;
            w_enb = 1'b0 ;
            r_enb = 1'b1 ; //read data 1
            #40
            r_enb = 1'b0 ;
        end
endmodule
