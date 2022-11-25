//////////////////////////////////////////////////////////////////////////////////
// Module Name: contorl
// Author:grant
//////////////////////////////////////////////////////////////////////////////////

module contorl(
    input clk,rst,
    input [5:0] op,
    input [5:0] func,
    input z,
    output m2reg,
	output [1:0] pcsource,
	output wmem,
	output [4:0] aluc,
	output shift,
	output aluimm,
	output wreg,
	output sext,
	output jal,
	output regrt
 );
    reg m2reg_i, wmem_i, shift_i, aluimm_i, wreg_i, sext_i, jal_i, regrt_i;
	reg [1:0] pcsource_i;
	reg [4:0] aluc_i;
	
	//解析命令
	always @(*) begin
	  if(!rst) begin
	    m2reg_i <=0; 
		wmem_i <=0;
		shift_i <=0;
		aluimm_i <=0;
		wreg_i <=0;
		sext_i <=0;
		jal_i <=0;
		regrt_i <=0;
		pcsource_i <=0;
		aluc_i <=0;
	  end
	  
	 //R-type
	  else if(op == 'd0)begin
		case(func)
		//add
		6'b100000: begin
			aluc_i <= 6'd1;
			wreg_i <= 1'b1;
			pcsource_i <= 'd0;
			m2reg_i <= 1'b0;
			shift_i <= 1'b0;
			wmem_i <= 1'b0;
			aluimm_i <= 1'b0;
			sext_i <= 1'b0;
			jal_i <= 1'b0;
			regrt_i <= 1'b0;
			end
		//sub
		6'b100010: begin
			aluc_i <= 6'd2;
			wreg_i <= 1'b1;
			pcsource_i <= 'd0;
			m2reg_i <= 1'b0;
			shift_i <= 1'b0;
			wmem_i <= 1'b0;
			aluimm_i <= 1'b0;
			sext_i <= 1'b0;
			jal_i <= 1'b0;
			regrt_i <= 1'b0;
			end
		//and
		6'b100100: begin
			aluc_i <= 6'd3;
			wreg_i <= 1'b1;
			pcsource_i <= 'd0;
			m2reg_i <= 1'b0;
			shift_i <= 1'b0;
			wmem_i <= 1'b0;
			aluimm_i <= 1'b0;
			sext_i <= 1'b0;
			jal_i <= 1'b0;
			regrt_i <= 1'b0;
			end
		//or
		6'b100101: begin
			aluc_i <= 6'd4;
			wreg_i <= 1'b1;
			pcsource_i <= 'd0;
			m2reg_i <= 1'b0;
			shift_i <= 1'b0;
			wmem_i <= 1'b0;
			aluimm_i <= 1'b0;
			sext_i <= 1'b0;
			jal_i <= 1'b0;
			regrt_i <= 1'b0;
			end
		//xor
		6'b100110: begin
			aluc_i <= 6'd5;
			wreg_i <= 1'b1;
			pcsource_i <= 'd0;
			m2reg_i <= 1'b0;
			shift_i <= 1'b0;
			wmem_i <= 1'b0;
			aluimm_i <= 1'b0;
			sext_i <= 1'b0;
			jal_i <= 1'b0;
			regrt_i <= 1'b0;
			end
		//sll
		6'b000000: begin
			aluc_i <= 6'd6;
			wreg_i <= 1'b1;
			shift_i <= 1'b1;
			pcsource_i <= 'd0;
			m2reg_i <= 1'b0;
			wmem_i <= 1'b0;
			aluimm_i <= 1'b0;
			sext_i <= 1'b0;
			jal_i <= 1'b0;
			regrt_i <= 1'b0;
			end
		//srl
		6'b000010: begin
			aluc_i <= 6'd7;
			wreg_i <= 1'b1;
			shift_i <= 1'b1;
			pcsource_i <= 'd0;
			m2reg_i <= 1'b0;
			wmem_i <= 1'b0;
			aluimm_i <= 1'b0;
			sext_i <= 1'b0;
			jal_i <= 1'b0;
			regrt_i <= 1'b0;
			end
		//sra
		6'b000011: begin
			aluc_i <= 6'd8;
			wreg_i <= 1'b1;
			shift_i <= 1'b1;
			pcsource_i <= 'd0;
			m2reg_i <= 1'b0;
			wmem_i <= 1'b0;
			aluimm_i <= 1'b0;
			sext_i <= 1'b0;
			jal_i <= 1'b0;
			regrt_i <= 1'b0;
			end
		//jr
		6'b001000: begin
			aluc_i <= 6'd9;
			pcsource_i <= 'd2;
			wreg_i <= 1'b1;
			shift_i <= 1'b0;
			m2reg_i <= 1'b0;
			wmem_i <= 1'b0;
			aluimm_i <= 1'b0;
			sext_i <= 1'b0;
			jal_i <= 1'b0;
			regrt_i <= 1'b0;
			end
		//default
		default: aluc_i <= 6'd0;
		endcase
	  end
	  
	 //I-type
	  else begin
	    case(op)
		//addi
		6'b001000: begin
			aluc_i <= 6'd10;
			wreg_i <= 1'b1;
			aluimm_i <= 1'b1;
			regrt_i <= 1'b1;
			shift_i <= 1'b0;
			pcsource_i <= 'd0;
			m2reg_i <= 1'b0;
			wmem_i <= 1'b0;
			sext_i <= 1'b1;
			jal_i <= 1'b0;
			end
		//andi
		6'b001100: begin
			aluc_i <= 6'd11;
			wreg_i <= 1'b1;
			aluimm_i <= 1'b1;
			regrt_i <= 1'b1;
			shift_i <= 1'b0;
			pcsource_i <= 'd0;
			m2reg_i <= 1'b0;
			wmem_i <= 1'b0;
			sext_i <= 1'b0;
			jal_i <= 1'b0;
			end
		//ori
		6'b001101: begin
			aluc_i <= 6'd12;
			wreg_i <= 1'b1;
			aluimm_i <= 1'b1;
			regrt_i <= 1'b1;
			shift_i <= 1'b0;
			pcsource_i <= 'd0;
			m2reg_i <= 1'b0;
			wmem_i <= 1'b0;
			sext_i <= 1'b0;
			jal_i <= 1'b0;
			end
		//xori
		6'b001110: begin
			aluc_i <= 6'd13;
			wreg_i <= 1'b1;
			aluimm_i <= 1'b1;
			regrt_i <= 1'b1;
			shift_i <= 1'b0;
			pcsource_i <= 'd0;
			m2reg_i <= 1'b0;
			wmem_i <= 1'b0;
			sext_i <= 1'b0;
			jal_i <= 1'b0;
			end
		//lw
		6'b100011: begin
			aluc_i <= 6'd14;
			wmem_i <= 1'b0;
			wreg_i <= 1'b1;
			aluimm_i <= 1'b1;
			regrt_i <= 1'b1;
			m2reg_i <= 1'b1;
			sext_i <= 1'b1;
			shift_i <= 1'b0;
			pcsource_i <= 'd0;

			jal_i <= 1'b0;
			end
		//sw
		6'b101011: begin
			aluc_i <= 6'd15;
			wmem_i <= 1'b1;
			wreg_i <= 1'b0;
			aluimm_i <= 1'b1;
			regrt_i <= 1'b1;
			m2reg_i <= 1'b1;
			sext_i <= 1'b1;
			shift_i <= 1'b0;
			pcsource_i <= 'd0;
			jal_i <= 1'b0;
			end
		//beq
		6'b000100: begin
			aluc_i <= 6'd16;
			sext_i <= 1'b1;
			regrt_i <= 1'b1;
			wmem_i <= 1'b0;
			wreg_i <= 1'b0;
			aluimm_i <= 1'b0;
			m2reg_i <= 1'b0;
			shift_i <= 1'b0;
			jal_i <= 1'b0;
			pcsource_i <= (z)? 'd1 : 'd0;
			end
		//bne
		6'b000101: begin
			aluc_i <= 6'd17;
			sext_i <= 1'b1;
			regrt_i <= 1'b1;
			wmem_i <= 1'b0;
			wreg_i <= 1'b0;
			aluimm_i <= 1'b0;
			m2reg_i <= 1'b0;
			shift_i <= 1'b0;
			jal_i <= 1'b0;
			pcsource_i <= (z)? 'd1 : 'd0;
			end
		//lui
		6'b001111: begin
			aluc_i <= 6'd18;
			wreg_i <= 1'b1;
			aluimm_i <= 1'b1;
			regrt_i <= 1'b1;
			shift_i <= 1'b0;
			pcsource_i <= 'd0;
			m2reg_i <= 1'b0;
			wmem_i <= 1'b0;
			sext_i <= 1'b0;
			jal_i <= 1'b0;
			end
		//J-type
		//j
		6'b000010: begin
			aluc_i <= 6'd19;
			pcsource_i <= 'd3;
			wreg_i <= 1'b0;
			shift_i <= 1'b0;
			m2reg_i <= 1'b0;
			wmem_i <= 1'b0;
			aluimm_i <= 1'b0;
			sext_i <= 1'b0;
			jal_i <= 1'b0;
			regrt_i <= 1'b0;
			end
		//jal
		6'b000011: begin
			aluc_i <= 6'd20;
			pcsource_i <= 'd3;
			wreg_i <= 1'b1;
			jal_i <= 1'b1;
			shift_i <= 1'b0;
			m2reg_i <= 1'b0;
			wmem_i <= 1'b0;
			aluimm_i <= 1'b0;
			sext_i <= 1'b0;
			regrt_i <= 1'b0;
			end
		//default
		default : aluc_i <= 6'd0;
		endcase
	  end
	end
    
	assign m2reg = m2reg_i;
	assign wmem = wmem_i;
	assign shift = shift_i;
	assign aluimm = aluimm_i;
	assign wreg = wreg_i;
	assign sext = sext_i;
	assign jal = jal_i;
	assign regrt = regrt_i;
	assign pcsource = pcsource_i;
	assign aluc = aluc_i;
	
endmodule








