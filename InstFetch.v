// Module Name:    InstFetch 
// Project Name:   CSE141L
//
// Revision Fall 2020
// Based on SystemVerilog source code provided by John Eldon
// Comment:
// This module does not actually fetch the actual code
// It is responsible for providing which line number will be read next


	 
module InstFetch(Reset, Start, Clk, BranchRelEn, ALU_flag,Target, ProgCtr);

  input              Reset,			   // reset, init, etc. -- force PC to 0 
                     Start,			   // begin next program in series
                     Clk,			      // PC can change on pos. edges only	   
                     BranchRelEn,	   // set to 1 when instruction is beq
                     ALU_flag;		   // zero flag from ALU
  input signed [7:0] Target;		      // offset for beq(aka value of 3rd register)
  output reg signed [10:0] ProgCtr ;         // the program counter register itself
  

	//reg [7:0] temp; 
  
  //// program counter can clear to 0, increment, or jump
	always @(posedge Clk)
	begin 
		if(Reset)
		  ProgCtr <= 0;				        // for first program; want different value for 2nd or 3rd
		else if(Start)						     // hold while start asserted; commence when released
		  ProgCtr <= ProgCtr;
		else if(BranchRelEn && ALU_flag)   // beq, offset is positive
		  ProgCtr <= Target + ProgCtr; 
		/*
		else if(BranchRelEn && ALU_flag && (Target[7] == 1)) begin  // beq, offset is negitive
		  temp[0] <= ~Target[0];
		  temp[1] <= ~Target[1];
		  temp[2] <= ~Target[2];
		  temp[3] <= ~Target[3];
		  temp[4] <= ~Target[4];
		  temp[5] <= ~Target[5];
		  temp[6] <= ~Target[6];
		  temp[7] <= ~Target[7];
		  temp <= temp + 1;
		  ProgCtr <= ProgCtr - temp; 
		  $display("temp BEQ for negative offset is : %d", temp);
		  $display("BEQ for negative offset is : %d", ProgCtr);
		end
		*/
		else
		  ProgCtr <= ProgCtr+'b1; 	        // default increment (no need for ARM/MIPS +4. Pop quiz: why?)
	end


endmodule

/* Note about Start: if your programs are spread out, with a gap in your machine code listing, you will want 
to make Start cause an appropriate jump. If your programs are packed sequentially, such that program 2 begins 
right after Program 1 ends, then you won't need to do anything special here. 
*/