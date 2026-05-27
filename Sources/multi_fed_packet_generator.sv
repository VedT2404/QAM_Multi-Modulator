`timescale 1ns/1ps

module multi_fed_packet_generator(

input logic clk,
input logic rst,
input logic symbol_tick,
input logic bit_in,
input logic bit_valid,
input logic [1:0] modulation,
output logic request_bit,
output logic [6:0] symbol,
output logic symbol_valid

);

typedef enum logic [1:0]
{

IDLE,
REQUEST,
COLLECT,
OUTPUT

} state_t;

state_t state;

logic [6:0] shift_reg;
logic [2:0] bit_count;
logic [2:0] bits_needed;

always_comb
begin

case(modulation)

2'd0: bits_needed = 7; //128QAM
2'd1: bits_needed = 6; //64QAM
2'd2: bits_needed = 5; //32QAM
2'd3: bits_needed = 4; //16QAM

default:
bits_needed = 7;

endcase

end

/////////////////////////////////////////////////
// FSM
/////////////////////////////////////////////////

always_ff @(posedge clk or posedge rst)

begin

if(rst) begin
state <= IDLE;
shift_reg <= 0;
bit_count <= 0;
symbol <= 0;
symbol_valid <= 0;
request_bit <= 0;
end

else begin
symbol_valid <= 0;

case(state)

IDLE: begin
request_bit <= 0;

if(symbol_tick) begin
shift_reg <= 0;
bit_count <= 0;
state <= REQUEST;
end

end

REQUEST:

begin
request_bit <= 1;
state <= COLLECT;
end

COLLECT:
begin
request_bit <= 0;
if(bit_valid) begin

shift_reg <=
{
shift_reg[5:0],
bit_in
};
bit_count <=
bit_count + 1;

if(bit_count == bits_needed-1)
state <= OUTPUT;

else
state <= REQUEST;
end

end

OUTPUT: begin

symbol <= shift_reg;
symbol_valid <= 1;
state <= IDLE;

end
default:

state <= IDLE;
endcase

end

end

endmodule