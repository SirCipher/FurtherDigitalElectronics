LIBRARY 	ieee;
USE 		ieee.std_logic_1164.ALL;
USE 		ieee.numeric_std.ALL;
USE 		ieee.math_real.all;
 
ENTITY macc_tb IS
END 	 macc_tb;
 
ARCHITECTURE behavior OF macc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	 CONSTANT data_size 			: natural := 4;
	 CONSTANT coeff_data_size 	: natural := 8;
	 
    COMPONENT macc
	 GENERIC(data_size,coeff_data_size : natural);
    PORT(
				clk 	: IN   std_logic;
				RST 	: IN   std_logic;
				EN 	: IN   std_logic;
				A 		: IN   SIGNED(data_size-1 downto 0);
				B 		: IN   SIGNED(data_size-1 downto 0);
				P 		: OUT  SIGNED(coeff_data_size-1 downto 0)
			 );
    END COMPONENT;

   --Inputs
   signal clk 	: std_logic := '0';
   signal RST	: std_logic := '0';
   signal EN 	: std_logic := '0';
   signal A 	: SIGNED(data_size-1 downto 0) := (others => '0');
   signal B 	: SIGNED(data_size-1 downto 0) := (others => '0');

 	--Outputs
   signal P : SIGNED(coeff_data_size-1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: macc 
	GENERIC MAP (
			data_size 		 => 4,
			coeff_data_size => 8)
	PORT MAP (
			clk 	=> clk,
			RST 	=> RST,
			EN 	=> EN,
			A 		=> A,
			B 		=> B,
			P 		=> P
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
      -- hold reset state for 100 ns
		RST <= '1';
      wait for 100 ns;	
		
		RST <= '0';
		EN  <= '1';
		wait for clk_period*5;
		
-- TEST 1	: 	Multiply by 1 and check that the unit adds as it should

	-- Set the multiplier 
	B <= B+1;
	
	countTest : for i in 0 to 127 loop
		A <= A+1;
		wait for clk_period*5;
	end loop countTest;
	
	rst <= '1';
	wait for clk_period*5;
	rst <= '0';
-- END TEST 1

-- TEST 2	:	Start a count from 0. Count to a quarter of the data_size. 
--					Stop. Toggle enable and then continue to count

	-- Start the initial count
	count : for i in 0 to ((2 ** data_size)/4) loop
		A <= A+1;
		wait for clk_period*5;
	end loop count;
	
	-- Toggle enable
	en <= '0';
	wait for clk_period*5;
	en <= '1';
	
	-- Check if the unit continues to operate
	resumecount : for i in ((2 ** data_size)/4)+1 to (2 ** data_size)/2 loop
		A <= A+1;
		wait for clk_period*5;
	
	end loop resumecount;
-- END TEST 2
	
	-- Reset the unit
	rst <= '1';
	wait for clk_period*5;
	rst <= '0';
	
-- TEST 3	:	Check multiplication is correct
	-- Check multiplication by a positive number
	A <= X"2";
	B <= X"4";
	wait for clk_period*5;
	
	-- Reset the unit and the inputs to 0
	A <= (Others => '0');
	B <= (Others => '0');	
	rst <= '1';
	wait for clk_period*5;
	rst <= '0';
	
	-- Check multiplication by a negative number
	A <= X"2";
	B <= X"e";
	wait for clk_period*5;
	en <= '0';
	
-- END TEST 3

   wait;
   end process;

END;