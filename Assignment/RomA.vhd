library 	IEEE;
use 		IEEE.STD_LOGIC_1164.ALL;
use 		IEEE.NUMERIC_STD.ALL;
use		work.DigEng.ALL;

entity ROM_Matrix_A is
		generic (M 					: natural := 2;
					H 					: natural := 3;
					Data_size		: natural := 4);
		Port(Address 			 	: in  unsigned (size(M*H-1)-1 downto 0);
			  Matrix_Coefficient : out SIGNED 	(Data_size-1 downto 0));
end ROM_Matrix_A;

architecture Behavioral of ROM_Matrix_A is
	type ROM_Array is array (0 to M*H-1) of SIGNED(Data_size-1 downto 0);
		constant Data: ROM_Array :=(
			--MAXIMUM POSITIVE COEFFICIENT VALUE
			0 		=> to_signed((2**(Data_size-1))-1,Data_size),-- A1_1
			1 		=> to_signed((2**(Data_size-1))-1,Data_size),
			2 		=> to_signed((2**(Data_size-1))-1,Data_size),
			3 		=> to_signed((2**(Data_size-1))-1,Data_size),
			4 		=> to_signed((2**(Data_size-1))-1,Data_size),
			5 		=> to_signed((2**(Data_size-1))-1,Data_size),
			6 		=> to_signed((2**(Data_size-1))-1,Data_size),
			7 		=> to_signed((2**(Data_size-1))-1,Data_size),
			8		=> to_signed((2**(Data_size-1))-1,Data_size),
			9		=> to_signed((2**(Data_size-1))-1,Data_size),
			10		=> to_signed((2**(Data_size-1))-1,Data_size),
			11		=> to_signed((2**(Data_size-1))-1,Data_size),
			12		=> to_signed((2**(Data_size-1))-1,Data_size),
			13		=> to_signed((2**(Data_size-1))-1,Data_size),
			14		=> to_signed((2**(Data_size-1))-1,Data_size),
			15		=> to_signed((2**(Data_size-1))-1,Data_size),
			16		=> to_signed((2**(Data_size-1))-1,Data_size),--A1_17
			--MINIMUM COEFFICIENT SIZE
			17		=> to_signed(0,Data_size),--A2_1
			18		=> to_signed(0,Data_size),
			19		=> to_signed(0,Data_size),
			20		=> to_signed(0,Data_size),
			21		=> to_signed(0,Data_size),
			22		=> to_signed(0,Data_size),
			23		=> to_signed(0,Data_size),
			24		=> to_signed(0,Data_size),
			25		=> to_signed(0,Data_size),
			26		=> to_signed(0,Data_size),
			27		=> to_signed(0,Data_size),
			28		=> to_signed(0,Data_size),
			29		=> to_signed(0,Data_size),
			30		=> to_signed(0,Data_size),
			31		=> to_signed(0,Data_size),
			32 	=> to_signed(0,Data_size),
			33		=> to_signed(0,Data_size),--A2_17
			--MAXIMUM NEGATIVE VALUE
			34		=> to_signed(-(2**(Data_size-1)),Data_size),--A3_1
			35		=> to_signed(-(2**(Data_size-1)),Data_size),
			36		=> to_signed(-(2**(Data_size-1)),Data_size),
			37		=> to_signed(-(2**(Data_size-1)),Data_size),
			38		=> to_signed(-(2**(Data_size-1)),Data_size),
			39		=> to_signed(-(2**(Data_size-1)),Data_size),
			40		=> to_signed(-(2**(Data_size-1)),Data_size),
			41		=> to_signed(-(2**(Data_size-1)),Data_size),
			42		=> to_signed(-(2**(Data_size-1)),Data_size),
			43		=> to_signed(-(2**(Data_size-1)),Data_size),
			44		=> to_signed(-(2**(Data_size-1)),Data_size),
			45		=> to_signed(-(2**(Data_size-1)),Data_size),
			46		=> to_signed(-(2**(Data_size-1)),Data_size),
			47		=> to_signed(-(2**(Data_size-1)),Data_size),
			48		=> to_signed(-(2**(Data_size-1)),Data_size),
			49		=> to_signed(-(2**(Data_size-1)),Data_size),
			50		=> to_signed(-(2**(Data_size-1)),Data_size),--A3_17
			-- MINUS 1
			51		=> to_signed(-1,Data_size),--A4_1
			52		=> to_signed(-1,Data_size),
			53		=> to_signed(-1,Data_size),
			54		=> to_signed(-1,Data_size),
			55		=> to_signed(-1,Data_size),
			56		=> to_signed(-1,Data_size),
			57		=> to_signed(-1,Data_size),
			58		=> to_signed(-1,Data_size),
			59		=> to_signed(-1,Data_size),
			60		=> to_signed(-1,Data_size),
			61		=> to_signed(-1,Data_size),
			62		=> to_signed(-1,Data_size),
			63		=> to_signed(-1,Data_size),
			64		=> to_signed(-1,Data_size),
			65		=> to_signed(-1,Data_size),
			66		=> to_signed(-1,Data_size),
			67		=> to_signed(-1,Data_size),--A4_17
			
					
			others => to_signed(0,Data_size));
begin
	
	-- Asynchronous read
	Matrix_Coefficient <= Data(to_integer(address));
	
end Behavioral;

