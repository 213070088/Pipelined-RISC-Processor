library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
	port(
		inst : in std_logic_vector(15 downto 0);
		regA1,regA2,regA3 : out std_logic_vector(2 downto 0);
		WB_sel : out std_logic_vector(1 downto 0);
		WB_en: out std_logic;
		RWbar: out std_logic;
		alu_control : out std_logic_vector(3 downto 0);
		reg_imm_sel: out std_logic;
		pc_update_sel : out std_logic_vector(1 downto 0)
	);

end decoder;

architecture a1 of decoder is
begin
decoder_process: process(inst)
		begin
			case inst(15 downto 12) is
				when "0001"=> --addition
					regA1<=inst(11 downto 9);
					regA2<=inst(8 downto 6);
					regA3<=inst(5 downto 3);
					WB_sel<="10";
					WB_en<='1';
					RWbar<='X';
					if inst(1 downto 0)="00" then --add
						alu_control<="0000";
						reg_imm_sel<='0';
						pc_update_sel<="00";
					elsif inst(1 downto 0)="10" then --adc
						alu_control<="0001";
						reg_imm_sel<='0';
						pc_update_sel<="00";
					
					elsif inst(1 downto 0)="01" then --adz
						alu_control<="0010";
						reg_imm_sel<='0';
						pc_update_sel<="00";
					end if;
				when "0000"=>	--adi
						regA1<=inst(11 downto 9);
						regA3<=inst(8 downto 6);
						WB_sel<="10";
						WB_en<='1';
						RWbar<='X';
						alu_control<="0000";
						reg_imm_sel<='1';
						pc_update_sel<="00";
				
				when "0010"=>	--nand
						regA1<=inst(11 downto 9);
						regA2<=inst(8 downto 6);
						regA3<=inst(5 downto 3);
						WB_sel<="10";
						WB_en<='1';
						RWbar<='X';
					if inst(1 downto 0)="00" then --ndu
						alu_control<="0011";
						reg_imm_sel<='0';
						pc_update_sel<="00";
					elsif inst(1 downto 0)="10" then --ndc
						alu_control<="0100";
						reg_imm_sel<='0';
						pc_update_sel<="00";
					
					elsif inst(1 downto 0)="01" then --ndz
						alu_control<="0101";
						reg_imm_sel<='0';
						pc_update_sel<="00";
					end if;
				when "0011"=>	--LHI
						regA3<=inst(11 downto 9);
						alu_control<="XXXX";
						WB_sel<="11";
						WB_en<='1';
						RWbar<='X';
						pc_update_sel<="00";
				when "0100"=> --load
						regA1<=inst(8 downto 6);
						regA3<=inst(11 downto 9);
						WB_sel<="01";
						WB_en<='1';
						RWbar<='0';
						alu_control<="0110";
						reg_imm_sel<='1';
						pc_update_sel<="00";
				when "0101"=> --store
						regA1<=inst(8 downto 6);
						regA2<=inst(11 downto 9);
						WB_en<='0';
						alu_control<="0111";
						RWbar<='1';
						reg_imm_sel<='1';
						pc_update_sel<="00";
				
				when "1000"=> --branch beq
						regA1<=inst(11 downto 9);
						regA2<=inst(8 downto 6);
						WB_en<='0';
						RWbar<='X';
						alu_control<="1111";
						reg_imm_sel<='0';
						pc_update_sel<="01";
				when "1001"=> --jal 
						regA3<=inst(11 downto 9);
						WB_sel<="00";
						WB_en<='1';
						RWbar<='X';
						alu_control<="1000";
						reg_imm_sel<='1';
						pc_update_sel<="01";
				when "1010"=> --jlr
						regA3<=inst(11 downto 9);
						regA1<=inst(8 downto 6);
						WB_sel<="00";
						WB_en<='1';
						RWbar<='X';
						alu_control<="XXXX";
						pc_update_sel<="10";
				when "1011"=> --jri
						regA3<=inst(11 downto 9);
						
						
						WB_sel<="00";
						WB_en<='1';
						RWbar<='X';
						alu_control<="1000";
						reg_imm_sel<='1';
						pc_update_sel<="10";
				when others =>
						alu_control<="XXXX";
						WB_en<='0';
						RWbar<='X';
						regA1<="XXX";
						regA2<="XXX";
						regA3<="XXX";
						WB_sel<="XX";
			end case;
		end process;
end a1;