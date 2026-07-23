`timescale 1ns/1ps

module tb_test;

logic clk;
logic rst;
logic enable;
logic [1:0] modulation;

logic signed [21:0] wave_out;

// CSV file handle
integer csv_file;

multi_top dut(
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .modulation(modulation),
    .wave_out(wave_out)
);

// Clock generation
always #1 clk = ~clk;

//-----------------------------------------------------
// Open CSV file
//-----------------------------------------------------
initial begin
    csv_file = $fopen("simulation_results.csv","w");
    

    if (csv_file == 0) begin
        $display("ERROR: Could not create CSV file.");
        $finish;
    end

    $fwrite(csv_file,
"Time_ns,Modulation,Enable,Wave_Out,Symbol,Phase,I_reg,Q_reg,I_next,Q_next\n");
end

//-----------------------------------------------------
// Log data AFTER DUT updates
//-----------------------------------------------------
always @(negedge clk) begin
    if (!rst) begin
        $fwrite(csv_file,
            "%0t,%0d,%0d,%0d,%07b,%0d,%0d,%0d,%0d,%0d\n",
            $time,
            modulation,
            enable,
            wave_out,
            dut.symbol,
            dut.phase,
            dut.I_reg,
            dut.Q_reg,
            dut.I_next,
            dut.Q_next
        );
    end
end
//-----------------------------------------------------
// Test stimulus
//-----------------------------------------------------
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

    $fclose(csv_file);
    $finish;
end
endmodule