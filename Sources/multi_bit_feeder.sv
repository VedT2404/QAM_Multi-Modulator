`timescale 1ns/1ps

module multi_bit_feeder #

(parameter MEM_DEPTH = 64)

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


memory[ 0] = 32'h01234567;
memory[ 1] = 32'h89ABCDEF;

memory[ 2] = 32'h01234567;
memory[ 3] = 32'h89ABCDEF;

memory[ 4] = 32'h01234567;
memory[ 5] = 32'h89ABCDEF;

memory[ 6] = 32'h01234567;
memory[ 7] = 32'h89ABCDEF;

memory[ 8] = 32'h01234567;
memory[ 9] = 32'h89ABCDEF;

memory[10] = 32'h01234567;
memory[11] = 32'h89ABCDEF;

memory[12] = 32'h01234567;
memory[13] = 32'h89ABCDEF;

memory[14] = 32'h01234567;
memory[15] = 32'h89ABCDEF;

memory[16] = 32'h01234567;
memory[17] = 32'h89ABCDEF;

memory[18] = 32'h01234567;
memory[19] = 32'h89ABCDEF;

memory[20] = 32'h01234567;
memory[21] = 32'h89ABCDEF;

memory[22] = 32'h01234567;
memory[23] = 32'h89ABCDEF;

memory[24] = 32'h01234567;
memory[25] = 32'h89ABCDEF;

memory[26] = 32'h01234567;
memory[27] = 32'h89ABCDEF;

memory[28] = 32'h01234567;
memory[29] = 32'h89ABCDEF;

memory[30] = 32'h01234567;
memory[31] = 32'h89ABCDEF;

//verify 16-QAM only
//    memory[0] = 32'h01234567;
//   memory[1] = 32'h89ABCDEF;
//    memory[2] = 32'h01234567;
//    memory[3] = 32'h89ABCDEF;



//memory[0]=32'hB669E25D;
//memory[1]=32'hCA78B14F;
//memory[2]=32'h55AA1234;
//memory[3]=32'hDEADBEEF;

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