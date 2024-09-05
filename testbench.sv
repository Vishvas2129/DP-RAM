// Code your testbench here
// or browse Examples
module Dpram_tb;

  // Inputs
  reg clk;
  reg [9:0] add_read_p1;
  reg [9:0] add_read_p2;
  reg [9:0] add_write_p1;
  reg [9:0] add_write_p2;
  reg [15:0] input_data_p1;
  reg [15:0] input_data_p2;
  reg we_p1;
  reg we_p2;
  reg re_p1;
  reg re_p2;

  // Outputs
  wire [15:0] output_data_p1;
  wire [15:0] output_data_p2;

  // Instantiate the Dpram module
  Dpram uut (
    .clk(clk),
    .add_read_p1(add_read_p1),
    .add_read_p2(add_read_p2),
    .add_write_p1(add_write_p1),
    .add_write_p2(add_write_p2),
    .input_data_p1(input_data_p1),
    .input_data_p2(input_data_p2),
    .we_p1(we_p1),
    .we_p2(we_p2),
    .re_p1(re_p1),
    .re_p2(re_p2),
    .output_data_p1(output_data_p1),
    .output_data_p2(output_data_p2)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock period
  end

  // Test stimulus
  initial begin
    // Initialize Inputs
    add_read_p1 = 0;
    add_read_p2 = 0;
    add_write_p1 = 0;
    add_write_p2 = 0;
    input_data_p1 = 0;
    input_data_p2 = 0;
    we_p1 = 0;
    we_p2 = 0;
    re_p1 = 0;
    re_p2 = 0;

    // Wait for the reset time
    #10;

    // Test 1: Write to Port 1 and Read from Port 1
    add_write_p1 = 10'b0000000001;
    input_data_p1 = 16'hAAAA;
    we_p1 = 1;
    #10 we_p1 = 0;

    add_read_p1 = 10'b0000000001;
    re_p1 = 1;
    #10 re_p1 = 0;

    // Test 2: Write to Port 2 and Read from Port 2
    add_write_p2 = 10'b0000000010;
    input_data_p2 = 16'h5555;
    we_p2 = 1;
    #10 we_p2 = 0;

    add_read_p2 = 10'b0000000010;
    re_p2 = 1;
    #10 re_p2 = 0;

    // Test 3: Write to Port 1 and Read from Port 2 (Port 1 to Port 2)
    add_write_p1 = 10'b0000000011;
    input_data_p1 = 16'h1234;
    we_p1 = 1;
    #10 we_p1 = 0;

    add_read_p2 = 10'b0000000011;
    re_p2 = 1;
    #10 re_p2 = 0;

    // Test 4: Write to Port 2 and Read from Port 1 (Port 2 to Port 1)
    add_write_p2 = 10'b0000000100;
    input_data_p2 = 16'h5678;
    we_p2 = 1;
    #10 we_p2 = 0;

    add_read_p1 = 10'b0000000100;
    re_p1 = 1;
    #10 re_p1 = 0;

    // Test 5: Simultaneous writes to the same location from both ports (last write wins)
    add_write_p1 = 10'b0000000101;
    add_write_p2 = 10'b0000000101;
    input_data_p1 = 16'h9ABC;
    input_data_p2 = 16'hDEF0;
    we_p1 = 1;
    we_p2 = 1;
    #10 we_p1 = 0;
    we_p2 = 0;

    add_read_p1 = 10'b0000000101;
    re_p1 = 1;
    #10 re_p1 = 0;

    // End the simulation
    #20 $finish;
  end

  // Monitor the signals
  initial begin
    $monitor("Time: %0t | we_p1: %b | we_p2: %b | re_p1: %b | re_p2: %b | add_write_p1: %h | add_write_p2: %h | input_data_p1: %h | input_data_p2: %h | output_data_p1: %h | output_data_p2: %h", 
             $time, we_p1, we_p2, re_p1, re_p2, add_write_p1, add_write_p2, input_data_p1, input_data_p2, output_data_p1, output_data_p2);
  end

  initial begin
    // Dump waves to a file for viewing in GTKWave or other waveform viewers
    $dumpfile("dpram_waveform.vcd");
    $dumpvars(0, Dpram_tb);
  end

endmodule



