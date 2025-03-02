`include "seq_mealy.v"

module tb_seq_mealy;

    // Declare testbench signals
    reg clk, rst, X;
    wire Y;

    // Instantiate the DUT (Device Under Test)
    seq_mealy uut (
        .clk(clk),
        .rst(rst),
        .X(X),
        .Y(Y)
    );

    // Clock generation (50% duty cycle)
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0; 
        rst = 1; 
        X = 0;
        #10 rst = 0; // Release reset

        // Input sequence: 1011010 (Overlapping case)
        #10 X = 1;
        #10 X = 0;
        #10 X = 1;
        #10 X = 1;
        #10 X = 0; // Output Y should be 1 here (Detected "10110")
        #10 X = 1;
        #10 X = 1;
        #10 X = 0; // Output Y should be 1 here (Detected "10110")

        #20 $finish;
    end

    // Monitor state transitions
    initial begin
        $monitor("Reset = %b Time=%0t | X=%b | Y=%b ",rst, $time, X, Y);
    end

    // Generate waveform dump for GTKWave
    initial begin
        $dumpfile("waveform.vcd");  // VCD file for GTKWave
        $dumpvars(0, tb_seq_mealy);  // Dump all variables in the module
    end

endmodule
