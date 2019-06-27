LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.DigEng.all;
 
ENTITY control_logic_tb IS
END control_logic_tb;
 
ARCHITECTURE behavior OF control_logic_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	 CONSTANT N	: natural := 3;
	 CONSTANT M : natural := 2;
	 CONSTANT H	: natural := 3;
	 
    COMPONENT Control_logic
	 GENERIC (N, M, H : natural);
    PORT(
				clk 						: IN   std_logic;
				deb_rst 					: IN   std_logic;
				deb_nxt 					: IN   std_logic;
				ROM_A_address 			: OUT  unsigned(size(M*H)-1 downto 0);
				ROM_B_address 			: OUT  unsigned(size(M*H)-1 downto 0);
				RAM_C_address 			: OUT  unsigned(size(M*H)-1 downto 0);
				RAM_C_write_enable 	: OUT  std_logic;
				MACC_enable				: OUT  std_logic;
				MACC_reset 				: OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk 		: std_logic := '0';
   signal deb_rst : std_logic := '0';
   signal deb_nxt : std_logic := '0';

 	--Outputs
   signal ROM_A_address 		: unsigned (size(M*H)-1 downto 0);
   signal ROM_B_address 		: unsigned (size(M*H)-1 downto 0);
   signal RAM_C_address 		: unsigned (size(M*H)-1 downto 0);
   signal RAM_C_write_enable 	: std_logic;
   signal MACC_enable			: std_logic;
   signal MACC_reset 			: std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control_logic 
	GENERIC MAP(N => N,
					M => M,
					H => H)
	PORT MAP (
          clk 						=> clk,
          deb_rst 				=> deb_rst,
          deb_nxt 				=> deb_nxt,
          ROM_A_address 		=> ROM_A_address,
          ROM_B_address 		=> ROM_B_address,
          RAM_C_address 		=> RAM_C_address,
          RAM_C_write_enable 	=> RAM_C_write_enable,
          MACC_enable 			=> MACC_enable,
          MACC_reset 			=> MACC_reset
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

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
