library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Stage_M is
	port(
		RW 		:in std_logic;
		Address     : in  std_logic_vector(15 downto 0);
		Data_In    : in  std_logic_vector(15 downto 0);
		DMemOutData :out std_logic_vector(15 downto 0)
	);
end Stage_M;

architecture a1 of Stage_M is


begin
				
DMemInsta:entity work.DMem(a1) port map(RW,Address,
			Data_In,DMemOutData);

end a1;