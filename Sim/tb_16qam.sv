`timescale 1ns/1ps

module tb_16qam;

logic clk;
logic rst;
logic enable;
logic [1:0] modulation;
logic signed [21:0] wave_out;

integer csv_file;

multi_top dut(
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .modulation(modulation),
    .wave_out(wave_out)
);

always #1 clk = ~clk;

initial begin
    csv_file = $fopen("16QAM_results.csv","w");

    $fwrite(csv_file,
"Time_ns,Wave_Out,Symbol,Phase,I_reg,Q_reg,I_next,Q_next\n");
end

always @(negedge clk)
begin
    if(!rst)
        $fwrite(csv_file,
"%0t,%0d,%0d,%0d,%0d,%0d,%0d,%0d\n",
$time,wave_out,dut.symbol,dut.phase,
dut.I_reg,dut.Q_reg,dut.I_next,dut.Q_next);
end

initial begin
    clk=0;
    rst=1;
    enable=0;
    modulation=2'd3;

    #10;
    rst=0;
    enable=1;

    #900000;

    $fclose(csv_file);
    $finish;
end

endmodule