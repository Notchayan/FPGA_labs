`timescale 1ns / 1ps

module LCD_Controller_Top(
    input clk, // Clock input
    input [2:0] button_input, // Input for selecting buttons
    input [3:0] button_values, // Values of the buttons
    output lcd_rs, lcd_rw, lcd_e, lcd4, lcd5, lcd6, lcd7 // LCD control signals
);
    // Control signals for LCD
    output reg lcd_rs, lcd_rw, lcd_e, lcd4, lcd5, lcd6, lcd7;
    
    // Register declarations for button inputs
    reg [2:0] button_a, button_b, button_c, button_d; 
    
    // Wire declaration for determining the minimum position among buttons
    wire [1:0] min_position;
    
    // ASCII values for numbers 0 to 7
    reg [7:0] ascii[7:0]; 
    initial begin
        ascii[0] = 8'd48; // ASCII value for '0'
        ascii[1] = 8'd49; // ASCII value for '1'
        ascii[2] = 8'd50; // ASCII value for '2'
        ascii[3] = 8'd51; // ASCII value for '3'
        ascii[4] = 8'd52; // ASCII value for '4'
        ascii[5] = 8'd53; // ASCII value for '5'
        ascii[6] = 8'd54; // ASCII value for '6'
        ascii[7] = 8'd55; // ASCII value for '7'
    end
    
    // Register declarations for storing first and second line data
    reg [0:127] first_line_data;
    reg [0:127] second_line_data;
    
    // Assigning button inputs to respective registers
    always @(posedge button_values[0])
        button_a <= button_input;
    always @(posedge button_values[1])
        button_b <= button_input;
    always @(posedge button_values[2])
        button_c <= button_input;
    always @(posedge button_values[3])
        button_d <= button_input;
    
    // Finding the minimum position among button inputs
    Return_Minimum_Position MIN_POS(button_a, button_b, button_c, button_d, min_position);
    
    // Assigning data for first and second lines based on button inputs
    always @(posedge clk) begin
        first_line_data <= {ascii[button_a], 8'd44, 8'd32, ascii[button_b], 8'd44, 8'd32, ascii[button_c], 8'd44, 8'd32, ascii[button_d], 48'd0};
        case (min_position)
            0: second_line_data <= {ascii[0], 120'd0}; // Display ASCII value for '0' on second line
            1: second_line_data <= {ascii[1], 120'd0}; // Display ASCII value for '1' on second line
            2: second_line_data <= {ascii[2], 120'd0}; // Display ASCII value for '2' on second line
            default: second_line_data <= {ascii[3], 120'd0}; // Display ASCII value for '3' on second line
        endcase
    end
    
    // Instantiating the LCD controller module
    LCD_Controller LCD_Module(first_line_data, second_line_data, clk, lcd_rs, lcd_rw, lcd_e, lcd4, lcd5, lcd6, lcd7);

endmodule
