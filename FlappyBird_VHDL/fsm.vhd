LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY fsm IS
	PORT(Vert_Sync, Button, Dead, Reset_State : IN std_logic;
		 Reset, Enable           : OUT std_logic; 
		 Text_Mode               : OUT std_logic_vector(1 DOWNTO 0));		
END fsm;

-- The fsm controls which state the game is in, and the reset, enable and text_mode control lines
-- Start state - display main menu with instructios
-- Play state - main game state during play
-- Pause stae - pause the game temporarily
-- Game over - when the player dies stop game and display final score

-- Reset - reverts all game components to their inital state
-- Enable - makes all game components move appropriately
-- Text mode: 00 main screen, 01 play screen, 10 pause screen, 11 game over screeen
ARCHITECTURE behavior OF fsm IS

	type state_type is (SSTART, SPLAY, SPAUSE, SGAMEOVER);
	signal state : state_type := SSTART;

BEGIN           

Next_State: PROCESS (Vert_Sync) IS
	VARIABLE next_state : state_type;
	VARIABLE last_button : std_logic := '0';
	VARIABLE button_push : boolean;
BEGIN
	-- Check for rising edge
	button_push := last_button = '0' and Button = '1';

	next_state := state;

	case state is
		when SSTART =>
			-- When the button is pushed begin the game
			if button_push then
				next_state := SPLAY;
			end if;
		when SPLAY =>
			-- If the player dies it is game over
			if Dead = '1' then
				next_state := SGAMEOVER;
			-- Pause if the button is pushed
			elsif button_push then
				next_state := SPAUSE;
			end if;
		when SPAUSE =>	
			-- Resume if the button is pushed
			if button_push then
				next_state := SPLAY;
			end if;
		when SGAMEOVER =>
			-- Go back to main menu on button push
			if button_push then
				next_state := SSTART;
			end if;
	end case;

	if Reset_State = '1' then
		next_state := SSTART;
	end if;

	if rising_edge(Vert_Sync) then
		state <= next_state;
		last_button := Button;
	end if;
END PROCESS Next_State;

-- Set which text component to display
with state select
    Text_Mode <= "00" when SSTART, 
	             "01" when SPLAY, 
				 "10" when SPAUSE, 
				 "11" when SGAMEOVER;

-- Continuously reset components when on the main menu
Reset <= '1' when state = SSTART else '0';
-- Enable only during the play state
Enable <= '1' when state = SPLAY else '0';

END behavior;

