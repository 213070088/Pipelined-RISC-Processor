library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipe_exm is
  port(
	clk:in std_logic;
	flush:in std_logic;
	pcp1_in,alu_out_in,store_val_in,sl7_in: in std_logic_vector(15 downto 0);
	pcp1_out,alu_out_out,store_val_out,sl7_out: out std_logic_vector(15 downto 0);
	M_cntl_in:in std_logic;
	M_cntl_out:out std_logic;
	WB_cntl_in:in std_logic_vector( 5 downto 0);
	WB_cntl_out:out std_logic_vector( 5 downto 0)
    );
end pipe_exm;

architecture a1 of pipe_exm is 
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			if(flush='1') then
			pcp1_out<=(others=>'Z');
			alu_out_out<=(others=>'Z');
			store_val_out<=(others=>'Z');
			sl7_out<=(others=>'Z');
			M_cntl_out<='Z';
			WB_cntl_out<=(others=>'Z');
			
			else
			pcp1_out<=pcp1_in;
			alu_out_out<=alu_out_in;
			store_val_out<=store_val_in;
			sl7_out<=sl7_in;
			M_cntl_out<=M_cntl_in;
			WB_cntl_out<=WB_cntl_in;
			end if;
		end if;
	
	end process;
end a1;