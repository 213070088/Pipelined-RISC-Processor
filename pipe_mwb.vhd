library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipe_mwb is
  port(
	clk:in std_logic;
	flush:in std_logic;
	pcp1_in,D_mem_out_in,alu_out_in,sl7_in: in std_logic_vector(15 downto 0);
	pcp1_out,D_mem_out_out,alu_out_out,sl7_out: out std_logic_vector(15 downto 0);
	WB_cntl_in:in std_logic_vector( 5 downto 0);
	WB_cntl_out:out std_logic_vector( 5 downto 0)
    );
end pipe_mwb;

architecture a1 of pipe_mwb is 
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			if(flush='1') then
			pcp1_out<=(others=>'Z');
			D_mem_out_out<=(others=>'Z');
			alu_out_out<=(others=>'Z');
			sl7_out<=(others=>'Z');
			WB_cntl_out<=(others=>'Z');
			
			else
			pcp1_out<=pcp1_in;
			D_mem_out_out<=D_mem_out_in;
			alu_out_out<=alu_out_in;
			sl7_out<=sl7_in;
			WB_cntl_out<=WB_cntl_in;
			end if;
		end if;
	
	end process;
end a1;