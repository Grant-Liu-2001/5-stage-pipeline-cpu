//////////////////////////////////////////////////////////////////////////////////
// Module Name: data memory
// Author:grant
//////////////////////////////////////////////////////////////////////////////////

module data_memory(
    input clk,rst,
    input write_control,
    input [31:0] address,
    input [31:0] wdata,
    output [31:0] mem_data
 );
    // for循环只能建立16位二进制数数量的memory
	reg [31:0] mem [1:32'hFF];
	integer i;
	
	//寄存器初始化与写入数据
	always @(*) begin
	  if(!rst) begin
	    for (i=32'b0; i<32'hFF; i=i+1'b1)begin
		  mem[i] <= 32'b0;
	    end
	  end
	 
	  else if(write_control && address)begin
		  mem[address[15:0]] <= wdata;
	  end
	end
    
	//取出数据
	assign mem_data = (address == 32'b0) ? 32'b0: mem[address[7:0]];
	
endmodule








