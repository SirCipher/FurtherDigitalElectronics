library	IEEE;
use		IEEE.STD_LOGIC_1164.ALL;
use 		IEEE.NUMERIC_STD.ALL;
use		work.DigEng.All;

---------------------------------------------------------
-- MATRIX C RAM (single port)
-- Synchronous write
-- Asynchronous read
---------------------------------------------------------

entity RAM_single_port is
	generic(
	-- The maximum number of bits needed to store the result of multiplying
	-- the two matricies together. SIGNED !
				Maximum_coefficient_bit_number : natural := 4;
	-- The width of matrix B (N) and the depth of matrix A (H), for matrix
	-- multiplication to be valid N=H, hence only one generic for both values.
				H			 : natural := 3;
				N			 : natural := 3);
	
	Port ( 	clk 				: in  STD_LOGIC;
				write_enable 	: in  STD_LOGIC;
				data_in 			: in  signed 	(Maximum_coefficient_bit_number-1 downto 0);
				-- The RAM has a depth of H*N 
				-- The address bus size needed is size(N*H) bits
				Address 			: in  unsigned (size(N*H-1)-1 downto 0);
				output 			: out signed 	(Maximum_coefficient_bit_number-1 downto 0));
				
end RAM_single_port;

architecture Behavioral of RAM_single_port is
	-- RAM_depth , width of matrix B times depth of matrix a gives the number
	-- of coefficients that the resultant matrix will have.
	constant RAM_depth : natural := N*H;
	
	-- Introduced RAM_width constant for readibility of code
	constant RAM_width : natural := Maximum_coefficient_bit_number;
	
	-- Creating RAM array to store the coefficients of matrix C
	type RAM is array(0 to RAM_depth-1 of signed(RAM_width-1 downto 0);
	
	-- Declare RAM 
	signal RAM_matrix_C : RAM ;
	
begin
	
---------------------------------------------------------
-- Asynchronous read
---------------------------------------------------------
output <= RAM_matrix_C(to_integer(Address));

---------------------------------------------------------
-- Synchronous write
---------------------------------------------------------
RAM_write: PROCESS(clk)
begin
	if(rising_edge(clk)) then
		if(write_enable = '1') then
			RAM_matrix_C(to_integer(Address)) <= data_in;
		end if;
	end if;
end process;

end Behavioral;