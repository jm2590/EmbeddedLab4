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
    signal vs_temp, hs_temp,vid : std_logic;
    signal hcount_temp : std_logic_vector(9 downto 0);
    signal pic_pxl : std_logic_vector(7 downto 0);
    
    component picture IS
      port (
        clka : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
    end component;

begin


    clock_divider: entity work.clock_div
        port map(
            clk => clk,
            div => en
        );

    vgaContr: entity work.vga_ctrl
        port map(
            clk => clk,
            clk_en => en,
            hcount => hcount_temp,
            vid => vid,
            hs => hs_temp,
            vs => vs_temp
        );

    pxlPush: entity work.pixel_pusher
        port map(
            clk => clk,
            clk_en => en,
            vid => vid,
            vs => vs_temp,
            hcount => hcount_temp,
            pxl_sig => pic_pxl,
            R_sig => vga_r,
            B_sig => vga_b,
            G_sig => vga_g,
            addr => address
        );

    Img: component picture
        port map(
            clka => clk,
            addra => address,
            douta => pic_pxl
        );
    vga_vs <= vs_temp;
    vga_hs <= hs_temp;

end Behavioral;
