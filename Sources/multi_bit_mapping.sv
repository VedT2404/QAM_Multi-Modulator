`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:
// Design Name:
// Module Name: multi_bit_mapping
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//   Multi-modulation symbol-to-IQ mapper
//////////////////////////////////////////////////////////////////////////////////

module multi_bit_mapping(
    input  logic [6:0] symbol,
    input  logic [1:0] modulation,
   
    output logic signed [4:0] i,
    output logic signed [4:0] q
);

//   modulation = 2'd0 -> 128
//   modulation = 2'd1 -> 64
//   modulation = 2'd2 -> 32
//   modulation = 2'd3 -> 16


always_comb begin
    i = 5'sd0;
    q = 5'sd0;

    case (modulation)

        // 128-QAM : 4 bits for I, 3 bits for Q
        2'd0: begin
            case (symbol[6:3])
                4'b0000: i = -5'sd15;
                4'b0001: i = -5'sd13;
                4'b0010: i = -5'sd11;
                4'b0011: i = -5'sd9;
                4'b0100: i = -5'sd7;
                4'b0101: i = -5'sd5;
                4'b0110: i = -5'sd3;
                4'b0111: i = -5'sd1;
                4'b1000: i =  5'sd1;
                4'b1001: i =  5'sd3;
                4'b1010: i =  5'sd5;
                4'b1011: i =  5'sd7;
                4'b1100: i =  5'sd9;
                4'b1101: i =  5'sd11;
                4'b1110: i =  5'sd13;
                4'b1111: i =  5'sd15;
                default: i = 5'sd0;
            endcase

            case (symbol[2:0])
                3'b000: q = -5'sd7;
                3'b001: q = -5'sd5;
                3'b010: q = -5'sd3;
                3'b011: q = -5'sd1;
                3'b100: q =  5'sd1;
                3'b101: q =  5'sd3;
                3'b110: q =  5'sd5;
                3'b111: q =  5'sd7;
                default: q = 5'sd0;
            endcase
        end

        // 64-QAM : 3 bits for I, 3 bits for Q
        2'd1: begin
            case (symbol[5:3])
                3'b000: i = -5'sd7;
                3'b001: i = -5'sd5;
                3'b010: i = -5'sd3;
                3'b011: i = -5'sd1;
                3'b100: i =  5'sd1;
                3'b101: i =  5'sd3;
                3'b110: i =  5'sd5;
                3'b111: i =  5'sd7;
                default: i = 5'sd0;
            endcase

            case (symbol[2:0])
                3'b000: q = -5'sd7;
                3'b001: q = -5'sd5;
                3'b010: q = -5'sd3;
                3'b011: q = -5'sd1;
                3'b100: q =  5'sd1;
                3'b101: q =  5'sd3;
                3'b110: q =  5'sd5;
                3'b111: q =  5'sd7;
                default: q = 5'sd0;
            endcase
        end

        // 32-QAM : 3 bits for I, 2 bits for Q
        2'd2: begin
            case (symbol[4:2])
                3'b000: i = -5'sd7;
                3'b001: i = -5'sd5;
                3'b010: i = -5'sd3;
                3'b011: i = -5'sd1;
                3'b100: i =  5'sd1;
                3'b101: i =  5'sd3;
                3'b110: i =  5'sd5;
                3'b111: i =  5'sd7;
                default: i = 5'sd0;
            endcase

            case (symbol[1:0])
                2'b00: q = -5'sd3;
                2'b01: q = -5'sd1;
                2'b10: q =  5'sd1;
                2'b11: q =  5'sd3;
                default: q = 5'sd0;
            endcase
        end

        // 16-QAM : 2 bits for I, 2 bits for Q
        2'd3: begin
            case (symbol[3:2])
                2'b00: i = -5'sd3;
                2'b01: i = -5'sd1;
                2'b10: i =  5'sd1;
                2'b11: i =  5'sd3;
                default: i = 5'sd0;
            endcase

            case (symbol[1:0])
                2'b00: q = -5'sd3;
                2'b01: q = -5'sd1;
                2'b10: q =  5'sd1;
                2'b11: q =  5'sd3;
                default: q = 5'sd0;
            endcase
        end

        default: begin
            i = 5'sd0;
            q = 5'sd0;
        end
    endcase
end

endmodule