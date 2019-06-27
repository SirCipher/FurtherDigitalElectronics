----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:42:23 01/17/2016 
-- Design Name: 
-- Module Name:    Top_Level - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top_Level is
    Port ( enable : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           display1 : out  unsigned (6 downto 0);
           display2 : out  unsigned (6 downto 0));
end Top_Level;
architecture Behavioral of Top_Level is

	COMPONENT Counter
		PORT(
			clk : IN std_logic;
			en : IN std_logic;
			rst : IN std_logic;          
			Display1 : OUT unsigned(3 downto 0);
			Display2 : OUT unsigned(3 downto 0)
			);
	END COMPONENT;
	
	COMPONENT Debouncer
	PORT(
		clk : IN std_logic;
		sig : IN std_logic;          
		Deb_Sig : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT Decoder
	PORT(
		Sig_bus : IN unsigned(3 downto 0);          
		Decoded_sig_bus : OUT unsigned(6 downto 0)
		);
	END COMPONENT;
	
	signal deb_rst,deb_en : STD_LOGIC;
	signal counter1_out,counter2_out : unsigned(3 Downto 0);
	
begin
	
	Counter1 : Counter PORT MAP(
		clk => clk,
		en => deb_en,
		rst => deb_rst,
		Display1 => counter1_out,
		Display2 => counter2_out
	);
	
	Debouncer_enable : Debouncer PORT MAP(
		clk => clk,
		sig => enable,
		Deb_Sig => deb_en
	);
	
	Debouncer_reset : Debouncer PORT MAP(
		clk => clk,
		sig => reset,
		Deb_Sig => deb_rst
	);
	
	Display1_Decoder: Decoder PORT MAP(
		Sig_bus => counter1_out,
		Decoded_sig_bus => display1
	);
	
	Display2_Decoder: Decoder PORT MAP(
		Sig_bus => counter2_out,
		Decoded_sig_bus => display2
	);

end Behavioral;

