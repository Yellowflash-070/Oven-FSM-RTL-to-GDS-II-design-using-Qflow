`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2024 21:59:38
// Design Name: 
// Module Name: Oven_FSM
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


module Oven_FSM(clk,rst,start_btn,pause_btn,door_open,set_temp,set_time,mode_sel,
fan,light,buzzer,temp,timer,hrod1,hrod2,hrod3,hrod4,high_grill);

//input-output variables
input clk,rst,start_btn,pause_btn,door_open;
input [7:0]set_temp,set_time;
input [1:0]mode_sel;
input high_grill;
output reg fan,light,buzzer;
output reg hrod1,hrod2,hrod3,hrod4;
output reg [7:0]temp;
output reg [7:0]timer;

//defining states of our Oven FSM
parameter Idle = 3'b000;
parameter Preheating = 3'b001;
parameter Cooking = 3'b010;
parameter Grilling = 3'b011;
parameter Baking = 3'b100;
parameter Pause = 3'b101;


reg [2:0]state,next_state;
reg flag,timer_start;



//initial value of variables
assign set_temp = 0;
//assign set_time = 0;


initial
    begin
        state = Idle;
        next_state = Idle;
        temp = 0;
        flag = 0;
        timer = 0;
    end


//state register block
always @(posedge clk, posedge rst)
        begin
            if(rst)
                begin
                    state <= Idle;
                end    
            else
                    state <= next_state;
        end
    

//next_state logic block
always @(*)
    begin
        case(state)
            Idle : begin
                    if(start_btn && !door_open)
                        case(mode_sel)
                            2'b00 : next_state = Preheating;
                            2'b01 : next_state = Cooking;
                            2'b10 : next_state = Grilling;
                            2'b11 : next_state = Baking;
                            default : next_state = Idle;
                        endcase
                    else
                        next_state = Idle;    
                   end
                   
            Preheating: begin
                        if (pause_btn) 
                            next_state = Pause;

                        else 
                            next_state = Preheating;
                     end
                     
            Cooking: begin
                        if (pause_btn) 
                            next_state = Pause;
                        else if (timer == 0) 
                            next_state = Idle;

                        else 
                            next_state = Cooking;
                     end 
            
            Grilling: begin
                        if (pause_btn) 
                            next_state = Pause;
                        else if (timer == 0) 
                            next_state = Idle;

                        else 
                            next_state = Grilling;
                     end
            
            Baking: begin
                        if (pause_btn) 
                            next_state = Pause;
                        else if (timer == 0) 
                            next_state = Idle;

                        else 
                            next_state = Baking;
                     end
                     
            
            Pause:     begin
                        if (!pause_btn)
                            begin
                                    timer_start = 1'b1;
                                    case(mode_sel)
                                        2'b00 : next_state = Preheating;
                                        2'b01 : next_state = Cooking;
                                        2'b10 : next_state = Grilling;
                                        2'b11 : next_state = Baking;
                                        default : next_state = Idle;
                                    endcase
                            end

                        else
                            next_state = Pause;
                       end
            
            default :       next_state = Idle;                 
        endcase
    end
    

//output logic block
always @(state,timer,timer_start,flag)
    begin

        case(state)
            Idle: begin
                    timer_start = 1'b0;
                    light = 1'b1;
                    buzzer = 1'b0;
                    fan = 1'b0;
                    hrod1 = 1'b0;   
                    hrod2 = 1'b0;   
                    hrod3 = 1'b0;   
                    hrod4 = 1'b0;   
                  end
                  
            Preheating: begin
                            temp = set_temp;
                            light = 1'b1;
                            buzzer = 1'b0;
                            fan = 1'b0;
                            hrod1 = 1'b0;   
                            hrod2 = 1'b0;   
                            hrod3 = 1'b1;   
                            hrod4 = 1'b0;     
                        end
            
            Cooking: begin
                        
                        if(flag)
                            begin
                                timer = timer;
                                flag = 1'b0;
                                timer_start = 1'b1;
                            end
                        else if(!timer_start)
                            begin
                             timer = set_time;
                             timer_start = 1'b1;
                            end
                            
                        else
                            timer = timer;
                        
                        temp = set_temp;    
                        light = 1'b1;
                        hrod1 = 1'b0;   
                        hrod2 = 1'b1;   
                        hrod3 = 1'b1;   
                        hrod4 = 1'b0;
                   
                        if(timer == 0)
                            begin
                                buzzer = 1'b1;
                                fan = 1'b1;
                            end
                        else
                            begin
                                buzzer = 1'b0;
                                fan = 1'b0;
                            end   
                     end
                     
            Grilling: begin
                       
                        if(flag)
                            begin
                                timer = timer;
                                flag = 1'b0;
                                timer_start = 1'b1;
                            end
                        else if(high_grill && !timer_start)
                            begin
                             timer = set_time;
                             timer_start = 1'b1;
                            end
                        else if(!timer_start)
                            begin
                                timer = 8'b01011010;
                                timer_start = 1'b1;
                            end
                        else
                            timer = timer;
                         
                        temp = set_temp;   
                        light = 1'b1;
                        hrod1 = 1'b0;   
                        hrod2 = 1'b1;   
                        hrod3 = 1'b1;   
                        hrod4 = 1'b0;
                   
                        if(timer == 0)
                            begin
                                buzzer = 1'b1;
                                fan = 1'b1;
                            end
                        else
                            begin
                                buzzer = 1'b0;
                                fan = 1'b0;
                            end   
                        
                      end
            
            Baking: begin
                        if(flag)
                            begin
                                timer = timer;
                                flag = 1'b0;
                                timer_start = 1'b1;
                            end
                        else if(!timer_start)
                            begin
                             timer = set_time;
                             timer_start = 1'b1;
                            end
                        else
                            timer = timer;
                            
                        temp = set_temp;
                        light = 1'b1;
                        hrod1 = 1'b1;   
                        hrod2 = 1'b1;   
                        hrod3 = 1'b1;   
                        hrod4 = 1'b1;
                   
                        if(timer == 0)
                            begin
                                buzzer = 1'b1;
                                fan = 1'b1;
                            end
                        else
                            begin
                                buzzer = 1'b0;
                                fan = 1'b0;
                            end   
                     end
            
            Pause: begin
                        timer_start = 1'b0;
                        flag = 1'b1;
                        light = 1'b1;
                        buzzer = 1'b0;
                        fan = 1'b0;
                        hrod1 = 1'b0;   
                        hrod2 = 1'b0;   
                        hrod3 = 1'b0;   
                        hrod4 = 1'b0;
                   end
            
                       
            default: begin
                        light = 1'b1;
                        buzzer = 1'b0;
                        fan = 1'b0;
                        hrod1 = 1'b0;   
                        hrod2 = 1'b0;   
                        hrod3 = 1'b0;   
                        hrod4 = 1'b0;   
                      end 
        endcase        
    end
    
    
//timer_mod t1(.clk(clk),.rst(rst),.en(en),.set_time(run_time),.timer(timer1));



//logic block
always @(posedge clk, posedge rst)
    begin
        if(rst)
            timer <= 0;
        else if (timer_start)
            if(timer > 0)
                timer <= timer - 1;
            else
                timer <= timer;
        else
            timer <= timer;
            

    end
endmodule



