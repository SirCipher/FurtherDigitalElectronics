LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY fsm_tb IS
END fsm_tb;
 
ARCHITECTURE behavior OF fsm_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT fsm
    PORT(
         nxt : IN  std_logic;
         rst : IN  std_logic;
         h_tc : IN  std_logic;
         n_tc : IN  std_logic;
         m_tc : IN  std_logic;
         clk : IN  std_logic;
         macc_en : OUT  std_logic;
         macc_rst : OUT  std_logic;
         counters_en : OUT  std_logic;
         write_en : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal nxt : std_logic := '0';
   signal rst : std_logic := '0';
   signal h_tc : std_logic := '0';
   signal n_tc : std_logic := '0';
   signal m_tc : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal macc_en : std_logic;
   signal macc_rst : std_logic;
   signal counters_en : std_logic;
   signal write_en : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fsm PORT MAP (
          nxt => nxt,
          rst => rst,
          h_tc => h_tc,
          n_tc => n_tc,
          m_tc => m_tc,
          clk => clk,
          macc_en => macc_en,
          macc_rst => macc_rst,
          counters_en => counters_en,
          write_en => write_en
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
	CONSTANT delay_time	: 	Time	:= 50 ns;

   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

-- TEST 1	: Transition from s0->s3 and reset to s0
		-- State 1
		nxt 	<= '1';
		wait for delay_time;
		nxt 	<= '0';
		
		-- State 2
		m_tc 	<= '1';
		nxt 	<= '1';
		wait for delay_time;
		m_tc 	<= '0';
		
		wait for delay_time;
		-- Reset back to s0 after delay_time
		rst 	<= '1';
		wait for delay_time;
		rst 	<= '0';
		
-- TEST 2	: Transition from s0->s3 and loop until h_tc & nxt = 1
		-- State 1
		nxt <= '1';
		wait for delay_time;
		nxt <= '0';
		
		-- State 2
		m_tc <= '1';
		wait for delay_time;
		m_tc <= '0';
		
		wait for 50 ns;
		h_tc <= '1';
		nxt <= '1';


		-- Reset for next test
		rst <= '1';
		wait for delay_time;
		rst <= '0';
		
		
-- TEST 3	: Transition from s0->s3 and then reset during the cycle
		-- State 1
		nxt <= '1';
		wait for delay_time;
		nxt <= '0';
		
		-- State 2
		m_tc <= '1';
		nxt 	<= '1';
		
		wait for delay_time;
		m_tc 	<= '0';
		nxt 	<= '0';
		

		rst <= '1';
		wait for delay_time;
		rst <= '0';
		
      wait;
   end process;

END;