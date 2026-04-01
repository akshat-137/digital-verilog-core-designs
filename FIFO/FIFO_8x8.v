`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2026 03:46:22
// Design Name: 
// Module Name: FIFO_8x8
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


module FIFO_8x8(
    input clk , rst , w_enb , r_enb ,
    input [7:0]data_in ,
    output reg [7:0]data_out ,
    output full , empty 
    );
    reg [3:0]w_ptr , r_ptr ;
    integer i ;
    //create internal memory
    reg [7:0]memory[7:0] ;
    always@(posedge clk)
        begin
            if(rst)
                begin
                    w_ptr <= 0 ;
                    r_ptr <= 0 ;
                    data_out <= 0 ; 
                    for(i = 0 ; i < 8 ; i = i + 1 )
                        memory[i] <= 0 ;
                end
            else 
                begin
                    if(w_enb == 1'b1 && full == 1'b0) //write only if memory is not full
                        begin
                            memory[w_ptr] <= data_in ;
                            w_ptr <= w_ptr + 1'b1 ;
                        end
                    if(r_enb == 1'b1 && empty == 1'b0) //read only if memory is not empty
                        begin
                            data_out <= memory[r_ptr] ;
                            r_ptr <= r_ptr + 1'b1 ;
                        end
                    else if(empty)
                        data_out <= data_out ;
                end
        end
    assign full = ((w_ptr[3] != r_ptr[3]) && w_ptr[2:0] == r_ptr[2:0])? 1'b1 : 1'b0 ; //full memory logic
    assign empty = (w_ptr == r_ptr)? 1'b1 : 1'b0 ; //empty memory logic
endmodule
