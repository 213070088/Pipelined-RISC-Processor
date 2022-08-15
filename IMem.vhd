library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IMem is
	port(
		pc_in     : in  std_logic_vector(15 downto 0);
		inst_out : out  std_logic_vector(15 downto 0)
	);
end IMem;

architecture a1 of IMem is
type IMemType is array(0 to 512) of std_logic_vector(15 downto 0);
signal InstMem : IMemType:= (
													
                                         "0011001000101011",   -- LHI R1  000101011
										"0001001000100000",    --add  r4 = r1+r0
										"0010011100101000",    --NDU   r5 =r3nandr4 
										"0001001000010001",    --addc   r2 =  r1 +r0  
										"0101100001000010",	   --store to mem(5)
										"0100110001000010",	-- load r6=r1(2)
										"0001100110101000",	--add r5=r4+r6
										"0000100101000010", --adi r5=r4+000010
										"1000100110000010", -- beq pc+2 (r4==r6)
										"0001010011001001", -- adz r1=r2+r3
										"0010100101011010",	-- ndc r3= r4 nand r5
										"1010010011000000",	--jlr branch to r3 store in r2
										"0010100101001001",-- ndz r1= r4 nand r5
										"1001110000000011", --jal pc+1 in r6
										"0001010100011000",  -- add r3 = r2+r4
											"0001010100011000",  -- add r3 = r2+r4
											"0011001000101011",   -- LHI R1  000101011 
                                         others=>(others=>'0')          
		
                                        );

begin
IMem_process: process(pc_in) 
				begin
					inst_out <= InstMem(to_integer(unsigned(pc_in)));
			end process;
end a1;