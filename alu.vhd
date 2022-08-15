library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity alu is 
	port (      input1: in  std_logic_vector(15 downto 0);
                input2 : in  std_logic_vector(15 downto 0);
                carry_flag: in std_logic;
                zero_flag : in std_logic;
				alu_out : out std_logic_vector(15 downto 0);
				carry_flag_out : out std_logic;
				zero_flag_out : out std_logic;
                alu_control : in std_logic_vector(3 downto 0)
          );
end alu;
architecture a1 of alu is 
   signal input1_temp : std_logic_vector(16 downto 0);
   signal input2_temp : std_logic_vector(16 downto 0);
   signal alu_out_temp : std_logic_vector(16 downto 0);
   
begin
            input1_temp <= input1(15)& input1(15 downto 0); --sign extension
            input2_temp <= input2(15)&input2(15 downto 0);
       aluprocess: process(input1_temp, input2_temp, alu_control,alu_out_temp,carry_flag ,zero_flag )
					begin
						case alu_control is 
										---ADD, ADI
							when "0000"=>
								alu_out_temp <= std_logic_vector(input1_temp +input2_temp);
								carry_flag_out <= alu_out_temp(16);
								alu_out <= alu_out_temp(15 downto 0);
                                                  
										if (alu_out_temp(15 downto 0) = x"0000") then
												zero_flag_out <= '1';
										else 
												zero_flag_out <= '0';
										end if;
							when "0001"=>  ----ADC
										if(carry_flag='1') then 
											alu_out_temp <= std_logic_vector(input1_temp +input2_temp);
											alu_out <= alu_out_temp(15 downto 0);
											carry_flag_out <= alu_out_temp(16);                  
												if (alu_out_temp(15 downto 0) = x"0000") then
													zero_flag_out <= '1';
												else 
													zero_flag_out <= '0';
												end if;
										end if;
							when "0010"=>  ----ADZ
										if(zero_flag='1') then 
											alu_out_temp <= std_logic_vector(input1_temp +input2_temp);
											alu_out <= alu_out_temp(15 downto 0);
											carry_flag_out <= alu_out_temp(16);                  
												if (alu_out_temp(15 downto 0) = x"0000") then
													zero_flag_out <= '1';
												else 
													zero_flag_out <= '0';
												end if;
										end if;
							when "0011" => ---NDU
										for i in 0 to 15 loop 
										alu_out_temp(i) <= input1_temp(i) nand input2_temp(i);
										end loop;
											alu_out <= alu_out_temp(15 downto 0);
											if (alu_out_temp(15 downto 0) = x"0000") then
												zero_flag_out <= '1';
											else 
												zero_flag_out <= '0';
											end if;
							when "0100"=> ----NDC
									if(carry_flag='1') then 
										for i in 0 to 15 loop 
										alu_out_temp(i) <= input1_temp(i) nand input2_temp(i);
										end loop;
											alu_out <= alu_out_temp(15 downto 0);
											if (alu_out_temp(15 downto 0) = x"0000") then
												zero_flag_out <= '1';
											else 
												zero_flag_out <= '0';
											end if;
									end if;
							when "0101"=> --NDZ
									if(zero_flag='1') then 
										for i in 0 to 15 loop 
										alu_out_temp(i) <= input1_temp(i) nand input2_temp(i);
										end loop;
											alu_out <= alu_out_temp(15 downto 0);
											if (alu_out_temp(15 downto 0) = x"0000") then
												zero_flag_out <= '1';
											else 
												zero_flag_out <= '0';
											end if;
									end if;
						when "0110"=> --load
										alu_out_temp <= std_logic_vector(input1_temp +input2_temp);
										alu_out <= alu_out_temp(15 downto 0);
          
										if (alu_out_temp(15 downto 0) = x"0000") then
												zero_flag_out <= '1';
										else 
												zero_flag_out <= '0';
										end if;
						when "0111"=> ---store
										alu_out_temp <= std_logic_vector(input1_temp +input2_temp);
										alu_out <= alu_out_temp(15 downto 0);
						when "1111" => ---beq
										for i in 0 to 15 loop 
										alu_out_temp(i) <= input1_temp(i) xor input2_temp(i);
										end loop;
											alu_out <= alu_out_temp(15 downto 0);
											if (alu_out_temp(15 downto 0) = x"0000") then
												zero_flag_out <= '1';
											else 
												zero_flag_out <= '0';
											end if;
							 when others =>
                        ---null;
                        alu_out <="ZZZZZZZZZZZZZZZZ";
						
						 end case;
				end process;
end a1;