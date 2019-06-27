library 	IEEE;
use 		IEEE.STD_LOGIC_1164.ALL;
use 		IEEE.NUMERIC_STD.ALL;
use		work.DigEng.ALL;

--	Multiply-Accumulate unit (MACC). Accepts two SIGNED inputs (A and B), multiplies 
--	them together, producing the AprodB signal. The output is accumulated with output P
--	resulting in the ABsumP output. 

entity macc is
	generic(	data_size 			: natural := 4;  -- size in bits of coefficient of matrix A and B
				coeff_data_size 	: natural := 8); -- size (in bits of) coefficient of matrix C
				
	Port( clk			:	in  STD_LOGIC;
			RST			: 	in  STD_LOGIC; -- Sets the value of the Flip-Flops in the MACC to 0
			EN				: 	in  STD_LOGIC; -- Enables the MACC
			A 				: 	in  SIGNED(data_size-1 downto 0);		-- Coeff from matrix A
			B 				: 	in  SIGNED(data_size-1 downto 0);  	  	-- Coeff from matrix B
			P 				: 	out SIGNED(coeff_data_size-1 downto 0));-- Output coeff. Stored in RAM
end macc;

architecture Behavioral of macc is
	signal ABsumP		: SIGNED(coeff_data_size-1 downto 0); -- (A*B)+ P result
	signal ACCout		: SIGNED(coeff_data_size-1 downto 0) := (others => '0'); -- Output of the MACC unit
	signal AprodB 		: SIGNED(coeff_data_size-1 downto 0); -- Signal is used for testing
begin

	-- Sum and product calculated separately so AprodB
	-- signal is displayed on ISim
	AprodB <= to_signed(to_integer(A)*to_integer(B),coeff_data_size); 
	ABsumP <= AprodB + ACCout;
	
acc : process (clk)
begin
	if(rising_edge(clk)) then
		-- Pass the input to the output, on enable signal
		if (en = '1') then
			ACCout <= ABsumP;
		end if;
		-- Reset the unit to 0
		if (RST = '1') then
			ACCout <= (others => '0');
		end if;
	end if;
end process acc;

-- ACC output to port P
P <= ACCout;

end Behavioral;