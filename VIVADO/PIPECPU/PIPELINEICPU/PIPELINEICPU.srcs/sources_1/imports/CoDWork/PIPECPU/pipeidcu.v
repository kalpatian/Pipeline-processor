module pipeidcu (mwreg,mrn,ern,ewreg,em2reg,mm2reg,rsrtequ,func,op,rs,rt,wreg,m2reg,wmem,aluc,regrt,aluimm,fwda,fwdb,nostall,sext,pcsource,shift,jal);
	input mwreg, ewreg, em2reg, mm2reg, rsrtequ;
	input [4:0] mrn,ern,rs,rt;
	input [5:0] func, op;
	output wreg,m2reg,wmem,regrt,aluimm,sext,shift,jal;
	output [3:0] aluc;
	output [1:0] pcsource;
	output [1:0] fwda, fwdb;  //forwarding
	output nostall;
	reg [1:0] fwda,fwdb;
	
	wire rtype  = ~|op;
	wire i_add  = rtype& func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0]; // add
	wire i_sub  = rtype& func[5]&~func[4]&~func[3]&~func[2]& func[1]&~func[0]; // sub
	wire i_and  = rtype& func[5]&~func[4]&~func[3]& func[2]&~func[1]&~func[0]; // and
	wire i_or   = rtype& func[5]&~func[4]&~func[3]& func[2]&~func[1]& func[0]; // or
	wire i_xor  = rtype& func[5]&~func[4]&~func[3]& func[2]& func[1]&~func[0];
	wire i_slt  = rtype& func[5]&~func[4]& func[3]&~func[2]& func[1]&~func[0]; // slt
	wire i_sltu = rtype& func[5]&~func[4]& func[3]&~func[2]& func[1]& func[0]; // sltu
	wire i_addu = rtype& func[5]&~func[4]&~func[3]&~func[2]&~func[1]& func[0]; // addu
	wire i_subu = rtype& func[5]&~func[4]&~func[3]&~func[2]& func[1]& func[0]; // subu
	wire i_jr   = rtype&~func[5]&~func[4]& func[3]&~func[2]&~func[1]&~func[0]; // jr
	wire i_jalr = rtype&~func[5]&~func[4]& func[3]&~func[2]&~func[1]& func[0]; // jalr
	wire i_nor  = rtype& func[5]&~func[4]&~func[3]& func[2]& func[1]& func[0]; // nor
	wire i_sll  = rtype&~func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0]; // sll
	wire i_srl  = rtype&~func[5]&~func[4]&~func[3]&~func[2]& func[1]&~func[0]; // srl
	wire i_sra  = rtype&~func[5]&~func[4]&~func[3]&~func[2]& func[1]& func[0]; // sra
	wire i_sllv = rtype&~func[5]&~func[4]&~func[3]& func[2]&~func[1]&~func[0]; // sllv
	wire i_srlv = rtype&~func[5]&~func[4]&~func[3]& func[2]& func[1]&~func[0]; // srlv
  // i format
	wire i_addi = ~op[5]&~op[4]& op[3]&~op[2]&~op[1]&~op[0]; // addi
	wire i_ori  = ~op[5]&~op[4]& op[3]& op[2]&~op[1]& op[0]; // ori
	wire i_lw   =  op[5]&~op[4]&~op[3]&~op[2]& op[1]& op[0]; // lw
	wire i_sw   =  op[5]&~op[4]& op[3]&~op[2]& op[1]& op[0]; // sw
	wire i_beq  = ~op[5]&~op[4]&~op[3]& op[2]&~op[1]&~op[0]; // beq
	wire i_bne  = ~op[5]&~op[4]&~op[3]& op[2]&~op[1]& op[0]; // bne
	wire i_slti = ~op[5]&~op[4]& op[3]&~op[2]& op[1]&~op[0]; // slti
	wire i_lui  = ~op[5]&~op[4]& op[3]& op[2]& op[1]& op[0]; // lui
	wire i_andi = ~op[5]&~op[4]& op[3]& op[2]&~op[1]&~op[0]; // andi
	wire i_xori = ~op[5]&~op[4]& op[3]& op[2]& op[1]&~op[0];
  // j format
	wire i_j    = ~op[5]&~op[4]&~op[3]&~op[2]& op[1]&~op[0];  // j
	wire i_jal  = ~op[5]&~op[4]&~op[3]&~op[2]& op[1]& op[0];  // jal
	wire i_rs = i_add | i_sub | i_and | i_or  | i_jr | i_addi | i_andi | i_ori | i_lw | i_sw | i_beq | i_bne | i_slt |i_xor | i_xori | i_nor | i_srlv | i_sllv;
	wire i_rt = i_add | i_sub | i_and | i_or  | i_sll | i_srl | i_sra | i_sw | i_beq | i_bne | i_slt |i_xor | i_nor | i_srlv | i_sllv | i_lw;
	assign nostall = ~(ewreg & em2reg & (ern != 0) & (i_rs & (ern == rs) | i_rt & (ern == rt)));
	always @ (ewreg or mwreg or ern or mrn or em2reg or mm2reg or rs or rt)	begin
		fwda = 2'b00;
		if (ewreg & (ern!=0) & (ern == rs) & ~em2reg)	begin	
			fwda = 2'b01;
		end else begin
			if (mwreg & (mrn != 0) & (mrn == rs) & ~mm2reg)	begin
				fwda = 2'b10;
			end else begin
				if (mwreg & (mrn !=0) & (mrn == rs) & mm2reg)	begin
					fwda = 2'b11;
				end
			end
		end
		fwdb = 2'b00;
		if (ewreg & (ern!=0) & (ern == rt) & ~em2reg) begin	
			fwdb = 2'b01;
		end else begin
			if(mwreg & (mrn != 0) & (mrn == rt) & ~mm2reg) begin
				fwdb = 2'b10;
			end else begin
				if (mwreg & (mrn != 0) & (mrn ==rt) & mm2reg) begin
					fwdb = 2'b11;
				end
			end
		end
	end
	assign wreg = (i_add |i_sub |i_and |i_or |i_sll |i_srl |i_sra |i_addi |i_andi |i_ori  |i_lw |i_lui |i_jal | i_slt | i_xor | i_xori | i_nor | i_srlv | i_sllv) & nostall;
	assign regrt = i_addi | i_andi | i_ori | i_lw | i_lui | i_xori;
	assign jal = i_jal;
	assign m2reg = i_lw;
	assign shift = i_sll | i_srl | i_sra;
	assign aluimm = i_addi | i_andi | i_ori  | i_xori | i_lw | i_lui | i_sw;
	assign sext = i_addi | i_lw | i_sw | i_beq | i_bne | i_lui;
	

	assign aluc[3] = i_sra | i_slt | i_nor | i_sllv | i_srlv;
	assign aluc[2] = i_sub| i_or | i_srl | i_sra | i_ori | i_lui  | i_srlv;
	assign aluc[1] = i_xor | i_sll | i_srl | i_sra | i_xori | i_beq | i_bne | i_lui | i_nor;
	assign aluc[0] = i_and | i_or | i_sll | i_srl | i_sra | i_andi | i_ori | i_sllv;

	//alu
	assign wmem = i_sw & nostall;
	assign pcsource[1] = i_jr | i_j | i_jal;
	assign pcsource[0] = (i_beq & rsrtequ) | (i_bne & ~rsrtequ) | i_j | i_jal; 			//控制冒险解决
endmodule