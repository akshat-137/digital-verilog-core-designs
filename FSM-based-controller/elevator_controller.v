`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2026 11:52:38
// Design Name: 
// Module Name: elevator_controller
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


module elevator_controller(
    input clk , rst ,
    input [3:0]floor_req ,
    input emergency_stop ,
    output reg move_up , move_down , stop_motor ,
    output reg [3:0]current_floor
    );
    //declare variable state 
    reg [1:0]current_state ;
    reg [1:0] next_state ;
    reg [3:0] target_floor ;
    reg valid_req ;
    reg [3:0] latched_target;
    //declare states 
    parameter idle = 2'b00 ;
    parameter move_elevator_up = 2'b01 ;
    parameter move_elevator_down = 2'b10 ;
    parameter emergency = 2'b11 ;
    //priority logic
    always@(*)
        begin
            valid_req = 1'b0;
            target_floor = current_floor;

            if(floor_req[0]) begin
                target_floor = 4'd0;
                valid_req = 1'b1;
            end
            else if(floor_req[1]) begin
                target_floor = 4'd1;
                valid_req = 1'b1;
            end
            else if(floor_req[2]) begin
                target_floor = 4'd2;
                valid_req = 1'b1;
            end
            else if(floor_req[3]) begin
                target_floor = 4'd3;
                valid_req = 1'b1;
            end    
        end
    //present state logic
    always@(posedge clk)
        begin
            if(rst)
                current_state <= idle ;
            else
                current_state <= next_state ;
        end
     //target latching
     always @(posedge clk or posedge rst)
         begin
              if(rst)
                  latched_target <= 4'd0;
              else if(current_state == idle && valid_req)
                   latched_target <= target_floor;
          end
    //floor tracking logic
    always@(posedge clk or posedge rst)
        begin
            if(rst)
                current_floor <= 4'b00 ;
            else if(current_state == move_elevator_up && current_floor < 4'd3) 
                 current_floor <= current_floor + 1'b1 ;
            else if(current_state == move_elevator_down && current_floor > 4'd0)
                  current_floor <= current_floor - 1'b1 ;                
        end
    //next state logic
    always@(*)
        begin
            next_state = current_state ;
            if(emergency_stop)
                next_state = emergency ; 
            else
                begin
                    case(current_state)
                        idle: begin
                                if(valid_req) begin
                                if(latched_target > current_floor)
                                    next_state = move_elevator_up ;
                                else if(latched_target < current_floor)
                                    next_state = move_elevator_down ;
                                end
                              end
                        move_elevator_up : begin
                                             if(latched_target == current_floor)
                                                next_state = idle ;
                                             else
                                                next_state = move_elevator_up ;
                                            end
                        move_elevator_down : begin
                                               if(latched_target == current_floor)
                                                  next_state = idle ;
                                               else 
                                                   next_state = move_elevator_down ;
                                               end
                        emergency : begin
                                       if(!emergency_stop)
                                           next_state = idle ;
                                       else
                                           next_state = emergency ;
                                    end   
                        default : next_state = idle ;
                    endcase                              
                end
        end
    //output logic
    always@(*)
        begin
            move_up = 1'b0 ;
            move_down = 1'b0 ;
            stop_motor = 1'b0 ;
            
            case(current_state)
                move_elevator_up : move_up = 1'b1 ;
                move_elevator_down : move_down = 1'b1 ;
                emergency : stop_motor = 1'b1 ;
                idle : stop_motor = 1'b1 ;
           endcase  
        end
        
endmodule
