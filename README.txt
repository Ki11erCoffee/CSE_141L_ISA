Members:
Paul Doan
Felix Campos

This has been an interesting and quite difficult project for us this quarter. Developing the
ISA and routing all the control signals and logic were doable; as was writing the assembler
to decode our ISA instructions into binary values which our ISA could then process.
Our instructions work fine and the instructions we support are ADD, BEQ, SW, LW, SLT, Mv, ORR, SUB, 
SLL, and SRL. We implemented BEQ without using labels by specifying how many instructions we wanted to 
jump forward or backwards. Our ISA has access to 4 registers which proved to be quite difficult in managing 
while trying to implement our algorithms. We will go into detail on our ISA in the video as well as a demo so I 
won’t write much on it here so algorithm wise we tried our best to implement Program 1 and Program 2.
As you can infer by my tone sadly we were unsuccessful in implementing program 1 and program 2.
We poured countless hours into program 1 but no matter how hard we tried to debug by following
modelSim’s wave graphs we couldn’t find the error that was causing our program 1 to fail. So 
fast forward to Thursday night we made the call to abandon ship on program 1 and try to 
Implement program 2 because we desperately want to pass this class and we thought we would have better luck in implementing program 2. We have two files in our submission for program 1 and 2; one 
for running purposes and one that's filled with comments labeled Program1Comments.txt which labels what each instruction is doing in order for us to check our implementation and ensure the 
algorithm was doing what we wanted it to do. Unfortunately we didn’t have any better luck implementing program 2 than we did program 1. We went so far as to code the program in java
first to run and ensure our algorithm was correct, which it was but clearly our translation from 
Java to assembly was failing us because when we ran the code in modelSim; sure enough we failed the tests in the test bench. We tried going through the wave of each of the variables at different clock stages to 
try and debug but we were unsuccessful in getting program 2 working. 
We apologize for not meeting the standard and completing a program but we really did put 
a lot of time and effort in planning and debugging this ISA and we hope that this is taken
into consideration when grading our project. Our ISA works; we tested it thoroughly using the provided test bench and running individual instructions to ensure the inputs/outputs in the wave
file performed as expected but we fell short in our algorithm/code to assembly translation to the point where we were unable to implement a program.    



NOTES:
1. We submitted our own test bench because we were infinite looping because the reset bit was not being set to 0 so we set it to 0 in testBench after a clock cycle 
2. When running machine code -> must specify which file you are reading from in file InstROM.v line 49
3. 
