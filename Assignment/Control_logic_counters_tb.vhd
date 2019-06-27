LIBRARY 	ieee;
USE 		ieee.std_logic_1164.ALL;
USE 		ieee.numeric_std.ALL;
use 		work.DigEng.All;

ENTITY 	Control_logic_counters_tb IS
END 		Control_logic_counters_tb;
 
ARCHITECTURE behavior OF Control_logic_counters_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control_Logic_Counters

	 GENERIC(M : natural :=2;
				N : natural :=3;
				H : natural :=3
				);
    PORT(
         clk : IN  std_logic;
         enable : IN  std_logic;
         reset : IN  std_logic;
         m_value : OUT  unsigned(size(M-1)-1 downto 0);
         m_terminal_count : OUT  std_logic;
         n_value : OUT  unsigned(size(N-1)-1 downto 0);
         n_terminal_count : OUT  std_logic;
         h_value : OUT  unsigned(size(H-1)-1 downto 0);
         h_terminal_count : OUT  std_logic
        );
    END COMPONENT; 
	 constant M_generic : natural := 2;
	 constant N_generic : natural := 3;
	 constant H_generic : natural := 3;

   --Inputs
   signal clk 		: std_logic := '0';
   signal enable 	: std_logic := '0';
   signal reset 	: std_logic := '0';

 	--Outputs
   signal m_value 			: unsigned(size(M_generic-1)-1 downto 0);
   signal m_terminal_count : std_logic;
   signal n_value 			: unsigned(size(N_generic-1)-1 downto 0);
   signal n_terminal_count : std_logic;
   signal h_value 			: unsigned(size(H_generic-1)-1 downto 0);
   signal h_terminal_count : std_logic;

   -- Clock period definitions
   constant clk_period 	: time := 10 ns;
	signal 	Test1 		: std_logic := '0';
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	
   uut: Control_Logic_Counters 
	GENERIC MAP( 	-- 
						M => M_generic,
						-- 
						N => N_generic,
						
						H => H_generic)
	PORT MAP (
				 clk 					=> clk,
				 enable 				=> enable,
				 reset 				=> reset,
				 m_value 			=> m_value,
				 m_terminal_count => m_terminal_count,
				 n_value 			=> n_value,
				 n_terminal_count => n_terminal_count,
				 h_value 			=> h_value,
				 h_terminal_count => h_terminal_count
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
	
	--integer used in test 3
	variable Test3 : integer :=0;
   
	begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		reset <= '1';
		wait for clk_period;
		reset <= '0';
		
-- TEST 1.1	: Test if the counters count up to the maximum value 

		enable <= '1';
      wait for clk_period*(H_generic*H_generic*M_generic);
		Test1 <= h_terminal_count and n_terminal_count and m_terminal_count ;
		enable <= '0';
		wait for clk_period;
		
		assert (Test1 = '1')
			report "TEST1.1: FAILED, terminal count not reached: "
			severity ERROR;
		assert (Test1 = '0')
			report "TEST1.1: PASSED"
			severity NOTE;
		
--TEST 	2 		: reset tests
--			2.1 	: test if counter loops back to 0 on TC
--			2.2	: test if counter resumes counting after reset
--			2.3	: test if counter resets mid cycle when reset = 1
      wait for clk_period;
		enable <= '1';
		wait for clk_period;
		
		--TEST 2.1
		assert (to_integer(m_value + n_value + h_value) = 0)
			report "TEST2.1: FAILED, counter did not reset to 0"
			severity ERROR;
		assert (to_integer(m_value + n_value + h_value) /= 0)
			report "TEST2.1: PASSED"
			severity NOTE;
			
		--TEST 2.2
		wait for clk_period*8;-- count up to somewhere mid cycle
		--check that counter value is not 0
		assert (to_integer(m_value + n_value + h_value) /= 0)
			report "TEST2.2: FAILED, counter did not resume counting after reset"
			severity FAILURE;
		assert (to_integer(m_value + n_value + h_value) = 0)
			report "TEST2.2: PASSED"
			severity NOTE;
		
		-- Reset for next text
		reset 	<= '1';
		enable	<= '0';
		
		--TEST 2.3
		wait for clk_period;
		reset  <= '0';
		enable <= '1';
		assert (to_integer(m_value + n_value + h_value) = 0)
			report "TEST2.3: FAILED, counter did not reset when reset = '1'"
			severity FAILURE;
		assert (to_integer(m_value + n_value + h_value) /= 0)
			report "TEST2.3: PASSED"
			severity NOTE;
		
-- TEST 3.1 : Test if counter holds value when enable = 0 mid cycle
		wait for clk_period*9;-- count up to somewhere mid cycle
		enable <= '0';
		Test3 := to_integer(m_value + n_value + h_value);
		wait for clk_period;
		assert (Test3 = to_integer(m_value + n_value + h_value))
			report "TEST3.1: FAILED, counter did not reset when reset = '1'"
			severity FAILURE;
		assert (Test3 /= to_integer(m_value + n_value + h_value))
			report "TEST3.1: PASSED"
			severity NOTE;
      wait;
		
   end process;

END;