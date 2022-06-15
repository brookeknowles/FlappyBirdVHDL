LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;
LIBRARY WORK;
USE WORK.CHARS.all;

ENTITY game_over_screen IS
	PORT(Pixel_Row, Pixel_Column : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			Score : IN STD_LOGIC_VECTOR(11 downto 0);
			Character_Address : OUT STD_LOGIC_VECTOR(5 DOWNTO 0));
END ENTITY game_over_screen;

ARCHITECTURE behaviour OF game_over_screen IS
BEGIN
	PROCESS(Pixel_Row, Pixel_Column)
		variable char_row, char_column : STD_LOGIC_VECTOR(5 downto 0);
	BEGIN

		-- Characters are aligned to 16x16 grid
		char_row := Pixel_Row(9 DOWNTO 4);
		char_column := Pixel_Column(9 DOWNTO 4);
	
		-- Refer to slide 18 of the VGA Interface and LFSR notes
		-- Each character has an Octal value which can be converted to binary at 
		-- https://www.binaryhexconverter.com/octal-to-binary-converter
		-- Make Character_Address the (binary) value of the character needed. 
		
		-- probs just copy and paste from main screen and make it say "Game over" on top, with "Score = x" on bottom
		
		-- "Game"
		IF(char_row = 2) THEN
			IF(char_column = 18) THEN
				Character_Address <= C_G;
			ELSIF(char_column = 19) THEN
				Character_Address <= C_A;
			ELSIF(char_column = 20) THEN
				Character_Address <= C_M;
			ELSIF(char_column = 21) THEN
				Character_Address <= C_E;
			ELSE
				Character_Address <= C_SPACE;
			END IF;
		-- "Over"
		ELSIF(char_row = 3) THEN
			IF(char_column = 18) THEN
				Character_Address <= C_O;
			ELSIF(char_column = 19) THEN
				Character_Address <= C_V;
			ELSIF(char_column = 20) THEN
				Character_Address <= C_E;
			ELSIF(char_column = 21) THEN
				Character_Address <= C_R;
			ELSE
				Character_Address <= C_SPACE;
			END IF;
		-- "Score-"
		ELSIF(char_row = 8) THEN
			IF(char_column = 17) THEN
				Character_Address <= C_S;
			ELSIF(char_column = 18) THEN
				Character_Address <= C_C;
			ELSIF(char_column = 19) THEN 
				Character_Address <= C_O;
			ELSIF(char_column = 20) THEN
				Character_Address <= C_R;
			ELSIF(char_column = 21) THEN
				Character_Address <= C_E;
			ELSIF(char_column = 22) THEN
				Character_Address <= C_DASH;
			ELSE
				Character_Address <= C_SPACE;
			END IF;
		-- score
		ELSIF(char_row = 9) THEN
			IF(char_column = 19) THEN
				Character_Address <= C_0 + ('0' & Score(11 downto 8));
			ELSIF(char_column = 20) THEN
				Character_Address <= C_0 + ('0' & Score(7 downto 4));
			ELSIF(char_column = 21) THEN
				Character_Address <= C_0 + ('0' & Score(3 downto 0));
			ELSE
				Character_Address <= C_SPACE;
			END IF;
		ELSE
			Character_Address <= C_SPACE;
		END IF;
	
	END PROCESS;	
END behaviour;