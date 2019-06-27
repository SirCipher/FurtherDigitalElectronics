library 	IEEE;
use 		IEEE.STD_LOGIC_1164.ALL;
use 		IEEE.NUMERIC_STD.ALL;


entity Control is
    Port ( clk 		: in   STD_LOGIC;
           rst 		: in   STD_LOGIC;
           nxt 		: in   STD_LOGIC;
           mem_wr 	: out  STD_LOGIC;
           Mem_Addr  : out  UNSIGNED (4 downto 0);
           r1_en 		: out  STD_LOGIC;
           r2_en     : out  STD_LOGIC;
           out_en 	: out  STD_LOGIC;
           Mux_Sel 	: out  STD_LOGIC_VECTOR (1 downto 0));
	end Control;
architecture Behavioral of Control is
	signal CNT_EN, DONE : STD_LOGIC;
	type State_type is ( Store0, Store1, LoadR1, LoadR2, StoreN, Wait_State);
	signal state, next_state : State_type;
	signal Count : unsigned( 4 Downto 0);
begin	

--counter to provide ram memory adress
counter : process(clk,DONE,rst)
begin
	if (rising_edge(clk) and ((DONE = '0') or (rst = '1'))) then
		if (rst = '1') then
			Count <= (others => '0');
		elsif ( CNT_EN = '1') then
			Count <= Count + 1;
		end if;
	end if;
end process counter;

-- state register
state_assignment : process(clk) is
begin 
	if (rising_edge(clk)) then
		if (rst = '1') then
			state <= Store0;
		else
			state <= next_state;
		end if;
	end if;
end process state_assignment;

-- FSM 
fsm_process : process (state,nxt,done) is
begin
	case state is
		when Store0 =>
			if (nxt='1') then 
				next_state <= Store1;
			else 
				next_state <= state ;
			end if;
			
		when Store1 => 
			if (nxt='1') then 
				next_state <= LoadR1;
			else 
				next_state <= state ;
			end if;
			
		when LoadR1 =>
			next_state <=LoadR2; 
			
		when LoadR2 =>
			next_state <=StoreN;
			
		when StoreN =>
			next_state <= Wait_State;
			
		when Wait_State =>
			if (nxt='1') AND (done ='0') then 
				next_state<=LoadR1;
			else 
				next_state <= state ; 
			end if;
	end case;
end process fsm_process;

--Done signal
done_sig : process(clk) is
begin
	if(rising_edge(clk))then
		if(rst = '1') then
			DONE <= '0';
		elsif ( count >= 24) then
			DONE <= '1';
		end if;
	end if;
end process done_sig;

--outputs
mem_wr <= '1' When 	state = Store0 or
							state = Store1 or
							state = storeN 
							else '0';
							
r1_en <= '1'  When 	state = LoadR1 
							else '0';

r2_en <= '1'  When 	state = LoadR2
							else '0';
					
out_en <= '1' When 	state = Store0 or
							state = Store1 or
							state = StoreN 
							else '0';

Mux_Sel <= 	"10" When state = Store0 else
				"11" When state = Store1 else
				"00" When state = StoreN 
				else "00"; -- Dont care
				
CNT_EN <= 	nxt 	When 	state = Store0 or
								state = Store1 else
				(nxt and (not DONE)) When
								state = Wait_State
				else '0';
				
							
Mem_Addr <= count	When	state = Store0 or
								state = Store1 or
								state = StoreN else
				(count - 2) When 
								state = LoadR1 else
				(count - 1) When 
								state = LoadR2 
				else (others => '0'); -- Dont care


end Behavioral;

