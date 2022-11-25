
`timescale 1ns/1ps

module testbench_top();
	
////////////////////////////////////////////////////////////
//��������

`define CLK_PERIORD		10		//ʱ����������Ϊ10ns��100MHz��	

////////////////////////////////////////////////////////////
//�ӿ�����
	
reg clk;
reg rst;
reg [31:0] instruction;
wire[5:0] op, func;
wire [4:0] rs, rt, rd, sa;
wire [15:0] immediate;
wire [25:0] address;

////////////////////////////////////////////////////////////	
//�Ա����Ե���ƽ�������
	
	
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
//��λ��ʱ�Ӳ���

	//ʱ�Ӻ͸�λ��ʼ������λ����
initial begin
	clk <= 0;
	rst <= 0;
	
	instruction <= 0;
	
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






