Library IEEE;
USE IEEE.Std_logic_1164.all;

entity dff is 
   port(
   clk :in std_logic;
      q : out std_logic;    
         
      d :in  std_logic    
   );
end dff;
architecture a1 of dff is  
begin  
 process(Clk)
 begin 
    if(rising_edge(Clk)) then
    q <= d; 
    end if;       
 end process;  
end a1;