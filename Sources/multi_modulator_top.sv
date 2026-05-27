`timescale 1ns / 1ps

module multi_modulator_top(
    input  logic clk,
    input  logic rst,
    input  logic enable,
    input  logic bit_valid,
    input  logic [1:0] modulation,
    output logic signed [21:0] wave_out
);


logic [6:0] symbol;
logic       symbol_valid;
logic [6:0] symbol_reg;

logic signed [4:0] I_next, Q_next;
logic signed [4:0] I_reg, Q_reg;

logic [5:0] phase;
logic       symbol_tick;

logic signed [15:0] sin_out, cos_out;

always_ff @(posedge clk or posedge rst) begin
    if(rst)
        symbol_reg <= 0;
    else if(symbol_valid)
        symbol_reg <= symbol;
end

multi_packet_generator pkt (
    .clk(clk),
    .rst(rst),
    .symbol_tick(symbol_tick),
    .bit_valid(bit_valid),
    .modulation(modulation),
    .symbol(symbol),
    .symbol_valid(symbol_valid)
);

multi_bit_mapping mapper (
    .symbol(symbol_reg),
    .modulation(modulation),
    .i(I_next),
    .q(Q_next)
);

multi_phase_counter pc (
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .phase(phase),
    .symbol_tick(symbol_tick)
);

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        I_reg <= 4'sd0;
        Q_reg <= 4'sd0;
    end
    else if (symbol_tick) begin
        I_reg <= I_next;
        Q_reg <= Q_next;
    end
end

multi_sin_cos_rom rom (
    .phase(phase),
    .sin_out(sin_out),
    .cos_out(cos_out)
);

multi_waveform_generator wf (
    .I(I_reg),
    .Q(Q_reg),
    .sin_in(sin_out),
    .cos_in(cos_out),
    .wave_out(wave_out)
);

endmodule