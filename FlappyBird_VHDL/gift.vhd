LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.std_logic_unsigned.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY gift IS
	PORT(Vert_Sync, Reset, Enable	: IN std_logic;
		 Pixel_Row, Pixel_Column, bird_x, bird_y : IN unsigned(9 DOWNTO 0);
		 difficulty : IN unsigned(2 downto 0);
		 Rng : IN unsigned(7 downto 0);
		 Red, Green, Blue, active, life_up, score_up : OUT std_logic);			
END gift;

-- The gift component is a bonus the player can pick up
-- Gift style 0 is red and gives an extra life
--            1 is yelow and gives 1 extra score
ARCHITECTURE behavior OF gift IS
	CONSTANT size : INTEGER := 10;
	SIGNAL x      : signed(10 DOWNTO 0);
	SIGNAL y      : unsigned(9 downto 0);
	SIGNAL style  : std_logic := '0';
	SIGNAL collected : std_logic := '0';
BEGIN
	Move_Gift: Process (Vert_Sync)
	BEGIN
		if rising_edge(Vert_Sync) then
			if reset = '1' then
				x <= to_signed(700, x'length);
				collected <= '0';
				
				-- Randomly style and position the gift
				style <= rng(0);
				y <= 107 + ("00" & rng);
			elsif enable = '1' then
				x <= x - signed('0' & difficulty);

				-- When the gift goes offscreen generate new info
				if x < -size then
					collected <= '0';
					x <= to_signed(640, x'length);

					-- Randomly style and position the gift
					style <= rng(0);
					y <= 107 + ("00" & rng);
				end if;
			end if;

			-- If the bird collides with the gift (hitbox for gift is slightly larger than visual to make the game feel better)
			if (x <= signed(bird_x) + 25) and (signed(bird_x) < (x + size + 5)) and (y <= bird_y + 25) and (bird_y < y + size + 5) and (collected = '0') then
				life_up <= not style;
				score_up <= style;
				collected <= '1';
			else
				life_up <= '0';
				score_up <= '0';
			end if;
		end if;
	end process;

	-- Display the gift if the pixel is inside it and it hasn't been collected
	active <= '1' when (x <= signed('0' & Pixel_Column)) and (signed('0' & Pixel_Column) < x + size)
					and (Pixel_Row >= y) and (Pixel_Row < y + size) and (collected = '0') else
				'0';

	Red <=  '1';
	Green <= style;
	Blue <=  '0';
end ARCHITECTURE behavior;
