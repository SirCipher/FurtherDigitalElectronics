LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY adder_tb IS
END adder_tb;
 
ARCHITECTURE behavior OF adder_tb IS 
 
    COMPONENT adder
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         Cin : IN  std_logic;
         S : OUT  std_logic;
         Cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic := '0';
   signal B : std_logic := '0';
   signal Cin : std_logic := '0';

 	--Outputs
   signal S : std_logic;
   signal Cout : std_logic;

BEGIN
 
   uut: adder PORT MAP (
          A => A,
          B => B,
          Cin => Cin, 		-- carry input
		  
          S => S, 			-- sum output
          Cout => Cout 		-- carry output
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
	  
		A <= '0';
		B <= '0';
		Cin <= '0';
		wait for 10ns;		-- expected output: Cout =0 ,S =0
		
		A <= '0';
		B <= '0';
		Cin <= '1';
		wait for 10ns;		-- expected output: Cout =0 ,S =1
		
		A <= '0';
		B <= '1';
		Cin <= '0';
		wait for 10ns;		-- expected output: Cout =0 ,S =1
		
		A <= '0';
		B <= '1';
		Cin <= '1';
		wait for 10ns;		-- expected output: Cout =1 ,S =0
		
		A <= '1';
		B <= '0';
		Cin <= '0';
		wait for 10ns;		-- expected output: Cout =0 ,S =1
		
		A <= '1';
		B <= '0';
		Cin <= '1';
		wait for 10ns;		-- expected output: Cout =1 ,S =0
		
		A <= '1';
		B <= '1';
		Cin <= '0';
		wait for 10ns;		-- expected output: Cout =1 ,S =0
		
		A <= '1';
		B <= '1';
		Cin <= '1';
		wait for 10ns;		-- expected output: Cout =1 ,S =1
		
      wait;
   end process;

END;