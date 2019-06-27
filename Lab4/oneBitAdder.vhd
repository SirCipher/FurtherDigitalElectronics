library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity oneBitAdder is
    Port ( Cin : in  STD_LOGIC;
           Ain : in  STD_LOGIC;
           Bin : in  STD_LOGIC;
           Sum : out  STD_LOGIC;
           Cout : out  STD_LOGIC);
end oneBitAdder;

architecture Behavioral of oneBitAdder is

begin

	Sum <= (Ain xor Bin) xor Cin;
	Cout <= ((Ain xor Bin) and Cin) or (Ain and Bin );

end Behavioral;

