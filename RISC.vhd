library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity RISC is
	port(
		clk,prog_start  : in  std_logic;
		reg0:out std_logic_vector(15 downto 0);
		reg1:out std_logic_vector(15 downto 0);
		reg2:out std_logic_vector(15 downto 0);
		reg3:out std_logic_vector(15 downto 0);
		reg4:out std_logic_vector(15 downto 0);
		reg5:out std_logic_vector(15 downto 0);
		reg6:out std_logic_vector(15 downto 0);
		reg7:out std_logic_vector(15 downto 0)
		
		);
end RISC;

architecture a1 of RISC is


signal flush :std_logic;
--Stage_F
signal pcp1_out_F,inst_out_F: std_logic_vector(15 downto 0);
--pipe_fd
signal pc_out_pipe_FD,pcp1_out_pipe_FD,inst_out_pipe_FD: std_logic_vector(15 downto 0);
--Stage_D
signal RR_cntl_out_D:std_logic_vector(14 downto 0);
signal EX_cntl_out_D:std_logic_vector(6 downto 0);
signal M_cntl_out_D:std_logic;
signal WB_cntl_out_D:std_logic_vector(5 downto 0);
-- Pipe_DR
signal pc_out_pipe_DR,pcp1_out_pipe_DR: std_logic_vector(15 downto 0);
signal RR_cntl_out_pipe_DR:std_logic_vector(14 downto 0);
signal EX_cntl_out_pipe_DR:std_logic_vector(6 downto 0);
signal M_cntl_out_pipe_DR:std_logic;
signal WB_cntl_out_pipe_DR:std_logic_vector(5 downto 0);
--Stage_RR
signal D1_out_RR,D2_out_RR,SE7_out_RR,SE10_out_RR,SL7_out_RR,pc_out_RR:std_logic_vector(15 downto 0);
--Pipe_RE
signal pc_out_pipe_RE,pcp1_out_pipe_RE: std_logic_vector(15 downto 0);
signal Ex_cntl_out_pipe_RE:std_logic_vector(6 downto 0);
signal M_cntl_out_pipe_RE:std_logic;
signal WB_cntl_out_pipe_RE:std_logic_vector(5 downto 0);
signal D1_out_pipe_RE,D2_out_pipe_RE,SE6_out_pipe_RE,SE9_out_pipe_RE,SL7_out_pipe_RE: std_logic_vector(15 downto 0);
signal A1_out_pipe_RE,A2_out_pipe_RE:std_logic_vector(2 downto 0);

--Stage_EX
signal pc_update_out_EX,alu_out_EX,store_out_EX:std_logic_vector(15 downto 0);
signal WB_cntl_out_EX:std_logic_vector(5 downto 0);
signal c_hazard_flush:std_logic;
--pipe_exm
signal pcp1_out_pipe_EXM,alu_out_pipe_EXM,store_val_out_pipe_EXM,sl7_pipe_EXM:std_logic_vector(15 downto 0);
signal M_cntl_out_pipe_EXM:std_logic;
signal WB_cntl_out_pipe_EXM:std_logic_vector(5 downto 0);
--Stage_M
signal DMemOutData_out_M:std_logic_vector(15 downto 0);

--Pipe_MWB
signal WB_cntl_out_pipe_WB:std_logic_vector(5 downto 0);
signal pcp1_out_pipe_MWB,D_mem_out_pipe_EXM,alu_out_pipe_MWB,sl7_out_pipe_MWB:std_logic_vector(15 downto 0);
--Stage_WB
signal WB_data_out_WB:std_logic_vector(15 downto 0);

signal FC_out_Forward_cntl:std_logic_vector(3 downto 0);

begin
insta_Stage_F: entity work.Stage_F(a1) port map (pc_out_RR,pcp1_out_F,inst_out_F,prog_start);

insta_pipe_FD: entity work.pipe_fd(a1) port map(clk,c_hazard_flush,pc_out_RR,
						pcp1_out_F,inst_out_F,pc_out_pipe_FD,
						pcp1_out_pipe_FD,inst_out_pipe_FD);

