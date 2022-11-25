
`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: cpu
// Author:Grant
//////////////////////////////////////////////////////////////////////////////////

//include
`include "instruction_memory.v"
`include "contorl.v"
`include "register.v"
`include "data_memory.v"
`include "ALU.v" 

module cpu_main(
	input clk,
	input rst
    );
	
	//stage 1 参数
	reg [31:0] PC, PC_r1, PC_r2;
	
	
	wire [5:0] op, func;
	reg [5:0] op_r1, func_r1;
	
	wire [4:0] rs, rt, rd, sa;
	reg [4:0] rs_r1, rt_r1, rd_r1, sa_r1;
	
	wire [15:0] immediate;
	reg [15:0] immediate_r1;
	
	wire [25:0] address;
	reg [25:0] address_r1;
	
	//stage 2 参数
	wire [1:0] pcsource;
	
	wire [4:0] aluc;
	reg [4:0] aluc_r2;
	
	wire m2reg, wmem, shift, aluimm, wreg, sext, jal, regrt;
	reg m2reg_r2, wmem_r2, shift_r2, aluimm_r2, wreg_r2, jal_r2;
	
	reg [4:0] wn_r2, sa_r2;
	
	reg [31:0] immediate_r2;
	
	reg [31:0] data1, data2;
	
	//wire z;
	reg z_r;
	
	//register 参数
	wire [31:0] rs_data, rt_data;
	reg [31:0] rs_data_r2, rt_data_r2;
	
	//stage 3 参数
	reg wreg_r3, m2reg_r3, wmem_r3;
	
	reg [4:0] wn_r3;
	
	reg [31:0] rt_data_r3;
	
	wire[31:0] rdata;
	reg [31:0] rdata_r3;
	
	//stage 4 参数
	reg wreg_r4;
	
	reg [4:0] wn_r4;
	
	wire[31:0] mem_data;
	
	reg[31:0] wdata_r4;


	
	//stage 1 (IF)
	always @(posedge clk) begin
		if(!rst) begin
			PC <= 'd0;
			op_r1 <= 'd0;
			func_r1 <= 'd0;
			rs_r1 <= 'd0;
			rt_r1 <= 'd0;
			rd_r1 <= 'd0;
			sa_r1 <= 'd0;
			immediate_r1 <= 'd0;
			address_r1 <= 'd0;
			z_r <= 'd0;
			PC_r1 <= 'd0;
		end
	//数据送入寄存器1	
		else begin
			op_r1 <= op;
			func_r1 <= func;
			rs_r1 <= rs;
			rt_r1 <= rt;
			rd_r1 <= rd;
			sa_r1 <= sa;
			immediate_r1 <= immediate;
			address_r1 <= address;
			PC_r1 <= PC + 'd4;
			//实现转移指令
			case(pcsource)
			2'b00:PC <= PC + 'd4; //无跳转指令
			2'b01:PC <= PC_r1 + ({{16{immediate_r1[15]}}, immediate_r1[15:0]} << 2); //beq bne
			2'b10:PC <= rs_data;  //jr
			2'b11:PC <= {PC_r1[31:28],address_r1 << 2}; //j jal
			endcase
		end
	end

