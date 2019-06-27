library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- adds 2 one bit inputs and gives the resultant sum on S output and carry output
entity adder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Cin : in  STD_LOGIC;		-- carry input from e.g different adder.
           S : out  STD_LOGIC;		-- Sum output
           Cout : out  STD_LOGIC);	-- Carry output.
end adder;

architecture Behavioral of adder is
signal P,G,Cprop: STD_LOGIC;
begin
	-- Add signals A , B and carry in Cin to give output sum S.
	-- carry out output Cout should be high if more than one input is high.
		G <= A and B;
		P <= A xor B;
		Cprop <= P and Cin;
		Cout <= Cprop or G;
		S <= P xor Cin;
end Behavioral;

