library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SE10 is
	port(
		SE10_In : in std_logic_vector(5 downto 0);
		SE10_out : out std_logic_vector(15 downto 0)		
	);
end SE10;

architecture a1 of SE10 is
begin
	SE10_out <= std_logic_vector(resize(signed(SE10_In),SE10_out'length));
	
end a1;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SE7 is
	port(
		SE7_In : in std_logic_vector(8 downto 0);
		SE7_out : out std_logic_vector(15 downto 0)		
	);
end SE7;

architecture a1 of SE7 is
begin
	SE7_out <= std_logic_vector(resize(signed(SE7_In),SE7_out'length));
	
end a1;