insta_Stage_DRR: entity work.Stage_DRR(a1) port map(prog_start,clk,WB_cntl_out_pipe_WB(2 downto 0),
			     WB_data_out_WB,WB_cntl_out_pipe_WB(3),inst_out_pipe_FD,
			   pc_update_out_EX,
			 RR_cntl_out_D,EX_cntl_out_D,M_cntl_out_D,
			WB_cntl_out_D, D1_out_RR,D2_out_RR,
			SE7_out_RR,SE10_out_RR,SL7_out_RR,pc_out_RR,
			reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7);
			     
insta_pipe_DRE: entity work.Pipe_DRE(a1) port map(clk,flush,pc_out_pipe_FD,pcp1_out_pipe_FD,
					EX_cntl_out_D,M_cntl_out_D,WB_cntl_out_D,
					D1_out_RR,D2_out_RR,SE10_out_RR,SE7_out_RR,SL7_out_RR,
					pc_out_pipe_RE,pcp1_out_pipe_RE,Ex_cntl_out_pipe_RE,
					M_cntl_out_pipe_RE,WB_cntl_out_pipe_RE,D1_out_pipe_RE,
					D2_out_pipe_RE,SE6_out_pipe_RE,SE9_out_pipe_RE,SL7_out_pipe_RE,
					RR_cntl_out_D(14 downto 12),RR_cntl_out_D(11 downto 9),
					A1_out_pipe_RE,A2_out_pipe_RE);

insta_Stage_EX: entity work.stage_Ex(a1) port map(D2_out_pipe_RE,D1_out_pipe_RE,SE6_out_pipe_RE,
					SE6_out_pipe_RE,SE9_out_pipe_RE,pc_out_pipe_RE,Ex_cntl_out_pipe_RE(2),
					Ex_cntl_out_pipe_RE(1 downto 0),Ex_cntl_out_pipe_RE(6 downto 3),
					alu_out_EX,pc_update_out_EX,clk,pcp1_out_F,
					WB_cntl_out_pipe_RE,WB_cntl_out_EX,
					alu_out_pipe_EXM,DMemOutData_out_M,WB_data_out_WB,
					FC_out_Forward_cntl,store_out_EX,pcp1_out_pipe_RE,c_hazard_flush);

insta_pipe_EXM: entity work.pipe_exm(a1) port map(clk,flush,pcp1_out_pipe_RE,alu_out_EX,
					store_out_EX,SL7_out_pipe_RE,pcp1_out_pipe_EXM,
					alu_out_pipe_EXM,store_val_out_pipe_EXM,sl7_pipe_EXM,
					M_cntl_out_pipe_RE,M_cntl_out_pipe_EXM,WB_cntl_out_EX,
					WB_cntl_out_pipe_EXM);
					
insta_Stage_M: entity work.Stage_M(a1) port map(M_cntl_out_pipe_EXM,alu_out_pipe_EXM,store_val_out_pipe_EXM,						DMemOutData_out_M);

insta_pipe_MWB: entity work.pipe_mwb(a1) port map(clk,flush,pcp1_out_pipe_EXM,DMemOutData_out_M,
					alu_out_pipe_EXM,sl7_pipe_EXM,pcp1_out_pipe_MWB,
					D_mem_out_pipe_EXM,alu_out_pipe_MWB,sl7_out_pipe_MWB,
					WB_cntl_out_pipe_EXM,WB_cntl_out_pipe_WB);
					
insta_Stage_WB: entity work.Stage_WB(a1) port map(WB_cntl_out_pipe_WB(5 downto 4),pcp1_out_pipe_MWB,D_mem_out_pipe_EXM,
					alu_out_pipe_MWB,sl7_out_pipe_MWB,WB_data_out_WB);
					
insta_forward_cntl: entity work.Forward_cntl(a1) port map(A1_out_pipe_RE,A2_out_pipe_RE,WB_cntl_out_pipe_EXM(2 downto 0),
					WB_cntl_out_pipe_WB(2 downto 0), WB_cntl_out_pipe_EXM(5 downto 4),
					WB_cntl_out_pipe_EXM(3),WB_cntl_out_pipe_WB(3),FC_out_Forward_cntl);

end a1;