`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2025 21:17:17
// Design Name: 
// Module Name: test_mips32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_mips32();
reg clk1 , clk2;
integer k;
mips32 DUT(clk1 , clk2);
initial
begin
repeat(20) // Generating two phase clock
begin
#5 clk1 = 1; #5 clk1 = 0;
#5 clk2 = 1; #5 clk2 = 0;
end
end

initial
begin
for(k = 0 ; k<32 ; k=k+1)
mips32.regbank[k] = k;

mips32.Mem[0] = 32'h2801000a; //ADDI R1,R0,10
mips32.Mem[1] = 32'h28020014; //ADDI R2,R0,20
mips32.Mem[2] = 32'h28030019; //ADDI R3,R0,25
mips32.Mem[3] = 32'h0ce77800; //dummy instruction(to avoid pipeline hazard)
mips32.Mem[4] = 32'h0ce77800; //dummy instruction(to avoid pipeline hazard)
mips32.Mem[5] = 32'h00222000; //ADD R4,R1,R2
mips32.Mem[6] = 32'h0ce77800; //dummy instruction
mips32.Mem[7] = 32'h00832800; //ADD R5,R4,R3
mips32.Mem[8] = 32'hfc000000; // HALT
mips32.HALTED = 0;
mips32.PC = 0;
mips32.TAKEN_BRANCH = 0;
#280;
for(k = 0 ; k<6 ; k = k+1) begin
$display("R%1d - %2d" , k , mips32.regbank[k]);
end
end

initial 
begin
#300 $finish;
end
endmodule
