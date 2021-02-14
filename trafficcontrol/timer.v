`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:29:43 01/30/2021
// Design Name:   traffic_control
// Module Name:   E:/electrical/degital designCOURSE2/PROJECT/trafficcontrol/timerr.v
// Project Name:  trafficcontrol
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: traffic_control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module timerr;

	// Inputs
	reg CLK;
	reg RESET;

	// Outputs
	wire GSN1;
	wire GSN2;
	wire GWE1;
	wire GWE2;
	wire RWE;
	wire RNS;
	wire [6:0] SN1D1;
	wire [6:0] SN1D2;
	wire [6:0] SN2D1;
	wire [6:0] SN2D2;
	wire [6:0] WE1D1;
	wire [6:0] WE1D2;
	wire [6:0] WE2D1;
	wire [6:0] WE2D2;

	// Instantiate the Unit Under Test (UUT)
	traffic_control uut (
		.GSN1(GSN1), 
		.GSN2(GSN2), 
		.GWE1(GWE1), 
		.GWE2(GWE2), 
		.RWE(RWE), 
		.RNS(RNS), 
		.SN1D1(SN1D1), 
		.SN1D2(SN1D2), 
		.SN2D1(SN2D1), 
		.SN2D2(SN2D2), 
		.WE1D1(WE1D1), 
		.WE1D2(WE1D2), 
		.WE2D1(WE2D1), 
		.WE2D2(WE2D2), 
		.CLK(CLK), 
		.RESET(RESET)
	);

	initial begin
		// Initialize Inputs


	CLK=0;
	RESET=0;
	#10 CLK=1;RESET=1;
	#10 CLK=0;RESET=0;
	#10 CLK=1;RESET=1;
	#10 CLK=0;RESET=0;
	forever
	#10 CLK=~CLK;
	end
	   
endmodule


