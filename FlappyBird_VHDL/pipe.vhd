LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY pipe IS
	PORT(Vert_Sync, Reset, Enable	: IN std_logic;
        Pixel_Row, Pixel_Column, starting_x, bird_x, bird_y : IN unsigned(9 DOWNTO 0);
		  difficulty : IN unsigned(2 downto 0);
		  Rng : IN unsigned(7 downto 0);
		 Red, Green, Blue, active, collision, pass        : OUT std_logic);		
END pipe;

ARCHITECTURE behavior of pipe is
CONSTANT width   : integer := 40; 
CONSTANT gapSize : integer := 120;
SIGNAL x         : signed(10 DOWNTO 0);
SIGNAL height : unsigned(9 downto 0);
BEGIN
	Move_Pipe: PROCESS (Vert_Sync, difficulty) is
	BEGIN
		if rising_edge(Vert_Sync) then	
		
			if reset = '1' then
				-- Reset the height and position to the default value
				-- The first pipe will have a fixed height so the player can get ready
				height <= to_unsigned(180, height'length);
				x <= signed('0' & starting_x);
			elsif enable = '1' then
				x <= x - signed('0' & difficulty);

				-- If the pipe goes offscreen left then reset it 
				if x < -width then
					x <= to_signed(640, x'length);
					height <= ("00" & rng) + 52;
				elsif x >= 640 then
					-- While the pipe is offscreen to the right randomize its height
					height <= ("00" & rng) + 52;
				end if;
			end if;
			
			collision <= '0';
			pass <= '0';

			-- Check if the bird is horizontally aligned with the pipe
			if (x <= signed(bird_x) + 20) and (signed(bird_x) < x + width)  then
				-- The bird is hitting the top or bottom 
				if (bird_y >= height + gapSize - 20) or (bird_y <= height) then
					collision <= '1';
				-- The bird is in the gap
				else
					pass <= '1';
				end if;
			else
			end if;
		end if;
	end process;
	
	-- Display the pipe if the pixel is in it
	active <= '1' when ((x <= signed('0' & Pixel_Column)) and (signed('0' & Pixel_Column)) < x + width)
					and ((Pixel_Row >= height + gapSize) or (Pixel_Row <= height))  else
			'0';

	-- Colours for pixel data on video signal
	-- Changing the background and ball colour by pushbuttons
	Red <=  '0';
	Green <= '1';
	Blue <=  '0';
end architecture;