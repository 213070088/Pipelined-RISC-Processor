library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity and_beq is port(
	b :in std_logic_vector(3 downto 0);
	and_2:in std_logic;
	and_out: out std_logic
	);
end and_beq;
architecture a1 of  and_beq is
begin 
	process(b,and_2)
	begin
	and_out<=b(0) and  b(1) and b(2) and b(3) and and_2;
	end process;
end a1;