library IEEE; 
use IEEE.STD_LOGIC_1164.all; 

use ieee.std_logic_unsigned.all ;
use ieee.std_logic_arith.all ;

entity RISC_TB is
end;
architecture test of RISC_TB is

signal reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7:std_logic_vector(15 downto 0);
signal clk,reset:std_logic;

begin
inst_test_bench:entity work.RISC(a1) port map(clk,reset,reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7);
	
	clock_process :process
				begin
				clk <= '0';
				wait for 5 ns;
				clk <= '1';
				wait for 5 ns;
				end process;
		reset<='1' after 0 ns ,'0' after 15 ns;
				
end test;