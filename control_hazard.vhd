library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_hazard is 
	port (   
			alu_control:in std_logic_vector(3 downto 0);
			pc_update_in:in std_logic_vector(15 downto 0);
			pcp1:in std_logic_vector(15 downto 0);
			c_hazard:out std_logic
          );
end control_hazard;

architecture a1 of control_hazard is
begin
	process(alu_control,pc_update_in,pcp1)
	begin
		if (pc_update_in /= pcp1) then
			if(alu_control="1111" or alu_control="1000" or alu_control="1001") then 
				c_hazard<='1';
				else 
				c_hazard<='0';
			end if;
		else
			c_hazard<='0';
		end if;
	end process;
end a1;
