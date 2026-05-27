`timescale 1ns/1ps

module multi_bit_feeder #

(parameter MEM_DEPTH = 16)

(input logic clk,
input logic rst,
input logic request_bit,
output logic bit_out
);
logic [31:0] memory [0:MEM_DEPTH-1];
logic [31:0] current_word;
logic [$clog2(MEM_DEPTH)-1:0] addr;
logic [4:0] bit_ptr;

initial begin

memory[0]=32'hB669E25D;
memory[1]=32'hCA78B14F;
memory[2]=32'h55AA1234;
memory[3]=32'hDEADBEEF;

end

always_ff @(posedge clk or posedge rst) begin

if(rst) begin
addr<=0;
current_word<=memory[0];
bit_ptr<=31;
bit_out<=0;
end

else if(request_bit) begin
bit_out<=current_word[bit_ptr];

if(bit_ptr==0) begin
addr<=addr+1;
current_word<=memory[addr+1];
bit_ptr<=31;
end

else
bit_ptr<=bit_ptr-1;
end

end

endmodule