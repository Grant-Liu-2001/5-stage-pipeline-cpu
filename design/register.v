//////////////////////////////////////////////////////////////////////////////////
// Module Name: register
// Author:grant
//////////////////////////////////////////////////////////////////////////////////

module register(
    input clk,rst,
    input write_control,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] wn,
    input [31:0] wdata,
    output [31:0] rs_data,
    output [31:0] rt_data
 );
    // 32-bit register with 32 entries
	reg [31:0] file [1:31];
	integer i;
	
	//寄存器初始化与写入数据
	always @(negedge clk) begin
	  if(!rst) begin
	    for (i=0; i<32; i=i+1)begin
		  file[i] <= 0;
	    end
	  end
	 
	  else if(write_control && wn)begin
		  file[wn] <= wdata;
	  end
	end
    
	//取出数据
	assign rs_data = (rs == 0) ? 0: file[rs];
	assign rt_data = (rt == 0) ? 0: file[rt];
	
endmodule








