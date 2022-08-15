library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mux41 is
	port(
	    Sel 	: in std_logic_vector (1 downto 0);
        In0 	: in std_logic_vector (15 downto 0);
        In1 	: in std_logic_vector (15 downto 0);
		In2 	: in std_logic_vector (15 downto 0);
        In3 	: in std_logic_vector (15 downto 0);
        Mux41Out: out std_logic_vector(15 downto 0)
		);
end Mux41;

architecture a1 of Mux41 is 
begin
Mux41Process:process(Sel,In0,In1,In2,In3) is
		begin
            case Sel is
                when "00" =>
                    Mux41Out <= In0;
                when "01" =>
                    Mux41Out <= In1;
                when "10" =>
                    Mux41Out <= In2;
                when "11" =>
                    Mux41Out <= In3;
					when others=>
						Mux41Out<="XXXXXXXXXXXXXXXX";
				
			end case;
		end process;
end a1;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mux21 is
	port(
	    Sel 	: in std_logic;
        In0 	: in std_logic_vector (15 downto 0);
        In1 	: in std_logic_vector (15 downto 0);
        Mux21Out: out std_logic_vector(15 downto 0)
		);
end Mux21;

architecture a1 of Mux21 is

begin
Mux21Process:process(Sel,In0,In1) is
	begin
		if Sel='0' then
			Mux21Out <= In0;
		elsif Sel='1' then
			Mux21Out <= In1;
		end if;
	end process;
end a1;