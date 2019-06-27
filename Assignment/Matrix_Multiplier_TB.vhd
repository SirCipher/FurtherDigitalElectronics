LIBRARY 	ieee;
USE 		ieee.std_logic_1164.ALL;
USE 		ieee.numeric_std.ALL;
use 		work.DigEng.ALL;

ENTITY Matrix_Multiplier_TB IS
END Matrix_Multiplier_TB;
 
ARCHITECTURE behavior OF Matrix_Multiplier_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Matrix_Multiplier
	 GENERIC	(	M 					: natural := 17;
					N 					: natural := 8;
					H 					: natural := 4;
					data_size 		: natural := 4);
    PORT(
         clk 		: IN  std_logic;
         nxt 		: IN  std_logic;
         rst 		: IN  std_logic;
         output 	: OUT  signed(coeff_C(data_size,M)-1 downto 0));
    END COMPONENT;
    
	constant M_generic : natural := 17;
	constant N_generic : natural := 8;
	constant H_generic : natural := 4;
	constant data_size_generic : natural := 4;
	
   --Inputs
   signal clk : std_logic := '0';
   signal nxt : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal output : signed(coeff_C(data_size_generic,M_generic)-1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	type Matrix_C_array is array (0 to N_generic*H_generic-1) of signed(coeff_C(data_size_generic,M_generic)-1 downto 0);
	constant C_coefficients : Matrix_C_array :=(
				0 => 	to_signed(833	,coeff_C(data_size_generic,M_generic)),
				1 => 	to_signed(0		,coeff_C(data_size_generic,M_generic)),
				2 => 	to_signed(-952	,coeff_C(data_size_generic,M_generic)),
				3 => 	to_signed(-119	,coeff_C(data_size_generic,M_generic)),
				4 => 	to_signed(119	,coeff_C(data_size_generic,M_generic)),
				5 => 	to_signed(-238	,coeff_C(data_size_generic,M_generic)),
				6 => 	to_signed(238	,coeff_C(data_size_generic,M_generic)),
				7 => 	to_signed(-833	,coeff_C(data_size_generic,M_generic)),
				
				8 => 	to_signed(0		,coeff_C(data_size_generic,M_generic)),
				9 => 	to_signed(0		,coeff_C(data_size_generic,M_generic)),
				10 => to_signed(0		,coeff_C(data_size_generic,M_generic)),
				11 => to_signed(0		,coeff_C(data_size_generic,M_generic)),
				12 => to_signed(0		,coeff_C(data_size_generic,M_generic)),
				13 => to_signed(0		,coeff_C(data_size_generic,M_generic)),
				14 => to_signed(0		,coeff_C(data_size_generic,M_generic)),
				15 => to_signed(0		,coeff_C(data_size_generic,M_generic)),
				
				16 => to_signed(-952	,coeff_C(data_size_generic,M_generic)),
				17 => to_signed(0		,coeff_C(data_size_generic,M_generic)),
				18 => to_signed(1088	,coeff_C(data_size_generic,M_generic)),
				19 => to_signed(136	,coeff_C(data_size_generic,M_generic)),
				20 => to_signed(-136	,coeff_C(data_size_generic,M_generic)),
				21 => to_signed(272	,coeff_C(data_size_generic,M_generic)),
				22 => to_signed(-272	,coeff_C(data_size_generic,M_generic)),
				23 => to_signed(952	,coeff_C(data_size_generic,M_generic)),
				
				24 => to_signed(-119	,coeff_C(data_size_generic,M_generic)),
				25 => to_signed(0		,coeff_C(data_size_generic,M_generic)),
				26 => to_signed(136	,coeff_C(data_size_generic,M_generic)),
				27 => to_signed(17	,coeff_C(data_size_generic,M_generic)),
				28 => to_signed(-17	,coeff_C(data_size_generic,M_generic)),
				29 => to_signed(34	,coeff_C(data_size_generic,M_generic)),
				30 => to_signed(-34	,coeff_C(data_size_generic,M_generic)),
				31 => to_signed(119	,coeff_C(data_size_generic,M_generic)));	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Matrix_Multiplier 
	GENERIC MAP(M 						=> M_generic, 
					N  					=> N_generic, 
					H  					=> H_generic, 
					Data_size  			=> data_size_generic)
	PORT MAP (
          clk => clk,
          nxt => nxt,
          rst => rst,
          output => output
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
      -- hold reset state for 100 ns.
      wait for 100 ns;
		rst <= '1';
		wait for clk_period*2;
		rst <= '0';
		
	--TEST 1: Check if the circuit computes the expected matrix C coefficients.
		for i in 0 to N_generic*H_generic-1 loop
			nxt <= '1';
			wait for clk_period*2;
			nxt <= '0';
			wait for clk_period*(m_generic+3);
			assert(C_coefficients(i) = output)
			report 	"FAILED to compute coefficient " & integer'image(i) & " !" &
						" output = " & integer'image(to_integer(output)) & " expected = " & integer'image(to_integer(C_coefficients(i)))
			severity ERROR;
			assert(C_coefficients(i) /= output)
			report 	"PASSED! coefficient " & integer'image(i) & " computed " &
						" output = " & integer'image(to_integer(output)) & " expected = " & integer'image(to_integer(C_coefficients(i)))
			severity note;
		end loop;
		
	--TEST 2: Confirm that the matrix holds the value after the last coefficient has been computed.
		wait for clk_period*2;
		assert(C_coefficients(N_generic*H_generic-1) = output)
			report 	"FAILED to Hold value after final coefficient computed." &
						" Output = " & integer'image(to_integer(output)) & " expected = " & integer'image(to_integer(C_coefficients(N_generic*H_generic-1)))
			severity ERROR;
		assert(C_coefficients(N_generic*H_generic-1) /= output)
			report 	"PASSED! Held final value." &
						" Output = " & integer'image(to_integer(output)) & " expected = " & integer'image(to_integer(C_coefficients(N_generic*H_generic-1)))
			severity note;
			
	--TEST 3: Confrim that the matrix correctly resets.
		wait for clk_period;
		rst <= '1';
		wait for clk_period*2;
		rst <= '0';
		wait for clk_period*2;
		assert(C_coefficients(0) = output)
			report 	"FAILED to reset." &
						" Output = " & integer'image(to_integer(output)) & " expected = " & integer'image(to_integer(C_coefficients(0)))
			severity ERROR;
		assert(C_coefficients(0) /= output)
			report 	"PASSED! circuit reset correctly." &
						" Output = " & integer'image(to_integer(output)) & " expected = " & integer'image(to_integer(C_coefficients(0)))
			severity note;
		wait for clk_period*20;
	--TEST 4: Check that the Matrix resets properly from mid cycle
		--calculate coeff C up to a certain value
		for i in 0 to N_generic loop
			nxt <= '1';
			wait for clk_period*2;
			nxt <= '0';
			wait for clk_period*(m_generic+3);
			assert(C_coefficients(i) = output)
			report 	"FAILED to compute coefficient " & integer'image(i) & " !" &
						" output = " & integer'image(to_integer(output)) & " expected = " & integer'image(to_integer(C_coefficients(i)))
			severity ERROR;
			assert(C_coefficients(i) /= output)
			report 	"PASSED! coefficient " & integer'image(i) & " computed " &
						" output = " & integer'image(to_integer(output)) & " expected = " & integer'image(to_integer(C_coefficients(i)))
			severity note;
		end loop;
		--reset
		wait for clk_period*2;
		rst <= '1';
		wait for clk_period*2;
		rst <= '0';
		wait for clk_period*2;
		assert(C_coefficients(0) = output)
			report 	"FAILED to reset." &
						" Output = " & integer'image(to_integer(output)) & " expected = " & integer'image(to_integer(C_coefficients(0)))
			severity ERROR;
		assert(C_coefficients(0) /= output)
			report 	"PASSED! circuit reset correctly." &
						" Output = " & integer'image(to_integer(output)) & " expected = " & integer'image(to_integer(C_coefficients(0)))
			severity note;
      wait;
   end process;

END;