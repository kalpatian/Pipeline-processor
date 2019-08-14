module pipeif (pcsource,ins,pc,bpc,rpc,jpc,npc,pc4,inst);
	input [31:0] pc,bpc,rpc,jpc,ins;
	input [1:0] pcsource;
	output [31:0] npc,pc4,inst;
	mux4x32 next_pc (.a0(pc4),.a1(bpc),.a2(rpc),.a3(jpc),.s(pcsource),.y(npc));
	cla32 pc_plus4 (.a(pc),.b(32'h4),.ci(1'b0),.s(pc4));
//	pipeimem inst_mem (.a(pc),.inst(ins));
	//inst=ins;
	assign inst=ins;
endmodule