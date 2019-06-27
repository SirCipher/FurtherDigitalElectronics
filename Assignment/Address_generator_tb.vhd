LIBRARY 		ieee;
USE 			ieee.std_logic_1164.ALL;
USE 			ieee.numeric_std.ALL;
use 			work.DigEng.ALL; 
 
ENTITY Address_generator_tb IS
END 	 Address_generator_tb;
 
ARCHITECTURE behavior OF Address_generator_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Address_generator
	 generic(--matrix size
				N	 	: integer 	:= 3;
				H		: integer 	:= 3;
				M		: integer	:= 2
				);
    PORT(
         M_counter_value : IN  	unsigned(size(M-1)  	-1 downto 0);
         N_counter_value : IN  	unsigned(size(N-1)	-1 downto 0);
         H_counter_value : IN  	unsigned(size(H-1)	-1 downto 0);
         ROM_A_address : 	OUT  	unsigned(size(M*H) 	-1 downto 0);
         ROM_B_address : 	OUT  	unsigned(size(M*N) 	-1 downto 0);
         RAM_C_address : 	OUT  	unsigned(size(N*H)	-1 downto 0)
        );
    END COMPONENT;
	 
    constant N_generic 	:Integer 	:= 3;
	 constant H_generic 	:Integer 	:= 3;
	 constant M_generic	: Integer	:= 2;


   --Inputs
   signal M_counter_value : unsigned(size(M_generic-1)  -1 downto 0) := (others => '0');
   signal N_counter_value : unsigned(size(N_generic-1)-1 downto 0) := (others => '0');
   signal H_counter_value : unsigned(size(H_generic-1)-1 downto 0) := (others => '0');

 	--Outputs
   signal ROM_A_address : unsigned(size(M_generic*H_generic) -1 downto 0);
   signal ROM_B_address : unsigned(size(M_generic*N_generic) -1 downto 0);
   signal RAM_C_address : unsigned(size(N_generic*H_generic)-1 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Address_generator 
	GENERIC MAP( 	N 		=> N_generic,
						H 		=> H_generic,
						M 		=> M_generic
					)
	PORT MAP (
          M_counter_value 	=> M_counter_value,
          N_counter_value 	=> N_counter_value,
          H_counter_value 	=> H_counter_value,
          ROM_A_address 	=> ROM_A_address,
          ROM_B_address	 	=> ROM_B_address,
          RAM_C_address 	=> RAM_C_address
        );

 

   -- Stimulus process
   stim_proc: process
		variable M_value,N_value,H_value : Integer := 0;
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		
		for i in 0 to 1000 loop 
			M_counter_value <= to_unsigned(M_value,size(M_generic-1));
			N_counter_value <= to_unsigned(N_value,size(N_generic-1));
			H_counter_value <= to_unsigned(H_value,size(H_generic-1));
			wait for 100 ns;
			
			if (M_value < M_generic-1 )then
				M_value := M_value + 1;
			elsif(M_value = M_generic-1 )then
				M_value := 0;
				if(N_value < N_generic -1)then
					N_value := N_value + 1;
				elsif(N_value = N_generic -1)then
					N_value := 0;
					if(H_value < H_generic -1)then
					H_value := H_value + 1;
					elsif(H_value = H_generic -1) then
						H_value := 0;
					end if;
				end if;
			end if;
				
		end loop;

      -- insert stimulus here 

      wait;
   end process;

END;