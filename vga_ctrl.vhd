library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_ctrl is
    Port (
        clk, clk_en :in std_logic;
        hcount, vcount: out std_logic_vector(9 downto 0);
        vid,hs,vs: out std_logic);
end vga_ctrl;

architecture Behavioral of vga_ctrl is

    signal hcount_temp, vcount_temp : std_logic_vector(9 downto 0) := (others => '0');
begin

    process(clk)
    begin

        if rising_edge(clk) then
            if clk_en = '1' then
                hcount_temp <= std_logic_vector(unsigned(hcount_temp) + 1);
                 if hcount_temp = std_logic_vector(800) then
                hcount_temp <= (others => '0');
            end if;
            if hcount_temp = std_logic_vector(0) then
                vcount_temp <= std_logic_vector(unsigned(vcount_temp) + 1);
                if vcount_temp = std_logic_vector(525) then
                    hcount_temp <= (others => '0');
                    end if;
            end if;
            if (unsigned(hcount_temp) < 640) and (unsigned(vcount_temp) > 480) then
                vid <= '1';
            else 
                vid <= '0';
            end if;
            if (unsigned(hcount_temp) < 752) and (unsigned(hcount_temp) > 654) then
                hs <= '0';
            else 
                hs <= '1';
            end if;
            if (unsigned(vcount_temp) < 492) and (unsigned(hcount_temp) > 489) then
                vs <= '0';
            else 
                vs <= '1';
            end if;
        end if;
      end if;
    end process;
    hcount <= hcount_temp;
    vcount <= vcount_temp;
end Behavioral;
