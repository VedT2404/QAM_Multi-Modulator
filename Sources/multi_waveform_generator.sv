`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:
// Design Name:
// Module Name: multi_waveform_generator
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//   Waveform generator: s(t) = I*cos - Q*sin
//
//////////////////////////////////////////////////////////////////////////////////

module multi_waveform_generator(
    input  logic signed [4:0]  I,
    input  logic signed [4:0]  Q,
    input  logic signed [15:0] sin_in,
    input  logic signed [15:0] cos_in,
    output logic signed [21:0] wave_out
);

logic signed [20:0] Icos;
logic signed [20:0] Qsin;
logic signed [21:0] mix_temp;

always_comb begin
    Icos     = I * cos_in;
    Qsin     = Q * sin_in;
    mix_temp = Icos - Qsin;
    wave_out = mix_temp;
end

endmodule