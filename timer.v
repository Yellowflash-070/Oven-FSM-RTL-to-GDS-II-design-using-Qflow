`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2024 13:16:39
// Design Name: 
// Module Name: timer
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


module timer_mod(clk,rst,en,set_time,timer);

//input/output variables
input clk,rst,en;
input [7:0]set_time;
output reg [7:0]timer;

initial timer = set_time;

//logic block
always @(posedge clk, posedge rst)
    begin
        
        if(rst)
            timer <= 0;
        else if (en)
            if(timer > 0)
                timer <= timer - 1;
            else
                timer <= timer;
        else
            timer <= timer;
            
        
    end
endmodule
