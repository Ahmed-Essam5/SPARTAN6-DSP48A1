module DSP48A1_Project_reg (clk,enable,rst,in,out);

	parameter REGISTER=1; //1 reg, 0 no reg
	parameter RSTTYPE="SYNC";
	parameter WIDTH=18;

	input clk,enable,rst;
	input [WIDTH-1:0] in;
	output reg [WIDTH-1:0] out;

	generate
		if (REGISTER==0) begin
			always @(*) begin
				out=in;
			end
		end
		else if (RSTTYPE=="ASYNC") begin
			always @(posedge clk or posedge rst) begin
				if(rst) begin
					out<=0;
				end
				else if (enable) begin
					out<=in;
				end
			end
		end
		else begin
			always @(posedge clk) begin
				if(enable) begin
					if (rst) begin
						out<=0;
					end
					else begin
						out<=in;
					end
				end
			end
		end
	endgenerate

endmodule