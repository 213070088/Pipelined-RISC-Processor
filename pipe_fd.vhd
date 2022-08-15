library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipe_fd is
  port(
	clk:in std_logic;
	flush:in std_logic;
	pc_in,pcp1_in,inst_in: in std_logic_vector(15 downto 0);
	pc_out,pcp1_out,inst_out: out std_logic_vector(15 downto 0)
    );
end pipe_fd;

architecture a1 of pipe_fd is 
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(flush='1') then
			pc_out<=(others=>'Z');
			pcp1_out<=(others=>'Z');
			inst_out<=(others=>'Z');
			
			else
			pc_out<=pc_in;
			pcp1_out<=pcp1_in;
			inst_out<=inst_in;
			end if;
		end if;
	
	end process;
end a1;