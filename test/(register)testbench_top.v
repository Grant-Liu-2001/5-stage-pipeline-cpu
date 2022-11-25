
`timescale 1ns/1ps

module testbench_top();
	
////////////////////////////////////////////////////////////
//参数定义

`define CLK_PERIORD		10		//时钟周期设置为10ns（100MHz）	

////////////////////////////////////////////////////////////
//接口申明
	
reg clk;
reg rst;
reg write_control;
reg [31:0] wdata;
reg[4:0] rs, rt, rd;
wire[31:0] rs_data, rt_data;

////////////////////////////////////////////////////////////	
//对被测试的设计进行例化
	
	
register	test(
	.clk(clk),
	.rst(rst),
	.rs_data(rs_data),
	.rt_data(rt_data),
	.wdata(wdata),
	.write_control(write_control),
	.rs(rs),
	.rt(rt),
	.rd(rd)
    );	
////////////////////////////////////////////////////////////
//复位和时钟产生

	//时钟和复位初始化、复位产生
initial begin
	clk <= 0;
	rst <= 0;
	
	
	wdata <= 'd0;
	write_control <= 'd0;
	rs <= 'd0;
	rt <= 'd0;
	rd <= 'd0;
	
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
	
	wdata <= 'd44;
	write_control <= 'd0;
	rs <= 'd5;
	rt <= 'd4;
	rd <= 'd2;
	
	repeat(15) begin
		@(posedge clk);
	end
	
	wdata <= 'd56;
	write_control <= 'd1;
	rs <= 'd7;
	rt <= 'd8;
	rd <= 'd10;
	
	repeat(15) begin
		@(posedge clk);
	end
		
	
	
	#1_000;
	$stop;
end


endmodule






