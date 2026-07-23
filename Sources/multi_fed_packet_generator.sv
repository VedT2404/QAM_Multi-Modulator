`timescale 1ns/1ps

module multi_fed_packet_generator(

input  logic clk,
input  logic rst,

input  logic symbol_tick,

input  logic bit_in,
input  logic bit_valid,

input  logic [1:0] modulation,

output logic request_bit,
output logic [6:0] symbol,
output logic symbol_valid

);

typedef enum logic [1:0]
{
    IDLE,
    REQUEST,
    COLLECT
} state_t;

state_t state;

logic [6:0] shift_reg;
logic [2:0] bit_count;
logic [2:0] bits_needed;

/////////////////////////////////////////////////
// Bits required
/////////////////////////////////////////////////

always_comb begin

    case(modulation)

        2'd0: bits_needed = 7; //128-QAM
        2'd1: bits_needed = 6; //64-QAM
        2'd2: bits_needed = 5; //32-QAM
        2'd3: bits_needed = 4; //16-QAM

        default: bits_needed = 7;

    endcase

end

/////////////////////////////////////////////////
// FSM
/////////////////////////////////////////////////

always_ff @(posedge clk or posedge rst)
begin

    if(rst)
    begin

        state        <= IDLE;
        shift_reg    <= 7'd0;
        bit_count    <= 3'd0;
        symbol       <= 7'd0;
        symbol_valid <= 1'b0;
        request_bit  <= 1'b0;

    end

    else
    begin

        symbol_valid <= 1'b0;

        case(state)

        /////////////////////////////////////////////
        // IDLE
        /////////////////////////////////////////////

        IDLE:
        begin

            request_bit <= 1'b0;

            if(symbol_tick)
            begin
                shift_reg <= 7'd0;
                bit_count <= 3'd0;
                state <= REQUEST;
            end

        end

        /////////////////////////////////////////////
        // REQUEST
        /////////////////////////////////////////////

        REQUEST:
        begin

            request_bit <= 1'b1;
            state <= COLLECT;

        end

        /////////////////////////////////////////////
        // COLLECT
        /////////////////////////////////////////////

       COLLECT:
begin

    request_bit <= 1'b0;

    if(bit_valid)
    begin

        // Shift left and append new bit
        shift_reg <= {shift_reg[5:0], bit_in};

        //--------------------------------------------------
        // Last bit received
        //--------------------------------------------------
        if(bit_count == bits_needed-1)
        begin

            // Right-align the completed symbol
            case(bits_needed)

                3'd4:
                    symbol <= {3'b000, shift_reg[2:0], bit_in};

                3'd5:
                    symbol <= {2'b00, shift_reg[3:0], bit_in};

                3'd6:
                    symbol <= {1'b0, shift_reg[4:0], bit_in};

                3'd7:
                    symbol <= {shift_reg[5:0], bit_in};

                default:
                    symbol <= 7'd0;

            endcase

            symbol_valid <= 1'b1;
            state <= IDLE;

        end

        //--------------------------------------------------
        // Need more bits
        //--------------------------------------------------
        else
        begin

            bit_count <= bit_count + 1'b1;
            state <= REQUEST;

        end

    end

end

        default:

            state <= IDLE;

        endcase

    end

end

endmodule