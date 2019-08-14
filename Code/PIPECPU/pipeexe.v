module pipeexe (ealuc,ealuimm,ea,eb,eimm,eshift,ern0,epc4,ejal,ern,ealu);
	input  [31:0] ea,eb,eimm,epc4;
	input [4:0] ern0;
	input [3:0] ealuc;
	input ealuimm,eshift,ejal;
	output [31:0] ealu;
	output [4:0] ern;
	wire [31:0] alua,alub,sa,ealu0,epc8;
	wire z;
	assign sa = {eimm[5:0],eimm[31:6]};  //shift amount
	cla32 ret_addr (.a(epc4),.b(32'h4),.ci(1'b0),.s(epc8));
	mux2x32 alu_ina (.a0(ea),.a1(sa),.s(eshift),.y(alua));
	mux2x32 alu_inb (.a0(eb),.a1(eimm),.s(ealuimm),.y(alub));
	mux2x32 save_pc8 (.a0(ealu0),.a1(epc8),.s(ejal),.y(ealu));
	assign ern = ern0 | {5{ejal}};
	alu al_unit (.a(alua),.b(alub),.aluc(ealuc),.r(ealu0),.z(z));
endmodule