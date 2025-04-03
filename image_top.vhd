library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity image_top is
       Port (
              clk : in std_logic;
              vga_r, vga_b : out std_logic_vector(4 downto 0);
              vga_g : out std_logic_vector(5 downto 0);
              vga_vs, vga_hs : out std_logic );
              
end image_top;

architecture Behavioral of image_top is

signal en : std_logic;
signal address : std_logic_vector(17 downto 0);
signal R_signal, B_signal : std_logic_vector(4 downto 0);
signal G_signal : std_logic_vector(5 downto 0);
signal vs_temp, hs_temp : std_logic;

begin

clock_divider: entity work.clock_div
        port map(   
            clk => clk,
            div => en
        );
        
vgaContr: entity work.vga_ctrl
        port map(
        );
        
pxlPush: entity work.pixel_pusher
        port map(
        );

end Behavioral;
