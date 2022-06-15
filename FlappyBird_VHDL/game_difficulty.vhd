LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY game_difficulty IS
	PORT(Vert_Sync, pass, reset, game_mode: IN STD_LOGIC;
		  difficulty : OUT unsigned(2 downto 0));
END ENTITY game_difficulty;

-- Difficulty controls the speed of the pipes and gifts, 
-- in game mode, it increases from 2 to 7 by 1 each time the player
-- passes 5 pipes
-- in training mode, it outputs a constant 2
ARCHITECTURE behaviour OF game_difficulty IS
BEGIN
	PROCESS (pass, Vert_Sync, game_mode) IS
		variable last_pass : std_logic := '0';
		variable pipes_passed : unsigned(2 downto 0) := "000";
		variable diff : unsigned(2 downto 0) := "010";
	BEGIN
		IF rising_edge(Vert_Sync) THEN
			-- Reset the difficulty and also the internal pipe counter
			IF (reset = '1')  THEN
				diff := "010";
				pipes_passed := "000";
			END IF;
			
			-- Detect rising edge of pass
			IF (pass = '1' and last_pass = '0') THEN
				pipes_passed := pipes_passed + 1;
			END IF;
			
			-- When 5 pipes are passed increase the difficulty
			IF (pipes_passed = 5) THEN
				if diff /= "111" then
					diff := diff + 1;
				end if;
				pipes_passed := "000";
			END IF;
			
			-- Game mode 0 is training, 1 is game
			IF (game_mode = '0') THEN
				difficulty <= "010";
			ELSE 
				difficulty <= diff;
			END IF;

			last_pass := pass;
			
		END IF;
	END PROCESS;

END behaviour;