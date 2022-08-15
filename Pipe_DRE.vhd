library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Pipe_DRE is
  port(
	clk     : in  std_logic;
    flush 	: in std_logic;
    pc_in,pcp1_in : in std_logic_vector(15 downto 0);
	Ex_cntl_in:in std_logic_vector(6 downto 0);
	M_cntl_in:in std_logic;
	WB_cntl_in:in std_logic_vector(5 downto 0);

	D1_in,D2_in,SE6_in,SE9_in,SL7_in:in std_logic_vector(15 downto 0);
    
	pc_out,pcp1_out : out std_logic_vector(15 downto 0);
	Ex_cntl_out:out std_logic_vector(6 downto 0);
	M_cntl_out:out std_logic;
	WB_cntl_out: out std_logic_vector(5 downto 0);
	
	D1_out,D2_out,SE6_out,SE9_out,SL7_out:out std_logic_vector(15 downto 0);
	
	A1_in:in std_logic_vector(2 downto 0);
	A2_in:in std_logic_vector(2 downto 0);
	
	A1_out:out std_logic_vector(2 downto 0);
	A2_out:out std_logic_vector(2 downto 0)
    );
end Pipe_DRE;


architecture a1 of Pipe_DRE is
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			if(flush='1') then
			pc_out<=(others=>'Z');
			pcp1_out<=(others=>'Z');
			
			Ex_cntl_out<=(others=>'Z');
			M_cntl_out<='Z';
			WB_cntl_out<=(others=>'Z');
			
			D1_out<=(others=>'Z');
			D2_out<=(others=>'Z');
			SE6_out<=(others=>'Z');
			SE9_out<=(others=>'Z');
			SL7_out<=(others=>'Z');
			
			A1_out<=(others=>'Z');
			A2_out<=(others=>'Z');
			else
			pc_out<=pc_in;
			pcp1_out<=pcp1_in;
			Ex_cntl_out<=Ex_cntl_in;
			M_cntl_out<=M_cntl_in;
			
			WB_cntl_out<=WB_cntl_in;
			
			D1_out<=D1_in;
			D2_out<=D2_in;
			SE6_out<=SE6_in;
			SE9_out<=SE9_in;
			SL7_out<=SL7_in;
			
			A1_out<=A1_in;
			A2_out<=A2_in;
			end if;
		end if;
	end process;

end a1;