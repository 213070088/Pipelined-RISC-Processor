library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stage_Ex is port(
rgstr,reg_a,immediate,se6,se9,pc:in std_logic_vector(15 downto 0);
reg_imm:in std_logic;

sel_4_1: in std_logic_vector(1 downto 0);
alu_control_input:in std_logic_vector (3 downto 0);
alu_final_out,pc_update_out:out std_logic_vector(15 downto 0);
clk:in std_logic;
present_pcp1: in std_logic_vector(15 downto 0);
WB_cntl_in: in std_logic_vector(5 downto 0);
WB_cntl_out: out std_logic_vector(5 downto 0);
alu_out_exm,dmem_out_M,wb_data_wb:in std_logic_vector(15 downto 0);
FC: in std_logic_vector(3 downto 0);
store_out: out std_logic_vector(15 downto 0);
pcp1_in:in std_logic_vector(15 downto 0);
c_hazard:out std_logic
);
end stage_Ex;

architecture a1 of stage_Ex is 

signal reg_imm_out_sig,se6_se9_sig,adder_pc_se_out_sig: std_logic_vector(15 downto 0);
signal c_wire,z_wire,cf_out_wire,zf_out_wire,and_out_sig,and_out_sig_temp: std_logic;
signal sel_4_1_temp:std_logic_vector(1 downto 0);
signal alu_a_in,alu_b_in,alu_b_in_temp,pc_update_out_temp:std_logic_vector(15 downto 0);
signal c_hazard_temp:std_logic;



begin 
mux211:entity work.Mux21(a1) port map(reg_imm,rgstr,immediate,reg_imm_out_sig);

alu1: entity work.alu(a1) port map(alu_a_in,alu_b_in,c_wire,z_wire,alu_final_out,cf_out_wire,zf_out_wire,alu_control_input);

and1: entity work.and_beq(a1) port map(alu_control_input,zf_out_wire,and_out_sig);
			
			and_out_sig_temp<='0' when (alu_control_input="1000") else and_out_sig;
			
m212: entity work.Mux21(a1) port map(and_out_sig_temp,se9,se6,se6_se9_sig);

add1: entity work.adder_pc_se(a1) port map(pc,se6_se9_sig,adder_pc_se_out_sig);
	
	sel_4_1_temp<="00" when (alu_control_input="1111" and zf_out_wire='0') else sel_4_1;
						
	
mux411:  entity work.Mux41(a1) port map(sel_4_1_temp,present_pcp1,adder_pc_se_out_sig,reg_a,reg_a,pc_update_out_temp);

pc_update_out<=pc_update_out_temp when c_hazard_temp='1' else present_pcp1;
					
mux41_alu_a:entity work.Mux41(a1) port map(FC(3 downto 2),reg_a,alu_out_exm,dmem_out_M,wb_data_wb,alu_a_in);

mux41_alu_b:entity work.Mux41(a1) port map(FC(1 downto 0),reg_imm_out_sig,alu_out_exm,dmem_out_M,wb_data_wb,alu_b_in_temp);

dff1: entity work.dff(a1) port map(clk,c_wire,cf_out_wire);

dff2: entity work.dff(a1) port map(clk,z_wire,zf_out_wire);

store_out<=alu_out_exm when (alu_control_input="0111" and FC(1 downto 0)="01") else
			dmem_out_M when (alu_control_input="0111" and FC(1 downto 0)="10") else
			wb_data_wb when (alu_control_input="0111" and FC(1 downto 0)="11") else rgstr;
				
alu_b_in<=immediate when (alu_control_input="0111") else alu_b_in_temp;

insta_control_hazard: entity work.control_hazard(a1) port map(alu_control_input,pc_update_out_temp,pcp1_in,c_hazard_temp);

c_hazard<=c_hazard_temp;
	
	process(alu_control_input,c_wire,z_wire)
	begin
		WB_cntl_out<=WB_cntl_in;
		case alu_control_input is
			when "0001" => --adc
				if c_wire='0' then
					WB_cntl_out(3)<='0';
				end if;
			when "0010" => --adz
				if z_wire='0' then
					WB_cntl_out(3)<='0';
				end if;
			when "0100" =>--ndc
				if c_wire='0' then
					WB_cntl_out(3)<='0';
				end if;
			when "0101" =>--ndz
				if z_wire='0' then
					WB_cntl_out(3)<='0';
				end if;
			when others =>
				
		end case;
				
	end process;

				
end a1;
