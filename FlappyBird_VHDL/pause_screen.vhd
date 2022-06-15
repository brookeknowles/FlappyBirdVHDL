LIBRARY IEEE;
LIBRARY WORK;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;
USE WORK.CHARS.all;

ENTITY pause_screen IS
	PORT(Pixel_Row, Pixel_Column : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			Character_Address : OUT STD_LOGIC_VECTOR(5 DOWNTO 0));
END ENTITY pause_screen;

ARCHITECTURE behaviour OF pause_screen IS
BEGIN
	PROCESS(Pixel_Row, Pixel_Column)
		variable char_row, char_column : STD_LOGIC_VECTOR(5 downto 0);
	BEGIN

		char_row := Pixel_Row(9 DOWNTO 4);
		char_column := Pixel_Column(9 DOWNTO 4);
		
		-- Refer to slide 17 of the VGA Interface and LFSR notes
		-- Each character has an Octal value which can be converted to binary at 
		-- https://www.binaryhexconverter.com/octal-to-binary-converter
		-- Make Character_Address the (binary) value of the character needed. 
	
	
		-- "PAUSE"
		IF(char_row = 2) THEN 
			IF (char_column = 17) THEN 
				Character_Address <= C_P; 
			ELSIF (char_column = 18) THEN	
				Character_Address <= C_A; 
			ELSIF (char_column = 19) THEN 
				Character_Address <= C_U; 
			ELSIF (char_column = 20) THEN 
				Character_Address <= C_S; 
			ELSIF (char_column = 21) THEN 
				Character_Address <= C_E; 
			ELSIF (char_column = 22) THEN 
				Character_Address <= C_D; 
			ELSE
				Character_Address <= C_SPACE; 
			END IF;
		
		-- "PB0 TO RESUME"
		ELSIF(char_row = 8) THEN 
			IF (char_column = 17) THEN	
				Character_Address <= C_P; 
			ELSIF (char_column = 18) THEN 
				Character_Address <= C_B; 
			ELSIF (char_column = 19) THEN 
				Character_Address <= C_0 + 1; 
			ELSIF (char_column = 20) THEN 
				Character_Address <= C_SPACE; 
			ELSIF (char_column = 21) THEN 
				Character_Address <= C_T; 
			ELSIF (char_column = 22) THEN 
				Character_Address <= C_O; 
			ELSE
				Character_Address <= C_SPACE; 
			END IF;
			
		ELSIF(char_row = 10) THEN 
			IF (char_column = 17) THEN	
				Character_Address <= C_R; 
			ELSIF (char_column = 18) THEN 
				Character_Address <= C_E; 
			ELSIF (char_column = 19) THEN 
				Character_Address <= C_S; 
			ELSIF (char_column = 20) THEN 
				Character_Address <= C_U; 
			ELSIF (char_column = 21) THEN 
				Character_Address <= C_M; 
			ELSIF (char_column = 22) THEN 
				Character_Address <= C_E; 
			ELSE
				Character_Address <= C_SPACE; 
			END IF;
		
		
		ELSE
			Character_Address <= C_SPACE; 
		END IF;
	END PROCESS;	
END behaviour;