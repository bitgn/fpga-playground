module blink_sample(clk,led0,led1);
  input wire clk;
  output wire led0,led1;


  reg[24:0] counter;
  initial counter = 25'd0;


  always @(posedge clk)
    counter <= counter + 1'b1;

  assign led0 = counter[24];
  assign led1 = ~counter[24];
endmodule
