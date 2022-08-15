library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity pcplus1 is
	port (pc_in 	: in std_logic_vector(15 downto 0);
		pcp1	: out std_logic_vector(15 downto 0));
end pcplus1;
	
architecture a1 of pcplus1 is
begin	 
	pcp1 <= std_logic_vector(to_unsigned(to_integer(unsigned(pc_in)) + 1, 16));
end a1;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity adder_pc_se is port(
pc_fetch ,adder_pc_se_2 :in std_logic_vector(15 downto 0);
adder_pc_se_out : out std_logic_vector(15 downto 0)
);
end adder_pc_se;
architecture a1 of adder_pc_se is
begin
addder_pc_se:process(pc_fetch ,adder_pc_se_2)
	begin
	adder_pc_se_out<=std_logic_vector(signed(pc_fetch)+signed(adder_pc_se_2));
	end process addder_pc_se;
end a1;