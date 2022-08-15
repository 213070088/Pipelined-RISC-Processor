library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Forward_cntl is
	port(
		A1:in std_logic_vector(2 downto 0);
		A2:in std_logic_vector(2 downto 0);
		A3_ExM:in std_logic_vector(2 downto 0);
		A3_MWB:in std_logic_vector(2 downto 0);
		WB_sel_ExM:in std_logic_vector(1 downto 0);
		Write_en_ExM:in std_logic;
		Write_en_MWB:in std_logic;
		Forward_Control:out std_logic_vector(3 downto 0)
		);
end Forward_cntl;

architecture a1 of Forward_cntl is
signal FC1,FC2: std_logic_vector(1 downto 0);
begin
	process(A1,A2,A3_ExM,A3_MWB,WB_sel_ExM,Write_en_ExM,Write_en_MWB)
	begin
		if (Write_en_MWB='1') then
			if (A1=A3_MWB) then
				FC1<="11";
			else
				FC1<="00";
			end if;
			
			if (A2=A3_MWB) then
				FC2<="11";
			else
				FC2<="00";
			end if;
		end if;
		if (Write_en_ExM='1') then	
			if (WB_sel_ExM="01") then 
				if (A1=A3_ExM) then
					FC1<="10";
				else
					FC1<="00";
				end if;
				
				if (A2=A3_ExM) then
					FC2<="10";
				else
					FC2<="00";
				end if;
			else 
				if (A1=A3_ExM) then
					FC1<="01";
				else
					FC1<="00";
				end if;
				
				if (A2=A3_ExM) then
					FC2<="01";
				else
					FC2<="00";
				end if;
			end if;
		end if;
		if(Write_en_MWB='0' and Write_en_ExM='0') then
			FC1<="00";
			FC2<="00";
		end if;
	end process;
	Forward_Control<= FC1 & FC2;
end a1;