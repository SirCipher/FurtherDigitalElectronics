LIBRARY 	ieee;
USE 		ieee.std_logic_1164.ALL;
use		work.DigEng.All;
USE 		ieee.numeric_std.ALL;
 
ENTITY RAM_tb IS
END 	 RAM_tb;
 
ARCHITECTURE behavior OF RAM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	 CONSTANT Maximum_coefficient_bit_number 	: natural := 4;
	 CONSTANT Matrix_width_Depth_N_H 			: natural := 3;
	 CONSTANT delay_time								: Time 	 := 10 ns;
	 
    COMPONENT RAM_single_port
	 GENERIC(Maximum_coefficient_bit_number, Matrix_width_Depth_N_H : natural);
    PORT(
         clk 			 : IN  	std_logic;
         write_enable : IN  	std_logic;
         data_in 		 : IN  	signed(Maximum_coefficient_bit_number-1 downto 0);
         Address 		 : IN  	unsigned(size(Matrix_width_Depth_N_H**2)-1 downto 0);
         output 		 : OUT 	signed(Maximum_coefficient_bit_number-1 downto 0)
        );
    END COMPONENT;
   
   --Inputs
   signal clk 				: std_logic := '0';
   signal write_enable 	: std_logic := '0';
   signal data_in 		: SIGNED(Maximum_coefficient_bit_number-1 downto 0) 	 := (others => '0');
   signal Address 		: unsigned(size(Matrix_width_Depth_N_H**2)-1 downto 0) := (others => '0');

 	--Outputs
   signal output 			: signed(Maximum_coefficient_bit_number-1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;

	-- Define the test vector record and types
	type test_vector is record
		write_enable	: std_logic;
		data_in			: signed(Maximum_coefficient_bit_number-1 downto 0);
		Address			: unsigned(size(Matrix_width_Depth_N_H**2)-1 downto 0);
		output			: signed(Maximum_coefficient_bit_number-1 downto 0);
	end record;
	
	type test_vector_array is array
		(natural range <>) of test_vector;
	
	constant max_value 		:  signed(Maximum_coefficient_bit_number-1	 downto 0) 	:= (others => '1');
	constant min_value		: 	unsigned(Maximum_coefficient_bit_number-1 downto 0) 	:= (others => '0');
	
	constant test_vectors	:	test_vector_array := (
		-- Define test inputs and expected outputs
		-- Write Enable, Data in, Address, output
		('1', max_value, 				min_value, 				max_value), -- Write to address 	0000
		('0', max_value, 				min_value, 				max_value),	-- Read from address 0000
		('1', max_value, 				unsigned(max_value), max_value),	-- Write to address 	1111
		('0', signed(min_value), 	unsigned(max_value), max_value),	-- Read from address	1111
		('1', max_value, 				unsigned(max_value), max_value)		
	);
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RAM_single_port 
	
	GENERIC MAP (
			Matrix_width_Depth_N_H			 => 3,
			Maximum_coefficient_bit_number => 4)
	
	PORT MAP (
         clk 			 	=> clk,
         write_enable 	=> write_enable,
         data_in 			=> data_in,
         Address 			=> Address,
         output 			=> output
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

		-- Loop through all of the test vectors and check their outputs
		for i in test_vectors'range loop
			wait for delay_time;
			-- Input the current test_vector values
			write_enable 	<= test_vectors(i).write_enable;
			data_in			<= test_vectors(i).data_in;
			Address			<= test_vectors(i).Address;
			wait for delay_time;
			assert(output = test_vectors(i).output)
			-- Report any failures and display the outputs and expected outputs 
			report 	" Test inputs failed for line " 		& integer'image(i) &
						", with inputs: write_enable = " 	& std_logic'image(write_enable) &
						", & data_in = "							& integer'image(to_integer(unsigned(test_vectors(i).data_in))) &
						", & Address = "							& integer'image(to_integer(unsigned(test_vectors(i).Address))) &
						". Expected output "						& integer'image(to_integer(unsigned(test_vectors(i).output)))  &
						". Actual output "						& integer'image(to_integer(unsigned(output)))
			severity note;
		end loop;

      wait;
   end process;

END;