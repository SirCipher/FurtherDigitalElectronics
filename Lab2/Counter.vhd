----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:01:39 01/16/2016 
-- Design Name: 
-- Module Name:    Counter - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

entity Counter is
    Port ( clk 		: in  STD_LOGIC;
           en 			: in  STD_LOGIC;
           rst 		: in  STD_LOGIC;
           Display1 	: out  unsigned (3 downto 0);
           Display2 	: out  unsigned (3 downto 0));
end Counter;

architecture Behavioral of Counter is
	Signal count1,count2 : unsigned (3 downto 0 );
begin

	counter1 : PROCESS (clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			IF (rst = '1') THEN
				count1 <= (others => '0');
			ELSIF (en = '1' and count1 < "1001") THEN
				count1 <= count1 + 1;
			ELSIF (en = '1') THEN
				count1 <= (others => '0');
			END IF;
		END IF;
	END PROCESS counter1;
	
	counter2 : PROCESS (clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			IF (rst = '1') THEN
				count2 <= (others => '0');
			ELSIF (count1(0) = '1' and count1(3) = '1' and count2 < "1001" and en = '1') THEN
				count2 <= count2 + 1;
			ELSIF (count1(0) = '1' and count1(3) = '1' and en = '1') THEN
				count2 <= (others => '0');
			END IF;
		END IF;
	END PROCESS counter2;

	--outputs:
	Display1 <= count1;
	Display2 <= count2;
	
end Behavioral;

