
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
reg [31:0] wdata;
reg[4:0] rs, rt, rd;
wire[31:0] rs_data, rt_data;

////////////////////////////////////////////////////////////	
//�Ա����Ե���ƽ�������
	
	
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
//��λ��ʱ�Ӳ���

	//ʱ�Ӻ͸�λ��ʼ������λ����
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
	
	//ʱ�Ӳ���
always #(`CLK_PERIORD/2) clk = ~clk;	

////////////////////////////////////////////////////////////
//���Լ�������

initial begin
	
	@(posedge rst);	//�ȴ���λ���
	
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






