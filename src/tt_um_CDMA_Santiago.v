/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_CDMA_Santiago (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
  //Instantiate cdma module
    cdma cdma_U1(  
        .clk_i(),
        .rst_i(),
        .signal_i(),
        .seed_i(), 
        .receptor_i(),
        .load_i(),
        .cdma_o(),
        .gold_o(),
        .receptor_o(),
        .led_o()
    );
  // All output pins must be assigned. If not used, assign to 0.
    
  

endmodule
