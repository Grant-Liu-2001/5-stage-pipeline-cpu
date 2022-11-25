
`timescale 1ns/1ps

module testbench_top();
	
////////////////////////////////////////////////////////////
//参数定义

`define CLK_PERIORD		10		//时钟周期设置为10ns（100MHz）	

////////////////////////////////////////////////////////////
//接口申明
	
reg clk;
reg rst;
reg [31:0] instruction;
wire[5:0] op, func;
wire [4:0] rs, rt, rd, sa;
wire [15:0] immediate;
wire [25:0] address;

////////////////////////////////////////////////////////////	
//对被测试的设计进行例化
	
	
instruction_memory	test(
	.clk(clk),
	.rst(rst),
	.instruction(instruction),
	.op(op),
	.func(func),
	.rs(rs),
	.rt(rt),
	.rd(rd),
	.sa(sa),
	.immediate(immediate),
	.address(address)

    );	
////////////////////////////////////////////////////////////
//复位和时钟产生

	//时钟和复位初始化、复位产生
initial begin
	clk <= 0;
	rst <= 0;
	
	instruction <= 0;
	
	#1000;
	rst <= 1;
	
	
end
	
	//时钟产生
always #(`CLK_PERIORD/2) clk = ~clk;	

////////////////////////////////////////////////////////////
//测试激励产生

initial begin
	
	@(posedge rst);	//等待复位完成
	
	@(posedge clk);
	
	instruction <= 32'b000000_00101_00110_00111_00000_100000;
	
	repeat(15) begin
		@(posedge clk);
	end
	
	instruction <= 32'b001000_00101_00110_00111_00000_100000;
	
	repeat(15) begin
		@(posedge clk);
	end
	
	
	#1_000;
	$stop;
end


endmodule






