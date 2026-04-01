`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2026 21:26:48
// Design Name: 
// Module Name: RAM_8x8
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


module RAM_8x8(
    input clk , rst , rw_enb ,
    input [2:0]w_add , input [2:0]r_add ,
    input [7:0]data_in ,
    output reg [7:0]data_out 
    );
    integer i ;
    //create an internal memory
    reg [7:0]mem_int[7:0] ;
    always@(posedge clk)
        begin
            if(rst)
                begin
                    for(i = 0 ; i < 8 ; i = i+1)
                        mem_int[i] <= 0 ;
                end
            else 
                begin
                    if(rw_enb)
                        data_out <= mem_int[r_add] ; //read at rw_enb = 1 logic
                    else
                        mem_int[w_add] <= data_in ; //write at rw_enb = 0 logic 
                end
        end
endmodule
