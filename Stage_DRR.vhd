library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Stage_DRR is
	port( 	prog_start:in std_logic;
		clk: in std_logic;
		A3     : in  std_logic_vector(2 downto 0);
		D3in   : in  std_logic_vector(15 downto 0);
		write_en: in  std_logic;
		inst : in std_logic_vector(15 downto 0);
		pc_in : in  std_logic_vector(15 downto 0);

		RR_cntl : buffer std_logic_vector(14 downto 0);

		EX_cntl : out std_logic_vector(6 downto 0);
		M_cntl : out std_logic;
		WB_cntl : out std_logic_vector(5 downto 0);
		D1     : out  std_logic_vector(15 downto 0);
		D2     : out  std_logic_vector(15 downto 0);
		SE7_out : out std_logic_vector(15 downto 0);
		SE10_out : out std_logic_vector(15 downto 0);
		SL7_out : out std_logic_vector(15 downto 0);
		pc_out	: out std_logic_vector(15 downto 0);
		reg0:out std_logic_vector(15 downto 0);
   		reg1:out std_logic_vector(15 downto 0);
    		reg2:out std_logic_vector(15 downto 0);
    		reg3:out std_logic_vector(15 downto 0);
  		 reg4:out std_logic_vector(15 downto 0);
   		 reg5:out std_logic_vector(15 downto 0);
   		 reg6:out std_logic_vector(15 downto 0);
   		 reg7:out std_logic_vector(15 downto 0)
	
	);
end Stage_DRR;


architecture a1 of Stage_DRR is
	signal regA1,regA2,regA3 : std_logic_vector(2 downto 0);
	signal WB_sel : std_logic_vector(1 downto 0);
	signal WB_en: std_logic;
	signal RWbar: std_logic;
	signal alu_control : std_logic_vector(3 downto 0);
	signal reg_imm_sel: std_logic;
	signal pc_update_sel : std_logic_vector(1 downto 0);
	signal last9bits : std_logic_vector(8 downto 0);


begin
decoder_Insta: entity work.decoder(a1) port map(inst,regA1,regA2,regA3,WB_sel,WB_en,RWbar,alu_control,reg_imm_sel,pc_update_sel);
					
	last9bits<=inst(8 downto 0);
	
	RR_cntl<=regA1 & regA2 & last9bits;
	EX_cntl<=alu_control & reg_imm_sel & pc_update_sel;
	M_cntl<=RWbar;
	WB_cntl<=WB_sel & WB_en & regA3;

	RegFile: entity work.Registers(a1) port map(prog_start,clk,
	RR_cntl(14 downto 12),RR_cntl(11 downto 9),A3,
	D3in,write_en,
	D1,D2,
	pc_in,pc_out,
	reg0,reg1,reg2,reg3,reg4,reg5,
	reg6,reg7);

	
	SE7inst: entity work.SE7(a1) port map(RR_cntl(8 downto 0),SE7_out);
	
	SE10inst: entity work.SE10(a1) port map(RR_cntl(5 downto 0),SE10_out);

	SL7inst: entity work.SL7(a1) port map(RR_cntl(8 downto 0),SL7_out);
end a1;