LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY color_picker IS
	PORT(Active, Red_In, Green_In, Blue_In : IN std_logic_vector(0 to 4);
		 Red, Green, Blue : OUT std_logic);		
END color_picker;

-- The color picker decides which component should be displayed based on multiple color 
-- inputs
ARCHITECTURE behavior OF color_picker IS
constant BG_RED   : std_logic := '0';
constant BG_GREEN : std_logic := '0';
constant BG_BLUE  : std_logic := '1';

BEGIN           
PROCESS (Active, Red_In, Green_In, Blue_In) IS
	VARIABLE v_red, v_green, v_blue : std_logic;
BEGIN
	v_red := BG_RED;
	v_green := BG_GREEN;
	v_blue := BG_BLUE;

	-- Select the active color, prioritising the last one
	for i in Active'range loop
		if Active(i) = '1' then
			v_red := Red_In(i);
			v_green := Green_In(i);
			v_blue := Blue_In(i);
		end if;
	end loop;

	Red <= v_red;
	Green <= v_green;
	Blue <= v_blue;
END PROCESS;

END behavior;

