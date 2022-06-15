LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;

ENTITY time IS
	PORT(Vert_Sync, Reset, Enable : IN std_logic;
		Time : OUT unsigned(11 downto 0));
END time;

-- BCD Counter for time in M:SS
ARCHITECTURE behavior OF time IS
BEGIN
	Score_Counter: PROCESS (Vert_Sync) IS
		VARIABLE frames : unsigned(5 downto 0) := "000000";
		VARIABLE count0 : unsigned(3 downto 0) := "0000";
		VARIABLE count1 : unsigned(3 downto 0) := "0000";
		VARIABLE count2 : unsigned(3 downto 0) := "0000";
	BEGIN
		
		if (rising_edge(Vert_Sync)) then
			if Reset = '1' then
				frames := "000000";
				count0 := "0000";
				count1 := "0000";
				count2 := "0000";
			elsif Enable = '1' then
				-- Every 60 frames increment the seconds
				if frames = 59 then
					frames := "000000";

					-- 1's overflow
					if count0 = 9 then
						count0 := "0000";
						
						-- 10's overflow
						if count1 = 5 then
							count1 := "0000";

							-- Minutes overflow
							if count2 = 9 then
								count2 := "0000";
							else
								count2 := count2 + 1;
							end if;
						else
							count1 := count1 + 1;
						end if;
					else
						count0 := count0 + 1;
					end if;
				else
					frames := frames + 1;
				end if;
			end if;
			
			Time <= count2 & count1 & count0;

		end if;
	END PROCESS;
end ARCHITECTURE behavior;