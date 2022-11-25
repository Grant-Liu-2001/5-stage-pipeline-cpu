//////////////////////////////////////////////////////////////////////////////////
// Module Name: instruction memory
// Author:grant
//////////////////////////////////////////////////////////////////////////////////

module instruction_memory(
    input clk,rst,
    input [31:0] addr_pc,
	output [5:0] op,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] sa,
    output [5:0] func,
    output [15:0] immediate,
	output [25:0] address
 );
 
	parameter [31:0] order = 'd50;
    reg [31:0] instruction;
	reg [31:0] mem [0:order];
	reg loading;
	integer i;
	
	always @(*) begin
		if (!rst) begin
			instruction <= 'd0;
			loading <= 'b1;
		for (i=32'b0; i<order; i=i+1'b1)begin
			mem[i] <= 32'b0;
			end
		end	
		//写入指令
		else if(loading) begin
			mem[0] <= 32'b001000_00000_00001_0000000000001010; 
			mem[1] <= 32'b001000_00000_11110_0000000000010100;
			mem[2] <= 32'b001000_00000_00111_0000000000000000;
			mem[3] <= 32'b001000_00000_10110_0000000000000000;
			mem[4] <= 32'b000000_11110_00001_00111_00000_100000;
			mem[5] <= 32'b000000_00111_11110_10110_00000_100010;
			mem[6] <= 32'b101011_10110_10110_0000000000000000;
			mem[7] <= 32'b000000_00000_00000_00000_00000_000000;
			mem[8] <= 32'b000000_00000_00000_00000_00000_000000;
			mem[9] <= 32'b000000_00000_00000_00000_00000_000000;
			mem[10] <= 32'b000000_00000_00000_00000_00000_000000;
			mem[11] <= 32'b000000_00000_00000_00000_00000_000000;
			mem[12] <= 32'b000000_00000_00000_00000_00000_000000;
			loading <= 'b0;
		end
		
		else if(addr_pc[31:2] < order) begin
			instruction <= mem[addr_pc[31:2]];
		end 
		
		else instruction <= 'd0;
	
	
	end
	//decode
	assign op = instruction [31:26];
	assign rs = instruction [25:21];
	assign rt = instruction [20:16];
	assign rd = instruction [15:11];
	assign sa = instruction [10:6];
	assign func = instruction [5:0];
	assign immediate = instruction [15:0];
	assign address = instruction [25:0];
	
endmodule








