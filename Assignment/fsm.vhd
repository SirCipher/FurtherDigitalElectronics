library IEEE;
use 	IEEE.STD_LOGIC_1164.ALL;
use 	IEEE.NUMERIC_STD.ALL;
use		work.DigEng.ALL;

-- 	State machine for the Matrix Multiplier
-- 	5-state machine, with a reset state and the final 
-- 	coefficient is held at the output 

entity fsm is
	Port(	nxt 				: in   STD_LOGIC;
			rst 				: in   STD_LOGIC;
			h_tc				: in   STD_LOGIC;
			n_tc				: in   STD_LOGIC;
			m_tc				: in   STD_LOGIC;
			clk				: in   STD_LOGIC;
         macc_en 			: out  STD_LOGIC;
         macc_rst 		: out  STD_LOGIC;
         m_counter_en 	: out  STD_LOGIC;
         n_counter_en 	: out  STD_LOGIC;
         h_counter_en 	: out  STD_LOGIC;
         write_en 		: out  STD_LOGIC);
end fsm;

architecture Behavioral of fsm is

type fsm_state is (s0, s1, s2, s3, s4);
	signal state, next_state : fsm_state;
begin

state_assignment : process(clk) is
begin
	if (rising_edge(clk)) then
			if (rst = '1') then
				state <= s0;
			else 
				state <= next_state;
		end if;
	end if;
end process state_assignment;

state_transitions : process(state, nxt, clk, h_tc, n_tc, m_tc) is
begin
	case state is
		-- 	Reset state. Wait for next to be pressed.
		when 	s0 => if(nxt = '1') then
							next_state <= s1;
						else 
							next_state <= s0;
						end if;
						
		--	Computes the coefficient of matrix C. 
		-- 	Waits here until the M counter reaches TC.
		when 	s1 => if(m_tc = '1') then 
							next_state <= s2;
						else  
							next_state <= s1;
						end if;
		
		-- 	Write the coefficient to RAM
		when 	s2 =>  next_state <= s3;
		
		-- 	MACC is reset. Unless N & H counters are at TC,
		-- 	then remain in this state and output the last coefficient. 
		when 	s3 => 	if((h_tc = '0' or n_tc = '0') and ( nxt = '1')) then
							next_state <= s4;
						else 
						   next_state <= s3;
						end if;
		
		-- Calculate the next coefficient
		when s4 => 	next_state <= s1;
		
		-- Safety catch
		when others => next_state <= s0;
		
	end case;
end process state_transitions;

--	State outputs
	macc_en <= '1' 		when (state = s1 ) else '0'; 

	macc_rst <= '1' 	when (state = s0  or state = s3) else '0';  

	m_counter_en <= '1' when (state = s1) else '0';								
	n_counter_en <= '1' when (state = s4) else '0';								
	h_counter_en <= '1' when (state = s4  and n_TC = '1') else '0';								
		
	write_en <= '1'		when (state = s2) else '0';

end Behavioral;