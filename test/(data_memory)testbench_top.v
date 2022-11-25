
`timescale 1ns/1ps

module testbench_top();
	
////////////////////////////////////////////////////////////
//��������

`define CLK_PERIORD		10		//ʱ����������Ϊ10ns��100MHz��	

////////////////////////////////////////////////////////////
//�ӿ�����
	
reg clk;
reg rst;
reg write_control;
reg [31:0] wdata, address;
wire[31:0] mem_data;

////////////////////////////////////////////////////////////	
//�Ա����Ե���ƽ�������
	
	
data_memory	test(
	.clk(clk),
	.rst(rst),
	.wdata(wdata),
	.write_control(write_control),
	.address(address),
	.mem_data(mem_data)

    );	
////////////////////////////////////////////////////////////
//��λ��ʱ�Ӳ���

	//ʱ�Ӻ͸�λ��ʼ������λ����
initial begin
	clk <= 0;
	rst <= 0;
	
	
	wdata <= 'd0;
	write_control <= 'd0;
	address <= 'd0;
	
	#1000;
	rst <= 1;
	
	
end
	
	//ʱ�Ӳ���
always #(`CLK_PERIORD/2) clk = ~clk;	

////////////////////////////////////////////////////////////
//���Լ�������

initial begin
	
	@(posedge rst);	//�ȴ���λ���
	
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






