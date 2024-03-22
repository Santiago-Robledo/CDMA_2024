`default_nettype none `timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

  // Dump the signals to a VCD file. You can view it with gtkwave.
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  // Wire up the inputs and outputs:
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  // Replace tt_um_example with your module name:
  tt_um_CDMA_Santiago user_project (

      // Include power ports for the Gate Level test:
`ifdef GL_TEST
      .VPWR(1'b1),
      .VGND(1'b0),
`endif

      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

   //Create the clock signal
    always begin #0.5 clk = ~clk; end

    always begin #32 ui_in[0]= ~ui_in[0]; end //Espera 1 ciclo de la carga de la semilla

    always begin #0.001 ui_in[6] = uio_out[0]; end

    //Create stimulus
    initial begin
		#1; rst_n = 1; //Initializes the FlipFlops with 0.
		#1.3; rst_n=0;   //stop the reset
      #1; ui_in[5:1]=4'b1101; //Set the seed into the LFSR
		#1; ui_in[7]= 1;
      #1.3; //Realease the load
      ui_in[7] = 0;
    end
    //This will stop the simulator when the time expires
    initial begin
        #63 $stop;
    end
endmodule
