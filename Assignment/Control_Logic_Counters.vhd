library IEEE;
use 	IEEE.STD_LOGIC_1164.ALL;
use 	IEEE.NUMERIC_STD.ALL;
use 	work.DigEng.ALL;

-- Three counters that count up to the width and depth of the matrices
-- Counter M counts to the width of A and depth of B
-- Counter N counts to the width of B
-- Counter H counts to the depth of A
-- All counters have a reset and enable input. M & N reset on TC.

entity Control_Logic_Counters is
		generic(	M 	: natural 	:= 2; -- width of A , depth of B (starting at 1)
					N	: natural 		:= 3; -- width of B
					H	: natural 		:= 3  -- depth of A
				);
					
		Port( clk 				: in  STD_LOGIC;
				m_enable 		: in  STD_LOGIC;
				n_enable 		: in  STD_LOGIC;
				h_enable 		: in  STD_LOGIC;
				reset 			: in  STD_LOGIC;
				-- Generic_value - 1 because counters count up from 0, whilst
				-- The size of the matrix starts from 1.
				m_value 				: out  unsigned (size(M-1)-1 downto 0);
				m_terminal_count 	: out  STD_LOGIC;
				n_value 				: out  unsigned (size(N-1)-1 downto 0);
				n_terminal_count 	: out  STD_LOGIC;
				h_value 				: out  unsigned (size(H-1)-1 downto 0);
				h_terminal_count 	: out  STD_LOGIC);
end Control_Logic_Counters;

architecture Behavioral of Control_Logic_Counters is
	-- Internal signals for counter values
	signal m_internal : unsigned(size(M-1)-1 downto 0);
	signal n_internal : unsigned(size(N-1)-1 downto	0);
	signal h_internal : unsigned(size(H-1)-1 downto	0);
	-- Internal terminal count signals
	signal m_TC,n_TC,h_TC : std_logic;
begin
	
---------------------------------------------------------------------------
-- Mapping internal signals to outputs
---------------------------------------------------------------------------
m_value				<= m_internal;
m_terminal_count	<= m_TC;
n_value				<= n_internal;
n_terminal_count	<= n_TC;
h_value				<= h_internal;
h_terminal_count	<= h_TC;


---------------------------------------------------------------------------
-- M counter
-- counter is enabled by the FSM
---------------------------------------------------------------------------
	m_counter: process(clk)
	begin
		if(rising_edge(clk)) then -- Synchronous
		-- Reset counter if reset signal goes high or if the maximum
		-- counter value has been reached
			if (reset = '1' or (m_TC = '1' and m_enable = '1')) then
				-- Reset counter value
				m_internal <= (others => '0');
			elsif (m_enable = '1') then
				-- Increment counter value by 1
				m_internal <= m_internal + 1;
				end if;
			end if;
	end process;
	
	m_TC <= '1' when m_internal = M-1 else '0';
	
---------------------------------------------------------------------------
-- N counter
-- Counter is enabled if the M counter reaches terminal count
---------------------------------------------------------------------------
	n_counter: process(clk)
	begin
		if(rising_edge(clk)) then -- Synchronous
			if(reset = '1' or (n_enable = '1' and n_TC = '1')) then 	
				-- Reset counter value
				n_internal <= (others => '0');
			elsif(n_enable = '1') then
				-- Increment counter by 1
				n_internal <= n_internal + 1;
			end if;
		end if;
	end process;

	n_TC <= '1' when n_internal = N-1 else '0';

---------------------------------------------------------------------------
-- H counter
-- Counter is enabled if the N counter reaches terminal count
---------------------------------------------------------------------------
	h_counter: process(clk)
	begin
		if(rising_edge(clk)) then -- Synchronous
			if(reset = '1') then
				-- Reset counter value
				h_internal <= (others => '0');
			elsif(h_enable = '1') then
				-- Increment counter by 1
				h_internal <= h_internal + 1;
			end if;
		end if;
	end process;
	
	h_TC <= '1' when h_internal = H-1 else '0';
	
end Behavioral;