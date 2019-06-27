LIBRARY  ieee;
USE 		ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY m_by_n_tb IS
END 	 m_by_n_tb;
 
ARCHITECTURE behavior OF m_by_n_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	 CONSTANT M, N : natural := 4;
    COMPONENT M_by_N_bitAdder
	 GENERIC (M,N : natural );
    PORT(
         Cin 	: IN   std_logic;
         Cout 	: OUT  std_logic;
         A 		: IN   std_logic_vector(15 downto 0);
         B 		: IN   std_logic_vector(15 downto 0);
         Sum 	: OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal Cin  : std_logic := '0';
   signal A 	: std_logic_vector(15 downto 0) := (others => '0');
   signal B 	: std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Cout : std_logic;
   signal Sum  : std_logic_vector(15 downto 0);

-- Start
	type test_vector is record
			a 		: std_logic_vector(15 downto 0); 
			b 		: std_logic_vector(15 downto 0); 
			cin 	: std_logic; 
			sum	: std_logic_vector(15 downto 0);
			cout	: std_logic; 
	end record;

	type test_vector_array is array 
			(natural range <>) of test_vector;
			
	constant test_vectors : test_vector_array := (
			-- define test inputs and expected outputs using hex
			-- a, b, cin, sum, cout
			(X"0001", X"0000", '0', X"0001", '0'), -- Change all values to hex 
			(X"FFFF", X"0000", '0', X"FFFF", '0'),
			(X"FFFF", X"0000", '1', X"0000", '1'),
			(X"FFFF", X"FFFF", '1', X"FFFF", '1'),
			(X"ABCD", X"ABCD", '1', X"ABCD", '0') 	-- Incorrect values to check verify process
			);
		 
BEGIN
	
	
	-- Instantiate the Unit Under Test (UUT)
   uut: M_by_N_bitAdder 
	generic map(N => 4,
					M => 4
	)
	
	PORT MAP (
          Cin  => Cin,
          Cout => Cout,
          A 	=> A,
          B 	=> B,
          Sum 	=> Sum
        );

-- Process to check 
	verifyadder: process
	begin 
		wait for 10ns;
		for i in test_vectors'range loop
			a 	 <= test_vectors(i).a;
			b 	 <= test_vectors(i).b;
			cin <= test_vectors(i).cin;
			
			wait for 10ns;
			assert ((sum = test_vectors(i).sum) and 
					 (cout = test_vectors(i).cout))
--			report "Test inputs " 	& integer'image(i) 
--				 " failed for inputs a= "	& std_logic'image(a)
--					 ", b = "& std_logic_vector'image(b) &
--					 " and Cin = " & std_logic'image(cin)
			severity error;
		end loop;
		
		a 	 <= X"0000";
		b 	 <= X"0000";
		cin <= '0';		-- Made these 0 to make the simulation easier to read. 
							-- Remove when finished 
		
		wait;
	end process;

END;