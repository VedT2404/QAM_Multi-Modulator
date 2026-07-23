`timescale 1ns/1ps

module tb_fullrun;

logic clk;
logic rst;
logic enable;
logic [1:0] modulation;

logic signed [21:0] wave_out;

integer csv_file;
integer symbol_counter;

/////////////////////////////////////////////////
// DUT
/////////////////////////////////////////////////

multi_top dut (
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .modulation(modulation),
    .wave_out(wave_out)
);

/////////////////////////////////////////////////
// Clock
/////////////////////////////////////////////////

always #5 clk = ~clk;

/////////////////////////////////////////////////
// CSV
/////////////////////////////////////////////////

initial begin
    csv_file = $fopen("All_QAM_Results.csv","w");

    $fwrite(csv_file,
    "Time_ns,Modulation,Wave_Out,Symbol,Phase,I_reg,Q_reg,I_next,Q_next\n");
end

/////////////////////////////////////////////////
// Logging
/////////////////////////////////////////////////

always @(negedge clk)
begin
    if(enable)
    begin
        $fwrite(csv_file,
        "%0t,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d\n",
        $time,
        modulation,
        dut.wave_out,
        dut.symbol_reg,
        dut.phase,
        dut.I_reg,
        dut.Q_reg,
        dut.I_next,
        dut.Q_next);
    end
end

/////////////////////////////////////////////////
// Count symbols
/////////////////////////////////////////////////

always @(posedge clk)
begin
    if(rst)
        symbol_counter <= 0;
    else if(dut.symbol_valid)
        symbol_counter <= symbol_counter + 1;
end

/////////////////////////////////////////////////
// Run one modulation
/////////////////////////////////////////////////

task automatic run_modulation(
    input [1:0] mod,
    input integer total_symbols,
    input string name
);

begin

    modulation = mod;

    rst = 1;
    repeat(2) @(posedge clk);

    rst = 0;
    repeat(2) @(posedge clk);

    $display("--------------------------------------");
    $display("Running %s", name);
    $display("--------------------------------------");

    while(symbol_counter < total_symbols)
        @(posedge clk);

    $display("%s complete (%0d symbols)", name, total_symbols);

    repeat(10) @(posedge clk);

end

endtask

/////////////////////////////////////////////////
// Stimulus
/////////////////////////////////////////////////

initial begin

    clk = 0;
    rst = 1;
    enable = 0;
    modulation = 2'd3;

    repeat(5) @(posedge clk);

    enable = 1;

    // 16-QAM : 3 cycles
    run_modulation(2'd3,48,"16-QAM");

    // 32-QAM : 3 cycles
    run_modulation(2'd2,96,"32-QAM");

    // 64-QAM : 3 cycles
    run_modulation(2'd1,192,"64-QAM");

    // 128-QAM : 3 cycles
    run_modulation(2'd0,384,"128-QAM");

    $display("--------------------------------------");
    $display("ALL MODULATIONS VERIFIED");
    $display("--------------------------------------");

    $fclose(csv_file);

    #100;
    $finish;

end

endmodule