LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;
LIBRARY WORK;
USE WORK.CHARS.all;

ENTITY score_screen IS
	PORT(Pixel_Row, Pixel_Column : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			Score, Time : IN STD_LOGIC_VECTOR(11 downto 0);
			Lives : IN STD_LOGIC_VECTOR(2 downto 0);
			Character_Address : OUT STD_LOGIC_VECTOR(5 DOWNTO 0));
END ENTITY score_screen;

ARCHITECTURE behaviour OF score_screen IS
BEGIN
	PROCESS(Pixel_Row, Pixel_Column)
		variable char_row, char_column : STD_LOGIC_VECTOR(5 downto 0);
	BEGIN

		-- Characters are aligned to 16x16 grid
		char_row := Pixel_Row(9 DOWNTO 4);
		char_column := Pixel_Column(9 DOWNTO 4);
	
		IF(char_row = 2) THEN
			-- "SCORE" at top left
			IF(char_column = 1) THEN
				Character_Address <= C_S;
			ELSIF(char_column = 2) THEN
				Character_Address <= C_C;
			ELSIF(char_column = 3) THEN
				Character_Address <= C_O;
			ELSIF(char_column = 4) THEN
				Character_Address <= C_R;
			ELSIF(char_column = 5) THEN
				Character_Address <= C_E;
			ELSIF(char_column = 6) THEN
				Character_Address <= C_DASH;
			ELSIF(char_column = 7) THEN
				Character_Address <= C_0 + ('0' & Score(11 downto 8));
			ELSIF(char_column = 8) THEN
				Character_Address <= C_0 + ('0' & Score(7 downto 4));
			ELSIF(char_column = 9) THEN
				Character_Address <= C_0 + ('0' & Score(3 downto 0));
				
			-- Lives at top middle
			ELSIF(char_column = 16) THEN
				Character_Address <= C_L;
			ELSIF(char_column = 17) THEN
				Character_Address <= C_I;
			ELSIF(char_column = 18) THEN
				Character_Address <= C_V;
			ELSIF(char_column = 19) THEN
				Character_Address <= C_E;
			ELSIF(char_column = 20) THEN
				Character_Address <= C_S;
			ELSIF(char_column = 21) THEN
				Character_Address <= C_DASH;
			ELSIF(char_column = 22) THEN
				Character_Address <= C_0 + ('0' & Lives);
				
			-- "TIME" at top right
			ELSIF(char_column = 30) THEN
				Character_Address <= C_T;
			ELSIF(char_column = 31) THEN
				Character_Address <= C_I;
			ELSIF(char_column = 32) THEN
				Character_Address <= C_M;
			ELSIF(char_column = 33) THEN
				Character_Address <= C_E;
			ELSIF(char_column = 34) THEN
				Character_Address <= C_DASH;
			ELSIF(char_column = 35) THEN
				Character_Address <= C_0 + ('0' & Time(11 downto 8));
			ELSIF(char_column = 36) THEN
				Character_Address <= C_DOT;
			ELSIF(char_column = 37) THEN
				Character_Address <= C_0 + ('0' & Time(7 downto 4));
			ELSIF(char_column = 38) THEN
				Character_Address <= C_0 + ('0' & Time(3 downto 0));
			ELSE
				Character_Address <= C_SPACE;
			END IF;
		
			-- below is bottom instructions
		ELSIF(char_row = 28) THEN
			-- pause instructions at bottom left
			IF(char_column = 1) THEN
				Character_Address <= C_P;
			ELSIF(char_column = 2) THEN
				Character_Address <= C_A;
			ELSIF(char_column = 3) THEN
				Character_Address <= C_U;
			ELSIF(char_column = 4) THEN
				Character_Address <= C_S;
			ELSIF(char_column = 5) THEN
				Character_Address <= C_E;
			ELSIF(char_column = 6) THEN
				Character_Address <= C_DASH;
			ELSIF(char_column = 7) THEN
				Character_Address <= C_P;
			ELSIF(char_column = 8) THEN
				Character_Address <= C_B;
			ELSIF(char_column = 9) THEN
				Character_Address <= C_0 + 1;
				
			-- quit instructions at bottom right
			ELSIF(char_column = 30) THEN
				Character_Address <= C_Q;
			ELSIF(char_column = 31) THEN
				Character_Address <= C_U;
			ELSIF(char_column = 32) THEN
				Character_Address <= C_I;
			ELSIF(char_column = 33) THEN
				Character_Address <= C_T;
			ELSIF(char_column = 34) THEN
				Character_Address <= C_DASH;
			ELSIF(char_column = 35) THEN
				Character_Address <= C_P;
			ELSIF(char_column = 36) THEN
				Character_Address <= C_B;
			ELSIF(char_column = 37) THEN
				Character_Address <= C_0;
			ELSE
				Character_Address <= C_SPACE;
			END IF;
		ELSE
			Character_Address <= C_SPACE;
		END IF;

	END PROCESS;	
END behaviour;