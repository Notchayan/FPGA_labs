`timescale 1ns / 1ps

module FiniteStateMachine (
    input clk,
    input [1:0] input_signal,
    input [3:0] current_state,
    output reg [3:0] next_state
);

    // Define states and transitions
    reg [3:0] next_state;
    reg [2:0] state_transition_ROM[12:0];
    reg [3:0] state_data_ROM1[3:0], state_data_ROM2[3:0];
    reg counter = 0;

    // Initialize state transition and data ROMs
    initial begin
        state_data_ROM1[0] <= 4'b0100;
        state_data_ROM1[1] <= 4'b0101;
        state_data_ROM1[2] <= 4'b0110;
        state_data_ROM1[3] <= 4'b0110;

        state_data_ROM2[0] <= 4'b1011;
        state_data_ROM2[1] <= 4'b1100;
        state_data_ROM2[2] <= 4'b1100;
        state_data_ROM2[3] <= 4'b1100;

        state_transition_ROM[0] <= 3'b000;
        state_transition_ROM[1] <= 3'b000;
        state_transition_ROM[2] <= 3'b000;
        state_transition_ROM[3] <= 3'b001;
        state_transition_ROM[4] <= 3'b010;
        state_transition_ROM[5] <= 3'b010;
        state_transition_ROM[6] <= 3'b000;
        state_transition_ROM[7] <= 3'b000;
        state_transition_ROM[8] <= 3'b000;
        state_transition_ROM[9] <= 3'b000;
        state_transition_ROM[10] <= 3'b011;
        state_transition_ROM[11] <= 3'b100;
        state_transition_ROM[12] <= 3'b100;
    end

    // State transition logic
    always @(posedge clk) begin
        case(state_transition_ROM[current_state])
            3'b000: next_state <= current_state + 1;
            3'b001: next_state <= state_data_ROM1[input_signal];
            3'b010: next_state <= 7;
            3'b011: next_state <= state_data_ROM2[input_signal];
            3'b100: next_state <= 0;
        endcase
    end
endmodule
