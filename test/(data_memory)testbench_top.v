
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
reg [31:0] wdata, address;
wire[31:0] mem_data;

////////////////////////////////////////////////////////////	
//对被测试的设计进行例化
	
	
data_memory	test(
	.clk(clk),
	.rst(rst),
	.wdata(wdata),
	.write_control(write_control),
	.address(address),
	.mem_data(mem_data)

    );	
////////////////////////////////////////////////////////////
//复位和时钟产生

	//时钟和复位初始化、复位产生
initial begin
	clk <= 0;
	rst <= 0;
	
	
	wdata <= 'd0;
	write_control <= 'd0;
	address <= 'd0;
	
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
	address <= 'd10;
	
	repeat(15) begin
		@(posedge clk);
	end
	
	wdata <= 'd56;
	write_control <= 'd1;
	address <= 'd0;
	
	repeat(15) begin
		@(posedge clk);
	end
	
	wdata <= 'd56;
	write_control <= 'd1;
	address <= 'd20;
	
	repeat(15) begin
		@(posedge clk);
	end
	
	
	#1_000;
	$stop;
end


endmodule






