library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity M_by_N_bitAdder is
		generic (N,M : natural := 4);
		Port ( 	Cin : in  STD_LOGIC;
					Cout : out  STD_LOGIC;
					A : in  STD_LOGIC_VECTOR (N*M-1 downto 0);
					B : in  STD_LOGIC_VECTOR (N*M-1 downto 0);
					Sum : out  STD_LOGIC_VECTOR (N*M-1 downto 0));
end M_by_N_bitAdder;

architecture Behavioral of M_by_N_bitAdder is
 signal carry : STD_LOGIC_VECTOR(M+1 downto 0);
begin
	
	M_by_N: for i in 0 to M-1 generate
		Inst_N_Bit_Adder: entity work.N_Bit_Adder
		generic map(N => N)
		PORT MAP(
			Cin => carry(i),
			Cout => carry(i+1),
			A => A(i*N+(N-1) downto i*N) ,
			B => B(i*N+(N-1) downto i*N),
			Sum => Sum(i*N+(N-1) downto i*N)
		);
	end generate;
	
	carry(0) 	<= Cin;
	Cout 			<= carry(M); 

end Behavioral;

