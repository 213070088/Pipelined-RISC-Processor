library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity DMem is
	port(
		RW		:in std_logic;
		Address     : in  std_logic_vector(15 downto 0);
		Data_In   : in  std_logic_vector(15 downto 0);
		DMemOutData :out std_logic_vector(15 downto 0)
	);
end DMem;

architecture a1 of DMem is
type DMemType is array(0 to 512) of std_logic_vector(15 downto 0);
signal DataMem : DMemType;

begin
Dmemprocess:process(RW,Address,Data_In) is
	begin
		if (conv_integer(Address(15 downto 0))<512) then 
			if RW = '1' then	--writing in to memory
			DataMem(conv_integer(Address(15 downto 0))) <= Data_In;
				
				
			elsif RW ='0' then --reading from memory
				DMemOutData <= DataMem(conv_integer(Address( 15 downto 0)));
			end if;		
       end if; 
	end process;

end a1;