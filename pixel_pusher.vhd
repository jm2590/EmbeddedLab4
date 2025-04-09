library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pixel_pusher is
    Port (
        clk, clk_en, vid, vs: in std_logic;
        hcount: in std_logic_vector(9 downto 0);
        pxl_sig: in std_logic_vector(7 downto 0);
        R_sig, B_sig : out std_logic_vector(4 downto 0);
        G_sig : out std_logic_vector(5 downto 0);
        addr: out std_logic_vector(17 downto 0));
end pixel_pusher;

architecture Behavioral of pixel_pusher is

    signal addr_temp : std_logic_vector(17 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if vs = '0' then
                addr_temp <= (others => '0');
            else
                if ((clk_en = '1') and (vid = '1') and (unsigned(hcount) < 480)) then
                    addr_temp <= std_logic_vector(unsigned(addr_temp) + 1);
                    R_sig <= pxl_sig(7 downto 5) & "00";
                    B_sig <= pxl_sig(1 downto 0) & "000";
                    G_sig <= pxl_sig(4 downto 2) & "000";
                else
                    R_sig <= (others => '0');
                    B_sig <= (others => '0');
                    G_sig <= (others => '0');
                end if;
            end if;
        end if;
    end process;
    addr <= addr_temp;

end Behavioral;
