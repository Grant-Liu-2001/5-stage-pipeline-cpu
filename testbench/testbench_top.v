
`timescale 1ns/1ps

module testbench_top();
	
////////////////////////////////////////////////////////////
//参数定义

`define CLK_PERIORD		10		//时钟周期设置为10ns（100MHz）	

////////////////////////////////////////////////////////////
//接口申明
	
reg clk;
reg rst;

////////////////////////////////////////////////////////////	
//对被测试的设计进行例化
	
	
cpu_main	test(
	.clk(clk),
	.rst(rst)
    );	
////////////////////////////////////////////////////////////
//复位和时钟产生

	//时钟和复位初始化、复位产生
initial begin
	clk <= 0;
	rst <= 0;
	

	
	#200;
	rst <= 1;
	
	
end
	
	//时钟产生
always #(`CLK_PERIORD/2) clk = ~clk;	

////////////////////////////////////////////////////////////
//测试激励产生

initial begin
	
	@(posedge rst);	//等待复位完成
	
	@(posedge clk);
	
	
	
	#1_000;
	$stop;
end


endmodule






