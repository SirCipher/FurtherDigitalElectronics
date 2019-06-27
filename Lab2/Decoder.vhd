library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Decoder is
    Port ( Sig_bus 			: in  	unsigned (3 downto 0);
           Decoded_sig_bus : out  	unsigned (6 downto 0));
end Decoder;

architecture Behavioral of Decoder is
begin

-- Decoded outputs to 7-segment display
-- Assuming active high
-- A is the MSB, G is the LSB of Decoded_sig_bus
Decoded_sig_bus <= 	"1111110" when Sig_bus = "0000" ELSE -- 0
							"0110000" when Sig_bus = "0001" ELSE -- 1
							"1101101" when Sig_bus = "0010" ELSE -- 2
							"1111001" when Sig_bus = "0011" ELSE -- 3
							"0110011" when Sig_bus = "0100" ELSE -- 4
							"1011011" when Sig_bus = "0101" ELSE -- 5
							"1011111" when Sig_bus = "0110" ELSE -- 6
							"1110000" when Sig_bus = "0111" ELSE -- 7
							"1111111" when Sig_bus = "1000" ELSE -- 8
							"1111011" when Sig_bus = "1001" ELSE -- 9
							"UUUUUUU"; -- Others

end Behavioral;

