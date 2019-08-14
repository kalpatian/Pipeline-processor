module dffe32 (d,clk,clrn,e,q);
	input [31:0] d;
	input clk,clrn,e;
	output [31:0] q;
	reg [31:0] q;
	always @ (posedge clrn or posedge clk)
		if (clrn == 1)	begin
			q<=0;
		end else begin
			if (e)		q<= d;
		end
endmodule