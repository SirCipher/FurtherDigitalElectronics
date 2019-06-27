library 		IEEE;
use 			IEEE.STD_LOGIC_1164.ALL;
use 			IEEE.NUMERIC_STD.ALL;
use			work.DigEng.All;

entity Datapath is
		generic(	M 				 	: natural := 2;  -- Matrix A&B width and height
					N  				: natural := 3;  -- Matrix B width
					H  				: natural := 3;  -- Matrix A height
					Data_size  		: natural := 4;  -- Size of Matrix A&B coefficient
					coeff_C_bits  	: natural := 8); -- Size of Matrix C coefficient
		Port(	clk 			 		: in  STD_LOGIC;
				RAM_write_enable 	: in  STD_LOGIC;
				MACC_enable 	 	: in  STD_LOGIC;
				MACC_reset 		 	: in  STD_LOGIC;
				ROM_A_address 	 	: in  unsigned (size(M*H-1) -1 	downto 0);
				ROM_B_address 	 	: in  unsigned (size(M*N-1) -1 	downto 0);
				RAM_C_address 	 	: in  unsigned (size(N*H-1) -1 	downto 0);
				-- Output of the RAM
				OUTPUT 			 	: out signed 	(coeff_C_bits-1 downto 0));
end Datapath;
	
architecture Behavioral of Datapath is
	-- ROM A outputted coefficient 
	signal A_coefficient : signed (Data_size-1 	  Downto 0);
	-- ROM B outputted coefficient
	signal B_coefficient : signed (Data_size-1 	  Downto 0);
	-- MACC output of Matrix C coefficient
	signal MACC_output	: signed (coeff_C_bits-1 Downto 0);
	
begin
	-- Instantiates ROM_Matrix_A. 
	ROM_Matrix_A : ENTITY work.ROM_Matrix_A
		generic MAP(M 						=> M,
						H 						=> H,
						Data_size			=> Data_size)
		PORT MAP(Address 					=> ROM_A_address,
					Matrix_Coefficient 	=> A_coefficient);
					
	-- Instantiates ROM_Matrix_A. 
	Rom_Matrix_B : ENTITY work.Rom_Matrix_B 
		generic MAP(M 						=> M,
						N 						=> N,
						Data_size			=> Data_size)
		PORT MAP(Address 					=> ROM_B_address,
					matrix_coefficient 	=> B_coefficient);
	
	-- Instantiates the Multiply-Accumulate unit
	macc : ENTITY work.macc
		GENERIC MAP(data_size 			=> Data_size,
						coeff_data_size 	=> coeff_C_bits)
		PORT MAP(clk 	=> clk,
					RST 	=> MACC_reset,
					EN 	=> MACC_enable,
					A 		=> A_coefficient,
					B 		=> B_coefficient,
					P 		=> MACC_output);
			
	-- Instantiates the RAM_single_port, used to store Matrix C
	RAM_single_port : ENTITY work.RAM_single_port
		GENERIC MAP(Maximum_coefficient_bit_number 	=> coeff_C_bits,
						N 			 								=> N,
						H 			 								=> H)
		PORT MAP(clk 		 		=> clk,
					write_enable 	=> RAM_write_enable,
					data_in 	 		=> MACC_output,
					Address 	 		=> RAM_C_address,
					output 		 	=> OUTPUT);
				
end Behavioral;