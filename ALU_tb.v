`timescale 1ns/ 1ps



//Test bench
//Arithmetic Logic Unit
/*
* INPUT: A, B
* op: 00, A PLUS B
* op: 01, A AND B
* op: 10, A OR B
* op: 11, A XOR B
* OUTPUT A op B
* equal: is A == B?
* even: is the output even?
*/


module ALU_tb;
reg [ 7:0] INPUTA;     	  // data inputs
reg [ 7:0] INPUTB;
reg [ 7:0] IMMEDIATE;
reg [ 2:0] op;		// ALU opcode, part of microcode
reg [ 1:0] Function; // was 2 bits
wire[ 7:0] OUT;		  

  wire Zero;    
 
 reg [ 7:0] expected;
 
// CONNECTION
ALU uut(
  .InputA(INPUTA),      	  
  .InputB(INPUTB),
  .Immediate(IMMEDIATE),
  .OP(op),				  
  .Function(Function),
  .Out(OUT),		  			
  .Zero(Zero)
    );
	 
	initial begin


		INPUTA = 1;
		INPUTB = 1; 
		IMMEDIATE = 3'b000;
		op= 'b00; // ADD
		Function = 2'b00;
		test_alu_func; // void function call
		#5;
	
		INPUTA = 3;
		INPUTB = 1; 
		IMMEDIATE = 3'b000;
		op= 'b00; // BEQ
		Function = 2'b01;
		test_alu_func; // void function call
		#5;
		
		INPUTA = 2;
		INPUTB = 2; 
		IMMEDIATE = 3'b000;
		op= 'b00; // BEQ
		Function = 2'b01;
		test_alu_func; // void function call
		#5;
		
		INPUTA = 4;
		INPUTB = 3;
		IMMEDIATE = 3'b000;
		op= 'b01; // SLT
		Function = 2'b10;
		test_alu_func; // void function call
		#5;
		
		INPUTA = 2;
		INPUTB = 4; 
		IMMEDIATE = 3'b000;
		op= 'b01; // SLT
		Function = 2'b10;
		test_alu_func; // void function call
		#5;
		
		INPUTA = 6;
		INPUTB = 6;
		IMMEDIATE = 3'b000;	
		op= 'b01; // SLT
		Function = 2'b10;
		test_alu_func; // void function call
		#5;
		
		INPUTA = 1;
		INPUTB = 1; 
		IMMEDIATE = 3'b010;
		op= 'b01; // MV
		Function = 2'b11;
		test_alu_func; // void function call
		#5;
	
		INPUTA = 1;
		INPUTB = 1; 
		IMMEDIATE = 3'b111;
		op= 'b01; // MV
		Function = 2'b11;
		test_alu_func; // void function call
		#5;
	
		INPUTA = 1;
		INPUTB = 1; 
		IMMEDIATE = 3'b001;
		op= 'b01; // MV
		Function = 2'b11;
		test_alu_func; // void function call
		#5;
	
	   INPUTA = 4;
		INPUTB = 1;
		IMMEDIATE = 3'b000;
		op= 'b10; // ORR
		Function = 2'b00;
		test_alu_func; // void function call
		#5;
	
		INPUTA = 4;
		INPUTB = 1;
		IMMEDIATE = 3'b000;
		op= 'b10; // SUB
		Function = 2'b01;
		test_alu_func; // void function call
		#5;
		
		INPUTA = 4;
		INPUTB = 1;
		IMMEDIATE = 3'b000;
		op= 'b11; // SLL
		Function = 2'b00;
		test_alu_func; // void function call
		#5;
		
		INPUTA = 4;
		INPUTB = 1;
		IMMEDIATE = 3'b000;
		op= 'b11; // SRL
		Function = 2'b01;
		test_alu_func; // void function call
		#5;
		
	end
	
	task test_alu_func;
	begin
	  case (op)
		0: 
			if(Function[0] == 1'b0) begin			//add
				expected = INPUTA + INPUTB;
			end
						
			else if(Function[0] == 1'b1) begin 	//beq
				expected = INPUTA - INPUTB;		
			end
		1: 
			begin
				
				if(Function == 2'b10) begin 			// slt
					expected = INPUTA - INPUTB;
					if(expected < 0)
						expected = 1;
					else
						expected = 0;
				end
						
				else if(Function == 2'b11)				// mv
					if(IMMEDIATE == 3'b010) begin
						expected = -7;
					end 
							
					else begin
						expected = IMMEDIATE;
					end
					
			end
		2: 
			begin
				if(Function == 2'b00)
					expected = INPUTA | INPUTB;
				
				else if(Function == 2'b01)
					expected = INPUTA - INPUTB;
			end
		3:
			begin 
				if(Function ==2'b00)
					expected = INPUTA << INPUTB;
				
				else if(Function == 2'b01)
					expected = INPUTA >> INPUTB;
			end
	  endcase
	  #1; if(expected == OUT)
		begin
			$display("%t YAY!! inputs = %h %h, opcode = %b, Zero %b",$time, INPUTA,INPUTB,op, Zero);
		end
	    else begin $display("%t FAIL! inputs = %h %h, opcode = %b, zero %b",$time, INPUTA,INPUTB,op, Zero);end
		
	end
	endtask



endmodule
