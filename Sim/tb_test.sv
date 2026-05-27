`timescale 1ns/1ps

module tb_test;
logic clk;
logic rst;
logic enable;
logic [1:0] modulation;
logic signed [21:0] wave_out;

multi_top dut(
.clk(clk),
.rst(rst),
.enable(enable),
.modulation(modulation),
.wave_out(wave_out));

always #1 clk = ~clk;

initial begin
clk = 0;
rst = 1;
enable = 0;
modulation = 2'd3;
#10;
rst = 0;
enable = 1;
#250;

modulation = 2'd2;
#250;

modulation = 2'd1;
#250;

modulation = 2'd0;
#250;

$finish;

end
endmodule