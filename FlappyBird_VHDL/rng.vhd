library ieee; 
use ieee.std_logic_1164.all;

-- 8 bit galois lfsr for random number generation
-- taps at 0, 2, 4, 5
entity rng is 
    port(Vert_Sync : in  std_logic;
         lfsr      : out std_logic_vector(7 downto 0));
end rng;

architecture behavior of rng is
    signal v_lfsr : std_logic_vector(7 downto 0) := "11101101";  
begin
    process (Vert_Sync) 
    begin
        if rising_edge(Vert_Sync) THEN
            v_lfsr(7) <= v_lfsr(0);
            v_lfsr(6) <= v_lfsr(7);
            v_lfsr(5) <= v_lfsr(6);
            v_lfsr(4) <= v_lfsr(5) xor v_lfsr(0);
            v_lfsr(3) <= v_lfsr(4) xor v_lfsr(0);
            v_lfsr(2) <= v_lfsr(3);
            v_lfsr(1) <= v_lfsr(2) xor v_lfsr(0);
            v_lfsr(0) <= v_lfsr(1);
            
            lfsr <= v_lfsr;            
        end if;
    end process;
end architecture behavior;