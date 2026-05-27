`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:
// Design Name:
// Module Name: phase_counter
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//   6-bit phase counter for 64 ROM samples per carrier cycle
//
//////////////////////////////////////////////////////////////////////////////////

module multi_phase_counter(
    input  logic clk,
    input  logic rst,
    input  logic enable,
    output logic [5:0] phase,
    output logic symbol_tick
);

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        phase       <= 6'd0;
        symbol_tick <= 1'b0;
    end
    else if (enable) begin
        if (phase == 6'd63) begin
            phase       <= 6'd0;
            symbol_tick <= 1'b1;
        end
        else begin
            phase       <= phase + 6'd1;
            symbol_tick <= 1'b0;
        end
    end
    else begin
        symbol_tick <= 1'b0;
    end
end

endmodule