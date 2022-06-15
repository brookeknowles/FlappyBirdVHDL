LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY bird IS
	PORT(Left_Click, Vert_Sync, Enable, Reset	 : IN std_logic;
         Pixel_Row, Pixel_Column : IN unsigned(9 DOWNTO 0);
		 Bird_X, Bird_Y : OUT unsigned(9 DOWNTO 0);
		 Active, Red, Green, Blue: OUT std_logic);		
END bird;

-- The bird, which bounces when the mouse is clocked
ARCHITECTURE behavior OF bird IS

CONSTANT SIZE : integer := 20;  
CONSTANT x    : integer := 50;
SIGNAL y	  : signed(10 DOWNTO 0);

BEGIN

Active <= '1' when ((x <= Pixel_Column) and (Pixel_Column < x + SIZE)
					and (y <= signed(Pixel_Row)) and (signed(Pixel_Row) < y + SIZE))  else
			'0';


-- Make the bird yellow
Red <=  '1';
Green <= '1';
Blue <=  '0';

Bird_X <= to_unsigned(x, bird_x'length);
Bird_Y <= unsigned(y)(9 DOWNTO 0);


Move_Ball: PROCESS (Vert_Sync) IS
	VARIABLE last_click : std_logic := '0';
	VARIABLE dy : signed(7 DOWNTO 0);
BEGIN

	-- Move ball once every vertical sync
	if rising_edge(Vert_Sync) then	
		if Reset = '1' then
			-- Reset bird to middle and velocity to 0
			y <= to_signed(230, y'length);
			dy := (others => '0');
		elsif Enable = '1' then
			-- Move the bird by velocity
			y <= y + shift_right(dy, 2);

			-- Jump if the user clicks
			if last_click = '0' and Left_Click = '1' then
				dy := dy - 30;
			else
				dy := dy + 1;
			end if;

			-- Keep the bird from going to fast
			if dy > 60 then
				dy := to_signed(60, dy'length);
			elsif dy < -60 then
				dy := to_signed(-60, dy'length);
			end if;
		end if;

		last_click := Left_Click;
	end if;
END PROCESS Move_Ball;

END behavior;

