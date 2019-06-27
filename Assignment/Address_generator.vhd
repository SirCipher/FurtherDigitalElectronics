library IEEE;
use 	IEEE.STD_LOGIC_1164.ALL;
use 	IEEE.NUMERIC_STD.ALL;
use 	work.DigEng.ALL;

-- Uses counter values to generate the addresses for the ROM's and RAM_C. 

entity Address_generator is
	generic(-- matrix size generics
			N 	: integer 	:= 3;
			H 	: integer 	:= 3;
			M	: integer	:= 2);
    Port(   -- fields are -1 because counters start counting at 0 where as number of 
			-- fields in matrix starts at 1. I.e. , if the matrix A has width of 2 then
			-- the counter M goes from 0->1->0. but since M is 2 the size of M_counter_value
			-- is given by size(M-1) -1 downto 0.
			M_counter_value : in  	unsigned(size(M-1)-1 downto 0);
			N_counter_value : in  	unsigned(size(N-1)-1 downto 0);
			H_counter_value : in  	unsigned(size(H-1)-1 downto 0);
			-- ROM A has M*H fields, so the number of bits needed to address them
			-- is size(M*H)
			ROM_A_address 	: out  	unsigned(size(M*H-1) -1 downto 0);
			ROM_B_address 	: out  	unsigned(size(M*N-1) -1 downto 0);
			RAM_C_address 	: out  	unsigned(size(N*H-1) -1 downto 0));
			  
end Address_generator;

architecture Behavioral of Address_generator is
	signal 	ROM_B_address_integer	: 	integer;
	signal 	ROM_A_address_integer	: 	integer;
	signal 	RAM_C_address_integer	: 	integer;
	
begin

-------------------------------------------------------------------------------
-- Generating address for ROM_B
-------------------------------------------------------------------------------
	--the address as an integer value, (N_H_max)*M is the offset
	ROM_B_address_integer 	<= (N)*(to_integer(M_counter_value)) + to_integer(N_counter_value);
	--mapping address to output
	ROM_B_address 			<= to_unsigned(ROM_B_address_integer,size((N*M-1)-1));
-------------------------------------------------------------------------------
--Generating address for ROM_A
-------------------------------------------------------------------------------
	--the address as an integer value, (M_max)*N_H is the offset
	ROM_A_address_integer 	<= (M)*to_integer(H_counter_value) + to_integer(M_counter_value);
	--mapping address to output
	ROM_A_address 			<= to_unsigned(ROM_A_address_integer,size((H*M-1)-1));
-------------------------------------------------------------------------------
--Generating address for RAM_C
-------------------------------------------------------------------------------
	--the address as an integer value, (N_max)*H_counter is the offset
	RAM_C_address_integer 	<= (N)*to_integer(H_counter_value) + to_integer(N_counter_value);
	RAM_C_address			<= to_unsigned(RAM_C_address_integer,size((N*H-1)-1));
	
end Behavioral;