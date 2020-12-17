// Module Name:    CPU 
// Project Name:   CSE141L
//
// Revision Fall 2020
// Based on SystemVerilog source code provided by John Eldon
// Comment:
// This is the TopLevel of your project
// Testbench will create an instance of your CPU and test it
// You may add a LUT if needed
// Set Ack to 1 to alert testbench that your CPU finishes doing a program or all 3 programs



	 
module CPU(Reset, Start, Clk,Ack);

	input Reset;		// init/reset, active high
	input Start;		// start next program
	input Clk;			// clock -- posedge used inside design
	output reg Ack;   // done flag from DUT

	
	
	wire [ 9:0] PgmCtr,        // program counter
			      PCTarg;
	wire [ 8:0] Instruction;   // our 9-bit instruction
	wire [ 8:7] Instr_opcode;  // out 3-bit opcode
	wire [ 7:0] ReadA, ReadB;  // reg_file outputs
	wire [ 7:0] InA, InB, 	   // ALU operand inputs
					ALU_out;       // ALU result
	wire [ 7:0] RegWriteValue, // data in to reg file
					MemWriteValue, // data in to data_memory
					MemReadValue;  // data out from data_memory
	wire        MemWrite,	   // data_memory write enable
				   RegWrEn,	      // reg_file write enable
				   Zero,		      // ALU output = 0 flag
					BranchEn;	   // to program counter: branch enable
	reg  [15:0] CycleCt;	      // standalone; NOT PC!

	// Fetch = Program Counter + Instruction ROM
	// Program Counter
  InstFetch IF1 (
	.Reset       (Reset   ) , 
	.Start       (Start   ) ,  
	.Clk         (Clk     ) ,  
	.BranchRelEn (BranchEn) ,  // branch enable
	.ALU_flag	 (Zero    ) ,
   .Target      (PCTarg  ) ,
	.ProgCtr     (PgmCtr  )	   // program count = index to instruction memory
	);	

	// Control decoder
  Ctrl Ctrl1 (
	.Instruction  (Instruction),    // from instr_ROM
	.BranchEn     (BranchEn)		  // to PC
  );
  
  
	// instruction ROM
  InstROM IR1(
	.InstAddress   (PgmCtr), 
	.InstOut       (Instruction)
	);
	
	assign LoadInst = (Instruction[8:7]==2'b01) & Instruction[0];  // calls out load specially
	
	always@*							  
	begin
		Ack = Instruction[0];  // Update this to the condition you want to set done to true
	end
	
	
	//Reg file
	// Modify D = *Number of bits you use for each register*
   // Width of register is 8 bits, do not modify
	RegFile #(.W(8),.D(2)) RF1 (
		.Clk    		(Clk)		  ,
		.WriteEn   (RegWrEn)    , 
		.RaddrA    (Instruction[6:5]),         
		.RaddrB    (Instruction[4:3]), 
		.Waddr     (Instruction[2:1]), 	       
		.DataIn    (RegWriteValue) , 
		.DataOutA  (ReadA        ) , 
		.DataOutB  (ReadB		 )
	);
	
	
	
	assign InA = ReadA;						                       // connect RF out to ALU in
	assign InB = ReadB;
	assign Instr_opcode = Instruction[8:7];
	assign MemWrite = (Instruction[8:7] == 2'b01) & (Instruction[0] == 1'b0);   // mem_store command
	assign RegWriteValue = LoadInst? MemReadValue : ALU_out;  // 2:1 switch into reg_file
	

	// Arithmetic Logic Unit
	ALU ALU1(
	  .InputA(InA),      	  
	  .InputB(InB),
	  .Immediate(Instruction[4:2]),
	  .OP(Instruction[8:7]),
	  .Function(Instruction[1:0]),
	  .Out(ALU_out),		  			
	  .Zero()
		 );
	 
	 
	 // Data Memory
	 	DataMem DM1(
		.DataAddress  (ReadA)    , 
		.WriteEn      (MemWrite), 
		.DataIn       (MemWriteValue), 
		.DataOut      (MemReadValue)  , 
		.Clk 		  	  (Clk)     ,
		.Reset		  (Reset)
	);

	
	
// count number of instructions executed
// Help you with debugging
	always @(posedge Clk)
	  if (Start == 1)	   // if(start)
		 CycleCt <= 0;
	  else if(Ack == 0)   // if(!halt)
		 CycleCt <= CycleCt+16'b1;

endmodule
