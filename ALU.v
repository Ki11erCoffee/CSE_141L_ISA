// Module Name:    ALU 
// Project Name:   CSE141L
//
// Revision Fall 2020
// Based on SystemVerilog source code provided by John Eldon
// Comment:
// 
	 
module ALU(InputA, InputB, RD, Immediate, OP, Function, Out, Zero);

	input [7:0] InputA;
	input [7:0] InputB;
	input [7:0] RD;
	input [2:0] Immediate; 
	input [1:0] OP;
	input [1:0] Function; //was [1:0]
	output reg [7:0] Out; // logic in SystemVerilog
	output reg Zero;

	/*
		    OP		Function
	Add    00	      00		A + B
	Beq	 00			01		A - B, if result == 0 then zero = 1
	
	SW		 01			00		N/A
	LW		 01			01		N/A 
	SLT 	 01			10		A - B, if result < 0 then out = 1
	Mv		 01			11		A + 0 	*might not use
	
	ORR    10			00 	A | B
	Sub	 10			01		A - B
	
	SLL	 11			00    A << B
	SRL	 11			01		A >> B
	*/
	
	always@* // always_comb in systemverilog
	begin 
		Out = 0;
		case (OP)
		2'b00:
					begin
					
						if(Function[0] == 1'b0) begin			//add
							Out = InputA + InputB;
						end
						
						else if(Function[0] == 1'b1) begin 	//beq
							Out = RD - InputA;		
						end
						
					end
		2'b01: 
					begin
						
						if(Function == 2'b10) begin 			// slt
							Out = InputA - InputB;
							if(Out < 0)
								Out = 1;
							else
								Out = 0;
						end
						
						else if(Function == 2'b11)				// mv
							if(Immediate == 3'b010) begin
								Out = -7;
							end 
							
							else begin
								Out = Immediate;
							end
							
					end
		2'b10: 
					begin
						if(Function[0] == 1'b0)					// orr
							Out = InputA | InputB;
							
						else if(Function[0] == 1'b1)			// sub
							Out = InputA - InputB;
					end
				
		2'b11: 
					begin
						if(Function[0] == 1'b0)					// sll
							Out = InputA << InputB;
							
						else if(Function[0] == 1'b1)			// srl
							Out = InputA >> InputB;
					end				
	  endcase
	
	end 

	always@*							  // assign Zero = !Out;
	begin
		case(Out)
			'b0     : Zero = 1'b1;
			default : Zero = 1'b0;
      endcase
	end


endmodule
