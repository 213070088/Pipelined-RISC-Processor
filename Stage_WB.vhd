library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Stage_WB is
	port(
		WB_sel : in std_logic_vector(1 downto 0);
		pc_plus1 : in std_logic_vector(15 downto 0);
		DmemOut : in std_logic_vector(15 downto 0);
		ALU_out : in std_logic_vector(15 downto 0);
		SL7 : in std_logic_vector(15 downto 0);
		WB_data : out std_logic_vector(15 downto 0)
    );
end Stage_WB;

architecture a1 of Stage_WB is

begin
Mux41_insta: entity work.Mux41(a1) port map(WB_sel,pc_plus1,DmemOut,ALU_out,SL7,WB_data);

end a1;