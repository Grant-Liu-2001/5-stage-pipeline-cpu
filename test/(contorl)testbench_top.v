
`timescale 1ns/1ps

module testbench_top();
	
////////////////////////////////////////////////////////////
//��������

`define CLK_PERIORD		10		//ʱ����������Ϊ10ns��100MHz��	

////////////////////////////////////////////////////////////
//�ӿ�����
	
reg clk;
reg rst;
reg[5:0] op, func;
reg z;
wire m2reg, wmem, shift, aluimm, wreg, sext, jal, regrt;
wire [1:0] pcsource;
wire [4:0] aluc;

////////////////////////////////////////////////////////////	
//�Ա����Ե���ƽ�������
	
	
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
//��λ��ʱ�Ӳ���

	//ʱ�Ӻ͸�λ��ʼ������λ����
initial begin
	clk <= 0;
	rst <= 0;
	
	op <= 'd0;
	func <= 'd0;
	z <= 'd0;
	
	
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






