LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY Top_level_tb IS
END Top_level_tb;
 
ARCHITECTURE behavior OF Top_level_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Top_Level
    PORT(
         enable 	: IN std_logic;
         reset		: IN std_logic;
         clk 		: IN std_logic;
         display1 : OUT unsigned(6 downto 0);
         display2 : OUT unsigned(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal enable 	: std_logic := '0';
   signal reset 	: std_logic := '0';
   signal clk 		: std_logic := '0';

 	--Outputs
   signal display1 : unsigned(6 downto 0);
   signal display2 : unsigned(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Top_Level PORT MAP (
		 enable => enable,
		 reset => reset,
		 clk => clk,
		 display1 => display1,
		 display2 => display2
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
   begin		
      -- Wait for signals to settle
		wait for 125ns;
		reset <= '1';
		enable <= '0';
		wait for 100ns;
		reset <= '0';
		enable <= '1';
		wait for 100ns;
		enable <= '0';
		
		-- Test if counter counts correctly
		-- from 0->99->0
		pulse_1 : for i in 0 to 500 loop
			enable <= '1';
			wait for clk_period*10;
			enable <= '0';
			wait for clk_period*10;
		end loop pulse_1;
		
		-- Check if the counter only increments
		-- by one, per enable press
		enable <= '1';
		wait for 125ns;
		
		-- Test if counter resets synchronously
		reset <= '1';
		wait for 100ns;
		reset <= '0';

		-- Test if counter continues to count 
		-- after being reset
		pulse_2 : for i in 0 to 80 loop
		enable <= '1';
		wait for clk_period*10;
		enable <= '0';
		wait for clk_period*10;
		end loop pulse_2;

      wait;
   end process;

END;