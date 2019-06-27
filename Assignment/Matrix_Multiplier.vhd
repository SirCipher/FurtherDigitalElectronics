library IEEE;
use 	IEEE.STD_LOGIC_1164.ALL;
use 	IEEE.NUMERIC_STD.ALL;
use		work.DigEng.All;

-- Top-level of the Matrix Multiplier design. Instantiates the DataPath and Control_logic
-- Design accepts two matrices with signed coefficients (A & B) and multiplies them. Coefficients are stored in two separate
-- ROM's and the product of them (matrix C) is stored in the RAM. The design has a reset and next signal,
-- which starts the computation of the next coefficient of matrix C. 

entity Matrix_Multiplier is
	GENERIC(	M 					: natural 	:= 17; 	-- Matrix A width,Matrix B height
				N 					: natural 	:= 8; 	-- Matrix B width 
				H 					: natural 	:= 4; 	-- Matrix A height
				data_size 		: natural 	:= 4);	-- Size of Matrix A&B coefficient in bits
    Port(clk				: in		STD_LOGIC;
			nxt				: in  	STD_LOGIC;
			rst				: in  	STD_LOGIC;
			output 			: out  	signed(coeff_C(data_size,M)-1 downto 0));
end Matrix_Multiplier;

architecture Behavioral of Matrix_Multiplier is
	--internal Address signals
	signal ROM_A_address 		: unsigned(size(M*H-1) -1 downto 0);
	signal ROM_B_address 		: unsigned(size(M*N-1) -1 downto 0);
	signal RAM_C_address 		: unsigned(size(N*H-1) -1 downto 0);
	--Control signals to other datapath components
	signal RAM_write_enable 	: STD_LOGIC;
	signal MACC_enable 			: STD_LOGIC;
	signal MACC_reset 			: STD_LOGIC;
	
	-- De-bounced outputs 
	signal Deb_next 				: STD_LOGIC;
	signal Deb_reset				: STD_LOGIC;
	

begin
	-- De-bouncer for the reset input
	debouncer_rst	: ENTITY work.Debouncer
	PORT MAP(clk 		=> clk,
				sig 		=> rst,
				Deb_Sig 	=> Deb_reset);
	
	-- De-bouncer for the next input
	debouncer_nxt	: ENTITY work.Debouncer
	PORT MAP(clk		=> clk,
				sig 		=> nxt,
				Deb_Sig	=> Deb_next);
				
-- Instantiates the DataPath
-- Sub-Modules: ROM_Matrix_A.vhd, Rom_Matrix_B.vhd, macc.vhd, RAM_single_port.vhd	
	DataPath : ENTITY work.Datapath
	GENERIC MAP( 	M 						=> M, 
						N  					=> N, 
						H  					=> H, 
						Data_size  			=> data_size, 
						coeff_C_bits  		=> coeff_C(data_size,M))
		PORT MAP(clk 						=> clk,
					RAM_write_enable 		=> RAM_write_enable,
					MACC_enable 			=> MACC_enable,
					MACC_reset 				=> MACC_reset,
					ROM_A_address 			=> ROM_A_address,
					ROM_B_address 			=> ROM_B_address,
					RAM_C_address 			=> RAM_C_address,
					-- Output of the RAM
					OUTPUT 					=> output);

-- 	Instantiates the Control_logic
--	Sub-Modules Address_generator.vhd Control_Logic_Counters.vhd fsm.vhd
	Control_logic : ENTITY work.Control_logic
	GENERIC MAP( 	M 					=> M,
						N 					=> N,
						H 					=> H)
		PORT MAP(	clk 					=> clk,
						deb_rst 				=> Deb_reset,
						deb_nxt 				=> Deb_next,
						ROM_A_address 		=> ROM_A_address,
						ROM_B_address 		=> ROM_B_address,
						RAM_C_address 		=> RAM_C_address,
						RAM_C_write_enable=> RAM_write_enable,
						MACC_enable 		=> MACC_enable,
						MACC_reset 			=> MACC_reset);
end Behavioral;