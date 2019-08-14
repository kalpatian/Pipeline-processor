module pipepc(npc,wpc,clk,clrn,pc);
	input [31:0] npc;
	input wpc,clk,clrn;
	output [31:0] pc;
	dffe32 program_counter (.d(npc),.clk(clk),.clrn(clrn),.e(wpc),.q(pc));
endmodule