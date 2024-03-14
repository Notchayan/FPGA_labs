`timescale 1ns / 1ps
 
module RotaryShaftDetector(
    input clk, // Clock input
    input rotation_A, // Rotary shaft signal A
    input rotation_B, // Rotary shaft signal B
    output reg rotation_event // Output indicating rotation event
);

    // Detect rotation event based on the states of rotation signals A and B
    always @(posedge clk) begin
        if (rotation_A == 1 && rotation_B == 1) begin
            rotation_event <= 1; // Set rotation event signal high
        end
        else if (rotation_A == 0 && rotation_B == 0) begin
            rotation_event <= 0; // Set rotation event signal low
        end
    end

endmodule
