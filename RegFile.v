// Module Name:    RegFile 
// Project Name:   CSE141L
//
// Revision Fall 2020
// Based on SystemVerilog source code provided by John Eldon
// Comment:
// This module is your register file.
// If you have more or less bits for your registers, update the value of D.
// Ex. If you only supports 8 registers. Set D = 3

/* parameters are compile time directives 
       this can be an any-size reg_file: just override the params!
*/
module RegFile (Clk, WriteEn, RaddrA, RaddrB, Waddr, DataIn, DataOutA, DataOutB, DataOutBr);
	parameter W=8, D=2;  // W = data path width (Do not change); D = pointer width (You may change) **CHANGE D DEPENDING ON # REGISTERS**
	input                Clk,
								WriteEn;				 // if 0: do not write to register, if 1: write to register
	input        [D-1:0] RaddrA,				 // address pointers
								RaddrB,
								Waddr;
	input        [W-1:0] DataIn; 				  // data to write to register
	output reg   [W-1:0] DataOutA;			  // register A value
	output reg   [W-1:0] DataOutB;			  // register B value
	output reg 	 [W-1:0] DataOutBr;			  // offset for branch

// W bits wide [W-1:0] and 2**4 registers deep 	 
reg [W-1:0] Registers[(2**D)-1:0];	  // or just registers[16-1:0] if we know D=4 always



// NOTE:
// READ is combinational
// WRITE is sequential

always@*
begin
 DataOutA = Registers[RaddrA];	  
 DataOutB = Registers[RaddrB];    
 DataOutBr = Registers[Waddr];
end

// sequential (clocked) writes 
always @ (posedge Clk)
  if (WriteEn)	                     // works just like data_memory writes
    Registers[Waddr] <= DataIn;		//writed to RD

endmodule
