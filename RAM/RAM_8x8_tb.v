`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2026 21:38:29
// Design Name: 
// Module Name: RAM_8x8_tb
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


module RAM_8x8_tb();
    //variable declaration
    reg clk , rst , rw_enb ;
    reg [2:0]w_add ;
    reg [2:0]r_add ;
    reg [7:0]data_in ;
    wire [7:0]data_out ;
    //instantiation
    RAM_8x8 ram(clk , rst , rw_enb , w_add , r_add , data_in , data_out );
    //initialization
    initial
        begin
            {clk , rst , rw_enb , w_add , r_add , data_in} = 0 ;
        end
    //clock pulse generation
    always #5 clk = ~clk ;
    //driving inputs
    initial
        begin
            rst = 1'b1 ;
            #10 ;
            rst = 1'b0 ;
            #10 ;
            rw_enb = 0 ;
            w_add = 3'b100 ;
            data_in = 5 ;
            #10 ;
            rw_enb = 0 ;
            w_add = 3'b101 ;
            data_in = 10 ;
            #10 ;
            rw_enb = 1 ;
            r_add = 3'b100 ;
        end
endmodule
