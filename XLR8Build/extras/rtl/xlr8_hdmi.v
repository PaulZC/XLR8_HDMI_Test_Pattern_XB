// File name: xlr8_hdmi.v
// Author:    Paul Clark
// Based on:  xlr8_wrap_template.v
// By:        Steve Phillips

module xlr8_hdmi  // NOTE: Change the module name to match your design
  #(
    // Parameter definitions. The ADDR parameters will be defined when
    // this module is instantiated.
    parameter RED_ON_ADDR = 0,      // Address of the register that will hold the red component of pixels that are on
    parameter RED_OFF_ADDR = 0,		// Address of the register that will hold the red component of pixels that are off
    parameter GREEN_ON_ADDR = 0,		// Address of the register that will hold the green component of pixels that are on
    parameter GREEN_OFF_ADDR = 0,	// Address of the register that will hold the green component of pixels that are off
    parameter BLUE_ON_ADDR = 0,		// Address of the register that will hold the blue component of pixels that are on
    parameter BLUE_OFF_ADDR = 0,		// Address of the register that will hold the blue component of pixels that are off
    parameter WIDTH = 8
    )
   (
    // Input/Ouput definitions for the module. These are standard and
    // while other ports could be added, these are required.
    //  
    // Clock and Reset
    input        clk, //       Clock
    input        rstn, //      Reset
    input        clken, //     Clock Enable
	 
    // I/O 
    input [7:0]  dbus_in, //   Data Bus Input
    output [7:0] dbus_out, //  Data Bus Output
    output       io_out_en, // IO Output Enable
	 
    output [2:0] datap,			// HDMI RGB Data Pins (+ve)
    output [2:0] datan,			// HDMI RGB Data Pins (-ve)
    output clkp,					// HDMI Clock (+ve)
    output clkn,					// HDMI Clock (-ve)
	 output heartbeat,			// Heartbeat
	 
    // DM
    input [7:0]  ramadr, //    RAM Address
    input        ramre, //     RAM Read Enable
    input        ramwe, //     RAM Write Enable
    input        dm_sel //    DM Select
    );
   
   //======================================================================
   // Interfaces to the user module:
   
	logic red_on_sel;
	logic red_on_we;
	logic red_on_re;
	logic [WIDTH-1:0] red_on_reg; // The register that will hold the red component of pixels that are on

	logic red_off_sel;
	logic red_off_we;
	logic red_off_re;
	logic [WIDTH-1:0] red_off_reg; // The register that will hold the red component of pixels that are off

	logic green_on_sel;
	logic green_on_we;
	logic green_on_re;
	logic [WIDTH-1:0] green_on_reg;

	logic green_off_sel;
	logic green_off_we;
	logic green_off_re;
	logic [WIDTH-1:0] green_off_reg;

	logic blue_on_sel;
	logic blue_on_we;
	logic blue_on_re;
	logic [WIDTH-1:0] blue_on_reg;

	logic blue_off_sel;
	logic blue_off_we;
	logic blue_off_re;
	logic [WIDTH-1:0] blue_off_reg;

   // End, interfaces
   //----------------------------------------------------------------------

   
   //======================================================================
   //  Control select
   //
   // For each register interface, do control select based on address
   assign red_on_sel = dm_sel && (ramadr == RED_ON_ADDR);
   assign red_on_we  = red_on_sel && ramwe;
   assign red_on_re  = red_on_sel && ramre;
   
   assign red_off_sel = dm_sel && (ramadr == RED_OFF_ADDR);
   assign red_off_we  = red_off_sel && ramwe;
   assign red_off_re  = red_off_sel && ramre;
   
   assign green_on_sel = dm_sel && (ramadr == GREEN_ON_ADDR);
   assign green_on_we  = green_on_sel && ramwe;
   assign green_on_re  = green_on_sel && ramre;
   
   assign green_off_sel = dm_sel && (ramadr == GREEN_OFF_ADDR);
   assign green_off_we  = green_off_sel && ramwe;
   assign green_off_re  = green_off_sel && ramre;
   
   assign blue_on_sel = dm_sel && (ramadr == BLUE_ON_ADDR);
   assign blue_on_we  = blue_on_sel && ramwe;
   assign blue_on_re  = blue_on_sel && ramre;
   
   assign blue_off_sel = dm_sel && (ramadr == BLUE_OFF_ADDR);
   assign blue_off_we  = blue_off_sel && ramwe;
   assign blue_off_re  = blue_off_sel && ramre;
   
   // Mux the data and enable outputs
   assign dbus_out =  ({8{   red_on_sel  }} &   red_on_reg  ) |
                      ({8{   red_off_sel }} &   red_off_reg ) |
                      ({8{ green_on_sel  }} & green_on_reg  ) |
                      ({8{ green_off_sel }} & green_off_reg ) |
                      ({8{  blue_on_sel  }} &  blue_on_reg  ) |
                      ({8{  blue_off_sel }} &  blue_off_reg );

   assign io_out_en = red_on_re ||
                      red_off_re ||
                      green_on_re ||
                      green_off_re ||
                      blue_on_re ||
                      blue_off_re;

   // End, Control Select
   //----------------------------------------------------------------------
   

   //======================================================================
   // Load write data from AVR core into registers
   //
   // For data written from the AVR core to the user module, you may
   // want to register the value here so that it is held for reference
   // until the net update in value

   always @(posedge clk) begin
		if (clken && red_on_we) begin
        red_on_reg <= dbus_in[WIDTH-1:0];
      end
   end
   
   always @(posedge clk) begin
		if (clken && red_off_we) begin
        red_off_reg <= dbus_in[WIDTH-1:0];
      end
   end
   
   always @(posedge clk) begin
		if (clken && green_on_we) begin
        green_on_reg <= dbus_in[WIDTH-1:0];
      end
   end
   
   always @(posedge clk) begin
		if (clken && green_off_we) begin
        green_off_reg <= dbus_in[WIDTH-1:0];
      end
   end
   
   always @(posedge clk) begin
		if (clken && blue_on_we) begin
        blue_on_reg <= dbus_in[WIDTH-1:0];
      end
   end
   
   always @(posedge clk) begin
		if (clken && blue_off_we) begin
        blue_off_reg <= dbus_in[WIDTH-1:0];
      end
   end
   
   // End, Load write data
   //----------------------------------------------------------------------
   
   
   //======================================================================
   // Instantiate user module
   //
   // Below is an example instantiation of a simple user module. It
   // provides just enough I/O to demonstrate how the above logic is
   // connected.
   
   HDMI hdmi_inst (
                    .clkPixel    (clk),
						  .datap       (datap),
	                 .datan			(datan),
						  .clkp			(clkp),
						  .clkn			(clkn),
						  .red_on		(red_on_reg),
						  .red_off		(red_off_reg),
						  .green_on		(green_on_reg),
						  .green_off	(green_off_reg),
						  .blue_on		(blue_on_reg),
						  .blue_off		(blue_off_reg),
						  .heartbeat	(heartbeat)
                    );
   
   // End, Instantiate user module
   //----------------------------------------------------------------------
   
endmodule

