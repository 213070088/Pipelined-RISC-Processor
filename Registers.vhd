library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Registers is
  port(
	prog_start:in std_logic;
	clk	:in std_logic;
	A1     : in  std_logic_vector(2 downto 0);
	A2     : in  std_logic_vector(2 downto 0);
	A3     : in  std_logic_vector(2 downto 0);
	D3in   : in  std_logic_vector(15 downto 0);
	write_en: in  std_logic;
	D1     : out  std_logic_vector(15 downto 0);
	D2     : out  std_logic_vector(15 downto 0);
	pc_in	: in  std_logic_vector(15 downto 0);
	pc_out	: out std_logic_vector(15 downto 0);
	reg0:out std_logic_vector(15 downto 0);
    reg1:out std_logic_vector(15 downto 0);
    reg2:out std_logic_vector(15 downto 0);
    reg3:out std_logic_vector(15 downto 0);
    reg4:out std_logic_vector(15 downto 0);
    reg5:out std_logic_vector(15 downto 0);
    reg6:out std_logic_vector(15 downto 0);
    reg7:out std_logic_vector(15 downto 0)
  );
end Registers;
  
architecture a1 of Registers is
	type RFtype is array(0 to 7) of std_logic_vector(15 downto 0);
	signal RF : RFtype;
	signal pc_temp: std_logic_vector(15 downto 0);
begin
RF_process:process(A1,A2,A3,D3in, write_en,pc_in,prog_start) is
	begin
		if(prog_start='1') then
			RF(0) <= x"8000";--10
			RF(1) <= x"8000";--7
			RF(2) <= x"000D";--13
			RF(3) <= x"000B";--11
			RF(4) <= x"000C";--12
			RF(5) <= x"000F";--15
			RF(6) <= x"0006";--6
			RF(7) <= x"0000";--0
		elsif (prog_start='0') then
			RF(7)<=pc_in;
			D1 <= RF(to_integer(unsigned(A1)));
			D2 <= RF(to_integer(unsigned(A2)));
              if (write_en = '1') then
                RF(to_integer(unsigned(A3))) <= D3in;    
              end if;
		end if;
	end process;
		reg0<=RF(0);
		reg1<=RF(1);
		reg2<=RF(2);
		reg3<=RF(3);
		reg4<=RF(4);
		reg5<=RF(5);
		reg6<=RF(6);
		reg7<=pc_temp;
		pc_out<=pc_temp;
		
		process(clk)
		begin
			if (rising_edge(clk)) then
				pc_temp<=RF(7);
			end if;
		end process;

end a1;