`timescale 1ns / 1ps

module multi_top(

input logic clk,
input logic rst,
input logic enable,

input logic [1:0] modulation,
output logic signed [21:0] wave_out

);

/////////////////////////////////////////////////
// Internal signals
/////////////////////////////////////////////////



logic bit_in;

logic request_bit;

logic [6:0] symbol;
logic symbol_valid;

logic [6:0] symbol_reg;

logic signed [4:0] I_next;
logic signed [4:0] Q_next;

logic signed [4:0] I_reg;
logic signed [4:0] Q_reg;

logic [5:0] phase;
logic symbol_tick;

logic signed [15:0] sin_out;
logic signed [15:0] cos_out;

logic signed [21:0] wave_out_dbg;

logic bit_valid;

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        bit_valid <= 1'b0;
    else
        bit_valid <= request_bit;
end

/////////////////////////////////////////////////
// Feeder
/////////////////////////////////////////////////

multi_bit_feeder feeder(

.clk(clk),
.rst(rst),

.request_bit(request_bit),

.bit_out(bit_in)

);

/////////////////////////////////////////////////
// Packet Generator
/////////////////////////////////////////////////

multi_fed_packet_generator pkt(

.clk(clk),
.rst(rst),

.symbol_tick(symbol_tick),

.bit_in(bit_in),

.bit_valid(bit_valid),

.modulation(modulation),

.request_bit(request_bit),

.symbol(symbol),
.symbol_valid(symbol_valid)

);

/////////////////////////////////////////////////
// Symbol register
/////////////////////////////////////////////////

always_ff @(posedge clk or posedge rst)

begin

if(rst)

symbol_reg <= 0;

else if(symbol_valid)

symbol_reg <= symbol;

end


always_ff @(posedge clk)
    wave_out_dbg <= wave_out;

/////////////////////////////////////////////////
// Mapper
/////////////////////////////////////////////////

multi_bit_mapping mapper(

.symbol(symbol_reg),

.modulation(modulation),

.i(I_next),
.q(Q_next)

);

/////////////////////////////////////////////////
// Phase Counter
/////////////////////////////////////////////////

multi_phase_counter pc(

.clk(clk),
.rst(rst),
.enable(enable),

.phase(phase),

.symbol_tick(symbol_tick)

);

/////////////////////////////////////////////////
// IQ registers
/////////////////////////////////////////////////

always_ff @(posedge clk or posedge rst)

begin

if(rst)

begin

I_reg <= 0;
Q_reg <= 0;

end

else if(symbol_tick)

begin

I_reg <= I_next;
Q_reg <= Q_next;

end

end

/////////////////////////////////////////////////
// Carrier ROM
/////////////////////////////////////////////////

multi_sin_cos_rom rom(

.phase(phase),

.sin_out(sin_out),
.cos_out(cos_out)

);

/////////////////////////////////////////////////
// Waveform generation
/////////////////////////////////////////////////

multi_waveform_generator wf(

.I(I_reg),
.Q(Q_reg),

.sin_in(sin_out),
.cos_in(cos_out),

.wave_out(wave_out)

);

//ila_0 u_ila (
//    .clk(clk),

//    .probe0(wave_out_dbg),      // [21:0]
//    .probe1(modulation),    // [1:0]
//    .probe2(phase),         // [5:0]
//    .probe3(symbol),        // [6:0]
//    .probe4(symbol_valid),  // 1 bit
//    .probe5(enable)         // 1 bit
//);
endmodule