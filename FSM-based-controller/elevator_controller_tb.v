`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2026 12:39:03
// Design Name: 
// Module Name: elevator_controller_tb
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


module elevator_controller_tb(

    );
    //variable declaration
    reg clk , rst , emergency_stop ; 
    reg [3:0]floor_req ;
    wire move_up , move_down , stop_motor ;
    wire [3:0]current_floor ;
    //instantiation
    elevator_controller control(clk , rst , floor_req , emergency_stop ,move_up ,move_down , stop_motor , current_floor );
    //initialization
    initial
        begin
            {clk , rst , floor_req , emergency_stop} = 0 ;
        end
    //clock generation
    always #5 clk = ~clk ;
    //driving inputs
    initial
        begin
            rst = 1 ;
            #20 ;
            rst = 0 ;
            
            #10 ;
            floor_req = 4'b0100 ; //move to floor 2
            
            #20 ;
            floor_req = 4'b0001 ; //move to ground floor
            #40 ;
            floor_req = 4'b0000 ;
            
            #20 ;
            floor_req = 4'b1010 ; //multiple requests : floor 1 and floor 3 
            #40 ;
            floor_req = 4'b0000 ;
            
            #20 ;
            emergency_stop = 1'b1 ;
            
            #30 ;
            emergency_stop = 1'b0 ;
            
            $finish ; 
        end
endmodule
