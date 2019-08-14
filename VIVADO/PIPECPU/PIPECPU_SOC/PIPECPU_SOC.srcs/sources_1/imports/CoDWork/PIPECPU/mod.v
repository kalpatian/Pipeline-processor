
module alu (a,b,aluc,r,z);
	input signed [31:0] a,b;
	input [3:0] aluc;
	output signed [31:0] r;
	output z;
	reg [31:0] r;

	wire [31:0] d_and = a&b;
	wire [31:0] d_or=a | b;
	wire [31:0] d_xor = a^b;
	wire [31:0] d_lui = {b[15:0],16'h0};
	wire [31:0] d_and_or = aluc[2]?d_or : d_and;
	wire [31:0] d_xor_lui = aluc[2]?d_lui : d_xor;
	wire [31:0] d_as,d_sh,set_s;
	wire [31:0] d_nor = ~(a|b);
	wire [31:0] shift_v;
	setless set (.a(a),.b(b),.aluc(aluc),.set_s(set_s)); 
	addsub32 as32 (.a(a),.b(b),.sub(aluc[2]),.s(d_as));
	shift shifter (.d(b),.sa(a[4:0]),.right(aluc[2]),.arith(aluc[3]),.sh(d_sh));
	shiftv shifterv (.d(b),.sa(a),.sign(aluc),.sh(shift_v));	//srlv  sllv
	always @(*) begin 
		case (aluc)
			4'b0000: r = d_as;//ADD
			4'b0001: r = d_and_or;//AND
			4'b0010: r = d_xor_lui;//XOR
			4'b0011: r = d_sh;//SLL
			4'b0100: r = d_as;//SUB
			4'b0101: r = d_and_or;//OR
			4'b0110: r = d_xor_lui;//LUI
			4'b0111: r = d_sh;//SRL
			4'b1000: r = set_s;//SLT
			4'b1001: r = shift_v;//SLLV
			4'b1010: r = d_nor;//NOR
			4'b1100: r = shift_v;//SRLV
			4'b1111: r = d_sh;//SRA
			default: r = b;
		endcase
	end
	
	   
	//slt实现思路：aluc为1000时，实现此运算。将4选1改成n选1.如果转不过来，将muxnx32重写，按照书上的aluc，将x转化为实数挨个书写！一定能成功的！
	


//	mux7x32 select (.a0(d_as),.a1(d_and_or),.a2(d_xor_lui),.a3(d_sh),.a4(set_s),.a5(shift_v),.a6(d_nor),.s(aluc),.y(r)); //!!!7选1 还没写！
	assign z = ~|r; //0标志位
endmodule

module setless (a,b,aluc,set_s);
	input signed [31:0] a,b;
	input [3:0] aluc;
	output signed [31:0] set_s;
	reg [31:0] set_s;
	always @(*)
		if(aluc == 4'b1000 )	begin
			if(a[31]==1&&b[31]==0)	begin
				set_s = 32'd1;
			end
			else if(a[31]==0&&b[31]==1)  begin
				set_s = 32'd0;
			end
			else if(a[31]==0&&b[31]==0)	begin
				set_s = (a[30:0]<b[30:0]) ? 32'd1:32'd0;
			end
			else	begin
				set_s = (a[30:0]>b[30:0]) ? 32'd1:32'd0;
			end
		end
		else begin
			set_s = a;
		end
		
endmodule

module addsub32 (a,b,sub,s);
	input signed [31:0] a,b;
	input sub;
	output signed [31:0] s;
	cla32 as32 (.a(a),.b(b^{32{sub}}),.ci(sub),.s(s));
endmodule

module cla32 (a,b,ci,s);
	input signed [31:0] a,b;
	input ci;
	output signed [31:0] s;

	wire g_out,p_out;
	cla_32 cla (.a(a),.b(b),.c_in(ci),.g_out(g_out),.p_out(p_out),.s(s));

endmodule

module shift (d,sa,right,arith,sh);
	input signed [31:0] d;
	input [4:0] sa;
	input right,arith;
	output signed [31:0] sh;
	reg [31:0] sh;
	always @* begin
		if (!right)	begin	
			sh = d<<sa;
		end else if (!arith) 	begin
			sh = d>>sa;
		end else begin
			sh = $signed(d) >>>sa;
		end
	end
endmodule

module shiftv (d,sa,sign,sh);
	input signed [31:0] d,sa;
	input [3:0] sign;
	output signed [31:0] sh;
	reg [31:0] sh;
	always @* begin
		if (sign == 4'b1001)	begin	
			sh = d<<sa;
		end else if (sign == 4'b1100) 	begin
			sh = d>>sa;
		end 
		else begin	
			sh = d;
		end
	end
endmodule