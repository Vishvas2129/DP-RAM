// Code your design here
module Dpram(
  input clk,                        // Clock signal
  input [9:0] add_read_p1,
  input [9:0] add_read_p2,
  input [9:0] add_write_p1,
  input [9:0] add_write_p2,
  input [15:0] input_data_p1,
  input [15:0] input_data_p2,
  input we_p1,
  input we_p2,
  input re_p1,
  input re_p2,
  output reg [15:0] output_data_p1,
  output reg [15:0] output_data_p2
);

  reg [15:0] RAM [0:2047];           // Memory array

  always @(posedge clk) begin
    // Handle read operations
    if (re_p1) begin
      output_data_p1 <= RAM[add_read_p1];
    end
    if (re_p2) begin
      output_data_p2 <= RAM[add_read_p2];
    end

    // Handle write operations with "last write wins" rule
    if (we_p1 && we_p2 && (add_write_p1 == add_write_p2)) begin
      // If both ports write to the same address, Port 2's data wins
      RAM[add_write_p2] <= input_data_p2;
    end else begin
      if (we_p1) begin
        RAM[add_write_p1] <= input_data_p1;
      end
      if (we_p2) begin
        RAM[add_write_p2] <= input_data_p2;
      end
    end
  end

endmodule

