module mux2x32 (a0,a1,s,y);
	input [31:0] a0,a1;
	input s;
	output [31:0] y;
	assign y = s?a1:a0;
endmodule

module mux4x32 (a0,a1,a2,a3,s,y);
	input [31:0] a0,a1,a2,a3;
	input [1:0] s;
	output [31:0] y;
	function [31:0] select;
		input [31:0] a0,a1,a2,a3;
		input [1:0] s;
		case (s)
			2'b00: select = a0;
			2'b01: select = a1;
			2'b10: select = a2;
			2'b11: select = a3;
		endcase
	endfunction
	assign y = select(a0,a1,a2,a3,s);
endmodule

module mux2x5 (a0,a1,s,y);
	input [4:0] a0,a1;
	input s;
	output [4:0] y;
	assign y = s?a1:a0;
endmodule

/*module mux7x32 (a0,a1,a2,a3,a4,a5,a6,s,y);
	input [31:0] a0,a1,a2,a3,a4,a5,a6; //a0:add sub
	//a1:and or
	//a2:xor lui
	//a3:sll,srl,sra
	//a4:slt
	//a5:sllv,srlv
	//a6:nor
	input [3:0] s;
	output [31:0] y;
	function [31:0] select;
		input [31:0] a0,a1,a2,a3,a4,a5,a6;
		input [3:0] s;
		case (s)
			4'b0000: select = a0;//ADD
			4'b0001: select = a1;//AND
			4'b0010: select = a2;//XOR
			4'b0011: select = a3;//SLL
			4'b0100: select = a0;//SUB
			4'b0101: select = a1;//OR
			4'b0110: select = a2;//LUI
			4'b0111: select = a3;//SRL
			4'b1000: select = a4;//SLT
			4'b1001: select = a5;//SLLV
			4'b1010: select = a6;//NOR
			4'b1100: select = a5;//SRLV
			4'b1111: select = a3;//SRA
			default: select = a0;
		endcase
	endfunction
	assign y = select(a0,a1,a2,a3,a4,a5,a6,s);
endmodule
	*/	