module sccpu (clock,resetn,instr,mmo,reg_sel,aluout,
						pc,mb,mwmem,reg_data);
		input clock,resetn;
		input [31:0] instr; //来自指令存储器
		input [31:0] mmo; //readdata
		output [31:0] pc,mb; //mb是writedata
		output [31:0] aluout;
		output mwmem;
//for debug use:		
		input [4:0] reg_sel;
		output [31:0] reg_data;
		wire [31:0] dinst;
		wire [31:0] ealu,walu;
		wire [31:0] bpc,jpc,npc,pc4,dpc4,inst,da,db,dimm,ea,eb,eimm;
		wire [31:0] epc4,mb,wmo,wdi;
		wire [4:0] drn,ern0,ern,mrn,wrn;
		wire [3:0] daluc,ealuc;
		wire [1:0] pcsource;
		wire wpcir;
		wire dwreg,dm2reg,dwmem,daluimm,dshift,djal;
		wire ewreg,em2reg,ewmem,ealuimm,eshift,ejal;
		wire mwreg,mm2reg,mwmem;
		wire wwreg,wm2reg;
		pipepc prog_cnt (.npc(npc),.wpc(wpcir),.clk(clock),.clrn(resetn),.pc(pc)); //pc寄存器
		pipeif if_stage (.pcsource(pcsource),.ins(instr),.pc(pc),.bpc(bpc),.rpc(da),.jpc(jpc),.npc(npc),.pc4(pc4),.inst(dinst));  //IF级的组合电路
		pipeir inst_reg (.pc4(pc4),.ins(instr),.wir(wpcir),.clk(clock),.clrn(resetn),.dpc4(dpc4),.inst(inst)); //IR寄存器及PC+4寄存器
		pipeid id_stage (.mwreg(mwreg),.mrn(mrn),.ern(ern),.ewreg(ewreg),.em2reg(em2reg),.mm2reg(mm2reg),.dpc4(dpc4),.inst(inst),.wrn(wrn),.wdi(wdi),.ealu(ealu),.malu(aluout),.mmo(mmo),
						.wwreg(wwreg),.clk(clock),.clrn(resetn),.bpc(bpc),.jpc(jpc),.pcsource(pcsource),.nostall(wpcir),.wreg(dwreg),.m2reg(dm2reg),.wmem(dwmem),.aluc(daluc),
						.aluimm(daluimm),.a(da),.b(db),.imm(dimm),.rn(drn),.shift(dshift),.jal(djal)); //ID级组合电路 
		pipedereg de_reg (.dwreg(dwreg),.dm2reg(dm2reg),.dwmem(dwmem),.daluc(daluc),.daluimm(daluimm),.da(da),.db(db),.dimm(dimm),.drn(drn),.dshift(dshift),
							.djal(djal),.dpc4(dpc4),.clk(clock),.clrn(resetn),.ewreg(ewreg),.em2reg(em2reg),.ewmem(ewmem),.ealuc(ealuc),
							 .ealuimm(ealuimm),.ea(ea),.eb(eb),.eimm(eimm),.ern(ern0),.eshift(eshift),.ejal(ejal),.epc4(epc4)); //ID级和EXE级之间的流水线寄存器
		pipeexe exe_stage (.ealuc(ealuc),.ealuimm(ealuimm),.ea(ea),.eb(eb),.eimm(eimm),
							.eshift(eshift),.ern0(ern0),.epc4(epc4),.ejal(ejal),.ern(ern),.ealu(ealu));  //EXE级的组合电路
		pipeemreg em_reg (.ewreg(ewreg),.em2reg(em2reg),.ewmem(ewmem),.ealu(ealu),
							.eb(eb),.ern(ern),.clk(clock),.clrn(resetn),.mwreg(mwreg),.mm2reg(mm2reg),.mwmem(mwmem),.malu(aluout),.mb(mb),.mrn(mrn)); 	//EXE级和MEM级之间的流水线寄存器
		
		pipemwreg mw_reg (.mwreg(mwreg),.mm2reg(mm2reg),.mmo(mmo),.malu(aluout),.mrn(mrn),
							.clk(clock),.clrn(resetn),.wwreg(wwreg),.wm2reg(wm2reg),.wmo(wmo),.walu(walu),.wrn(wrn));	//MEM级和WB级之间的流水线寄存器
		mux2x32 wb_stage (.a0(walu),.a1(wmo),.s(wm2reg),.y(wdi));		//WB级的电路 
	endmodule
	
	//mb 对应writedata!