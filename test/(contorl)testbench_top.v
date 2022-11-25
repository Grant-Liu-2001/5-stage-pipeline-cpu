
`timescale 1ns/1ps

module testbench_top();
	
////////////////////////////////////////////////////////////
//参数定义

`define CLK_PERIORD		10		//时钟周期设置为10ns（100MHz）	

////////////////////////////////////////////////////////////
//接口申明
	
reg clk;
reg rst;
reg[5:0] op, func;
reg z;
wire m2reg, wmem, shift, aluimm, wreg, sext, jal, regrt;
wire [1:0] pcsource;
wire [4:0] aluc;

////////////////////////////////////////////////////////////	
//对被测试的设计进行例化
	
	
contorl		test(
	.clk(clk),
	.rst(rst),
	.op(op),
	.func(func),
	.z(z),
	.m2reg(m2reg),
	.wmem(wmem),
	.shift(shift),
	.aluimm(aluimm),
	.wreg(wreg),
	.sext(sext),
	.jal(jal),
	.regrt(regrt),
	.pcsource(pcsource),
	.aluc(aluc)

    );	
////////////////////////////////////////////////////////////
//复位和时钟产生

	//时钟和复位初始化、复位产生
initial begin
	clk <= 0;
	rst <= 0;
	
	op <= 'd0;
	func <= 'd0;
	z <= 'd0;
	
	
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
	
	op <= 6'b000000;
	func <= 6'b100000;
	
	repeat(15) begin
		@(posedge clk);
	end
	
	op <= 6'b001100;
	func <= 6'b100000;
	
	repeat(15) begin
		@(posedge clk);
	end
	
	#1_000;
	$stop;
end


endmodule






