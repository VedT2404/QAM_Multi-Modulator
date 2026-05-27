`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:
// Design Name:
// Module Name: multi_packet_generator
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//   Serial-to-symbol packet generator for multi-modulation architecture
//////////////////////////////////////////////////////////////////////////////////

module multi_packet_generator(
    input  logic clk,
    input  logic rst,
    input  logic symbol_tick,
  
    input  logic bit_valid,
    input  logic [1:0] modulation,
    output logic [6:0] symbol,
    output logic symbol_valid
);

//   modulation = 2'd0 -> 128 (7 bits/symbol)
//   modulation = 2'd1 -> 64  (6 bits/symbol)
//   modulation = 2'd2 -> 32  (5 bits/symbol)
//   modulation = 2'd3 -> 16  (4 bits/symbol)


logic [6:0] buffer;
logic [2:0] count;
logic [1:0] modulation_d;
logic pack_enable;

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        buffer       <= 7'd0;
        count        <= 3'd0;
        symbol       <= 7'd0;
        symbol_valid <= 1'b0;
    end
    else begin
        symbol_valid <= 1'b0;


        if (modulation != modulation_d) begin // reset buffer and count on modulation change
            buffer <= 7'd0;
            count  <= 3'd0;
        end

        modulation_d <= modulation;

        if (bit_valid) begin
            case (modulation)

                2'd0:begin if (symbol_tick) begin //QAM 128
                        pack_enable <= 1;
                         end
                        symbol_valid <= 0;
        
                        if (bit_valid) begin
                            if (pack_enable)begin
                             buffer <= {buffer[5:0], $urandom % 2};
                             count <= count + 1;
                                 if (count == 3'd6) begin
                                 symbol <= {buffer[5:0], $urandom % 2};
                                 symbol_valid <= 1;
                                 count <= 0;
                                 pack_enable <= 0;
                                end
                            end 
                        end
                end

                2'd1: begin if (symbol_tick) begin //QAM 64
                        pack_enable <= 1;
                         end
                        symbol_valid <= 0;
        
                        if (bit_valid) begin
                            if (pack_enable)begin
                             buffer <= {buffer[5:0], $urandom % 2};
                             count <= count + 1;
                                 if (count == 3'd5) begin
                                 symbol <= {1'b0, buffer[4:0], $urandom % 2};
                                 symbol_valid <= 1;
                                 count <= 0;
                                 pack_enable <= 0;
                                end
                            end 
                        end
                end

                2'd2: begin if (symbol_tick) begin //QAM 32
                        pack_enable <= 1;
                         end
                        symbol_valid <= 0;
        
                        if (bit_valid) begin
                            if (pack_enable)begin
                             buffer <= {buffer[5:0], $urandom % 2};
                             count <= count + 1;
                                 if (count == 3'd4) begin
                                 symbol <= {2'b00, buffer[3:0], $urandom % 2};
                                 symbol_valid <= 1;
                                 count <= 0;
                                 pack_enable <= 0;
                                end
                            end 
                        end
                end

                2'd3: begin if (symbol_tick) begin //QAM 16
                        pack_enable <= 1;
                         end
                        symbol_valid <= 0;
        
                        if (bit_valid) begin
                            if (pack_enable)begin
                             buffer <= {buffer[5:0], $urandom % 2};
                             count <= count + 1;
                                 if (count == 3'd3) begin
                                 symbol <= {3'b0000, buffer[2:0], $urandom % 2};
                                 symbol_valid <= 1;
                                 count <= 0;
                                 pack_enable <= 0;
                                end
                            end 
                        end
                end

                default: begin
                    buffer       <= 7'd0;
                    count        <= 3'd0;
                    symbol       <= 7'd0;
                    symbol_valid <= 1'b0;
                end
            endcase
        end
    end
end

endmodule