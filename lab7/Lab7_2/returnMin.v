`timescale 1ns / 1ps

module Minimum_Position(
    input [2:0] input_a, input_b, input_c, input_d, // Input values to compare
    output reg [1:0] min_position // Output indicating the minimum position
);
    // Register declaration for storing the minimum position
    reg [1:0] min_position;

    // Always block to determine the minimum position among the inputs
    always @(*) begin
        if (input_a < input_b) begin
            if (input_a < input_c) begin
                if (input_a < input_d) begin
                    min_position = 2'b00; // Input 'a' is the minimum
                end
                else begin
                    min_position = 2'b11; // Input 'd' is the minimum
                end
            end
            else begin
                if (input_c < input_d) begin
                    min_position = 2'b10; // Input 'c' is the minimum
                end
                else begin
                    min_position = 2'b11; // Input 'd' is the minimum
                end
            end
        end
        else begin
            if (input_b < input_c) begin
                if (input_b < input_d) begin
                    min_position = 2'b01; // Input 'b' is the minimum
                end
                else begin
                    min_position = 2'b11; // Input 'd' is the minimum
                end
            end
            else begin
                if (input_c < input_d) begin
                    min_position = 2'b10; // Input 'c' is the minimum
                end
                else begin
                    min_position = 2'b11; // Input 'd' is the minimum
                end
            end
        end
    end
endmodule
