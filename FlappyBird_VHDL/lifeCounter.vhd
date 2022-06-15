LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY lifeCounter IS
	PORT(Vert_Sync, Reset, Pipe, Gift: IN std_logic;
		Bird_Y : IN unsigned(9 downto 0);
		Lives : OUT unsigned(2 downto 0);
		Dead : OUT std_logic);
end lifeCounter;

-- Tracks the number of lives the player has, starts at 3 but can go up to 5 if the 
-- player picks up gifts
ARCHITECTURE behavior of lifeCounter is
	CONSTANT MAX_LIVES: unsigned(2 downto 0) := "101";
BEGIN
	Life_Change: PROCESS (Vert_Sync) is
		variable v_lives : unsigned(2 downto 0) := "011";
		variable last_pipe : std_logic := '0';
		variable last_gift : std_logic := '0';
	BEGIN
		if rising_edge(Vert_Sync) then
			if Reset = '1' then
				-- reset the number of lives
				v_lives := "011";
			else
				-- on the rising edge of a pipe collision decrease lives
				if last_pipe = '0' and Pipe = '1' then
					v_lives := v_lives - 1;
				end if;
				-- on the rising edge of a gift collision increase lives
				if last_gift = '0' and Gift = '1' then
					v_lives := v_lives + 1;
				end if;

				if v_lives > MAX_LIVES then
					v_lives := MAX_LIVES;
				end if;
			end if;
			
			last_pipe := Pipe;
			last_gift := Gift;

			-- The bird should die if it hits the top/bottom of the screen or has 0 lives
			if (v_lives = 0) or (Bird_Y <= 0) or (Bird_Y >= 460) then
				Dead <= '1';
			else
				Dead <= '0';
			end if;
			Lives <= v_lives;
		end if;
	end PROCESS;
end ARCHITECTURE behavior;
		