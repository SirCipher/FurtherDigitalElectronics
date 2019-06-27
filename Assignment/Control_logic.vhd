library IEEE;
use 	IEEE.STD_LOGIC_1164.ALL;
use 	IEEE.NUMERIC_STD.ALL;
use		work.DigEng.All;

-- Instantiates the Address_generator, Control_Logic_Counters and fsm
entity Control_logic is
		generic(	M 						: natural := 2;
					N 						: natural := 3;
					H 						:natural := 3);
		Port(	clk 						: in  	STD_LOGIC;
				deb_rst 					: in  	STD_LOGIC;
				deb_nxt 					: in  	STD_LOGIC;
				ROM_A_address 			: out  	unsigned(size(M*H-1)-1 downto 0);
				ROM_B_address 			: out  	unsigned(size(M*N-1)-1 downto 0);
				RAM_C_address 			: out  	unsigned(size(N*H-1)-1 downto 0);
				RAM_C_write_enable 	: out  	STD_LOGIC;
				MACC_enable 			: out  	STD_LOGIC;
				MACC_reset 				: out  	STD_LOGIC);
end Control_logic;

architecture Behavioral of Control_logic is
	-- signals for the counter values 
	signal M_counter_value_temp 	: unsigned(size(M-1)-1 Downto 0);
	signal N_counter_value_temp 	: unsigned(size(N-1)-1 Downto 0);
	signal H_counter_value_temp 	: unsigned(size(H-1)-1 Downto 0);
	-- signals for the terminal count signals of the counters
	signal m_terminal_count			: STD_LOGIC;
	signal n_terminal_count			: STD_LOGIC;
	signal h_terminal_count			: STD_LOGIC;
	-- enables the M counter in the Control_logic_counters
	signal m_counter_enable			: STD_LOGIC;
	signal n_counter_enable			: STD_LOGIC;
	signal h_counter_enable			: STD_LOGIC;
	
begin
	-- Instantiates the Address_generator which generates an
	-- address based on the current counter values
	Address_generator : ENTITY work.Address_generator
		GENERIC MAP(M => M,
						N => N,
						H => H)
		PORT MAP(	M_counter_value 	=> M_counter_value_temp,
					N_counter_value 		=> N_counter_value_temp,
					H_counter_value 		=> H_counter_value_temp,
					ROM_A_address 			=> ROM_A_address,
					ROM_B_address 			=> ROM_B_address,
					RAM_C_address 			=> RAM_C_address);
	
	-- Instantiates the Control_Logic_Counters. Three counters, M, N and H
	Control_Logic_Counters : ENTITY work.Control_Logic_Counters
		GENERIC MAP(M => M,
						N => N,
						H => H)
		PORT MAP(	clk 				=> clk,
					m_enable 			=> m_counter_enable,
					n_enable 			=> n_counter_enable,
					h_enable 			=> h_counter_enable,
					reset 				=> deb_rst,
					m_value 				=> M_counter_value_temp,
					m_terminal_count 	=> m_terminal_count,
					n_value 				=> N_counter_value_temp,
					n_terminal_count 	=> n_terminal_count,
					h_value 				=> H_counter_value_temp,
					h_terminal_count 	=> h_terminal_count);
					
	-- Instantiates the Finite State Machine
	fsm : ENTITY work.fsm
		PORT MAP(clk 				=> clk,
					nxt 				=> deb_nxt,
					rst 				=> deb_rst,
					h_tc 				=> h_terminal_count,
					n_tc 				=> n_terminal_count,
					m_tc 				=> m_terminal_count,
					macc_en 			=> MACC_enable,
					macc_rst 		=> MACC_reset,
					m_counter_en 	=> m_counter_enable,
					n_counter_en 	=> n_counter_enable,
					h_counter_en 	=> h_counter_enable,
					write_en 		=> RAM_C_write_enable);

end Behavioral;