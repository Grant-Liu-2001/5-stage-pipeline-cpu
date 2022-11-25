
`timescale 1ns/1ps

module testbench_top();
	
////////////////////////////////////////////////////////////
//��������

`define CLK_PERIORD		10		//ʱ����������Ϊ10ns��100MHz��	

////////////////////////////////////////////////////////////
//�ӿ�����
	
reg clk;
reg rst;
reg [31:0] data1, data2;
reg[4:0] aluc;
wire z;
wire [31:0] rdata;

////////////////////////////////////////////////////////////	
//�Ա����Ե���ƽ�������
	
	
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
//��λ��ʱ�Ӳ���

	//ʱ�Ӻ͸�λ��ʼ������λ����
initial begin
	clk <= 0;
	rst <= 0;
	
	data1 <= 'd0;
	data2 <= 'd0;
	aluc <= 'd0;
	
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






