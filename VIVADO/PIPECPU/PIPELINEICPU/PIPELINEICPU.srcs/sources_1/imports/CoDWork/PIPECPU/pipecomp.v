module pipecomp(clk, rstn, reg_sel, reg_data);
   input          clk;
   input          rstn;
   input [4:0]    reg_sel;
   output [31:0]  reg_data;
   
   wire [31:0]    instr;
   wire [31:0]    PC;
   wire           MemWrite;
   wire [31:0]    dm_addr, dm_din, dm_dout;
   
   wire rst = ~rstn;
       
  // instantiation of single-cycle CPU   
   sccpu U_PIPECPU(
         .clock(clk),                 // input:  cpu clock
         .resetn(rst),                 // input:  reset
         .instr(instr),             //!!!! input:  instruction
         .mmo(dm_dout),        //!!!!!! input:  data to cpu  
         .mwmem(MemWrite),       // output: memory write signal
         .pc(PC),                   // output: PC
         .aluout(dm_addr),          
         .mb(dm_din) ,      // output: data from cpu to memory
         .reg_sel(reg_sel),         // input:  register selection
         .reg_data(reg_data) );       // output: register data      
         
  // pipemem  
   dm    U_DM(
         .clk(clk),           // input:  cpu clock
         .DMWr(MemWrite),     // input:  ram write
         .addr(dm_addr[8:2]), // input:  ram address
         .din(dm_din),        // input:  data to ram
         .dout(dm_dout)       // output: data from ram
         );
         
  // pipeimem (used for simulation)
   im    U_IM ( 
      .addr(PC[8:2]),     // input:  rom address
      .dout(instr)        // output: instruction
   );
        
endmodule

