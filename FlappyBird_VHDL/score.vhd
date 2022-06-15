LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;

ENTITY score IS
	PORT(Vert_Sync, Reset, Pass, Gift : IN std_logic;
		Score : OUT unsigned(11 downto 0));
END score;

-- BCD Counter for the players score
ARCHITECTURE behavior OF score IS
BEGIN
	Score_Counter: PROCESS (Vert_Sync) IS
		VARIABLE old_pass : std_logic := '0';
		VARIABLE old_gift : std_logic := '0';
		VARIABLE count0 : unsigned(3 downto 0) := "0000";
		VARIABLE count1 : unsigned(3 downto 0) := "0000";
		VARIABLE count2 : unsigned(3 downto 0) := "0000";
	BEGIN
		
		if (rising_edge(Vert_Sync)) then
			if Reset = '1' then
				count0 := "0000";
				count1 := "0000";
				count2 := "0000";
			else
				-- On rising edge of pass pipe or gift increase score
				if old_pass = '0' and Pass = '1' then
					count0 := count0 + 1;
				end if;

				if old_gift = '0' and Gift = '1' then
					count0 := count0 + 1;
				end if;

				-- 1's overflow
				if count0 > 9 then
					count0 := count0 - 10;
					
					-- 10's overflow
					if count1 = 9 then
						count1 := "0000";

						-- 100's overflow
						if count2 = 9 then
							count2 := "0000";
						else
							count2 := count2 + 1;
						end if;
					else
						count1 := count1 + 1;
					end if;
				end if;
			end if;
			
			old_pass := Pass;
			old_gift := Gift;
			Score <= count2 & count1 & count0;

		end if;
	END PROCESS;
end ARCHITECTURE behavior;