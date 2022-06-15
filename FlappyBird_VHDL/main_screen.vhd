LIBRARY IEEE;
LIBRARY WORK;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;
USE WORK.CHARS.all;

ENTITY main_screen IS
	PORT(Pixel_Row, Pixel_Column : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			Character_Address : OUT STD_LOGIC_VECTOR(5 DOWNTO 0));
END ENTITY main_screen;

ARCHITECTURE behaviour OF main_screen IS
BEGIN
	PROCESS(Pixel_Row, Pixel_Column)
		variable char_row, char_column : STD_LOGIC_VECTOR(5 downto 0);
	BEGIN

		-- Characters are aligned to 16x16 grid
		char_row := Pixel_Row(9 DOWNTO 4);
		char_column := Pixel_Column(9 DOWNTO 4);
		
		-- "FLAPPY"
		IF(char_row = 2) THEN 
			IF (char_column = 17) THEN 
				Character_Address <= C_F; 
			ELSIF (char_column = 18) THEN	
				Character_Address <= C_L; 
			ELSIF (char_column = 19) THEN 
				Character_Address <= C_A; 
			ELSIF (char_column = 20) THEN 
				Character_Address <= C_P; 
			ELSIF (char_column = 21) THEN 
				Character_Address <= C_P; 
			ELSIF (char_column = 22) THEN 
				Character_Address <= C_Y; 
			ELSE
				Character_Address <= C_SPACE; 
			END IF;
		-- "BIRD"
		ELSIF(char_row = 3) THEN 
			IF (char_column = 18) THEN	
				Character_Address <= C_B; 
			ELSIF (char_column = 19) THEN 
				Character_Address <= C_I; 
			ELSIF (char_column = 20) THEN 
				Character_Address <= C_R; 
			ELSIF (char_column = 21) THEN 
				Character_Address <= C_D; 
			ELSE
				Character_Address <= C_SPACE; 
			END IF;	
			
		-- instructions for game mode
		ELSIF(char_row = 8) THEN 
			IF (char_column = 18) THEN	
				Character_Address <= C_S; 
			ELSIF (char_column = 19) THEN 
				Character_Address <= C_W; 
			ELSIF (char_column = 20) THEN 
				Character_Address <= C_0; 
			ELSIF (char_column = 21) THEN 
				Character_Address <= C_UP_ARROW; 
			ELSE
				Character_Address <= C_SPACE; 
			END IF;
		ELSIF(char_row = 9) THEN 
			IF (char_column = 18) THEN	
				Character_Address <= C_G; 
			ELSIF (char_column = 19) THEN 
				Character_Address <= C_A; 
			ELSIF (char_column = 20) THEN 
				Character_Address <= C_M; 
			ELSIF (char_column = 21) THEN 
				Character_Address <= C_E; 
			ELSE
				Character_Address <= C_SPACE; 
			END IF;
		ELSIF(char_row = 10) THEN 
			IF (char_column = 18) THEN	
				Character_Address <= C_M; 
			ELSIF (char_column = 19) THEN 
				Character_Address <= C_O; 
			ELSIF (char_column = 20) THEN 
				Character_Address <= C_D; 
			ELSIF (char_column = 21) THEN 
				Character_Address <= C_E; 
			ELSE
				Character_Address <= C_SPACE; 
			END IF;
		
		-- instructions for training mode
		ELSIF(char_row = 14) THEN 
			IF (char_column = 18) THEN	
				Character_Address <= C_S; 
			ELSIF (char_column = 19) THEN 
				Character_Address <= C_W; 
			ELSIF (char_column = 20) THEN 
				Character_Address <= C_0; 
			ELSIF (char_column = 21) THEN 
				Character_Address <= C_DOWN_ARROW; 
			ELSE
				Character_Address <= C_SPACE; 
			END IF;
		ELSIF(char_row = 15) THEN 
			IF (char_column = 17) THEN 
				Character_Address <= C_T; 
			ELSIF (char_column = 18) THEN	
				Character_Address <= C_R; 
			ELSIF (char_column = 19) THEN 
				Character_Address <= C_A; 
			ELSIF (char_column = 20) THEN 
				Character_Address <= C_I; 
			ELSIF (char_column = 21) THEN 
				Character_Address <= C_N; 
			ELSE
				Character_Address <= C_SPACE; 
			END IF;
		ELSIF(char_row = 16) THEN 
			IF (char_column = 18) THEN	
				Character_Address <= C_M; 
			ELSIF (char_column = 19) THEN 
				Character_Address <= C_O; 
			ELSIF (char_column = 20) THEN 
				Character_Address <= C_D; 
			ELSIF (char_column = 21) THEN 
				Character_Address <= C_E; 
			ELSE
				Character_Address <= C_SPACE; 
			END IF;
			
			
		-- instructions for playing game
		ELSIF(char_row = 20) THEN 
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
		ELSIF(char_row = 21) THEN 
			IF (char_column = 18) THEN	
				Character_Address <= C_P; 
			ELSIF (char_column = 19) THEN 
				Character_Address <= C_L; 
			ELSIF (char_column = 20) THEN 
				Character_Address <= C_A; 
			ELSIF (char_column = 21) THEN 
				Character_Address <= C_Y; 
			ELSE
				Character_Address <= C_SPACE; 
			END IF;
			
		ELSE
			Character_Address <= C_SPACE; 
		END IF;
	END PROCESS;	
END behaviour;