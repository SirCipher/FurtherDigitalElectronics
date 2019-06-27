library 	IEEE;
use 		IEEE.STD_LOGIC_1164.ALL;
use 		IEEE.NUMERIC_STD.ALL;
use 		work.DigEng.ALL;

entity Rom_Matrix_B is
		generic (M 					: natural := 2;
					N 					: natural := 3;
					Data_size		: natural := 4);
    Port ( Address 				: in  unsigned (size(M*N-1)-1 downto 0);
           matrix_coefficient : out	signed 	(Data_size-1 downto 0));
end Rom_Matrix_B;

architecture Behavioral of Rom_Matrix_B is
	--ROM FOR A 3x2 matrix ( 2 rows and 3 columns) 
	type Rom_Array is array (0 to M*N-1) of signed(Data_size-1 downto 0);
	constant Rom_B : Rom_Array :=(

			0 		=> to_signed((2**(Data_size-1))-1,Data_size),--B1_1
			1 		=> to_signed(0,Data_size),
			2 		=> to_signed(-(2**(Data_size-1)),Data_size),
			3 		=> to_signed(-1,Data_size),
			4 		=> to_signed(1,Data_size),
			5 		=> to_signed(-2,Data_size),
			6 		=> to_signed(2,Data_size),
			7 		=> to_signed(-(2**(Data_size-1))+1,Data_size),--B1_8
			
			8		=> to_signed((2**(Data_size-1))-1,Data_size),--B2_1
			9		=> to_signed(0,Data_size),
			10		=> to_signed(-(2**(Data_size-1)),Data_size),
			11		=> to_signed(-1,Data_size),
			12		=> to_signed(1,Data_size),
			13		=> to_signed(-2,Data_size),
			14		=> to_signed(2,Data_size),
			15		=> to_signed(-(2**(Data_size-1))+1,Data_size),--B2_8
			
			16		=> to_signed((2**(Data_size-1))-1,Data_size),--B3_1
			17		=> to_signed(0,Data_size),
			18		=> to_signed(-(2**(Data_size-1)),Data_size),
			19		=> to_signed(-1,Data_size),
			20		=> to_signed(1,Data_size),
			21		=> to_signed(-2,Data_size),
			22		=> to_signed(2,Data_size),
			23		=> to_signed(-(2**(Data_size-1))+1,Data_size),--B3_8
			
			24		=> to_signed((2**(Data_size-1))-1,Data_size),--B4_1
			25		=> to_signed(0,Data_size),
			26		=> to_signed(-(2**(Data_size-1)),Data_size),
			27		=> to_signed(-1,Data_size),
			28		=> to_signed(1,Data_size),
			29		=> to_signed(-2,Data_size),
			30		=> to_signed(2,Data_size),
			31		=> to_signed(-(2**(Data_size-1))+1,Data_size),--B4_8
			
			32 	=> to_signed((2**(Data_size-1))-1,Data_size),--B5_1
			33		=> to_signed(0,Data_size),
			34		=> to_signed(-(2**(Data_size-1)),Data_size),
			35		=> to_signed(-1,Data_size),
			36		=> to_signed(1,Data_size),
			37		=> to_signed(-2,Data_size),
			38		=> to_signed(2,Data_size),
			39		=> to_signed(-(2**(Data_size-1))+1,Data_size),--B5_8
			
			40 	=> to_signed((2**(Data_size-1))-1,Data_size),--B6_1
			41		=> to_signed(0,Data_size),
			42		=> to_signed(-(2**(Data_size-1)),Data_size),
			43		=> to_signed(-1,Data_size),
			44		=> to_signed(1,Data_size),
			45		=> to_signed(-2,Data_size),
			46		=> to_signed(2,Data_size),
			47		=> to_signed(-(2**(Data_size-1))+1,Data_size),--B6_8
			
			48 	=> to_signed((2**(Data_size-1))-1,Data_size),--B7_1
			49		=> to_signed(0,Data_size),
			50		=> to_signed(-(2**(Data_size-1)),Data_size),
			51		=> to_signed(-1,Data_size),
			52		=> to_signed(1,Data_size),
			53		=> to_signed(-2,Data_size),
			54		=> to_signed(2,Data_size),
			55		=> to_signed(-(2**(Data_size-1))+1,Data_size),--B7_8
			
			56		=> to_signed((2**(Data_size-1))-1,Data_size),--B8_1
			57		=> to_signed(0,Data_size),
			58		=> to_signed(-(2**(Data_size-1)),Data_size),
			59		=> to_signed(-1,Data_size),
			60		=> to_signed(1,Data_size),
			61		=> to_signed(-2,Data_size),
			62		=> to_signed(2,Data_size),
			63		=> to_signed(-(2**(Data_size-1))+1,Data_size),--B8_8
			
			64		=> to_signed((2**(Data_size-1))-1,Data_size),--B9_1
			65		=> to_signed(0,Data_size),
			66		=> to_signed(-(2**(Data_size-1)),Data_size),
			67		=> to_signed(-1,Data_size),
			68		=> to_signed(1,Data_size),
			69		=> to_signed(-2,Data_size),
			70		=> to_signed(2,Data_size),
			71		=> to_signed(-(2**(Data_size-1))+1,Data_size),--B9_8
			
			72		=> to_signed((2**(Data_size-1))-1,Data_size),--B10_1
			73		=> to_signed(0,Data_size),
			74		=> to_signed(-(2**(Data_size-1)),Data_size),
			75		=> to_signed(-1,Data_size),
			76		=> to_signed(1,Data_size),
			77		=> to_signed(-2,Data_size),
			78		=> to_signed(2,Data_size),
			79		=> to_signed(-(2**(Data_size-1))+1,Data_size),--B10_8
			
			80		=> to_signed((2**(Data_size-1))-1,Data_size),--B11_1
			81		=> to_signed(0,Data_size),
			82		=> to_signed(-(2**(Data_size-1)),Data_size),
			83		=> to_signed(-1,Data_size),
			84		=> to_signed(1,Data_size),
			85		=> to_signed(-2,Data_size),
			86		=> to_signed(2,Data_size),
			87		=> to_signed(-(2**(Data_size-1))+1,Data_size),--B11_8
			
			88		=> to_signed((2**(Data_size-1))-1,Data_size),--B12_1
			89		=> to_signed(0,Data_size),
			90		=> to_signed(-(2**(Data_size-1)),Data_size),
			91		=> to_signed(-1,Data_size),
			92		=> to_signed(1,Data_size),
			93		=> to_signed(-2,Data_size),
			94		=> to_signed(2,Data_size),
			95		=> to_signed(-(2**(Data_size-1))+1,Data_size),--B12_8
			
			96		=> to_signed((2**(Data_size-1))-1,Data_size),--B13_1
			97		=> to_signed(0,Data_size),
			98		=> to_signed(-(2**(Data_size-1)),Data_size),
			99		=> to_signed(-1,Data_size),
			100	=> to_signed(1,Data_size),
			101	=> to_signed(-2,Data_size),
			102	=> to_signed(2,Data_size),
			103	=> to_signed(-(2**(Data_size-1))+1,Data_size),--B13_8
			
			104	=> to_signed((2**(Data_size-1))-1,Data_size),--B14_1
			105	=> to_signed(0,Data_size),
			106	=> to_signed(-(2**(Data_size-1)),Data_size),
			107	=> to_signed(-1,Data_size),
			108	=> to_signed(1,Data_size),
			109	=> to_signed(-2,Data_size),
			110	=> to_signed(2,Data_size),
			111	=> to_signed(-(2**(Data_size-1))+1,Data_size),--B14_8
			
			112	=> to_signed((2**(Data_size-1))-1,Data_size),--B15_1
			113	=> to_signed(0,Data_size),
			114	=> to_signed(-(2**(Data_size-1)),Data_size),
			115	=> to_signed(-1,Data_size),
			116	=> to_signed(1,Data_size),
			117	=> to_signed(-2,Data_size),
			118	=> to_signed(2,Data_size),
			119	=> to_signed(-(2**(Data_size-1))+1,Data_size),--B15_8
			
			120	=> to_signed((2**(Data_size-1))-1,Data_size),--B16_1
			121	=> to_signed(0,Data_size),
			122	=> to_signed(-(2**(Data_size-1)),Data_size),
			123	=> to_signed(-1,Data_size),
			124	=> to_signed(1,Data_size),
			125	=> to_signed(-2,Data_size),
			126	=> to_signed(2,Data_size),
			127	=> to_signed(-(2**(Data_size-1))+1,Data_size),--B16_8
			
			128	=> to_signed((2**(Data_size-1))-1,Data_size),--B17_1
			129	=> to_signed(0,Data_size),
			130	=> to_signed(-(2**(Data_size-1)),Data_size),
			131	=> to_signed(-1,Data_size),
			132	=> to_signed(1,Data_size),
			133	=> to_signed(-2,Data_size),
			134	=> to_signed(2,Data_size),
			135	=> to_signed(-(2**(Data_size-1))+1,Data_size),--B17_8
			
			
			others => to_signed(0,Data_size));
	
begin

	matrix_coefficient <= Rom_B(to_integer(Address));

end Behavioral;