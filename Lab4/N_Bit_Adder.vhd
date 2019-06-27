library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity N_Bit_Adder is
	generic (N : integer := 3);
	Port (  Cin : in  STD_LOGIC;
			  Cout : out  STD_LOGIC;
			  A : in  STD_LOGIC_VECTOR (N-1 downto 0);
			  B : in  STD_LOGIC_VECTOR (N-1 downto 0);
			  Sum : out  STD_LOGIC_VECTOR (N-1 downto 0));
end N_Bit_Adder;

architecture Behavioral of N_Bit_Adder is
  signal carry : STD_LOGIC_VECTOR (N+1 downto 0);
begin

	N_adder : for i in 0 to N-1 generate
		one_bit_adder : entity work.oneBitAdder
		port map(		Cin => carry(i),
							Ain => A(i),
							Bin => B(i),
							Sum => Sum(i),
							Cout => carry(i+1)
					);
	end generate;
	
	carry(0) <= Cin;
	Cout <= carry(N);

end Behavioral;

