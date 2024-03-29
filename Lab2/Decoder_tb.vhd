--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:44:04 01/17/2016
-- Design Name:   
-- Module Name:   C:/Users/PC/FurtherDigital/Lab2/TaskC/Decoder_tb.vhd
-- Project Name:  TaskC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY Decoder_tb IS
END Decoder_tb;
 
ARCHITECTURE behavior OF Decoder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder
    PORT(
         Sig_bus : IN  unsigned(3 downto 0);
         Decoded_sig_bus : OUT  unsigned(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Sig_bus : unsigned(3 downto 0) := (others => '0');

 	--Outputs
   signal Decoded_sig_bus : unsigned(6 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder PORT MAP (
          Sig_bus => Sig_bus,
          Decoded_sig_bus => Decoded_sig_bus
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		Sig_bus <= "0000";
		wait for 10 ns;	
		Sig_bus <= "0001";
		wait for 10 ns;
		Sig_bus <= "0010";
		wait for 10 ns;
		Sig_bus <= "0011";
		wait for 10 ns;
		Sig_bus <= "0100";
		wait for 10 ns;
		Sig_bus <= "0101";
		wait for 10 ns;
		Sig_bus <= "0110";
		wait for 10 ns;
		Sig_bus <= "0111";
		wait for 10 ns;
		Sig_bus <= "1000";
		wait for 10 ns;
		Sig_bus <= "1001";
		wait for 10 ns;
      wait;
   end process;

END;
