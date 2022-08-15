library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SL7 is
	port(
		SL7_In : in std_logic_vector(8 downto 0);
		SL7_out : out std_logic_vector(15 downto 0)		
	);
end SL7;

architecture a1 of SL7 is
begin
	SL7_out <= std_logic_vector(unsigned(SL7_In(8 downto 0) & "0000000"));
	
end a1;
