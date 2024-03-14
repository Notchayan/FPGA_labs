`timescale 1ns / 1ps

// Define clock period
`define CLOCK_PERIOD 100000000

module fsmROM_top (
    input clk,
    input [1:0] cin,
    input ROT_A, ROT_B,
    output [3:0] next_state
);

    // Declare internal signals and registers
    reg [3:0] next_state;
    reg [3:0] curr_state = 0;
    reg [31:0] counter = 0;
    reg [1:0] x;
    wire rotation_event;
    reg prev_rotation_event = 1;

    // Instantiate Finite State Machine ROM
    fsmROM FSMROM(clk, x, curr_state, next_state);

    // Clocked process for state transition and input handling
    always @(posedge clk) begin
        counter <= counter + 1;

        // Detect rotation event and update state and input data accordingly
        if (prev_rotation_event == 0 && rotation_event == 1) begin
            curr_state <= next_state;
            x <= cin;
            counter <= 0;
        end
        // If the specified clock time has elapsed, update state only
        else if (counter == `CLOCK_PERIOD) begin
            curr_state <= next_state;
            counter <= 0;
        end

        // Update previous rotation event for the next cycle
        prev_rotation_event <= rotation_event;
    end

    // Instantiate rotary shaft module to detect rotation event
    rotary_shaft RS(clk, ROT_A, ROT_B, rotation_event);

endmodule
