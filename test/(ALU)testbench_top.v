
`timescale 1ns/1ps

module testbench_top();
	
////////////////////////////////////////////////////////////
//参数定义

`define CLK_PERIORD		10		//时钟周期设置为10ns（100MHz）	

////////////////////////////////////////////////////////////
//接口申明
	
reg clk;
reg rst;
reg [31:0] data1, data2;
reg[4:0] aluc;
wire z;
wire [31:0] rdata;

////////////////////////////////////////////////////////////	
//对被测试的设计进行例化
	
	
ALU	test(
	.clk(clk),
	.rst(rst),
	.data1(data1),
	.data2(data2),
	.aluc(aluc),
	.z(z),
	.rdata(rdata)

    );	
////////////////////////////////////////////////////////////
//复位和时钟产生

	//时钟和复位初始化、复位产生
initial begin
	clk <= 0;
	rst <= 0;
	
	data1 <= 'd0;
	data2 <= 'd0;
	aluc <= 'd0;
	
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
	
	data1 <= 'd32;
	data2 <= 'd15;
	aluc <= 'd1;
	
	repeat(15) begin
		@(posedge clk);
	end
	
	data1 <= 'd12;
	data2 <= 'd12;
	aluc <= 'd16;
	
	repeat(15) begin
		@(posedge clk);
	end
		
	data1 <= 'd12;
	data2 <= 'd15;
	aluc <= 'd17;
	
	repeat(15) begin
		@(posedge clk);
	end
	
	
	#1_000;
	$stop;
end


endmodule






