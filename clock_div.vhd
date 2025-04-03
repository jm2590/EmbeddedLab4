
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity clock_div is
    Port (
        clk : in std_logic;
        div : out std_logic);
end clock_div;

architecture Behavioral of clock_div is

    signal counter : std_logic_vector(0 to 26) := (others => '0');

begin
    process (clk)

    begin

        if rising_edge(clk) then
            --if (unsigned(counter) < 62499999) then
            -- want 25MHz: 125/25  = 5 --> 5-1
            if (unsigned(counter) < 5-1) then
                counter <= std_logic_vector(unsigned(counter) + 1);
            else
                counter <= (others => '0');
            end if;
            if (unsigned(counter) = 2) then
                div <= '1';
            else
                div <= '0';
            end if;

        end if;


    end process;
end Behavioral;
