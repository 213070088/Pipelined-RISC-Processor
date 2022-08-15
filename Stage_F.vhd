library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Stage_F is
	port(
		pc_in     : in  std_logic_vector(15 downto 0);
		pcp1     : out  std_logic_vector(15 downto 0);
		inst_out : out  std_logic_vector(15 downto 0);
		prog_start: in std_logic);
end Stage_F;

architecture a1 of Stage_F is

signal pc_temp :std_logic_vector(15 downto 0);

begin
	pc_temp <= x"0000" when (prog_start='1') else
					pc_in;
	

pcp1_insta: entity work.pcplus1(a1) port map(pc_temp,pcp1);
IMem_insta: entity work.IMem(a1) port map(pc_temp,inst_out);

end a1;