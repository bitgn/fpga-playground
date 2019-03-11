// # -*- compile-command: "make all data.vcd" -*-
module top(/*AUTOARG*/
   // Outputs
   o_light_a, o_light_b,
   // Inputs
   i_clk, i_reset, i_test_a, i_test_b
   );


   input i_clk;
   input i_reset;
   
   input i_test_a;
   input i_test_b;
   
   output [1:0] o_light_a;
   output [1:0]   o_light_b;

   

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [1:0]            o_light_a;
   reg [1:0]            o_light_b;
   // End of automatics

   localparam state0 = 2'b00;
   localparam state1 = 2'b01;
   localparam state2 = 2'b10;
   localparam state3 = 2'b11;

   localparam green = 2'b00;
   localparam yellow = 2'b01;
   localparam red = 2'b10;
   localparam redyellow = 2'b11;
   
   reg [1:0]            state;
            
   always @(posedge i_clk) begin
       if (i_reset) begin
            /*AUTORESET*/
            // Beginning of autoreset for uninitialized flops
            o_light_a <= 2'h0;
            o_light_b <= 2'h0;
            state <= 2'h0;
            // End of automatics

          state <= state1;
          o_light_a <= green;
          o_light_b <= red;

       end // if (!i_reset)

      case(state)
        state0:
             if (~i_test_a) begin
                state<=state1;
                o_light_a <=  yellow;
                o_light_b <= redyellow;
             end
        state1:
          begin
             state<=state2;
             o_light_a <= red;
             o_light_b <= green;
          end
        state2:
          begin
             if (~i_test_b) begin
                state<=state3;
                o_light_a <= redyellow;
                o_light_b <= yellow;
             end
          end
        state3:
          begin
             state<=state0;
             o_light_a <= green;
             o_light_b <= red;
             end
        endcase
   end
endmodule
