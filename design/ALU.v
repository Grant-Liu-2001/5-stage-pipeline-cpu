//////////////////////////////////////////////////////////////////////////////////
// Module Name: ALU
// Author:grant
//////////////////////////////////////////////////////////////////////////////////

module ALU(
    input clk,rst,
    input [31:0] data1,
	input [31:0] data2,
	input [4:0] aluc,
	//output  z,
    output [31:0] rdata
    
 );
    reg [31:0] rdata_i;
	reg z_i;
	
	always @(*) begin
		if (!rst) begin
		 rdata_i <= 0;
		 z_i <= 0;
		end
		else begin
			case(aluc)
			//add addi
			6'd1,6'd10: rdata_i <= data1 + data2;
			//sub
			6'd2: rdata_i <= data1 - data2;
			//and andi
			6'd3,6'd11: rdata_i <= data1 & data2;
			//or ori
			6'd4,6'd12: rdata_i <= data1 | data2;
			//xor xori
			6'd5,6'd13: rdata_i <= data1 ^ data2;
			//sll
			6'd6: rdata_i <= data2 << data1[4:0];
			//srl
			6'd7: rdata_i <= data2 >> data1[4:0];
			//sra
			6'd8: rdata_i <= data2 >>> data1[4:0];
			//lw sw
			6'd14,6'd15: rdata_i <= data1 + data2;
			//比较函数前移
				//beq
				//6'd16: z_i <= (data1 == data2)? 1'b1:1'b0;
				//bne
				//6'd17: z_i <= (data1 != data2)? 1'b1:1'b0;
			//lui
			6'd18: rdata_i <= data2 << 5'd16;
			
			default: rdata_i <= 0;
			endcase
		end
	
	end
	
	assign rdata = rdata_i;
	//assign z = z_i;
	
endmodule