instruction_memory inst_mem(
	.clk(clk),
	.rst(rst),
	.addr_pc(PC),
	.op(op),
	.rs(rs),
	.rt(rt),
	.rd(rd),
	.sa(sa),
	.func(func),
	.immediate(immediate),
	.address(address)
);

	//stage 2 (ID)
	always @(posedge clk) begin
		if(!rst) begin
		aluc_r2 <= 'd0;
		m2reg_r2 <= 'd0;
		wmem_r2 <= 'd0;
		shift_r2 <= 'd0;
		wreg_r2 <= 'd0;
		jal_r2 <= 'd0;
		wn_r2 <= 'd0;
		immediate_r2 <= 'd0;
		rs_data_r2 <= 'd0;
		rt_data_r2 <= 'd0;
		data2 <= 'd0;
		aluimm_r2 <= 'd0;
		PC_r2 <= 'd0;
		sa_r2 <= 'd0;
		end
	//数据送入寄存器2	
		else begin
		jal_r2 <= jal;
		PC_r2 = PC_r1 + 'd4;
		wreg_r2 <= wreg;
		m2reg_r2 <= m2reg;
		wmem_r2 <= wmem;
		aluc_r2 <= aluc;
		/* rs_data_r2 <= rs_data;
		rt_data_r2 <= rt_data; */
		
		//wn_r2 == rs
			if((wn_r2 == rs_r1) && wreg_r2) begin 
				rs_data_r2 <= rdata;
			end
			else if((wn_r3 == rs_r1) && wreg_r3) begin 
				rs_data_r2 <= rdata_r3;
			end
			else begin
				rs_data_r2 <= rs_data;
			end
		//wn_r2 == rt
			if((wn_r2 == rt_r1) && wreg_r2) begin 
				rt_data_r2 <= rdata;
			end
			else if((wn_r3 == rt_r1) && wreg_r3) begin 
				rt_data_r2 <= rdata_r3;
			end
			else begin
				rt_data_r2 <= rt_data;
			end
		
		aluimm_r2 <= aluimm;
		sa_r2 <= sa_r1;
		shift_r2 <= shift;
	//立即数拓展
		 case (regrt)
		 //R-type
		 'b0: wn_r2 <= rd_r1;
		 //I-tyoe
		 'b1: wn_r2 <= rt_r1;
		 endcase
	
	/* //立即数计算或R-type计算
		 case (aluimm)
		 //r-type
		 'b0: data2 <= rt_data_r2;
		 //immediate
		 'b1: data2 <= immediate_r2;
		 endcase */
		end
	end
	
	//内部前推
	/* always @(*) begin
		if(!rst) begin
		end
		
		else begin
		//wn_r2 == rs
			if((wn_r2 == rs) & wreg_r2) begin 
				rs_data_r2 <= rdata;
			end
			else begin
				rs_data_r2 <= rs_data;
			end
		//wn_r2 == rt
			if((wn_r2 == rt) & wreg_r2) begin 
				rt_data_r2 <= rdata;
			end
			else begin
				rt_data_r2 <= rt_data;
			end
		end
	end */
	
	//拓展模块e	 
	always @(posedge clk) begin
		case (sext) 
		//0拓展
		'b0: immediate_r2 <= {16'h0, immediate_r1[15:0]};
		//符号位拓展
		'b1: immediate_r2 <= {{16{immediate_r1[15]}}, immediate_r1[15:0]};
		 endcase
	end
	
	//rs st对应数据比较	 
	always @(*) begin
		case (aluc) 
		//beq
		6'd16: z_r <= (rs_data == rt_data)? 1'b1:1'b0;
		//bne
		6'd17: z_r <= (rs_data != rt_data)? 1'b1:1'b0;
		default: z_r <= 'd0;
		endcase
	end
	
contorl ctl(
	.clk(clk),
	.rst(rst),
	.op(op_r1),
	.func(func_r1),
	.z(z_r),
	.m2reg(m2reg),
	.pcsource(pcsource),
	.wmem(wmem),
	.aluc(aluc),
	.shift(shift),
	.aluimm(aluimm),
	.wreg(wreg),
	.sext(sext),
	.jal(jal),
	.regrt(regrt)
);

	
register regi(
	.clk(clk),
	.rst(rst),
	.write_control(wreg_r4),
	.rs(rs_r1),
	.rt(rt_r1),
	.wn(wn_r4),
	.wdata(wdata_r4),
	.rs_data(rs_data),
	.rt_data(rt_data)
);

	
	//stage 3 (EXE)
	always @(posedge clk) begin
		if(!rst) begin
		wreg_r3 <= 'd0;
		m2reg_r3 <= 'd0;
		wmem_r3 <= 'd0;
		rt_data_r3 <= 'd0;
		rdata_r3 <= 'd0;
		wn_r3 <= 'd0;
		end
		else begin
		wreg_r3 <= wreg_r2;
		m2reg_r3 <= m2reg_r2;
		wmem_r3 <= wmem_r2;
		
		//jal
		case(jal_r2)
			1'b0:begin wn_r3 <= wn_r2;
					   rdata_r3 <= rdata;
				 end
			1'b1:begin wn_r3 <= 'd31;
					   rdata_r3 <= PC_r2;
				 end
		endcase
		rt_data_r3 <= rt_data_r2;
		
		end
	end

	always @(*) begin
	//是否左移或右移
		 case (shift_r2)
		 //未移动
		 'b0: data1 <= rs_data_r2;
		 //移动
		 'b1: data1 <= sa_r2;
		 endcase
	//立即数计算或R-type计算
		 case (aluimm_r2)
		 //r-type
		 'b0: data2 <= rt_data_r2;
		 //immediate
		 'b1: data2 <= immediate_r2;
		 endcase
	end
ALU alu(
	.clk(clk),
	.rst(rst),
	.data1(rs_data_r2),
	.data2(data2),
	.aluc(aluc_r2),
	//.z(z),
	.rdata(rdata)
);	


	//sdage 4 (MEM)
	always @(posedge clk) begin
		if(!rst) begin
		wreg_r4 <= 'd0;
		wn_r4 <= 'd0;
		wdata_r4 <= 'd0;
		end
		else begin
		wreg_r4 <= wreg_r3;
		wn_r4 <= wn_r3;
		//写入register的数据
		 case(m2reg_r3)
		 //rdata
		 'd0: wdata_r4 <= rdata_r3;
		 //mem_data
		 'd1: wdata_r4 <= mem_data;
		 endcase
		end
	end
	
data_memory d_mem(
	.clk(clk),
	.rst(rst),
	.write_control(wmem_r3),
	.address(rdata_r3),
	.wdata(rt_data_r3),
	.mem_data(mem_data)
);
endmodule